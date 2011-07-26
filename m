From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule: update and add must honor --quiet flag
Date: Tue, 26 Jul 2011 23:39:03 +0200
Message-ID: <4E2F33F7.20407@web.de>
References: <3A1F23B2-AC3F-416C-BFBD-97096724C400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Holtmann-Rice <flyingtabmow@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 23:39:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlpLM-0001AU-6h
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 23:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab1GZVjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 17:39:08 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48059 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab1GZVjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 17:39:06 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2309D1A72A91E;
	Tue, 26 Jul 2011 23:39:04 +0200 (CEST)
Received: from [93.246.54.42] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QlpLE-00056B-00; Tue, 26 Jul 2011 23:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <3A1F23B2-AC3F-416C-BFBD-97096724C400@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18+xPCGoJrk32zEJGjfR5V1qOFhY+V6axDdUD7k
	dnrnLw795uppMpuJOVTMWKaT5DJ/ZG11yxdatooZ+piL8gB8ab
	Q6YlHXTg+EghMsSj8ThA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177903>

When using the --quiet flag "git submodule update" and "git submodule add"
didn't behave as the documentation stated. They printed progress output
from the clone, even though they should only print error messages.

Fix that by passing the -q flag to git clone in module_clone() when the
GIT_QUIET variable is set. Two tests in t7400 have been modified to test
that behavior.

Reported-by: Daniel Holtmann-Rice <flyingtabmow@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 26.07.2011 13:26, schrieb Daniel Holtmann-Rice:
> I can't find a place to submit bug reports, so I'll post this here...

This is the right place.

> the --quiet/-q flag seems to have no effect for 'git submodule update'.  For example (http://pastebin.com/0KWT4EeA):
> 
> #!/bin/bash
> 
> git clone -q git://github.com/dhr/evp-tools.git
> cd evp-tools
> git submodule -q init
> git submodule -q update
> 
> This doesn't run quietly (the first three commands do, the last does not).  I've tried this through Git 1.7.6.

Thanks for reporting this, this patch should fix it.

 git-submodule.sh           |    9 +++++++--
 t/t7400-submodule-basic.sh |    6 ++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc1d3fa..f46862f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -122,12 +122,17 @@ module_clone()
 	path=$1
 	url=$2
 	reference="$3"
+	quiet=
+	if test -n "$GIT_QUIET"
+	then
+		quiet=-q
+	fi

 	if test -n "$reference"
 	then
-		git-clone "$reference" -n "$url" "$path"
+		git-clone $quiet "$reference" -n "$url" "$path"
 	else
-		git-clone -n "$url" "$path"
+		git-clone $quiet -n "$url" "$path"
 	fi ||
 	die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5afe6cc..bc70d69 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -75,7 +75,8 @@ test_expect_success 'submodule add' '

 	(
 		cd addtest &&
-		git submodule add "$submodurl" submod &&
+		git submodule add -q "$submodurl" submod >actual &&
+		test ! -s actual &&
 		git submodule init
 	) &&

@@ -273,7 +274,8 @@ test_expect_success 'update should work when path is an empty dir' '
 	echo "$rev1" >expect &&

 	mkdir init &&
-	git submodule update &&
+	git submodule update -q >update.out &&
+	test ! -s update.out &&

 	inspect init &&
 	test_cmp expect head-sha1
-- 
1.7.6.347.g4db0d.dirty
