From: Patrick Steinhardt <ps@pks.im>
Subject: [RFC/PATCH 1/4] submodules: implement synchronizing of remotes.
Date: Wed,  8 Apr 2015 12:58:22 +0200
Message-ID: <1428490705-11586-2-git-send-email-ps@pks.im>
References: <1428490705-11586-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 13:17:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfnyx-0007rY-T1
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 13:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbbDHLRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 07:17:15 -0400
Received: from sender1.zohomail.com ([74.201.84.157]:50226 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbDHLRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 07:17:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=tiyeG8i69ps0KoLX23iw5dDrTLm7xo8vkz52JDXxPlBEwLNxPg0LXR2RhkOaiB5f5M82sPqpOH7p
    xc12uubGrxgypV8D2IyOo65d/t9P+ZVpEMzUXWvtjgKUUNHxTH0ccH/6lQy9W39uw7XzoHccsgrJ
    nFAboQzVYwcyOByczsg=  
Received: from localhost (x5ce10f35.dyn.telefonica.de [92.225.15.53]) by mx.zohomail.com
	with SMTPS id 1428490762962965.8892167216995; Wed, 8 Apr 2015 03:59:22 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1428490705-11586-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468 iZSF-HLOLL_2  SGR3_0_01045_96
X-ZohoMail-Owner: <1428490705-11586-2-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.15.53
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266954>

Previously it was not possible to specify custom remotes for
submodules. This feature has now been implemented and can be
accessed by setting the keys 'submodule-remote.$name.$remote.url'
and 'submodule-remote.$name.$remote.push-url', respectively.

When issuing a `git submodule sync` we will test if submodules
have one or more remotes specified and if so those will be either
added if nonexistent or their URLs will be adjusted to match the
specified URLs.
---
 git-submodule.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 36797c3..599a847 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1268,6 +1268,7 @@ cmd_status()
 		fi
 	done
 }
+
 #
 # Sync remote urls for submodules
 # This makes the value for remote.$remote.url match the value
@@ -1347,6 +1348,32 @@ cmd_sync()
 			)
 			fi
 		fi
+
+		git config -f .gitmodules --get-regexp "submodule-remote\.$name\..*\.url" 2>/dev/null |
+		while read key url
+		do
+			remote=$(echo "$key" | sed "s/submodule-remote\.$name\.\(.*\)\.url/\1/")
+			pushurl=$(git config -f .gitmodules --get "submodule-remote.$name.$remote.pushurl")
+
+			(
+				cd "$sm_path"
+
+				if ! git remote | grep "^$remote$" >/dev/null 2>/dev/null
+				then
+					say "$(eval_gettext "Adding remote '$remote' for submodule '$prefix$sm_path'")"
+					git remote add "$remote" "$url"
+				else
+					say "$(eval_gettext "Setting URL for remote '$remote' in submodule '$prefix$sm_path'")"
+					git remote set-url "$remote" "$url"
+				fi
+
+				if test ! -z "$pushurl"
+				then
+					say "$(eval_gettext "Setting push URL for remote '$remote' in submodule '$prefix$sm_path'")"
+					git remote set-url --push "$remote" "$pushurl"
+				fi
+			)
+		done
 	done
 }
 
-- 
2.3.5
