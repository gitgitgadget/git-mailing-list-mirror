From: Marcus Brinkmann <m.brinkmann@semantics.de>
Subject: [PATCH] contrib/subtree: Split history with empty trees correctly
 (was: Re: BUG: git subtree split gets confused on removed and readded
 directory)
Date: Wed, 20 Jan 2016 02:17:58 +0100
Message-ID: <569EE046.9040506@semantics.de>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
 <xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
 <87twmbaizo.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Dave Ware <davidw@realtimegenomics.com>, <git@vger.kernel.org>
To: "David A. Greene" <greened@obbligato.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:35:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLhgZ-0007Qn-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934347AbcATBf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:35:28 -0500
Received: from smtp.semantics.de ([212.117.75.54]:4788 "EHLO
	flusser.semantics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934161AbcATBfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:35:15 -0500
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2016 20:35:15 EST
Received: from tarski.semantics.de ([192.168.1.3])
	by flusser.semantics.de with esmtp (Exim 3.36 #1 (Debian))
	id 1aLhS7-0005Xg-00; Wed, 20 Jan 2016 02:20:51 +0100
Received: from LOCKE.semantics.de ([192.168.1.6]) by tarski.semantics.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Jan 2016 02:18:00 +0100
Received: from [192.168.142.172] (80.147.161.94) by Locke.semantics.de
 (192.168.1.6) with Microsoft SMTP Server (TLS) id 14.0.722.0; Wed, 20 Jan
 2016 02:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <87twmbaizo.fsf@waller.obbligato.org>
X-OriginalArrivalTime: 20 Jan 2016 01:18:00.0062 (UTC) FILETIME=[66E249E0:01D15320]
X-semantics-MailScanner: Found to be clean
X-semantics-MailScanner-From: m.brinkmann@semantics.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284407>

'git subtree split' will fail if the history of the subtree has empty
tree commits (or trees that are considered empty, such as submodules).
This fix keeps track of this condition and correctly follows the history
over such commits.

Signed-off-by: Marcus Brinkmann <m.brinkmann@semantics.de>
---
 contrib/subtree/git-subtree.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index edf36f8..b68828b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -36,6 +36,8 @@ PATH=$PATH:$(git --exec-path)

 require_work_tree

+EMPTY_TREE=`git hash-object -t tree /dev/null`
+
 quiet=
 branch=
 debug=
@@ -449,7 +451,8 @@ copy_or_skip()
 	rev="$1"
 	tree="$2"
 	newparents="$3"
-	assert [ -n "$tree" ]
+
+	[ -z "$tree" ] && tree=$EMPTY_TREE

 	identical=
 	nonidentical=
@@ -603,6 +606,7 @@ cmd_split()
 	revmax=$(eval "$grl" | wc -l)
 	revcount=0
 	createcount=0
+	found_first_commit=
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
@@ -625,12 +629,16 @@ cmd_split()
 		
 		# ugly.  is there no better way to tell if this is a subtree
 		# vs. a mainline commit?  Does it matter?
-		if [ -z $tree ]; then
-			set_notree $rev
-			if [ -n "$newparents" ]; then
-				cache_set $rev $rev
+		if [ -z $found_first_commit ]; then
+			if [ -z $tree ]; then
+				set_notree $rev
+				if [ -n "$newparents" ]; then
+					cache_set $rev $rev
+				fi
+				continue
+			else
+				found_first_commit=yes
 			fi
-			continue
 		fi

 		newrev=$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?
-- 
2.5.0
