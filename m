From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Thu, 09 Jul 2015 17:53:20 -0400
Organization: Twitter
Message-ID: <1436478800.4542.61.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	 <1436316963-25520-2-git-send-email-dturner@twopensource.com>
	 <559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	 <559D92CF.7000408@kdbg.org> <xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
	 <1436399058.4542.26.camel@twopensource.com>
	 <xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 23:53:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDJl3-0001Uh-1R
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 23:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbbGIVxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 17:53:25 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35718 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbbGIVxX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 17:53:23 -0400
Received: by qget71 with SMTP id t71so121524359qge.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 14:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=DNTsLMfeYFvkeJAEr2NIGzLILzAilw/x37T/bLFpyw0=;
        b=QQJgZ9ScF7rgeF+OWQQh7gPD2ECC0wghxmIyQdbSAudG59mC2YlDGirMfq1b9fBE0r
         MKqXl94eByXvm+ZqDB/6QhaGtbqcQXX43ufnrWCtP0gfPMQJ7PNlzu1tTEubnYajW4YW
         jIFPP7L3ccZNQiQPIJAqTL8j3imgKvAQSlw17Mzyi2s2v60tk21dxluav4ysZHDr9sZK
         B1mxHz5s6uUSWcohOt/tz9MvrBBbEOys5H4KJVDkXcYVDJ/DwlT7vzOxy3tmkO7ZU1Mf
         656+Dmf6r9uWC8QiDLV8zMV2yZ6mNd/Ew+10Fp/ifCVppVypfNl5F+lhCFryKCePL+ws
         D3sQ==
X-Gm-Message-State: ALoCoQmVsSPyexV/MsMhyD68k2JjR2B6SIj9Pl3f3TOeMOuLdya/lVEgeRZ71Oh83ehAPfF++TwG
X-Received: by 10.140.33.227 with SMTP id j90mr27962437qgj.6.1436478802626;
        Thu, 09 Jul 2015 14:53:22 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b66sm4110544qkh.36.2015.07.09.14.53.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 14:53:21 -0700 (PDT)
In-Reply-To: <xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273780>

On Wed, 2015-07-08 at 22:55 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > I didn't see this until after I had sent my previous message.  I think
> > the "multiple working trees" argument is strong enough that I will
> > change the code (and tests). 
> 
> Not just code, but we probably should step back a bit and clearly
> define what we are trying to achieve.  I _think_ what we want are:
> 
>  - Everything under refs/* and their associated logs would be handed
>    off to the "pluggable ref backend" when one is in use.
> 
>  - All ref-like things with one-level ALL_CAPS names are per working
>    tree.
> 
>    - They do not participate in "prunable?" reachability
>      computation.
>
>    - They (typically) do not want "logs".

Except HEAD definitely does. 

>    - Each may have extra information specific to it.
>    - You can however read an object name off of them.
> 
> One possible and straight-forward implementation to achieve
> "ref-like things with one-level ALL_CAPS names are per working tree"
> is to declare that they will not be handed off to the backend, but
> will always be implemented as files immediately under $GIT_DIR/.
> 
> But note that there is no fundamental reason we have to do it that
> way; an alternative would be to allow backends to store these things
> per working tree, but then the interface to drive backends need to
> tell them which working tree we are working from.
> 
> Unlike branches, HEAD must be per working tree; the "pluggable ref
> backend" needs to be able handle HEAD when you introduce it.

I actually punted on this in my implementation, because at the time,
git-new-workdir was only in contrib.  But since the new worktree stuff,
multiple worktrees have first-class support, so I'll have to update the
code to handle it.

> So
> from that point of view, "multiple working tree" is *not* a valid
> argument why they *have* to be implemented as files under $GIT_DIR/.
> If you plan to let the pluggable ref backend to handle HEAD, you
> must have a solution for per working tree ref-like things anyway.

OK, here's my current best idea:

1. A "pseudoref" is an all-caps file in $GIT_DIR/ that always contains
at least a SHA1.  CHERRY_PICK_HEAD and REVERT_HEAD are examples. Because
HEAD might be a symbolic ref, it is not a pseudoref. 

Refs backends do not manage pseudorefs.  Instead, when a pseudoref (an
all-caps ref containing no slashes) is requested (e.g. git rev-parse
FETCH_HEAD) the generic refs code checks for the existence of that
file and if it exists, returns immediately without hitting the backend.
The generic code will refuse to allow updates to pseudorefs.

2. The pluggable refs backend manages all refs other than HEAD.

3. The "files" backend always manages HEAD.  This allows for a reflog
and for HEAD to be a symbolic ref.

The major complication here is ref transactions -- what if there's a
transaction that wants to update e.g. both HEAD and refs/heads/master?

It may be the case that this never happens; I have not actually audited
the code to figure it out.  If someone knows for sure that it does not
happen, please say so. But assuming it does happen, here's my idea:

If the refs backend is the files backend, we can simply treat HEAD like
any other ref.

If the refs backend is different, then the refs code needs to hold a
files-backend transaction for HEAD, which it will commit immediately
after the other transaction succeeds.  We can stick a pointer to the
extra transaction in the generic struct ref_transaction, which (as
Michael Haggerty suggests) specific backends will extend.

A failure to commit either transaction will be reported as a failure,
and we'll give an additional inconsistent state warning if the main
transaction succeeds but the HEAD transaction fails.

I don't love this idea -- it seems like kind of a hack.  But it's the
best I can come up with.

What do other folks think?

> As to J6t's "no excessive plumbing invocations", I think the right
> approach is to have a single "git prompt--helper" command that does
> what the current script does to compute $r.  "we want to keep
> peeking into files under $GIT_DIR/" alone is not a valid enough
> reason to constrain us (I am fine if the solution we find
> appropriate for the 'multiple working trees' and other issues ends
> up being "we solve it by having them as files in $GIT_DIR" for other
> reasons, though).

Agree.
