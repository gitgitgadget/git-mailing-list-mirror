From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2 1/2] completion: Add sequencer function
Date: Sat, 30 May 2015 18:01:50 +0200
Message-ID: <1433001710.5113.8.camel@virtuell-zuhause.de>
References: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 18:01:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyjCv-0001aq-Mi
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 18:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbbE3QBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 12:01:53 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:33649 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755351AbbE3QBw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 May 2015 12:01:52 -0400
Received: from p5ddc33fc.dip0.t-ipconnect.de ([93.220.51.252] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1YyjCo-0004nv-R2; Sat, 30 May 2015 18:01:50 +0200
In-Reply-To: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1433001712;43fcb5aa;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270288>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 48 +++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bfc74e9..f6e5bf6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -851,15 +851,40 @@ __git_count_arguments ()
 	printf "%d" $c
 }
 
+__git_complete_sequencer ()
+{
+	local dir="$(__gitdir)"
+
+	case "$1" in
+	am)
+		if [ -d "$dir"/rebase-apply ]; then
+			__gitcomp "--skip --continue --resolved --abort"
+			return 0
+		fi
+		;;
+	cherry-pick)
+		if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
+			__gitcomp "--continue --quit --abort"
+			return 0
+		fi
+		;;
+	rebase)
+		if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+			__gitcomp "--continue --skip --abort"
+			return 0
+		fi
+		;;
+	esac
+
+	return 1
+}
+
 __git_whitespacelist="nowarn warn error error-all fix"
 
 _git_am ()
 {
-	local dir="$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ]; then
-		__gitcomp "--skip --continue --resolved --abort"
-		return
-	fi
+	__git_complete_sequencer "am" && return
+
 	case "$cur" in
 	--whitespace=*)
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
@@ -1044,11 +1069,8 @@ _git_cherry ()
 
 _git_cherry_pick ()
 {
-	local dir="$(__gitdir)"
-	if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "--continue --quit --abort"
-		return
-	fi
+	__git_complete_sequencer "cherry-pick" && return
+
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --no-commit --signoff --strategy= --mainline"
@@ -1666,11 +1688,7 @@ _git_push ()
 
 _git_rebase ()
 {
-	local dir="$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort"
-		return
-	fi
+	__git_complete_sequencer "rebase" && return
 	__git_complete_strategy && return
 	case "$cur" in
 	--whitespace=*)
