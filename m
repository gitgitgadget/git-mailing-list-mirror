From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/5] pull: add merge-ff-only option
Date: Sun,  8 Sep 2013 20:23:15 -0500
Message-ID: <1378689796-19305-5-git-send-email-felipe.contreras@gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 03:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqHT-0001HK-8h
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab3IIB2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:28:40 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39984 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3IIB2i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:28:38 -0400
Received: by mail-oa0-f54.google.com with SMTP id j10so6084157oah.27
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sF8NsexeGjM4RgwjAcMFIUanA5c5xvHQsyot2Rwda/g=;
        b=qKijMQcc9UJQoAmx54LklolvKJN2PTaOxqg+vdQOtBRNLFYOC0G2sfFGQQgAFfqj/4
         41jhSgRgD41wtxNHd93ebrE9il9cF36GsJ4zj1cb6pxa3xpdkBdyfcInTOITXJkwtgui
         ZZ3Qwo+7wCIuKL42jtM0P3XWFJPNOyF3n4YRISfaHvyps61oP3QFnlMyZXMaic2E5ftM
         n6nwF4oEkTxvo09Kdl2HLUnxJWpriuE8jmhxudh966qe1+AeIxSI7Zep+JbUF53TwpPq
         AxgjjfsXJHzDqEdZZD8qxcAS4LWstiHqrGQdHbf4sMuIfHc5W2zlZuXuBuGoUqN0hAaQ
         b7Zw==
X-Received: by 10.60.116.230 with SMTP id jz6mr9880667oeb.21.1378690118433;
        Sun, 08 Sep 2013 18:28:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm10414251obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 18:28:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234296>

It is very typical for Git newcomers to inadvertently create merges and
worst; inadvertently pushing them. This is one of the reasons many
experienced users prefer to avoid 'git pull', and recommend newcomers to
avoid it as well.

To avoid these problems and keep 'git pull' useful, it has been
suggested that 'git pull' barfs by default if the merge is
non-fast-forward, which unfortunately would break backwards
compatibility.

This patch leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it; pull.mode =
merge-ff-only.

Later on this mode can be enabled by default (e.g. in v2.0).

For the full discussion you can read:

http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225305

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt |  8 +++++---
 git-pull.sh              | 12 ++++++++++++
 t/t5520-pull.sh          | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9489a59..13635e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1822,9 +1822,11 @@ pretty.<name>::
 
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
-	rebase the fetched branch. The possible values are 'merge' and
-	'rebase'. See "branch.<name>.pullmode" for doing this in a non
-	branch-specific manner.
+	rebase the fetched branch. The possible values are 'merge',
+	'rebase', and 'merge-ff-only'. If 'merge-ff-only' is specified, the
+	merge will only succeed if it's fast-forward. See
+	"branch.<name>.pullmode" for doing this in a non branch-specific
+	manner.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
diff --git a/git-pull.sh b/git-pull.sh
index fbb8a9b..580d633 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -62,6 +62,7 @@ then
 		echo "Please use pull.mode and branch.<name>.pullmode instead."
 	fi
 fi
+test -z "$mode" && mode=merge
 dry_run=
 while :
 do
@@ -282,6 +283,17 @@ case "$merge_head" in
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
 	;;
+*)
+	# check if a non-fast-foward merge would be needed
+	merge_head=${merge_head% }
+	if test "$mode" = merge-ff-only -a -z "$no_ff$ff_only${squash#--no-squash}" &&
+		test -n "$orig_head" &&
+		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
+		! git merge-base --is-ancestor "$merge_head" "$orig_head"
+	then
+		die "The pull was not fast-forward, please either merge or rebase."
+	fi
+	;;
 esac
 
 # Pulling into unborn branch: a shorthand for branching off
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 978a3c1..798ae2f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -310,4 +310,40 @@ test_expect_success 'branch.to-rebase.pullmode should override pull.mode' '
 	test new = $(git show HEAD:file2)
 '
 
+test_expect_success 'git pull fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull
+'
+
+test_expect_success 'git pull non-fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
+test_expect_success 'git pull non-fast-forward (merge)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --merge
+'
+
 test_done
-- 
1.8.4-338-gefd7fa6
