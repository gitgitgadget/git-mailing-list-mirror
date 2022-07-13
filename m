Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846B8C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 22:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiGMWGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiGMWGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 18:06:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40545047
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 15:06:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 432C5198933;
        Wed, 13 Jul 2022 18:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kaCgGHkJ/8EvKuXfnXS6PLY5/acjLHjUrE7imJ
        2JFy0=; b=L6jhJ16pT0vW9dF9AAozB5N01joJNlu+tWtQmUJ2k6KnbhiKsm0PSo
        roWi/QfdCybpaBhoeJf8KPHQwSPSOc+kGVyOu2sWvxdRSXBHhCyEgBaIjCboG8qY
        0wm/qc/7wBSw4r0fry5GzvgrNjN2suxLfLaLG81xLvkStHR/+xGAA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B79D198932;
        Wed, 13 Jul 2022 18:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D905619892F;
        Wed, 13 Jul 2022 18:06:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
        <xmqq7d4gbu10.fsf@gitster.g> <Ys86MnwhembiXRxj@zacax395.localdomain>
        <xmqqr12oadbk.fsf@gitster.g>
Date:   Wed, 13 Jul 2022 15:06:36 -0700
In-Reply-To: <xmqqr12oadbk.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        13 Jul 2022 14:54:23 -0700")
Message-ID: <xmqqmtdcacr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1104AE34-02F8-11ED-8B5B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> For one, as you said, "1" should be "true". That also changes the expected
>> output.
>
> OK, because "1" fails to execute, the expected output Dscho had
> (which is for the case without base) would become invalid when we
> use "true".
>
> Perhaps we should use "false" instead?  Or do we need to test both?

How confident are you with the "leftabove" stuff?  Is it solid
enough that it is safe to assume that we can queue this fix on top
of it?

This is how it would look like on top of the "leftabove" topic.

 mergetools/vimdiff | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git c/mergetools/vimdiff w/mergetools/vimdiff
index b045b10fd7..f770b8fe24 100644
--- c/mergetools/vimdiff
+++ w/mergetools/vimdiff
@@ -414,8 +414,8 @@ merge_cmd () {
 
 	if $base_present
 	then
-		eval "$merge_tool_path" \
-			-f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
+		eval '"$merge_tool_path"' \
+			-f "$FINAL_CMD" '"$LOCAL"' '"$BASE"' '"$REMOTE"' '"$MERGED"'
 	else
 		# If there is no BASE (example: a merge conflict in a new file
 		# with the same name created in both braches which didn't exist
@@ -424,8 +424,8 @@ merge_cmd () {
 		FINAL_CMD=$(echo "$FINAL_CMD" | \
 			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')
 
-		eval "$merge_tool_path" \
-			-f "$FINAL_CMD" "$LOCAL" "$REMOTE" "$MERGED"
+		eval '"$merge_tool_path"' \
+			-f "$FINAL_CMD" '"$LOCAL"' '"$REMOTE"' '"$MERGED"'
 	fi
 
 	ret="$?"
@@ -614,6 +614,37 @@ run_unit_tests () {
 		fi
 	done
 
+	# verify that `merge_cmd` handles paths with spaces
+	record_parameters () {
+		>actual
+		for arg
+		do
+			echo "$arg" >>actual
+		done
+	}
+
+	base_present=false
+	LOCAL='lo cal'
+	BASE='ba se'
+	REMOTE="' '"
+	MERGED='mer ged'
+	merge_tool_path=record_parameters
+
+	merge_cmd vimdiff || at_least_one_ko=true
+
+	cat >expect <<-\EOF
+	-f
+	-c
+	echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	-c
+	tabfirst
+	lo cal
+	' '
+	mer ged
+	EOF
+
+	diff -u expect actual || at_least_one_ko=true
+
 	if test "$at_least_one_ko" = "true"
 	then
 		return 255
