From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/6] t9600: adjust for new cvsimport
Date: Sun, 13 Jan 2013 23:52:03 -0800
Message-ID: <7vip70fbh8.fsf_-_@alter.siamese.dyndns.org>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358148351-31552-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 08:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueqK-0008LQ-HC
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab3ANHwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:52:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755610Ab3ANHwG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:52:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08FA698AF;
	Mon, 14 Jan 2013 02:52:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hxXBWMjth3TbV54ElziFIiNwkew=; b=gLUbAw
	xqImycN8cVg28ZcHPwtNl/I3a1gKiKhK21rAbh14Aq/4dx4/2QzX+68a5T3h5Cdp
	vYtm/AfnIW27FqiGUa513h/OoMXcns/CwU61a/5YYFabR5wCnGOwLxo/4N9vt1UU
	nI7Yt/ulgnbu4TTYqWmWvP9G6h+V07jFPaPDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bl4i0zoI1mm4G4YRrqs+9LYcsD8eFi6B
	6OhKfRbRbQByXCDv42F53zoC8kPISOqnjDPN8V15m4kaDjVqhdsgFO81disC4m56
	7lpy3ptRtHvlCcW6x0E5e8MNkXzq/hitMiyE1oYkv2c1Hyo0JamQx55bvew4RU64
	d5BswyGWrko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F165A98AE;
	Mon, 14 Jan 2013 02:52:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4404A98AC; Mon, 14 Jan 2013
 02:52:05 -0500 (EST)
In-Reply-To: <1358148351-31552-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sun, 13 Jan 2013 23:25:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49FD22A8-5E1F-11E2-884D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213468>

The rewritten cvsimport does not skip the latest 10 minutes worth of
CVS commits by default, so there is no need to pass the "-a" option;
it will barf if it sees "-a".

Also it will do the merge itself, so there is no need to merge
"origin" ourselves, either.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is still untested and primarily to illustrate the concept
   introduced by the 5/6 patch, together with 6/6.  Testing by
   interested parties with a working cvsps 3 may be nice.  Something
   like:

    $ make CVSPS3_PATH=/path/to/your/cvsps3/bin/cvsps
    $ cd t && sh t9650-cvsimport3.sh

 t/t9600-cvsimport.sh | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 906cbdc..7b5a9a0 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -42,9 +42,13 @@ EOF
 	)
 '
 
-test_expect_success 'import a trivial module' '
+case "$TEST_CVSPS_VERSION" in
+3)	import_all= ;;
+*)	import_all=-a ;;
+esac &&
 
-	git cvsimport -a -R -z 0 -C module-git module &&
+test_expect_success 'import a trivial module' '
+	git cvsimport $import_all -R -z 0 -C module-git module &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
 '
@@ -90,8 +94,11 @@ test_expect_success 'update git module' '
 
 	(cd module-git &&
 	git config cvsimport.trackRevisions true &&
-	git cvsimport -a -z 0 module &&
-	git merge origin
+	git cvsimport $import_all -z 0 module &&
+	if test "$TEST_CVSPS_VERSION" = 2
+	then
+		git merge origin
+	fi
 	) &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
@@ -119,8 +126,11 @@ test_expect_success 'cvsimport.module config works' '
 	(cd module-git &&
 		git config cvsimport.module module &&
 		git config cvsimport.trackRevisions true &&
-		git cvsimport -a -z0 &&
-		git merge origin
+		git cvsimport $import_all -z0 &&
+		if test "$TEST_CVSPS_VERSION" = 2
+		then
+			git merge origin
+		fi
 	) &&
 	test_cmp module-cvs/tick module-git/tick
 
@@ -140,7 +150,7 @@ test_expect_success 'import from a CVS working tree' '
 	$CVS co -d import-from-wt module &&
 	(cd import-from-wt &&
 		git config cvsimport.trackRevisions false &&
-		git cvsimport -a -z0 &&
+		git cvsimport $import_all -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
 		test_cmp actual expect
-- 
1.8.1.421.g6236851
