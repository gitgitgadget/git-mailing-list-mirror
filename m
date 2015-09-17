From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/10] git submodule update: cmd_update_fetch
Date: Wed, 16 Sep 2015 18:39:08 -0700
Message-ID: <1442453948-9885-11-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAn-0006Ku-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbbIQBja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:30 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33434 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbIQBjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:25 -0400
Received: by pacex6 with SMTP id ex6so4763769pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h60SJF+8fqZurpJMHl7RjBeA79C3dDEJnxc1yLh6+pM=;
        b=VacsjmKna9JIwX0B77FlV3tOPmrPKQBCGjr6Ho7gnNMY/YKVCYBeeUblLCJaKChfeo
         1e0DPiZRicguyFwYiHi3sMk/AtyIruRSHwDCQgNM9iYVcXTsxiAQJWFbTklBbaMT8A/0
         GmU57StAlLzDfbR94949/fLXZRb9wNUwg3L7uKhB6U46cSLXRsxkbpZ0H7uYFuk/GmZK
         UCS4nGnN2luEbcb/WIQpWSs5yGghZNzM0UH7Nvo6fFMttWl+WDZpcWpp45VFWvR1QY2E
         6FpqcoF3p68wiyA4Eac+z4PQ9sa5VVER6Qw0qYLxE6fyD/2tJXGwkUWLoAkIgCJQRTDT
         p+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h60SJF+8fqZurpJMHl7RjBeA79C3dDEJnxc1yLh6+pM=;
        b=dCGUDAmy8e7RRiaJPkY8srvhr3FUfCptR/lSvuAjIaVFhZwWrR+veY5DG6/iPvxVfZ
         c9Jb3QYCR/X6Uxu0s0SImoDRfeCKDpc9ynKTuGBaxrc5ZtqwGkiCQ6J4JHugqJ8JBUDg
         x3uEkSKK0Q1rMh1UpCJKrz2wLb2coQstgB18TMDHn9NBnL711aqiRv5GNFy/v/bCyUa5
         DIY3MFdn7kyyRu9RAv9+Jkqcqt2EjQG7xdhhNIKJNrHocTth1lGXfgWzuKJuPG64VDcm
         4m2eTxPuocQu1j+eUfi+1ZXT3XRwVVZH831n3e86y0yy+yux4czn6yzXSNeQqYXilfgT
         CzQg==
X-Gm-Message-State: ALoCoQmMtqoCQGjZXBn9sEMKhShQ50fOHZ+IZbLYce0RPapz00Y7Pvc3kD7bq/bQMTR6jztO6BYi
X-Received: by 10.68.100.36 with SMTP id ev4mr65467725pbb.119.1442453964946;
        Wed, 16 Sep 2015 18:39:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id qv5sm554167pbc.71.2015.09.16.18.39.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:24 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278096>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 164 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 84 insertions(+), 80 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c40d60f..2c9f1f2 100755
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
2.6.0.rc0.131.gf624c3d
