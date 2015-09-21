From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 12/13] git submodule update: cmd_update_fetch
Date: Mon, 21 Sep 2015 15:39:18 -0700
Message-ID: <1442875159-13027-13-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kU-0006e0-B1
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbbIUWjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36656 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933067AbbIUWjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:40 -0400
Received: by padbj2 with SMTP id bj2so3595812pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AHsIfWcWYv2H8ouLYmEUtVKT4Uwopb6xpUDVNTqajTo=;
        b=eP68IWlFp/IFNM+Q4NCHg0hCnc/AC9r7vlCYYTjiXEolzKtl7OvqBubokFj6KjJXgD
         QlnqsXO8ALaJOjukHd4EuYEqZxQvwAPBowPNZjTR23ENU3ArHw1QoPW9hA4zxBero2H6
         NCmr3hVkkhXSF+4rqpjzY4o+bHM21riZmflX4uTHFcDfW5Dexed1EWVzOM9msPtoyiYI
         qO2dkUDhUmRo7d7bacBU0OzfLtUOn8kUK1A71l8RPNXe4f61aFHV5P+3U0o3lRizQuuk
         LNmaRcpq5A6BOkfbTWMHxuHea90h2B5YU1IauuOpGIqVVxSgygV/l/1n4VYtjGg/MvsZ
         clsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AHsIfWcWYv2H8ouLYmEUtVKT4Uwopb6xpUDVNTqajTo=;
        b=UVzox8Kxb1Vj3F9E5NOU2nXTswFOGDmJXrhVRmjbYUFPWrcTmpLMFm3/xlKntpjJGf
         zxc9jTFdfFX70hDdWwrGVcStrvfEr7zLkSbHr8NvufIMO+PPdWj0x/rGfKG0Q8nWB7b5
         MSKNUjY5GmLiSmnkYXu7VVOGBGesPtQ4VkjibCYCRhxlKQNa75Ta15KBBmdGhLZeCMPz
         beDnObT9jvKbnDxjubxzaSGKhiJBkluywzVr1EO7Jl3mQUIeM6Qm65J+eGZkgkRdLj02
         V2B1OvfH6vtI1SEm9fNHllv6ufFpOEk5xxffSgLLj0+z1BYZbYz9BsNT0nqgi3cWZ5vH
         kimw==
X-Gm-Message-State: ALoCoQngu9Is2T7gJZZhfBcW3sFYZvWM8is5BQIlMuoKgOGrXIrZ+I6P5QYKdWs72v+PddGD2ZED
X-Received: by 10.66.182.135 with SMTP id ee7mr27753954pac.95.1442875179783;
        Mon, 21 Sep 2015 15:39:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id si1sm26471767pbc.72.2015.09.21.15.39.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278342>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 164 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 84 insertions(+), 80 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7f11158..a1bc8d5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -625,6 +625,89 @@ cmd_update_clone()
 	cmd_update_recursive
 }
 
+cmd_update_fetch()
+{
+	subsha1=$(clear_local_git_env; cd "$sm_path" &&
+		git rev-parse --verify HEAD) ||
+	die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
+
+	if test -n "$remote"
+	then
+		if test -z "$nofetch"
+		then
+			# Fetch remote before determining tracking $sha1
+			(clear_local_git_env; cd "$sm_path" && git-fetch) ||
+			die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+		fi
+		remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
+		sha1=$(clear_local_git_env; cd "$sm_path" &&
+			git rev-parse --verify "${remote_name}/${branch}") ||
+		die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
+	fi
+
+	if test "$subsha1" != "$sha1" || test -n "$force"
+	then
+		subforce=$force
+		# If we don't already have a -f flag and the submodule has never been checked out
+		if test -z "$subsha1" && test -z "$force"
+		then
+			subforce="-f"
+		fi
+
+		if test -z "$nofetch"
+		then
+			# Run fetch only if $sha1 isn't present or it
+			# is not reachable from a ref.
+			(clear_local_git_env; cd "$sm_path" &&
+				( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
+				 test -z "$rev") || git-fetch)) ||
+			die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+		fi
+
+		must_die_on_failure=
+		case "$update_module" in
+		checkout)
+			command="git checkout $subforce -q"
+			die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
+			say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
+			;;
+		rebase)
+			command="git rebase"
+			die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
+			say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
+			must_die_on_failure=yes
+			;;
+		merge)
+			command="git merge"
+			die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
+			say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
+			must_die_on_failure=yes
+			;;
+		!*)
+			command="${update_module#!}"
+			die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
+			say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
+			must_die_on_failure=yes
+			;;
+		*)
+			die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+		esac
+
+		if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+		then
+			say "$say_msg"
+		elif test -n "$must_die_on_failure"
+		then
+			die_with_status 2 "$die_msg"
+		else
+			err="${err};$die_msg"
+			return
+		fi
+	fi
+
+	cmd_update_recursive
+}
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -743,88 +826,9 @@ Maybe you want to use 'update --init'?")"
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
 			cmd_update_clone
-			continue
 		else
-			subsha1=$(clear_local_git_env; cd "$sm_path" &&
-				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
+			cmd_update_fetch
 		fi
-
-		if test -n "$remote"
-		then
-			if test -z "$nofetch"
-			then
-				# Fetch remote before determining tracking $sha1
-				(clear_local_git_env; cd "$sm_path" && git-fetch) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
-			fi
-			remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
-			sha1=$(clear_local_git_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
-		fi
-
-		if test "$subsha1" != "$sha1" || test -n "$force"
-		then
-			subforce=$force
-			# If we don't already have a -f flag and the submodule has never been checked out
-			if test -z "$subsha1" && test -z "$force"
-			then
-				subforce="-f"
-			fi
-
-			if test -z "$nofetch"
-			then
-				# Run fetch only if $sha1 isn't present or it
-				# is not reachable from a ref.
-				(clear_local_git_env; cd "$sm_path" &&
-					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
-					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
-			fi
-
-			must_die_on_failure=
-			case "$update_module" in
-			checkout)
-				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
-				;;
-			rebase)
-				command="git rebase"
-				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			merge)
-				command="git merge"
-				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			!*)
-				command="${update_module#!}"
-				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
-				must_die_on_failure=yes
-				;;
-			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
-			esac
-
-			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
-			then
-				say "$say_msg"
-			elif test -n "$must_die_on_failure"
-			then
-				die_with_status 2 "$die_msg"
-			else
-				err="${err};$die_msg"
-				continue
-			fi
-		fi
-
-		cmd_update_recursive
 	done
 
 	if test -n "$err"
-- 
2.5.0.275.ge015d2a
