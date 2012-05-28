From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodules: print "registered for path" message only once
Date: Mon, 28 May 2012 21:46:58 +0200
Message-ID: <4FC3D632.6030604@web.de>
References: <1338198114-20480-1-git-send-email-nviennot+sidnair@viennot.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Viennot and Sid Nair <nviennot+sidnair@viennot.biz>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Nicolas Viennot <nicolas@viennot.biz>,
	Sid Nair <sidnair09@gmail.com>, Heiko Voigt <hvoigt@hvoigt.net>
To: Nicolas Viennot and Sid Nair <nicolas@viennot.com>
X-From: git-owner@vger.kernel.org Mon May 28 21:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ5uJ-0007uc-SA
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 21:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986Ab2E1TrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 15:47:07 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:37830 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab2E1TrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 15:47:06 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate02.web.de (Postfix) with ESMTP id EFCB71C4FFE5D
	for <git@vger.kernel.org>; Mon, 28 May 2012 21:47:03 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.180.110]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LpwMZ-1S4Pa642FD-00fgZb; Mon, 28 May 2012 21:47:03
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1338198114-20480-1-git-send-email-nviennot+sidnair@viennot.biz>
X-Provags-ID: V02:K0:uCXXvkNj+EX7eGiC5fTLnfnf9EWKy1O+qZSVuCW+3mG
 HFUUN9csQI5UntQvINrvqCV/oILtTSmI4HQxyimG6Q09pV5855
 KawEer2/pgXxaImdTz2IVIAYZlPjci3tHMWIZn1PciRQLdPE6j
 BylTtcX24MS2YflOhAb2HRWWxYL/KS7SZQGEUPcXXfQJUQwvmC
 1y5gLu/7k0f2M+DhBtVJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198718>

Since 2cd9de3e (submodule add: always initialize .git/config entry) the
message "Submodule '\$name' (\$url) registered for path '\$sm_path'" is
printed every time cmd_init() is called, e.g. each time "git submodule
update" is used with the --init option.

This was not intended and leads to bogus output which can confuse users
and build systems. Apart from that the $url variable was not set after the
first run which did the actual initialization and only "()" was printed
in subsequent runs where "($url)" was meant to inform the user about the
upstream repo.

Fix that by moving the say command in question into the if block where the
url is initialized, restoring the behavior that was in place before the
2cd9de3e commit. While at it also remove the comment which still describes
the logic used before 2cd9de3e and add a comment about how things work now.

Reported-by: Nicolas Viennot and Sid Nair <nicolas@viennot.com>
Reported-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 28.05.2012 11:41, schrieb Nicolas Viennot and Sid Nair:
> When git submodule init was called, the $url variable was not initialized
> properly for submodules which have already been initialized. This led
> to two problems.
> 
> First, when all of the submodules were initialized, each showed an empty url
> instead of the actual url.
> 
> Second, when previously initialized submodules were printed after newly
> added submodules, the displayed urls were incorrect.

Thanks for pointing this one out. Me thinks the real culprit here is to
print the "registered for path" message even though that was not what
was done. This popped up last week at $dayjob and I just got around to
do this fix when your patch appeared on the list ;-)


 git-submodule.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..5c61ae2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -396,8 +396,9 @@ cmd_init()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
-		# Skip already registered paths
 		name=$(module_name "$sm_path") || exit
+
+		# Copy url setting when it is not set yet
 		if test -z "$(git config "submodule.$name.url")"
 		then
 			url=$(git config -f .gitmodules submodule."$name".url)
@@ -412,6 +413,8 @@ cmd_init()
 			esac
 			git config submodule."$name".url "$url" ||
 			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
+
+			say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$sm_path'")"
 		fi

 		# Copy "update" setting when it is not set yet
@@ -420,8 +423,6 @@ cmd_init()
 		test -n "$(git config submodule."$name".update)" ||
 		git config submodule."$name".update "$upd" ||
 		die "$(eval_gettext "Failed to register update mode for submodule path '\$sm_path'")"
-
-		say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$sm_path'")"
 	done
 }

-- 
1.7.11.rc0.dirty
