From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 27/31] rebase -m: remember allow_rerere_autoupdate option
Date: Tue, 28 Dec 2010 10:30:44 +0100
Message-ID: <1293528648-21873-28-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYs-0005Wr-Fx
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab0L1Pdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:35 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48315 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab0L1PdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:10 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so10443701qyk.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kxhwY986oa5iWxlvL/BP7yCIr8fGAPGqmB+wgtShw14=;
        b=vHe8zSHx6Ztm+UHms3O+9bxTyr5VS2FIcnSn7+z7W31GBzmaCXComglkJWQpfXoVR9
         ExeuSxrmMU2CE3crDbJS5RwFBUEKh0nzUJbFBklnkVgmJBpKTgYHCT417WOB3uXNCc/3
         Uo4JkWEDLCWEnj/arrNfzvyZmCZ7ADNM02ihs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nfl7b12EEXlhMG/SBlIGCGnZSNaV8IlsQG/X36BU2OOeW3OD7D3+uiwZLottnTJuLM
         /muIqFYWCeA8SGtclrNVOPuDxoruWlk89VLVYz/r3CIf7HiFkVP+Eei2dh4v2l8xE+fS
         f1u4bOG8Hnit+xzIpIx4R97DSGF0ldg3cWlnU=
Received: by 10.229.213.211 with SMTP id gx19mr12005559qcb.172.1293550389994;
        Tue, 28 Dec 2010 07:33:09 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:09 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164264>

If '--[no-]allow_rerere_autoupdate' is passed when 'git rebase -m' is
called and a merge conflict occurs, the flag will be forgotten for the
rest of the rebase process. Make rebase remember it by saving the
value.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

allow_rerere_autoupdate is only used by git-rebase--merge. Still ok to
write and read it here?

Should allow_rerere_autoupdate also be added to git_am_opt?

 git-rebase.sh              |    4 ++++
 t/t3418-rebase-continue.sh |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d192038..05b4fe1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -81,6 +81,8 @@ read_basic_state () {
 	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
 	test -f "$state_dir"/strategy_opts &&
 		strategy_opts="$(cat "$state_dir"/strategy_opts)"
+	test -f "$state_dir"/allow_rerere_autoupdate &&
+		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
 }
 
 write_basic_state () {
@@ -97,6 +99,8 @@ write_basic_state () {
 	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
 	test -n "$strategy_opts" && echo "$strategy_opts" > \
 		"$state_dir"/strategy_opts
+	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
+		"$state_dir"/allow_rerere_autoupdate
 }
 
 output () {
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 5469546..1e855cd 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -74,4 +74,25 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
+test_expect_success 'rebase --continue remembers --rerere-autoupdate' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F3-on-topic-branch &&
+	git checkout master
+	test_commit "commit-new-file-F3" F3 3 &&
+	git config rerere.enabled true &&
+	test_must_fail git rebase -m master topic &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	test_must_fail git rebase --continue &&
+	echo "Resolved" >F3 &&
+	git add F3 &&
+	git rebase --continue &&
+	git reset --hard topic@{1} &&
+	test_must_fail git rebase -m --rerere-autoupdate master &&
+	test "$(cat F2)" = "Resolved" &&
+	test_must_fail git rebase --continue &&
+	test "$(cat F3)" = "Resolved" &&
+	git rebase --continue
+'
+
 test_done
-- 
1.7.3.2.864.gbbb96
