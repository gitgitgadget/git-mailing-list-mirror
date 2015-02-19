From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD/PATCH] stash: introduce checkpoint mode
Date: Thu, 19 Feb 2015 13:34:03 +0100
Message-ID: <dbd1aae0508bd72dc3b21fabda4c420eef487720.1424349039.git.git@drmicha.warpmail.net>
References: <54E5C27E.9060109@drmicha.warpmail.net>
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Armin Ronacher <armin.ronacher@active-4.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 13:34:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOQJ8-0007Pn-9c
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 13:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbbBSMeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 07:34:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60065 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752459AbbBSMeG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 07:34:06 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 6D5D8209DD
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 07:34:05 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 19 Feb 2015 07:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=AX7ZhMZJRoJNos
	yROpBnYgH3p1c=; b=mamHRjp1KxrArmQAgJ7wuM1qPGDa0gbS7GpFfx4x7EpUaN
	kzi6eBsFTb1bsb5XKfe8Kx73cQp93dU+zKkHpute7J8546jSj5Dt/YtZFE3s/ern
	wCme/TG26n08/tEJcEtOBfWFwntpMDsjoJGlnU7z243fcwApEaMl1KKAo/rE0=
X-Sasl-enc: d9Wx2vkAr1fTsUWOgd9sjZobehTnFxUBM9Fc7mU7RUwa 1424349245
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 08606C002A4;
	Thu, 19 Feb 2015 07:34:04 -0500 (EST)
X-Mailer: git-send-email 2.3.0.191.ge77e8b9
In-Reply-To: <54E5C27E.9060109@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264094>

"git stash save" performs the steps "create-store-reset". Often,
users try to use "stash save" as a way to to save their current state
(index, worktree) before an operation like "checkout/reset --patch" they
don't feel confident about, and are forced to do "git stash save && git
stash apply".

Provide an extra mode that does "create-store" only without the reset,
so that one can "ceckpoint" the sate and keep working on it.

Suggested-by: "Kyle J. McKay" <mackyle@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    I'm not sure about how to best expose this mode:
    
    git stash checkpoint
    git stash save --checkpoint
    
    Maybe it is best to document the former and rename "--checkpoint"
    to "--no-reset"?
    
    Also, a "safe return" to a checkpoint probably requires
    
    git reset --hard && git stash pop
    
    although "git stash pop" will do in many cases. Should we provide a shortcut
    "restore" which does the reset-and-pop?

 git-stash.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index d4cf818..42f140c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -193,12 +193,16 @@ store_stash () {
 }
 
 save_stash () {
+	checkpoint=
 	keep_index=
 	patch_mode=
 	untracked=
 	while test $# != 0
 	do
 		case "$1" in
+		-c|--checkpoint)
+			checkpoint=t
+			;;
 		-k|--keep-index)
 			keep_index=t
 			;;
@@ -267,6 +271,11 @@ save_stash () {
 	die "$(gettext "Cannot save the current status")"
 	say Saved working directory and index state "$stash_msg"
 
+	if test -n "$checkpoint"
+	then
+		exit 0
+	fi
+
 	if test -z "$patch_mode"
 	then
 		git reset --hard ${GIT_QUIET:+-q}
@@ -576,6 +585,10 @@ save)
 	shift
 	save_stash "$@"
 	;;
+checkpoint)
+	shift
+	save_stash "--checkpoint" "$@"
+	;;
 apply)
 	shift
 	apply_stash "$@"
-- 
2.3.0.191.ge77e8b9
