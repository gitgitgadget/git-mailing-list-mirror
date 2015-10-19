From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Mon, 19 Oct 2015 18:27:29 -0400
Organization: Twitter
Message-ID: <1445293649.3418.16.camel@twopensource.com>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
	 <561F1EE5.5070300@web.de> <1444935764.20887.1.camel@twopensource.com>
	 <xmqqfv1bhn2t.fsf@gitster.mtv.corp.google.com>
	 <1444979140.20887.19.camel@twopensource.com>
	 <xmqq1tcuhkb2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 00:27:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoIu4-0007Sx-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 00:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbbJSW1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 18:27:34 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35918 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbJSW1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 18:27:32 -0400
Received: by qkca6 with SMTP id a6so19073916qkc.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 15:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=+zYeem4Kwjcs9CRpwsZdxBru1ZaaPkZQL+4Vs+PiLJw=;
        b=OnoyFvI5wimbXiUdsL+118bbxzLWFT93Mvv4MND63kncLs6lzaBMl3hw0uROj6TFB9
         yUFUWJSV7VvEQ3agExqgtw70KOpw65pMJF+rnJYMKLAuz8RxIL316WdnAxiMqXdrgR3C
         +4s0jhO3dWIgn0jBUoOIY03jZoXDAoK3W/aXl1sbEihwUPrjSwR8tcPT/7iPo56vRZZQ
         rURk1mwjTE64qmbwTL39xlJfjKV9Neki2bKK2IkC3/TpeuG6QzL0Kh3S0TAjuSmTC53j
         vvCjf60o/3DljVjkG/KhS1GuQIxw9wdqBMBotOy5fsh6YrbuBQJZ4G5qdv7+kHes2VnN
         wAMQ==
X-Gm-Message-State: ALoCoQme9CVM9JUr7bdZ/64M2LBb3yl5KuH1/94DEVTMAhVWu9SeDkk+WT76/tpjJjEQnQ2HDM/P
X-Received: by 10.55.43.17 with SMTP id r17mr39887437qkh.96.1445293651044;
        Mon, 19 Oct 2015 15:27:31 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 145sm15166604qhb.20.2015.10.19.15.27.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2015 15:27:30 -0700 (PDT)
In-Reply-To: <xmqq1tcuhkb2.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279893>

On Fri, 2015-10-16 at 09:04 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > We also do dozens or hundreds of merges per day and only saw this quite
> > rarely.  Interestingly, we could only trigger it with an alternate
> > hashing function for git's hashmap implementation, and only once a
> > certain bug in that implementation was *fixed*.  But that was just a
> > trigger; it was certainly not the cause.  The bug would, in general,
> > have caused more hash collisions due to worse mixing, but I believe it
> > is possible that some particular collision would have been present in
> > the non-bugged version of the code but not in the bugged version.
> >
> > It may have also had something to do with a case-insensitive filesystem;
> > we never saw anyone reproduce it on anything but OS X, and even there it
> > was quite difficult to reproduce.
> >
> > In short, I don't think we know why the bug was not seen widely.
> 
> It has been a long time since I looked at name-hash.c and I am fuzzy
> on what the four functions (cache|index)_(file|dir)_exists are meant
> for, but I have this feeling that the original premise of the patch,
> "we may free a ce because we no longer use it in the index, but it
> may still need to keep a reference to it in name-hash" may be wrong
> in the first place.  The proposed "fix" conceptually feels wrong.
>
> The whole point of the name-hash is so that we can detect collisions
> in two names, one of which wants to have a file in one place while
> the other wants to have a directory, at the same path in the index.
> The pathnames and cache entries registered in the name-hash have to
> be the ones that are relevant to the index in quesition.  If a new
> ce will be added to the index, the name-hash will have to know about
> its path (and that is what CE_HASHED bit is about).  On the other
> hand, if you are going to remove an existing ce from the index, its
> sub-paths should no longer prevent other cache entries to be there.
> 
> E.g. if you have "a/b", it must prevent "A" from entering the index
> and the name-hash helps you to do so; when you remove "a/b", then
> name-hash must now allow "A" to enter the index.  So "a/b" must be
> removed from the name-hash by calling remove_name_hash() and normal
> codepaths indeed do so.
>
> I do not doubt the existence of "use-after-free bug" you observed,
> but I am not convinced that refcounting is "fixing" the problem; it
> smells like papering over a different bug that is the root cause of
> the use-after-free.
> 
> For example, if we forget to "unhash" a ce from name-hash when we
> remove a ce from the index (or after we "hashed" it, expecting to
> add it to the index, but in the end decided not to add to the index,
> perhaps), we would see a now-freed ce still in the name-hash.
> Checking a path against the name-hash in such a state would have to
> use the ce->name from that stale ce, which is a use-after-free bug.
> 
> In such a situation, isn't the real cause of the bug the fact that
> the stale ce that is no longer relevant to the true index contents
> still in name-hash?  The refcounting does not fix the fact that a
> ce->name of a stale ce that is no longer relevant being used for D/F
> collision checking.
> 
> I am not saying that I found such a codepath that forgets to unhash,
> but from the overall design and purpose of the name-hash subsystem,
> anything that deliberately _allows_ a stale ce that does not exist
> in the index in there smells like a workaround going in a wrong
> direction.

I've spent some time looking into this, but I don't quite have a repro.
I do have some comments which might be interesting.

The problem is not the name_hash, but with the dir_hash.  The dir_hash
is only even populated on case-insensitive filesystems (which is why you
and Linus don't see this bug).  The dir_hash is not designed to catch
d/f conflicts, but rather case conflicts (one side of a merge has
foo/bar; the other has FOO/bar).  For each directory, it maintains a
pointer to a cache_entry.  Then add_to_index uses that cache_entry to 
rewrite incoming entries' parent directories to the expected case.
Weirdly, that part of add_to_index is, so far as I can tell, never
called during a merge.  So where's are we using the freed value?
Probably in dir_entry_cmp, while adding another entry to the hashmap;
that's where our crash seems to have happened.  And our failure depended
on the details of the hash function as well; if a certain collision did
not happen, we would not see it.

There is, I think, another way to handle this: we could *copy* the path
into the struct dir_entry instead of pointing to a cache_entry.  But
this seems like a bunch of extra work; the refcounting is simpler.  
