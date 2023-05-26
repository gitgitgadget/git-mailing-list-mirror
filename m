Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B89C77B7C
	for <git@archiver.kernel.org>; Fri, 26 May 2023 05:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjEZF2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 01:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEZF2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 01:28:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2596E2
        for <git@vger.kernel.org>; Thu, 25 May 2023 22:28:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A65B193DBB;
        Fri, 26 May 2023 01:28:15 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=zN+C5/WY5o/3QWU1BZ97IxHqFPLdxfmEL9WeI4V
        i0iw=; b=U06Z4XtJbaMvfDadA0TI7O1OqmqF2nZYBLrAq8X5h9P2EIwpN7/vld0
        VMsnI+kNtDXGR7QisscOUBhvjyT9Mr8xD7hF3a2VrndIPv3qvJKqqda/UrzEnFp/
        n3bHXuUHiUKPMtjAK3fBAE2NBprvPmbAhaXFSDkbbrgoFXEVjb8Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5324B193DBA;
        Fri, 26 May 2023 01:28:15 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B840F193DB9;
        Fri, 26 May 2023 01:28:14 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 26 May 2023 01:28:12 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-gpg: fix ssh-keygen -Y check-novalidate with
 openssh-9.0
Message-ID: <ZHBDbGjid-33cJb4@pobox.com>
References: <20230525031026.3554406-1-tmz@pobox.com>
 <xmqqsfbjeltg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsfbjeltg.fsf@gitster.g>
X-Pobox-Relay-ID: 1CEECB76-FB86-11ED-A61C-C65BE52EC81B-09356542!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> While I was trying to see if the symptom reproduces in my
> environment roughly based on Debian testing, I had this trivial test
> script
> 
>     #!/bin/sh
> 
>     test_description='heh???'
> 
>     . ./test-lib.sh
>     . "$TEST_DIRECTORY/lib-gpg.sh"
> 
>     test_expect_success setup '
>             : test_have_prereq GPG &&
>             test_have_prereq GPGSSH_VERIFYTIME
>     '
> 
>     test_done
> 
> and noticed that GPGSSH_VERIFYTIME prerequisite does not pass
> regardless of the version of ssh-keygen installed, without first
> triggering GPG prereq to cause "$GNUPGHOME" to get created.
> Otherwise, this part
> 
> 	# Set up keys with key lifetimes
> 	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&
> 
> because GPGSSH_KEY_TIMEBOXEDVALID is defined to be created under
> GNUPGHOME, would not work.
> 
> I notice that GPGSM lazy prereq forces GPG prereq to be triggered
> by starting it like so:
> 
>     test_lazy_prereq GPGSM '
>             test_have_prereq GPG &&
> 
> and I think we should do the same for GPGSSH_VERIFYTIME for
> completeness in the longer term.  The current users of the
> prerequisite all seem to trigger GPG prerequisite check so
> this is not all that urgent, though.

Good idea. Perhaps:

	test_lazy_prereq GPGSSH_VERIFYTIME '
		test_have_prereq GPGSSH &&

is best there?  The GPGSSH prereq creates ${GNUPGHOME}.  It
may not be common, but there may be folks who want to run
the SSH tests and don't care about GPG.

Something like this?  (Sorry to distract you further in the
RC period. :)

-- 8< --
Subject: [PATCH] t/lib-gpg: require GPGSSH for GPGSSH_VERIFYTIME prereq

The GPGSSH_VERIFYTIME prequeq makes use of "${GNUPGHOME}" but does not
create it.  Require GPGSSH which creates the "${GNUPGHOME}" directory.

Additionally, it makes sense to require GPGSSH in GPGSSH_VERIFYTIME
because the latter builds on the former.  If we can't use GPGSSH,
there's little point in checking whether GPGSSH_VERIFYTIME is usable.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 114785586a..db63aeb6ed 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -135,6 +135,7 @@ test_lazy_prereq GPGSSH '
 '
 
 test_lazy_prereq GPGSSH_VERIFYTIME '
+	test_have_prereq GPGSSH &&
 	# Check if ssh-keygen has a verify-time option by passing an invalid date to it
 	ssh-keygen -Overify-time=INVALID -Y check-novalidate -s doesnotmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
 
-- 8< --

-- 
Todd
