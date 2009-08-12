From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH/RFC] Add diff tests for trailing-space and now newline
Date: Tue, 11 Aug 2009 19:47:29 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908111942020.15481@GWPortableVCS>
References: <alpine.DEB.1.00.0908052239180.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb20a-0007r6-C0
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbZHLArv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbZHLArv
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:47:51 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:48603 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbZHLAru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 20:47:50 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mb20K-0007Ox-UZ; Tue, 11 Aug 2009 19:47:49 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <alpine.DEB.1.00.0908052239180.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125632>

  - Test each diff whitespace ignore option on trailing-space at eof

Signed-off-by: Thell Fowler <git@tbfowler.name>
---

Johannes Schindelin (Johannes.Schindelin@gmx.de) wrote on Aug 5, 2009:
>On Tue, 4 Aug 2009, Thell Fowler wrote:
>
>> mkdir test_ws_eof
>> cd test_ws_eof
>> git init
>> echo -n "Test" > test.txt
>> git add .
>> git commit -m'test'
>> git symbolic-ref HEAD refs/heads/with_space
>> rm .git/index
>> git clean -f
>> echo -n "Test ">test.txt
>> git add .
>> git commit -m'test'
>> # Ignoring all whitespace there shouldn't be a diff.
>> git diff -w master -- test.txt
>> # Ignoring space at eol there shouldn't be a diff
>> git diff --ignore-space-at-eol master -- test.txt
>> # Ignoring with -b might have a case for a diff showing.
>> git diff -b master -- test.txt
>
>If you turn that into a patch to, say, t/t4015-diff-whitespace.sh (adding 
>a test_expect_failure for a known bug), it is much easier to convince 
>developers to work on the issue.

Is this more along the right line?

Thell


 t/t4015-diff-whitespace.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6d13da3..fddbf20 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -395,4 +395,27 @@ test_expect_success 'combined diff with autocrlf conversion' '
 
 '
 
+test_expect_failure 'diff -w on trailing-space with no newline' '
+
+	git reset --hard &&
+	printf "foo " >x &&
+	git commit -m "trailing-space @ eof test" x &&
+	printf "foo" >x &&
+	git commit -m "trailing-space @ eof test" x &&
+	test_must_pass git diff -w HEAD^ -- x | grep "foo "
+
+'
+
+test_expect_failure 'diff -b on trailing-space with no newline' '
+
+	test_must_pass git diff -b HEAD^ -- x | grep "foo "
+
+'
+
+test_expect_failure 'diff --ignore-space-at-eol on trailing-space with no newline' '
+
+	test_must_pass git diff -ignore-space-at-eol HEAD^ -- x | grep "foo "
+
+'
+
 test_done
-- 
1.6.4.240.g4cd31
