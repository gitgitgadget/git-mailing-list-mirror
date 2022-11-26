Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BD6C43217
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 20:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKZUVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 15:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKZUVa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 15:21:30 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A26A15FFC
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 12:21:28 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1669494085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=xv9sU+RVS0nRyfBrPrC7AYaszrveMAE6RVxn6dpJl0E=;
        b=dRUgIGTMAby68rK4zXnKbJVxOeUHbdzSV2rN4b31sDgd9e9CTPScSbBeUooyP1HVWCzafC
        /7AzAb9C+yrnx6aZIbl0bMx86vrlM0KzOTkJK/U8CLfFxkLjiNyAbIrEsw/6Fs6tcrB90K
        hCcTBB/EDVPyUTpMM9CmvhXPm4ZdLAGZh/zmHPn0cpKqM7YZjPbTvyHTTyeEiZEUWl5pJ5
        BIHKYw9VetiAjNTW89qPsOKgfJglAniI9b+HTYlFTQ8RfmLVV8IrSL3M5CbuMPXGUNjCfU
        SfGyDtxnULKCz1TkmQV3NpHyCoLCO+uE6aHsyt5qNbcZB9dU9CvWMNZJDY1Oiw==
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] send-email: relay '-v N' to format-patch
In-Reply-To: <87k03j54aj.fsf@kyleam.com>
Date:   Sat, 26 Nov 2022 15:21:23 -0500
Message-ID: <87edtp5uws.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer writes:

> Junio C Hamano writes:
>
>> The right solution for allowing "-v 3" given to "format-patch" I think
>> is to make send-email understand it and pass that through.  The
>> presence of both ("validate" => \$validate) and ("v" =>
>> \$reroll_count) in the GetOptions() argument would prevent "-v" to be
>> taken as "--validate" while still allowing "--val" to be used as an
>> abbrevatiion, no?
>
> I'd think that would work, yes.  I'll look more into going this route.
>
> With that approach, there are other cases of abbreviation intercepting
> valid format patch options.  [...]

Here's a patch handling the -v case.  I don't plan on working on a more
complete fix for the other cases (as I mentioned before, I don't use
send-email to drive format-patch), but in my opinion the -v fix by
itself is still valuable.

-- >8 --
Subject: [PATCH v2] send-email: relay '-v N' to format-patch

send-email relays unrecognized arguments to its format-patch call.
Passing '-v N' leads to an error because -v is consumed as
send-email's --validate.  For example,

  git send-email -v 3 @{u}

fails with

  fatal: ambiguous argument '3': unknown revision or path not in the
  working tree.  [...]

To prevent this, add the short --reroll-count option to send-email's
main option list and explicitly provide it to the format-patch call.

There other format-patch options that send-email doesn't relay
properly, including at least -n, -N, and the diff option -D.  Punt on
these because dealing with them is more complicated:

 * they would require configuring send-email to not ignore option case

 * send-email makes three GetOptions() calls with different sets of
   options, the last being the main set of options.  Unlike -v, which
   is consumed by the last GetOptions call, the -n, -N, and -D options
   are consumed as abbreviations by the earlier calls.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 git-send-email.perl   | 9 ++++++++-
 t/t9001-send-email.sh | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..07f2a0cbea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -220,6 +220,10 @@ sub format_2822_time {
 my $force = 0;
 my $dump_aliases = 0;
 
+# Variables to prevent short format-patch options from being captured
+# as abbreviated send-email options
+my $reroll_count;
+
 # Handle interactive edition of files.
 my $multiedit;
 my $editor;
@@ -542,6 +546,7 @@ sub config_regexp {
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
+		    "v=s" => \$reroll_count,
 );
 $rc = GetOptions(%options);
 
@@ -782,7 +787,9 @@ sub is_format_patch_arg {
 	die __("Cannot run git format-patch from outside a repository\n")
 		unless $repo;
 	require File::Temp;
-	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1), @rev_list_opts);
+	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1),
+				    defined $reroll_count ? ('-v', $reroll_count) : (),
+				    @rev_list_opts);
 }
 
 @files = handle_backup_files(@files);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 01c74b8b07..152bd2c697 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2334,6 +2334,12 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
 		"$(pwd)/0001-add-main.patch"
 '
 
+test_expect_success $PREREQ 'send-email relays -v 3 to format-patch' '
+	test_when_finished "rm -f out" &&
+	git send-email --dry-run -v 3 -1 >out &&
+	grep "PATCH v3" out
+'
+
 test_expect_success $PREREQ 'test that sendmail config is rejected' '
 	test_config sendmail.program sendmail &&
 	test_must_fail git send-email \

base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0
-- 
2.38.1

