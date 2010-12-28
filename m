From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 26/31] rebase: remember strategy and strategy options
Date: Tue, 28 Dec 2010 10:30:43 +0100
Message-ID: <1293528648-21873-27-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYp-0005Wr-Oz
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab0L1PdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:16 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58332 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab0L1PdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:08 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11286158qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9SikuF9pZAfWxrgHfxaIee7I+jJwMtFUzsr+htRKIH0=;
        b=d0h/n7BF+mlmgMgGdPgMMU5rF6w4jQ9sJW4AfwlU3kJspVbYpzOpqQwA/bpJ7MzO9d
         MNZgbjnSp6MclRTMRSv0fA4GOesB+oQlrraEjxMB2RZdj3e7LPUpJ+8kT3MpM6DSdVAd
         6l9FNCLilmK9gwE/P9NmOt3JE6IDcV5YOdIq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hd7EkNCZ5W214HtfRYY6CrKZhXjpD1SD1YXvlpsiE6lnVRWl8K5HN06Oh0aqrkI8h1
         vGAxbifXfEZPGdTBRdytRfd5EkD5Ow6wrYxUhKX+uU8Xj0kbwwR3E3tQsD+ys2NOAliO
         JdI6CoXpS1NbRN871Z4um/Ojwu24E8PYAwLUw=
Received: by 10.224.37.141 with SMTP id x13mr13386852qad.76.1293550388361;
        Tue, 28 Dec 2010 07:33:08 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:07 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164269>

When a rebase is resumed, interactive rebase remembers any merge
strategy passed when the rebase was initated. Make non-interactive
rebase remember any merge strategy as well. Also make non-interactive
rebase remember any merge strategy options.

To be able to resume a rebase that was initiated with an older version
of git (older than this commit), make sure not to expect the saved
option files to exist.

Test case idea taken from Junio's 71fc224 (t3402: test "rebase
-s<strategy> -X<opt>", 2010-11-11).

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

How to add support for strategy options to interactive rebase?

 git-rebase--interactive.sh |    2 --
 git-rebase.sh              |    6 ++++++
 t/t3418-rebase-continue.sh |   29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7809932..0763ef5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -584,7 +584,6 @@ skip_unnecessary_picks () {
 
 get_saved_options () {
 	test -d "$REWRITTEN" && preserve_merges=t
-	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
 	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
@@ -713,7 +712,6 @@ case "$rebase_root" in
 *)
 	: >"$state_dir"/rebase-root ;;
 esac
-test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
diff --git a/git-rebase.sh b/git-rebase.sh
index e5be7e5..d192038 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -78,6 +78,9 @@ read_basic_state () {
 	fi &&
 	GIT_QUIET=$(cat "$state_dir"/quiet) &&
 	test -f "$state_dir"/verbose && verbose=t
+	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
+	test -f "$state_dir"/strategy_opts &&
+		strategy_opts="$(cat "$state_dir"/strategy_opts)"
 }
 
 write_basic_state () {
@@ -91,6 +94,9 @@ write_basic_state () {
 	fi &&
 	echo "$GIT_QUIET" > "$state_dir"/quiet &&
 	test t = "$verbose" && : > "$state_dir"/verbose
+	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
+	test -n "$strategy_opts" && echo "$strategy_opts" > \
+		"$state_dir"/strategy_opts
 }
 
 output () {
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 1d90191..5469546 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -45,4 +45,33 @@ test_expect_success 'rebase --continue can not be used with other options' '
 	test_must_fail git rebase --continue -v
 '
 
+test_expect_success 'rebase --continue remembers merge strategy and options' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
+	test_when_finished "rm -fr test-bin funny.was.run" &&
+	mkdir test-bin &&
+	cat >test-bin/git-merge-funny <<-EOF
+	#!$SHELL_PATH
+	case "\$1" in --opt) ;; *) exit 2 ;; esac
+	shift &&
+	>funny.was.run &&
+	exec git merge-recursive "\$@"
+	EOF
+	chmod +x test-bin/git-merge-funny &&
+	(
+		PATH=./test-bin:$PATH
+		test_must_fail git rebase -s funny -Xopt master topic
+	) &&
+	test -f funny.was.run &&
+	rm funny.was.run &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	(
+		PATH=./test-bin:$PATH
+		git rebase --continue
+	) &&
+	test -f funny.was.run
+'
+
 test_done
-- 
1.7.3.2.864.gbbb96
