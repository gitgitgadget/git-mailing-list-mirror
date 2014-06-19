From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC PATCH 6/7] rebase -i: Prepare for squash in terms of do_pick
 --amend
Date: Thu, 19 Jun 2014 05:28:45 +0200
Message-ID: <53A258ED.1020604@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:28:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxT1y-0003Bb-OJ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 05:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979AbaFSD2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 23:28:50 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33032 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbaFSD2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 23:28:49 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so2101551wib.15
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 20:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=4gTj8nnv7u6eEC+gxSEA24XwJl16fTx9AlqgjlYUNIg=;
        b=RCzyVn/2koMSAL5hx6b277ABQslykghF3w7WTMM+ssHFgvb0gedIJ2MybpGtyJ7kJ3
         w0RolkuWuePx+HFd8WiiiO+c/vPFO1yayMj3Wat5rIbluw4cuVlYFep/bDDeD6Ek5UO2
         LBcA5eu9xCC/c3jRSWpfrPmhzYaSF1XXNoDJVxJc7HleY4+Bmvjg6zuyVBlDrDyjDCsE
         KTD/DoDFsy4R5Sed2JpKDMkeoe9BljdryNF+Mr7ozKMonjGrln5E5tiyCIb0HmoQEG3S
         ljVaSAJiD5X4BmQza42b1vbD/+TIpTN1L0kPNKXxa3ESonl2enx9fTvP/KlN7GgrLwHp
         UrFg==
X-Received: by 10.180.218.4 with SMTP id pc4mr2367056wic.21.1403148528104;
        Wed, 18 Jun 2014 20:28:48 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id cz4sm29246367wib.23.2014.06.18.20.28.46
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 20:28:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <cover.1403146774.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252094>

Rewrite `squash` and `fixup` handling in `do_next` using the atomic
sequence

    pick_one
    commit

in order to test the correctness of a single `do_squash` or parametrized
`do_pick` and make the subsequent patch reimplementing `squash` in terms
of such a single function more readable.

Might be squashed into the subsequent commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e4992dc..ada520d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -613,15 +613,15 @@ do_next () {
 		author_script_content=$(get_author_ident_from_commit HEAD)
 		echo "$author_script_content" > "$author_script"
 		eval "$author_script_content"
-		if ! pick_one -n $sha1
-		then
-			git rev-parse --verify HEAD >"$amend"
-			die_failed_squash $sha1 "$rest"
-		fi
 		case "$(peek_next_command)" in
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
+			if ! pick_one -n $sha1
+			then
+				git rev-parse --verify HEAD >"$amend"
+				die_failed_squash $sha1 "Could not apply $sha1... $rest"
+			fi
 			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die_failed_squash $sha1 "$rest"
@@ -630,12 +630,22 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
+				if ! pick_one -n $sha1
+				then
+					git rev-parse --verify HEAD >"$amend"
+					die_failed_squash $sha1 "Could not apply $sha1... $rest"
+				fi
 				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
+				if ! pick_one -n $sha1
+				then
+					git rev-parse --verify HEAD >"$amend"
+					die_failed_squash $sha1 "Could not apply $sha1... $rest"
+				fi
 				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
-- 
2.0.0
