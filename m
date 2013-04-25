From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 12:59:41 +0200
Message-ID: <51790C9D.8080901@viscovery.net>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 12:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVJu5-0002jb-3I
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 12:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab3DYK7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 06:59:49 -0400
Received: from so.liwest.at ([212.33.55.23]:44905 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778Ab3DYK7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 06:59:48 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UVJtt-0002Z0-PV; Thu, 25 Apr 2013 12:59:41 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 756051660F;
	Thu, 25 Apr 2013 12:59:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222365>

Am 4/25/2013 12:09, schrieb Michael J Gruber:
> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
> test which was meant to skip the test unless the test shell is bash.
> Unfortunately, it tests for the availability of bash only. But users can
> opt to use a different shell (using SHELL_PATH) for the tests even though
> bash is available.

After my patch this morning ("avoid process substitution"), there is not
much bashism left in git-remote-testgit:

diff --git a/git-remote-testgit b/git-remote-testgit
index e99d5fa..178d030 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 # Copyright (c) 2012 Felipe Contreras
 
 alias=$1
@@ -23,7 +23,6 @@ then
 	testgitmarks="$dir/testgit.marks"
 	test -e "$gitmarks" || >"$gitmarks"
 	test -e "$testgitmarks" || >"$testgitmarks"
-	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
 fi
 
 while read line
@@ -70,7 +69,10 @@ do
 		fi
 
 		echo "feature done"
-		git fast-export "${testgitmarks_args[@]}" $refs |
+		git fast-export \
+			${testgitmarks:+"--import-marks=$testgitmarks"} \
+			${testgitmarks:+"--export-marks=$testgitmarks"} \
+			$refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		echo "done"
 		;;
@@ -89,7 +91,10 @@ do
 
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
 
-		git fast-import "${testgitmarks_args[@]}" --quiet
+		git fast-import \
+			${testgitmarks:+"--import-marks=$testgitmarks"} \
+			${testgitmarks:+"--export-marks=$testgitmarks"} \
+			--quiet
 
 		# figure out which refs were updated
 		git for-each-ref --format='%(refname) %(objectname)' |

What's left is to take care of the shbang line, remove the bash
check from t5801, make a proper commit from this patch. But I leave
that to the interested reader. :-)

-- Hannes
