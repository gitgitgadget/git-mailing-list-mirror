Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E092DC33C99
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91058206F0
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kX+l0cW9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="cHUENXzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAHAbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:31:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50857 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHAbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 19:31:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 014C02FA1C;
        Tue,  7 Jan 2020 19:31:35 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=o6ygInMUGIauhJFRoyen3ApSul8=; b=kX+l0cW93c6a+fbHLa1v
        wnaQyaYSJ9rKWK2GH6ktDntTugrsngm+nQY+BGpw0PPNWtJZ+6YBwlNIY+auwMzR
        hbdeeGxqhexkILE5rMFFddx0/XAONtmnY94+yN1WhVjCvo+b6LmX0JdhpZUbAdDP
        cPsDPnPeSfjoDKnM2xzrobE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB212FA19;
        Tue,  7 Jan 2020 19:31:34 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=/Huzdv/RkRo93vZgRF+4+2c9hcoNaBIKnNK3uB7PFII=;
 b=cHUENXzdLvAtQNZTZS8MdN/9B9b4KepGuYX3y7l/OeCp2wllDxoNpyYcKRiLG2DpQKmHscFB49yLHLcZ5rt+JxOTKtdErmHcSMOza8IAP3jtJm4g/byFta3hwHcrWX3X9dkS+pXx0EbMT0Su6Wv1dZoHl7j45hzQUHPkzzW4JjQ=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 480272FA18;
        Tue,  7 Jan 2020 19:31:34 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Yaroslav O Halchenko <debian@onerussian.com>
Subject: [PATCH] submodule add: show 'add --dry-run' stderr when aborting
Date:   Tue,  7 Jan 2020 19:31:21 -0500
Message-Id: <20200108003121.28034-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Pobox-Relay-ID: 3944A980-31AE-11EA-8539-D1361DBA3BAF-24757444!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless --force is specified, 'submodule add' checks if the destination
path is ignored by calling 'git add --dry-run --ignore-missing', and,
if that call fails, aborts with a custom "path is ignored" message (a
slight variant of what 'git add' shows).  Aborting early rather than
letting the downstream 'git add' call fail is done so that the command
exits before cloning into the destination path.  However, in rare
cases where the dry-run call fails for a reason other than the path
being ignored---for example, due to a preexisting index.lock
file---displaying the "ignored path" error message hides the real
source of the failure.

Instead of displaying the tailored "ignored path" message, let's
report the standard error from the dry run to give the caller more
accurate information about failures that are not due to an ignored
path.

For the ignored path case, this leads to the following change in the
error message:

  The following [-path is-]{+paths are+} ignored by one of your .gitignor=
e files:
  <destination path>
  Use -f if you really want to add [-it.-]{+them.+}

The new phrasing is a bit awkward, because 'submodule add' is only
dealing with one destination path.  Alternatively, we could continue
to use the tailored message when the exit code is 1 (the expected
status for a failure due to an ignored path) and relay the standard
error for all other non-zero exits.  That, however, risks hiding the
message of unrelated failures that share an exit code of 1, so it
doesn't seem worth doing just to avoid a clunkier, but still clear,
error message.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 git-submodule.sh           | 14 ++++++++------
 t/t7400-submodule-basic.sh | 15 +++++++++++++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index aaa1809d24..afcb4c0948 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,13 +241,15 @@ cmd_add()
 	    die "$(eval_gettext "'\$sm_path' does not have a commit checked out=
")"
 	fi
=20
-	if test -z "$force" &&
-		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path=
" > /dev/null 2>&1
+	if test -z "$force"
 	then
-		eval_gettextln "The following path is ignored by one of your .gitignor=
e files:
-\$sm_path
-Use -f if you really want to add it." >&2
-		exit 1
+	    dryerr=3D$(git add --dry-run --ignore-missing --no-warn-embedded-re=
po "$sm_path" 2>&1 >/dev/null)
+	    res=3D$?
+	    if test $res -ne 0
+	    then
+		 echo >&2 "$dryerr"
+		 exit $res
+	    fi
 	fi
=20
 	if test -n "$custom_name"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7f75bb1be6..42a00f95b9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -156,9 +156,9 @@ test_expect_success 'submodule add to .gitignored pat=
h fails' '
 	(
 		cd addtest-ignore &&
 		cat <<-\EOF >expect &&
-		The following path is ignored by one of your .gitignore files:
+		The following paths are ignored by one of your .gitignore files:
 		submod
-		Use -f if you really want to add it.
+		Use -f if you really want to add them.
 		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
@@ -191,6 +191,17 @@ test_expect_success 'submodule add to reconfigure ex=
isting submodule with --forc
 	)
 '
=20
+test_expect_success 'submodule add relays add --dry-run stderr' '
+	test_when_finished "rm -rf addtest/.git/index.lock" &&
+	(
+		cd addtest &&
+		: >.git/index.lock &&
+		! git submodule add "$submodurl" sub-while-locked 2>output.err &&
+		test_i18ngrep "^fatal: .*index\.lock" output.err &&
+		test_path_is_missing sub-while-locked
+	)
+'
+
 test_expect_success 'submodule add --branch' '
 	echo "refs/heads/initial" >expect-head &&
 	cat <<-\EOF >expect-heads &&

base-commit: 042ed3e048af08014487d19196984347e3be7d1c
--=20
2.24.1

