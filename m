From: "Nick Edelen" <sirnot@gmail.com>
Subject: Re: [PATCH 5/5] full integration of rev-cache into git's revision
 walker, completed test suite
Date: Fri, 07 Aug 2009 15:47:26 +0200
Message-ID: <op.uyaolcvttdk399@sirnot.private>
References: <op.ux8i7ceotdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Nick Edelen" <sirnot@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>, "Sam Vilain" <sam@vilain.net>,
X-From: git-owner@vger.kernel.org Fri Aug 07 15:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZPnM-0005Xi-Ab
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 15:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716AbZHGNre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 09:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756707AbZHGNre
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 09:47:34 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:36825 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbZHGNrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 09:47:33 -0400
Received: by ewy10 with SMTP id 10so1542083ewy.37
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:references:content-transfer-encoding
         :message-id:in-reply-to:user-agent;
        bh=OchgMHdD3fTt2i6KuxQD1YontudUXgqeyk76OiyctPo=;
        b=PiCWlsQz6hDwryITcHjDQ6BX/Y6Wavex/0MLcDrFx+aT7xah4U8TMaH8A3ivJ6FB9O
         S7cOIfyV4xdNy/LLGfBsk4ePJhVKwFa2Ix8lOIQCrNNLY24Zzb+XqUsLywmGyzKzkwzD
         ShoZsaExAHNySYmWQb9uZLuqINr8fDBI/vCNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version:references
         :content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=iQIZH1B5Mil6zaRUW0cL1/ySkAwkOPCc3TWRrXjYDKuVROfHLo4aB0lyEFz/L0ThHx
         xhaGCuruAJ0gujDkNIBDOmc+5z6/sQA1SvdC7Px1ODiZzdxqsA+sK/NtSqp6souAbtvZ
         Z2k7UIsrwglqD2VtceKsnF8chzd/vNB54MnIQ=
Received: by 10.210.128.17 with SMTP id a17mr1465935ebd.4.1249652851432;
        Fri, 07 Aug 2009 06:47:31 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 5sm773860eyh.56.2009.08.07.06.47.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 06:47:30 -0700 (PDT)
In-Reply-To: <op.ux8i7ceotdk399@sirnot.private>
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125195>

