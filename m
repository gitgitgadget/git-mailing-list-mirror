Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB2C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248FC21739
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wxHCK1R8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBWVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:21:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61903 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBWVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 17:21:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 164FE4CE94;
        Mon,  2 Mar 2020 17:21:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+uYDgOH6ZuF6te4oZFVFx/CwVQ4=; b=wxHCK1
        R8EuJEB5Dct/TQRSaKwX7uO+RXlY8rSIGV0ZHrzysQ3QjT047FgRwjLtVHBFRuZe
        19d0lO40krP2O9Q9ZWCU5Oz9ef3yZynd0CRjsKAbf1sVpag+cl2dXLawx8t2aEzd
        00v2OcXVzZqSGUKsRzGeHKfz9NsBsCxYdDzDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SebuVT5FeliUHapwZOUiLtYfcT7VPRFa
        H3qq3mhZIPvocmD5gmnvoO+TGRP+qB3NSIUHZR9z9UOWpC3YyKKmfiMSOxUoWKeQ
        mpy+Ke/nEtbISeNtAUtcdZRA2Q7SIHDhOVp/aWai3pHrjzSTMDtf/gtzDKwte+aZ
        OIaJUsfsFLA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DB614CE92;
        Mon,  2 Mar 2020 17:21:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A3F84CE91;
        Mon,  2 Mar 2020 17:21:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: non-regression bug in 'git merge' (really, xdiff/xmerge, I think)
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
        <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
        <20200302181832.GA1571684@cat> <20200302181924.GB1571684@cat>
Date:   Mon, 02 Mar 2020 14:21:18 -0800
In-Reply-To: <20200302181924.GB1571684@cat> (Thomas Gummerer's message of
        "Mon, 2 Mar 2020 18:19:24 +0000")
Message-ID: <xmqqy2si9z4x.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23F7E2BC-5CD4-11EA-9CBF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 9804a0758b..096c6d1fbb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -609,7 +609,6 @@ SCRIPT_SH += git-merge-one-file.sh
>  SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
>  SCRIPT_SH += git-quiltimport.sh
> -SCRIPT_SH += git-legacy-stash.sh
>  SCRIPT_SH += git-request-pull.sh
>  SCRIPT_SH += git-submodule.sh
>  SCRIPT_SH += git-web--browse.sh

Merging this topic to 'pu', which has dl/merge-autostash topic
already merged, breaks the build and it is not fault of Thomas's
topic.  dl/merge-autostash has the following bit:

commit 4b981afaa03c00524f1d4986271a3f4cc119f4cd
Merge: 06928448f7 de4db86ff2
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Mar 2 13:23:26 2020 -0800

    Merge branch 'dl/merge-autostash' into pu
    
    "git merge" learns the "--autostash" option.
    
    * dl/merge-autostash:
      ...
      Makefile: alphabetically sort += lists

diff --git a/Makefile b/Makefile
index a5961113d8..c0793ac75b 100644
--- a/Makefile
+++ b/Makefile
@@ -604,12 +604,12 @@ unexport CDPATH
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
+SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
@@ -617,8 +617,8 @@ SCRIPT_SH += git-web--browse.sh

which makes it appear to the xmerge code that legacy-status that
used to exist in between quiltimport and request-pull has already
been removed.

As Thomas's above patch exactly wants to do that (i.e. we want to
remove legacy-stash between quiltimport and request-pull), the
xmerge code seems to think incorrectly that the requested change has
already been applied.  And as a result of that, there remains
legacy-stash between fliter-branch and merge-octopus, breaking the
build by having one unbuildable build target X-<.



