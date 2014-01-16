From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 1/6] submodule: Make 'checkout' update_module explicit
Date: Wed, 15 Jan 2014 20:10:22 -0800
Message-ID: <43e8f3bfdaffefca9edd7a23574816630690e1e5.1389837412.git.wking@tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 05:11:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3eIp-0001Lu-Iw
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 05:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbaAPELb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 23:11:31 -0500
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:58048
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbaAPELa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 23:11:30 -0500
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id EU501n00317dt5G5EUBVep; Thu, 16 Jan 2014 04:11:29 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id EUBT1n00M152l3L3ZUBUA2; Thu, 16 Jan 2014 04:11:29 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id 1F29FEFE487;
	Wed, 15 Jan 2014 20:11:27 -0800 (PST)
Received: (nullmailer pid 18536 invoked by uid 1000);
	Thu, 16 Jan 2014 04:11:03 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
In-Reply-To: <cover.1389837412.git.wking@tremily.us>
References: <cover.1389837412.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389845489;
	bh=tsks5nLsVwUxt0PVKpA6OV/O6BRs1Y7y5ZOeQHSQsmg=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=pJ1PPJ7FVIOY14Zsii+Spqe/2usc5EshaPwdcqEK0XQNP2H7RUCXJGT2z4bc0Y+jG
	 TlBezWV+hoOZRZUVz1yIASyFoiR/vnu4oK1J/YUtNxDxVpQuM2bOaSRfrgia/Eobmv
	 qtoj2ckVSzx24cxdmi8rWLWoW9bCecihBErJH1Dq7EnepThCDAX46PYbheFa0In1rp
	 kd4RJKYHs0UCQRy07+/VVI6bqKh+2yhPMB0JPtjzbh5CkxOI7+vx7MAZuPD4jXwn9+
	 vU6LciO6pVcRBa2aO5mR+SKRl0E50oOsXzOlxPinOEX4HgLk9w7m/8Cr3h974eIOmM
	 SzCUlwjlan3AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240500>

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
