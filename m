Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E65C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 20:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353377AbiFUU12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352338AbiFUU10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 16:27:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D92E9EB
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 13:27:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60FA5137243;
        Tue, 21 Jun 2022 16:27:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k88wfT+upOaERvXXFubv5Zo3KTEzLE5ysdNhxV
        MGdYc=; b=ShgPWj2tuXL2I0fS4qdV3XPna0YBW6AzkwKI6pNR2eHzt3FHO8/7lJ
        VWoS/WpqAVyW9sm84zoHvO9+lshNwavRzch8PnCAY1VfcZUPdN2KQx+fUJpWxRGA
        alOY1bWvOdr0c0ghPy8hkhbvz0DS12lP4OvaGR1SPk2NdwXXgm/rg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55338137242;
        Tue, 21 Jun 2022 16:27:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE4C413723F;
        Tue, 21 Jun 2022 16:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>, rsbecker@nexbridge.com,
        Jeff King <peff@peff.net>, avarab@gmail.com
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
        <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
        <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
        <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
        <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
        <YrFwcL2dRS/v7xAw@coredump.intra.peff.net>
        <xmqq1qviht4h.fsf@gitster.g>
Date:   Tue, 21 Jun 2022 13:27:22 -0700
In-Reply-To: <xmqq1qviht4h.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        21 Jun 2022 09:35:26 -0700")
Message-ID: <xmqqy1xpg3th.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EF7C51A-F1A0-11EC-8D5C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yup, a solution along that line was what I expected to see from
> those who write Perl when I saw the discussion yesterday.

Here is what I queued tentatively.  This is not exactly new;
e1790f92 (fetch tests: fetch <url> <spec> as well as fetch
[<remote>], 2018-02-09) first appeared in v2.17.0 and we can
live with the same glitch for few more weeks ;-)

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Derrick Stolee <derrickstolee@github.com>
Date: Mon, 20 Jun 2022 15:52:09 -0400
Subject: [PATCH] t5510: replace 'origin' with URL more carefully

The many test_configured_prune tests in t5510-fetch.sh test many
combinations of --prune, --prune-tags, and using 'origin' or an explicit
URL. Some machinery was introduced in e1790f9245f (fetch tests: fetch
<url> <spec> as well as fetch [<remote>], 2018-02-09) to replace
'origin' with this explicit URL. This URL is a "file:///" URL for the
root of the $TRASH_DIRECTORY.

However, if the current build tree has an '@' symbol, the
replacement using perl fails. It drops the '@' as well as anything
else in that directory name.  You can observe this locally by
cloning git.git into a "victim@03" directory and running the test
script.

As we are writing in Perl anyway, pass in the shell variables involved
to the script as arguments and perform necessary string transformations
inside it, instead of assuming that it is sufficient to enclose the
$remote_url variable inside a pair of single quotes.

Reported-by: Randall Becker <rsbecker@nexbridge.com>
Original-patch-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5510-fetch.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4620f0ca7f..b45879a760 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -853,7 +853,11 @@ test_configured_prune_type () {
 		then
 			new_cmdline=$cmdline_setup
 		else
-			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
+			new_cmdline=$(perl -e '
+				my ($cmdline, $url) = @ARGV;
+				$cmdline =~ s[origin(?!/)][quotemeta($url)]ge;
+				print $cmdline;
+			' -- "$cmdline" "$remote_url")
 		fi
 
 		if test "$fetch_prune_tags" = 'true' ||
-- 
2.37.0-rc1-99-g4626346e14

