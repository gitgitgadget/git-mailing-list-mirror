From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 38/43] refs: make some files backend functions public
Date: Tue, 06 Oct 2015 21:25:45 -0400
Organization: Twitter
Message-ID: <1444181145.7739.70.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-39-git-send-email-dturner@twopensource.com>
	 <56123CE3.9070909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 07 03:26:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjdUV-0004s1-KO
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 03:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbbJGBZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 21:25:50 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33231 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbbJGBZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 21:25:47 -0400
Received: by qgev79 with SMTP id v79so2606131qge.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 18:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=NJ2dfqn7Dzdiynd7nfZngWf6UDqlC3SZlw0gtesUJgE=;
        b=ImM4AXPudjE3H2dmJyYMkY2VJ/+KJCW+u5AG1eSD8l8+OJBLVTdHXFEXN9lk1uhcq3
         IdOCMogz94zLFLhtyqmndi55XWsS5vjKrI76pekp1xNcqH8oX77nkaS5X6irMsml7wZw
         ZntWzJ4umjiglCP/nAlT2kR0qQoWQlwMdLyQxNVwil7LKSOxRep5rJfgyeSKWh3opodN
         VQi/dkM/5PIQ3+dQr1tr0p5tbCWu8LFoqPvKw7NbREyeXEBVHdjGn93FvkdaNc/OAG7u
         tDdWhAAXyh+kYApc/VshxRTbtbR1SvPySBy1WR5DpyV2B9e40bcLA9jGMZUhFK5pVT8J
         my7A==
X-Gm-Message-State: ALoCoQn9NsB45IElI4tGPEKoircevR37nPxdrHs4Vo+SkbXCJliG8HZGRKSRoKSS7GUxjwyE7cMH
X-Received: by 10.140.236.144 with SMTP id h138mr53743479qhc.78.1444181146527;
        Tue, 06 Oct 2015 18:25:46 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id d66sm15192991qgd.36.2015.10.06.18.25.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2015 18:25:45 -0700 (PDT)
In-Reply-To: <56123CE3.9070909@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279171>

On Mon, 2015-10-05 at 11:03 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:02 AM, David Turner wrote:
> > Because HEAD and stash are per-worktree, other backends need to
> > go through the files backend to manage these refs and their reflogs.
> > 
> > To enable this, we make some files backend functions public.
> 
> I have a bad feeling about this change.
> 
> Naively I would expect a reference backend that cannot handle its own
> (e.g.) stash to instantiate internally a files backend object and to
> delegate stash-related calls to that object. That way neither class's
> interface has to be changed.
> 
> Here you are adding a separate interface to the files backend. That
> seems like a more complicated and less flexible design. But I'm open to
> be persuaded otherwise...

After some thought, here's a summary of the problem:

Some writes are cross-backend writes.  For example, if HEAD is symref to
refs/head/master, a commit is a cross-backend write (HEAD itself is not
updated, but its reflog is).  Ronnie's design of the ref backend
structure did not account for cross-backend writes, because we didn't
have per-worktree refs at the time (there was only HEAD, and there was
only one copy of it).

Cross-backend writes are complicated because there is no way to tell a
backend to do only part of a ref update -- for instance, to tell the
files backend to update HEAD and HEAD's reflog but not
refs/heads/master.  Maybe we could set a flag that would do this, but
the synchronization would be fairly complicated.  For instance, an
update to HEAD might need to confirm the old sha for HEAD, meaning that
we couldn't do the db write first.  But if we move the db write second,
then when the db code goes to do its check of the HEAD sha, it might see
a new value.  Perhaps there's a way to make it work, but it seems
fragile/complex.

Right now, for cross-backend reads/writes, the lmdb code cheats. It
simply does the write directly and immediately.  This means that these
portions of transactions cannot be rolled back.  That's clearly bad. 



The simplest solution would be for the lmdb code to simply acquire
locks, and write to lock files, and then commit those lock files just
before the db transaction commits. Then the lmdb code would handle all
of the orchestration without the files backend having to be rewritten to
handle this case.

We would still like to use files_log_ref_write, since that handles the
formatting details of writing to file-based reflogs.  If you want, we
could break that (and its callees) out to separate refs-be-common.[ch]
files, as you suggested for some #defines.  (The calls to
files_log_ref_write would also have to move to transaction_commit as
well, but I think that's straightforward).

Does this seem reasonable to you?