A small patch to eliminate the python dependency in rev-cache's test-suite.  
This is a holdover for the 'integration' patch until a revised patchset is sent.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
I've also implemented name caching, but I'd like to cleanup that (and the docs 
;-) up a bit before posting it.  I'll have everything ready for public display 
by tonight (I've got an appointment for the next several hours).

 t/t6015-rev-cache-list.sh |   39 +++++++++++++++++++++------------------
 t/t6015-sha1-dump-diff.py |   36 ------------------------------------
 2 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/t/t6015-rev-cache-list.sh b/t/t6015-rev-cache-list.sh
index bfd9525..7c3719d 100755
--- a/t/t6015-rev-cache-list.sh
+++ b/t/t6015-rev-cache-list.sh
@@ -3,7 +3,11 @@
 test_description='git rev-cache tests'
 . ./test-lib.sh
 
-sha1diff="python $TEST_DIRECTORY/t6015-sha1-dump-diff.py"
+test_cmp_sorted() {
+	grep -io "[a-f0-9]*" $1 | sort >.tmpfile1 && 
+	grep -io "[a-f0-9]*" $2 | sort >.tmpfile2 && 
+	test_cmp .tmpfile1 .tmpfile2
+}
 
 # we want a totally wacked out branch structure...
 # we need branching and merging of sizes up through 3, tree 
@@ -99,49 +103,49 @@ test_expect_success 'remake cache slice' '
 #check core mechanics and rev-list hook for commits
 test_expect_success 'test rev-caches walker directly (limited)' '
 	git-rev-cache walk HEAD --not HEAD~3 >list && 
-	test -z `$sha1diff list proper_commit_list_limited`
+	test_cmp_sorted list proper_commit_list_limited
 '
 
 test_expect_success 'test rev-caches walker directly (unlimited)' '
 	git-rev-cache walk HEAD >list && 
-	test -z `$sha1diff list proper_commit_list`
+	test_cmp_sorted list proper_commit_list
 '
 
 test_expect_success 'test rev-list traversal (limited)' '
 	git-rev-list HEAD --not HEAD~3 >list && 
-	test -z `$sha1diff list proper_commit_list_limited`
+	test_cmp list proper_commit_list_limited
 '
 
 test_expect_success 'test rev-list traversal (unlimited)' '
 	git-rev-list HEAD >list && 
-	test -z `$sha1diff list proper_commit_list`
+	test_cmp list proper_commit_list
 '
 
 #do the same for objects
 test_expect_success 'test rev-caches walker with objects' '
 	git-rev-cache walk --objects HEAD >list && 
-	test -z `$sha1diff list proper_object_list`
+	test_cmp_sorted list proper_object_list
 '
 
 test_expect_success 'test rev-list with objects (topo order)' '
 	git-rev-list --topo-order --objects HEAD >list && 
-	test -z `$sha1diff list proper_object_list`
+	test_cmp_sorted list proper_object_list
 '
 
 test_expect_success 'test rev-list with objects (no order)' '
 	git-rev-list --objects HEAD >list && 
-	test -z `$sha1diff list proper_object_list`
+	test_cmp_sorted list proper_object_list
 '
 
 #verify age limiting
 test_expect_success 'test rev-list date limiting (topo order)' '
 	git-rev-list --topo-order --max-age=$min_date --min-age=$max_date HEAD >list && 
-	test -z `$sha1diff list proper_list_date_limited`
+	test_cmp_sorted list proper_list_date_limited
 '
 
 test_expect_success 'test rev-list date limiting (no order)' '
 	git-rev-list --max-age=$min_date --min-age=$max_date HEAD >list && 
-	test -z `sha1diff list proper_list_date_limited`
+	test_cmp_sorted list proper_list_date_limited
 '
 
 #check partial cache slice
@@ -154,7 +158,7 @@ test_expect_success 'saving old cache and generating partial slice' '
 '
 
 test_expect_success 'rev-list with wholly interesting partial slice' '
-	git-rev-list --topo-order HEAD >list &&
+	git-rev-list --topo-order HEAD >list && 
 	test_cmp list proper_commit_list
 '
 
@@ -199,13 +203,13 @@ test_expect_success 'corrupt slice' '
 '
 
 test_expect_success 'test rev-list traversal (limited) (corrupt slice)' '
-	git-rev-list HEAD --not HEAD~3 >list && 
-	test -z `$sha1diff list proper_commit_list_limited`
+	git-rev-list --topo-order HEAD --not HEAD~3 >list && 
+	test_cmp list proper_commit_list_limited
 '
 
 test_expect_success 'test rev-list traversal (unlimited) (corrupt slice)' '
 	git-rev-list HEAD >list && 
-	test -z `$sha1diff list proper_commit_list`
+	test_cmp_sorted list proper_commit_list
 '
 
 test_expect_success 'corrupt index' '
@@ -213,16 +217,15 @@ test_expect_success 'corrupt index' '
 '
 
 test_expect_success 'test rev-list traversal (limited) (corrupt index)' '
-	git-rev-list HEAD --not HEAD~3 >list && 
-	test -z `$sha1diff list proper_commit_list_limited`
+	git-rev-list --topo-order HEAD --not HEAD~3 >list && 
+	test_cmp list proper_commit_list_limited
 '
 
 test_expect_success 'test rev-list traversal (unlimited) (corrupt index)' '
 	git-rev-list HEAD >list && 
-	test -z `$sha1diff list proper_commit_list`
+	test_cmp_sorted list proper_commit_list
 '
 
 #test --ignore-size in fuse?
 
 test_done
-
diff --git a/t/t6015-sha1-dump-diff.py b/t/t6015-sha1-dump-diff.py
deleted file mode 100755
index 7fc30e7..0000000
--- a/t/t6015-sha1-dump-diff.py
+++ /dev/null
@@ -1,36 +0,0 @@
-
-import sys, re
-
-if len(sys.argv) < 3 : 
-	sys.exit(0)
-
-f = open(sys.argv[1], 'r')
-dict = {}
-for line in f : 
-	if len(line) >= 40 and re.match(r'^[0-9a-fA-F]{40}', line[:40]) != None : 
-		dict[line[:40]] = 1
-
-f.close()
-
-f = open(sys.argv[2], 'r')
-for line in f :
-	if len(line) < 40 : 
-		continue
-	
-	hash = line[:40]
-	if re.match(r'^[0-9a-fA-F]{40}', hash) == None : 
-		continue
-	
-	if hash in dict : 
-		dict[hash] -= 1
-	else : 
-		dict[hash] = -1
-
-f.close()
-
-for k in dict.keys() : 
-	if dict[k] == 0 : 
-		del dict[k]
-
-if len(dict) : 
-	print dict
---
