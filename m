From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v5 1/4] submodule: Make 'checkout' update_module explicit
Date: Sun, 26 Jan 2014 12:45:13 -0800
Message-ID: <43e8f3bfdaffefca9edd7a23574816630690e1e5.1390768736.git.wking@tremily.us>
References: <20140117023746.GJ7078@odin.tremily.us>
 <cover.1390768736.git.wking@tremily.us>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 26 21:46:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7Way-0002Yc-LL
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 21:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbaAZUqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 15:46:11 -0500
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:40507
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753144AbaAZUqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 15:46:09 -0500
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id JkkB1n0040QuhwU5Dkm9EQ; Sun, 26 Jan 2014 20:46:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta02.westchester.pa.mail.comcast.net with comcast
	id Jkm61n00l152l3L3Nkm7my; Sun, 26 Jan 2014 20:46:08 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id 538CDF1C337;
	Sun, 26 Jan 2014 12:46:06 -0800 (PST)
Received: (nullmailer pid 2839 invoked by uid 1000);
	Sun, 26 Jan 2014 20:45:23 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
References: <cover.1390768736.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390769169;
	bh=tsks5nLsVwUxt0PVKpA6OV/O6BRs1Y7y5ZOeQHSQsmg=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=CFa3FVYMrudHi/eQ2R2+ugYrBqQ+GSfbv6XK6i/CTmXxe+PHUZaJkpU0f+6LGzFeZ
	 83ZTPVwugl6lji8PxukDt7afGZRV8AvxJyRhx/oHOEGa1QwQS2O81WC/CiYukIHBB5
	 Gy/s/ruuwT+ihOlI9x1XG9R4O5uIgqZcbYxjxOYSQ3RucE1lz561fz6gsBkkTUs4oB
	 aqvFhphVgZTdrXm7QveTV+88GAT+ajo8B/ZWU2LrEy7165OcBU3/s5dmSGKawL32uE
	 iaS+q+rGq9LKJcV8RseTTeb3o3ne8Q2b1shmhG9rq+lT3b66HGdONVNTh2f5yp3YoS
	 FNp/JVnlhfIMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241114>

This avoids the current awkwardness of having either '' or 'checkout'
for checkout-mode updates, which makes testing for checkout-mode
updates (or non-checkout-mode updates) easier.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 git-submodule.sh | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5247f78..5e8776c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -803,17 +803,10 @@ cmd_update()
 			update_module=$update
 		else
 			update_module=$(git config submodule."$name".update)
-			case "$update_module" in
-			'')
-				;; # Unset update mode
-			checkout | rebase | merge | none)
-				;; # Known update modes
-			!*)
-				;; # Custom update command
-			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
-				;;
-			esac
+			if test -z "$update_module"
+			then
+				update_module="checkout"
+			fi
 		fi
 
 		displaypath=$(relative_path "$prefix$sm_path")
@@ -882,11 +875,16 @@ Maybe you want to use 'update --init'?")"
 			case ";$cloned_modules;" in
 			*";$name;"*)
 				# then there is no local change to integrate
-				update_module= ;;
+				update_module=checkout ;;
 			esac
 
 			must_die_on_failure=
 			case "$update_module" in
+			checkout)
+				command="git checkout $subforce -q"
+				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
+				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
+				;;
 			rebase)
 				command="git rebase"
 				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
@@ -906,10 +904,7 @@ Maybe you want to use 'update --init'?")"
 				must_die_on_failure=yes
 				;;
 			*)
-				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
-				;;
+				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
 			esac
 
 			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
-- 
1.8.5.2.8.g0f6c0d1
