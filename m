From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 4/7] pull: add merge-ff-only option
Date: Sat, 12 Oct 2013 02:01:55 -0500
Message-ID: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:08:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtJ4-000280-G3
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab3JLHIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:08:06 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:40885 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JLHIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:08:04 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so3419116obc.21
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y05NcNXU9S3ETO3m5WgnJ+Jj49M3uoVnI4FAM6SCxEU=;
        b=hWfdeA+RD8+11ibopl7VsewKdr+dLYjOFy0Fa+IK+ovkA3TxkHTUNgQMg60UV7csuf
         jV8e1ujT7N2NJ1z7QN5nMtOqE4o8xbpoCIFipf8L7Rcx/iGHkT2jJPdbxkMWIsBrpeSG
         Ne+Ok5hzhQguZDSrwtoEHzAmTFIcs3URr8uFbvbeKlS4QIUafWvEEBLxs4qn+pYR1csT
         XKE5mn+rxbkzQo1oNVGXwD/M9EnVjxvEa6IxUyIEYi7+9ScmrDHk+xTp38VvzL2j1Eho
         XLYDD3mujq63GKxmKj1O0dqrjpt9c+o5bV2tytur56iI7iRo7NyS2dKE9+ct/8utpF6T
         UZMw==
X-Received: by 10.60.63.116 with SMTP id f20mr17827965oes.29.1381561683655;
        Sat, 12 Oct 2013 00:08:03 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm28620234obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:08:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235948>

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
 git-pull.sh              | 13 +++++++++++++
 t/t5520-pull.sh          | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

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
index fbb8a9b..6e6b887 100755
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
@@ -282,6 +283,18 @@ case "$merge_head" in
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
+		die "$(gettext "The pull was not fast-forward, please either merge or rebase.
+If unsure, run 'git pull --merge'.")"
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
1.8.4-fc
