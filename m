From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 15:29:36 -0700
Organization: Twitter
Message-ID: <1430346576.14907.40.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	 <1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnaUC-0007ND-FC
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 00:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbbD2W3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 18:29:40 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33691 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbD2W3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 18:29:39 -0400
Received: by pdbnk13 with SMTP id nk13so40928373pdb.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 15:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=6eKP5MwcHYSUAjGS0zlyUj5mvVBAMvgl89EJLDpTwJo=;
        b=Yk7I4u2QbCa3bEXeAdSeyauMiTwk1HUscbjUB3lKxWgEygDwdeTN2lQEy1oZntSNcP
         scevovBm9v0aK0MP5VDWO6XTgpDzexkdlv5GSsNIa2mklsIXNIkVDEO2MJNGO7nQoIyI
         Rqdpl1YXCOqfXRT3JkFYb/c5b3sOwCy+FIdsqjvsx1Q9NXPsTqwVWloudlqzlIXecxUG
         FVnTkqKgbnEgpULi0VqOtwbp8j1nD3VS0BE7ztYQHMXfgWk2b49Tbk9VlVO/V7/Lt4M9
         aDGxZeN3n0wpbSMzVJ/6UwStZ3wJZJRHN+R2J3uw83rcujsXZ1R823zLi9NXOPnSD3UX
         9MMQ==
X-Gm-Message-State: ALoCoQnKYxfHTiHtvHmBhr6CJQH2Cc5gvARWARfhRGQYEsWZTE2SCj+2xGRRjrmPARC52QDhuqGA
X-Received: by 10.70.37.69 with SMTP id w5mr2268262pdj.123.1430346578706;
        Wed, 29 Apr 2015 15:29:38 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id je11sm193988pbd.65.2015.04.29.15.29.37
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 15:29:37 -0700 (PDT)
In-Reply-To: <20150429214817.GA2725@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268031>

On Wed, 2015-04-29 at 17:48 -0400, Jeff King wrote:
> On Wed, Apr 29, 2015 at 02:30:59PM -0700, David Turner wrote:
> 
> > > I personally don't, exactly because we track the contents of the
> > > symlink itself, not the referent.  Your "major wrinkle" that they
> > > can point outside the repository is a mere manifestation of that.
> > 
> > I'm not sure I understand why tracking the contents of the symlink is a
> > problem for this approach.  It seems reasonable to ask what would have
> > happened had I checked out the repo at a certain SHA and said "cat
> > foo/bar/baz".
> 
> But git can't answer that question, can it? That is something that you
> are asking the filesystem and the OS, and it may involve leaving the git
> repository altogether (and depend on things like your cwd). Certainly
> git can ask the filesystem for you, but it's more flexible if you do it
> yourself (at the expense of more code on your end; see below).

As far as I know, symlink resolution doesn't depend on cwd.  And paths
passed to cat-file are interpreted relative to the repo root regardless
of the cwd anyway.

It's true that full symlink resolution might depend on leaving the git
repo.  I didn't want git to have to deal with that, so my proposal told
the caller about out-of-repo symlinks, allowing the caller to deal. The
caller can then use the standard library, which already knows how to
resolve symlinks.  I guess a sequence of links could leave and then
reenter the repository; that is indeed a corner case that I am happy to
leave to the callers; any caller who cares will be no worse off than
they are now.

> > > Perhaps an ideal interface might be something like this:
> > > 
> > >     $ echo HEAD:RelNotes |
> > >       git cat-file --batch='%(objecttype) %(intreemode) %(objectsize)'
> > >     blob 160000 32
> > >     Documentation/RelNotes/2.4.0.txt
> > > 
> > > I suspect it would be just the matter of teaching "cat-file --batch"
> > > to read from get_sha1_with_context() in batch_one_object(), instead
> > > of reading from get_sha1() which it currently does.
> > > 
> > > And that inteferface I think I can live with.
> > 
> > Even if I had %(intreemode), I would still have to do a recursive search
> > to figure out whether Documentation or RelNotes was a symlink.  This is
> > why I want a follow-symlinks mode.  And since I am already reading
> > RelNotes, I can (and presently do) parse the mode out of that data.
> > $(intreedmode) would save me some parsing, but it would not save me any
> > reading, nor would it make my code any less complex.  But
> > --follow-symlinks would simplify my code.
> 
> Wouldn't git have to do the same recursive search? That is, with the
> interface above, you would see "ah, %(intreemode) says we are a symlink;
> let me ask again using the filename from the symlink contents". And
> repeat until you get a non-symlink. But with a --follow-symlinks option,
> git is just doing the same thing internally. It cannot ask the
> filesystem because these are not real files.
> 
> So the advantages of --follow-symlinks are:
> 
>   1. It's more efficient. Instead of round-tripping across the pipe, git
>      follows the link internally.
> 
>   2. It's easier for callers. Git only has to implement it once, and
>      callers get it for free. Also, callers do not have to have a
>      bidirectional conversation with cat-file (which is doubly awkward
>      if they are trying to send the output of cat-file elsewhere, since
>      they end up having to forward along the non-symlinked output).
> 
> The disadvantages are:
> 
>   1. Git has to make a decision about what to do in corner cases. What
>      is our cwd for relative links? The project root? Can we be in a
>      subdir of the repo? What do we do about symlinks that point to
>      non-existent files?  Ones that point outside the repository? If we
>      cat the actual filesystem, what is the cwd of the pretend
>      working-tree that we start from? Do we need to be able to show the
>      contents _and_ the fact that we followed one or more links (and
>      their intermediate names?).
> 
> Can you think of arguments (either on pro or con side) that I am
> missing? Or did I misunderstand what you meant by "recursive search"?

Overall, I agree.  I think the disadvantages are somewhat overstated.

As I said above, I don't think the cwd is a problem.  The output for
symlinks which point outside the repo should be absolute (in the case of
absolute symlinks), or relative to the repo root (for relative
symlinks).  In other words, if my repo contains:
foo/bar -> ../../baz
then the output[1] would be 
symlink 6
../baz

I can't think of any other output that would be reasonable here, but
maybe there's something I don't understand.

Note that I'm not proposing that cat-file should actually read any files
or directories from outside of the repo.  It should just make it
possible for the caller to do so.


[1] (I realize, now, that having a sha would be useless, so I've omitted
it).
