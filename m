From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Wed, 15 Jul 2015 09:24:32 -0700
Message-ID: <xmqqd1ztxubj.fsf@gitster.dls.corp.google.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	<1436316963-25520-2-git-send-email-dturner@twopensource.com>
	<559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	<559D92CF.7000408@kdbg.org>
	<xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
	<1436399058.4542.26.camel@twopensource.com>
	<xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
	<1436478800.4542.61.camel@twopensource.com>
	<xmqqbnflugsw.fsf@gitster.dls.corp.google.com>
	<559F4A55.1070309@alum.mit.edu>
	<1436848402.5074.21.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 18:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFPU8-0006My-KK
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 18:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbbGOQYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 12:24:36 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34635 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbGOQYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 12:24:35 -0400
Received: by iebmu5 with SMTP id mu5so37186085ieb.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hRPyFYyF8Tt2g59zMvly40/p0JosuP+zijiLRd92Tqc=;
        b=othjGGkw0hwC7hL6Y9T0O+U225deeEzQ2deMSwZu1pNqlbR23l/uq3vnkn+3dtcOkb
         BbGJUoVPof0mXrwb0sX9qpQl1JZW2ESbVG3tlhyC7gJKcGIaWZo7mw64frCzxIfzI3SZ
         NHhie/iV/DfnZ0gSKb9M7WAvhXIrdi0R3eB8h3hm8q8e9NkRFPHGMS5MWdfGsTck+3Wb
         pwFh7YjRxAKjwH7LcSfI8KWFj78YsQ7AYYewe5je+vkkBPBVZG/CRrRx1l+NUKK3hhbh
         2FTHWATbVFW5cUj+Wql1f1U2zC/78XoeOiqfESyYvmCISljIfkEtA9v4EZOEpbkBMM/L
         2VXg==
X-Received: by 10.50.129.2 with SMTP id ns2mr10803298igb.5.1436977474834;
        Wed, 15 Jul 2015 09:24:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91d4:b530:378d:909b])
        by smtp.gmail.com with ESMTPSA id rj5sm3521578igc.2.2015.07.15.09.24.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 09:24:33 -0700 (PDT)
In-Reply-To: <1436848402.5074.21.camel@twopensource.com> (David Turner's
	message of "Tue, 14 Jul 2015 00:33:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273986>

David Turner <dturner@twopensource.com> writes:

> So I am thinking instead that backends should be required to manage
> updates to HEAD themselves, and that some functions from refs-be-files
> would be made generic to help with this.  
> ...
> For the LMDB backend, I could put most of that code at the LMDB access
> ...
> backend, it should still be possible to handle this cleanly.

Sounds sensible.

> On reflection, I think that this would also be a reasonable approach to
> take for stash, which does not fall into any of the listed categories.
> It's not a pseudoref because it's not all-caps and it starts with refs/.
> Unlike other pseudorefs, it needs a reflog.  But like HEAD and unlike
> other refs, it (and its reflog) wants to be per-worktree.

I think we want stash, unlike HEAD, to be shared across worktrees,
and contrib/workdir gets this right.

So there is nothing that makes refs/stash like CHERRY_PICK_HEAD at
all.

> Are there
> other ref-like-things in this category (which I'll call "per-worktree
> refs")?  I guess one set of these is submodules' HEADs.

I've been assuming that a secondary worktree of superproject will
get its own & corresponding secondary worktree of a submodule, which
would automatically give per-worktree "submodule's HEADs" and
everything else that has to be per-worktree.  Am I missing something
or are there any more need for underlying machinery than what we
currently have for secondary worktrees for a single project tree?
