From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Thu, 09 Jul 2015 15:06:39 -0700
Message-ID: <xmqqbnflugsw.fsf@gitster.dls.corp.google.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	<1436316963-25520-2-git-send-email-dturner@twopensource.com>
	<559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	<559D92CF.7000408@kdbg.org>
	<xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
	<1436399058.4542.26.camel@twopensource.com>
	<xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
	<1436478800.4542.61.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 00:06:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDJxx-0001uC-0J
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbbGIWGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:06:44 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35343 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbGIWGn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:06:43 -0400
Received: by iecuq6 with SMTP id uq6so185705054iec.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uStAbI218Psj2js3/hoLDLosME3kxr6nPr+kxyjltLY=;
        b=t1ZBemWaG1OH3tRGbNNLTzeFPWrDpYIpOqbB2E4l3EV4MybZR8Bo/rwgaWuDRgWynY
         Awkf4b3Alcbddr6gsCL0pRFUJ1RMo/JT5qrkvRCLMG84k4vraZvSJA+DKZaozWwSKJdd
         BBVSMHreWR4D0i1Rdp1UFk6MIdsowTZsBwsrx9XwRaCSBWBx+IIJrHA4v0Kiz8IJmRBl
         qAv2SzCwG5vT+gXBqp1MwEgKZSiKyKtHPeVWnZgOH8dnuTvXOdnL8aelWIvmUrskTayG
         FB6K+OLx3hV+1oFxaDk39+fdEaaFFTijfZL/sjKgEghUO5TmSyXsNQOL4v88DUg2bXGb
         dmEg==
X-Received: by 10.50.30.226 with SMTP id v2mr63288igh.3.1436479603150;
        Thu, 09 Jul 2015 15:06:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id t29sm447792ioi.24.2015.07.09.15.06.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 15:06:41 -0700 (PDT)
In-Reply-To: <1436478800.4542.61.camel@twopensource.com> (David Turner's
	message of "Thu, 09 Jul 2015 17:53:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273781>

David Turner <dturner@twopensource.com> writes:

> OK, here's my current best idea:
>
> 1. A "pseudoref" is an all-caps file in $GIT_DIR/ that always contains
> at least a SHA1.  CHERRY_PICK_HEAD and REVERT_HEAD are examples. Because
> HEAD might be a symbolic ref, it is not a pseudoref. 
>
> Refs backends do not manage pseudorefs.  Instead, when a pseudoref (an
> all-caps ref containing no slashes) is requested (e.g. git rev-parse
> FETCH_HEAD) the generic refs code checks for the existence of that
> file and if it exists, returns immediately without hitting the backend.
> The generic code will refuse to allow updates to pseudorefs.
>
> 2. The pluggable refs backend manages all refs other than HEAD.
>
> 3. The "files" backend always manages HEAD.  This allows for a reflog
> and for HEAD to be a symbolic ref.
>
> The major complication here is ref transactions -- what if there's a
> transaction that wants to update e.g. both HEAD and refs/heads/master?

An update to the current branch (e.g. "git commit") does involve at
least update to the reflog of HEAD, the current branch somewhere in
refs/heads/ and its log, so it is not "what if" but is a norm [*1*].

>
> It may be the case that this never happens; I have not actually audited
> the code to figure it out.  If someone knows for sure that it does not
> happen, please say so. But assuming it does happen, here's my idea:
>
> If the refs backend is the files backend, we can simply treat HEAD like
> any other ref.
>
> If the refs backend is different, then the refs code needs to hold a
> files-backend transaction for HEAD, which it will commit immediately
> after the other transaction succeeds.  We can stick a pointer to the
> extra transaction in the generic struct ref_transaction, which (as
> Michael Haggerty suggests) specific backends will extend.
>
> A failure to commit either transaction will be reported as a failure,
> and we'll give an additional inconsistent state warning if the main
> transaction succeeds but the HEAD transaction fails.

Yeah, I was thinking along those lines, too.  Thanks for clearly
writing it down.

> What do other folks think?

Me too ;-)


[Footnote]

*1* But that is not a complaint; I do not have a better idea myself
either.
