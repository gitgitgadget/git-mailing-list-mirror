From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Tue, 14 Jul 2015 00:33:22 -0400
Organization: Twitter
Message-ID: <1436848402.5074.21.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
		<1436316963-25520-2-git-send-email-dturner@twopensource.com>
		<559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
		<559D92CF.7000408@kdbg.org>	<xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
		<1436399058.4542.26.camel@twopensource.com>
		<xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
		<1436478800.4542.61.camel@twopensource.com>
	 <xmqqbnflugsw.fsf@gitster.dls.corp.google.com>
	 <559F4A55.1070309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 14 06:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEruj-0008W7-CG
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 06:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbbGNEd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 00:33:28 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34113 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbGNEd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 00:33:27 -0400
Received: by qkcl188 with SMTP id l188so86378088qkc.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 21:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=DyrwfaUr7eNZpWuldMkZsR8Q8Juxn2xP8r+9j2OvYz4=;
        b=HplJ7Pvq903HD/rVuiYuI7gCfVSuMkVfq2xZrR+1GA2GYC9ew9Mbrv+bIGik5F7b+4
         qWN1zjuIQZhSKiNtK/hM0Jx0XvR9q98yL8FHjLHJ0SaNBkFnp4Q+eMVBO1XN8FiMDRVh
         Elgn83R/32unbAdPqy8rz7UeBtiKnXE4LpoIFJrelShYjBGWItAzgcm8nPamAAvD/zqR
         A7NvyFEyw93gq2KTqAYWGiQLThc2BVWZk6pCQFEuZxSd51NXNQwc0eFlaYFxZgQ94SVw
         BARMtRJ0vIWSBcC3T7ZLYb+YCWrx50mwzL/I33OYHJmV9U7e8j4IEcZvI5b/qzIrse0T
         Iihg==
X-Gm-Message-State: ALoCoQmiZYblEK6vcAUpgTorb/3dvM0tfuqHvqrKmKpJb3No/0MfXDlRSSZVMijl7R3IT0bDDHFl
X-Received: by 10.140.104.110 with SMTP id z101mr56942383qge.76.1436848404935;
        Mon, 13 Jul 2015 21:33:24 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id k133sm12002694qhc.35.2015.07.13.21.33.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 21:33:23 -0700 (PDT)
In-Reply-To: <559F4A55.1070309@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273936>

[j6t to bcc as it looks like his concerns have been addressed]

On Fri, 2015-07-10 at 06:30 +0200, Michael Haggerty wrote:
> On 07/10/2015 12:06 AM, Junio C Hamano wrote:
> > David Turner <dturner@twopensource.com> writes:
> > 
> >> OK, here's my current best idea:
> >>
> >> 1. A "pseudoref" is an all-caps file in $GIT_DIR/ that always contains
> >> at least a SHA1.  CHERRY_PICK_HEAD and REVERT_HEAD are examples. Because
> >> HEAD might be a symbolic ref, it is not a pseudoref. 
> >>
> >> Refs backends do not manage pseudorefs.  Instead, when a pseudoref (an
> >> all-caps ref containing no slashes) is requested (e.g. git rev-parse
> >> FETCH_HEAD) the generic refs code checks for the existence of that
> >> file and if it exists, returns immediately without hitting the backend.
> >> The generic code will refuse to allow updates to pseudorefs.
> >>
> >> 2. The pluggable refs backend manages all refs other than HEAD.
> >>
> >> 3. The "files" backend always manages HEAD.  This allows for a reflog
> >> and for HEAD to be a symbolic ref.
> >>
> >> The major complication here is ref transactions -- what if there's a
> >> transaction that wants to update e.g. both HEAD and refs/heads/master?
> > 
> > An update to the current branch (e.g. "git commit") does involve at
> > least update to the reflog of HEAD, the current branch somewhere in
> > refs/heads/ and its log, so it is not "what if" but is a norm [*1*].
> 
> The updating of symlink reflogs in general, and particularly that of
> HEAD, is not done very cleanly. You can see the code in
> `commit_ref_update()` (some of it helpfully commented to be a "Special
> hack"):
> 
> * If a reference is modified through a symlink, the symlink is locked
> rather than the reference itself.
> * If a reference is modified directly, and HEAD points at it, then the
> HEAD reflog is amended without locking HEAD.
> 
> Aside from the lack of proper locking, which could result in races with
> other processes, we also have the problem that the same reference that
> is being changed via one of these implicit updates could *also* be being
> changed directly in the same transaction. Such an update would evade the
> `ref_update_reject_duplicates()` check.

On reflection, I'm not sure my approach makes sense.  The problem is
that refs backends internally manage recursive updates to symbolic refs,
so it is not easy to send update for HEAD to one backend while sending
the corresponding refs/heads/master updates to a different one. 

So I am thinking instead that backends should be required to manage
updates to HEAD themselves, and that some functions from refs-be-files
would be made generic to help with this.  

For the LMDB backend, I could put most of that code at the LMDB access
layer (which presently simply converts all LMDB errors other than
NOT_FOUND to calls to die()).  I would intercept reads and writes to
HEAD and logs/HEAD and replace them with calls to the appropriate
functions.  So, for instance, the LMDB backend would still decide
whether to write HEAD, but it would delegate to the files backend code
to actually write it.  Reflog updates are a bit more complicated,
because we might end up using a different reflog format for LMDB vs for
the files backend, but since all reflog updates are controlled by the
backend, it should still be possible to handle this cleanly.

On reflection, I think that this would also be a reasonable approach to
take for stash, which does not fall into any of the listed categories.
It's not a pseudoref because it's not all-caps and it starts with refs/.
Unlike other pseudorefs, it needs a reflog.  But like HEAD and unlike
other refs, it (and its reflog) wants to be per-worktree. Are there
other ref-like-things in this category (which I'll call "per-worktree
refs")?  I guess one set of these is submodules' HEADs.  I have been
planning on punting on these because it looks to me like that's what the
files backend does.  So, let's leave those aside.  I don't think of any
others but maybe I'm missing something.

I'm also not sure how worktrees handle HEAD's reflog -- there doesn't
seem to be anything worktree-specific in refs.c.  But perhaps I'm just
not understanding that bit of the code.
