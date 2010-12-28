From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 25/31] rebase: remember verbose option
Date: Tue, 28 Dec 2010 10:30:42 +0100
Message-ID: <1293528648-21873-26-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYt-0005Wr-0j
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0L1Pdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:38 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60539 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0L1PdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:06 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9392227qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vni4JJWUdujd2O5EUDncPJd5bfUH+3hq5Pqg7/umPiQ=;
        b=EOZbqxFMNn0YJos8YcumUJX0X9EogaS7aHwotnaTt3dh7Z/clflxwqlHAMNTamsKFF
         r5CYTH3zpazw+yqKdq7RPFyIl/zGCwnHUiXu00OxAIu2MSqORJLsjRvtg5PAUrL3WZee
         brLWgH/oQEyFV1U2hhLBVJPUMjMTUWuuCLDJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ujZFvTDknSMOu+ispnVqCbRlepgt7tHcIeySisnr4dTzk4gDIKWWCovBp9Wip/A2rS
         3j8+G+A7uJKVi8P2669N9rqrn40W3h3owipmEnerFtoR3nMOWimVdBXiu0+MQHe4Kkgc
         iWZ2+l5lglUv8Al9PxJBHUn30vl3eXmuMtmBQ=
Received: by 10.224.6.67 with SMTP id 3mr12915857qay.80.1293550386585;
        Tue, 28 Dec 2010 07:33:06 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:05 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164265>

Currently, only interactive rebase remembers the value of the '-v'
flag from the initial invocation. Make non-interactive rebase also
remember it.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    2 --
 git-rebase.sh              |    6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a33b246..7809932 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -585,7 +585,6 @@ skip_unnecessary_picks () {
 get_saved_options () {
 	test -d "$REWRITTEN" && preserve_merges=t
 	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
-	test -f "$state_dir"/verbose && verbose=t
 	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
@@ -715,7 +714,6 @@ case "$rebase_root" in
 	: >"$state_dir"/rebase-root ;;
 esac
 test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
-test t = "$verbose" && : > "$state_dir"/verbose
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
diff --git a/git-rebase.sh b/git-rebase.sh
index 95c0d05..e5be7e5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -76,7 +76,8 @@ read_basic_state () {
 	else
 		orig_head=$(cat "$state_dir"/orig-head)
 	fi &&
-	GIT_QUIET=$(cat "$state_dir"/quiet)
+	GIT_QUIET=$(cat "$state_dir"/quiet) &&
+	test -f "$state_dir"/verbose && verbose=t
 }
 
 write_basic_state () {
@@ -88,7 +89,8 @@ write_basic_state () {
 	else
 		echo "$orig_head" > "$state_dir"/orig-head
 	fi &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet
+	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t = "$verbose" && : > "$state_dir"/verbose
 }
 
 output () {
-- 
1.7.3.2.864.gbbb96
