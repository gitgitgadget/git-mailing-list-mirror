From: Nick Townsend <nick.townsend@mac.com>
Subject: [PATCH] Additional git-archive tests
Date: Wed, 04 Dec 2013 18:49:39 -0800
Message-ID: <CA9E9538-E39B-41CA-BB82-BDD8CF7A2E3F@mac.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
 <8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
 <CAPig+cTUjvfWLC5vX0=BwtSDb613E9jMoyVXWp=de_Tyb5Ei7w@mail.gmail.com>
 <xmqq61r5q0qs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 03:50:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoP12-0003EU-JX
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 03:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab3LECuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 21:50:08 -0500
Received: from nk11p03mm-asmtpout001.mac.com ([17.158.232.236]:52355 "EHLO
	nk11p03mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753566Ab3LECuG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 21:50:06 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MXB00CP6BVG0940@nk11p03mm-asmtp001.mac.com> for
 git@vger.kernel.org; Thu, 05 Dec 2013 02:50:05 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-12-04_08:2013-12-05,2013-12-04,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1312040226
In-reply-to: <xmqq61r5q0qs.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238839>


Interplay between paths specified in three ways now tested:
* After a : in the tree-ish,
* As a pathspec in the command,
* By virtue of the current working directory

Note that these tests are based on the behaviours
as found in 1.8.5. They may not be intentional.
They were developed to regression test enhancements
made to parse_treeish_arg() in archive.c

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nick Townsend <nick.townsend@mac.com>
---
 t/t5004-archive-corner-cases.sh | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 67f3b54..a81a836 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -113,4 +113,75 @@ test_expect_success 'archive empty subtree by direct pathspec' '
 	check_dir extract sub
 '
 
+test_expect_success 'setup - repository with subdirs' '
+	mkdir -p a/b/c a/b/d &&
+	echo af >a/af &&
+	echo bf >a/b/bf &&
+	echo cf >a/b/c/cf &&
+	git add a &&
+	git commit -m "commit 1" &&
+	git tag -a -m "rev-1" rev-1
+'
+
+test_expect_success 'archive subtree from root by treeish' '
+	git archive --format=tar HEAD:a >atreeroot.tar &&
+	make_dir extract &&
+	"$TAR" xf atreeroot.tar -C extract &&
+	check_dir extract af b b/bf b/c b/c/cf
+'
+
+test_expect_success 'archive subtree from root with pathspec' '
+	git archive --format=tar HEAD a >atreepath.tar &&
+	make_dir extract &&
+	"$TAR" xf atreepath.tar -C extract &&
+	check_dir extract a a/af a/b a/b/bf a/b/c a/b/c/cf
+'
+
+test_expect_success 'archive subtree from root by 2-level treeish' '
+	git archive --format=tar HEAD:a/b >abtreeroot.tar &&
+	make_dir extract &&
+	"$TAR" xf abtreeroot.tar -C extract &&
+	check_dir extract bf c c/cf
+'
+
+test_expect_success 'archive subtree from subdir' '
+	(
+		cd a &&
+		git archive --format=tar HEAD >../asubtree.tar
+	) &&
+	make_dir extract &&
+	"$TAR" xf asubtree.tar -C extract &&
+	check_dir extract af b b/bf b/c b/c/cf
+'
+
+test_expect_success 'archive subtree from subdir with treeish' '
+	(
+		cd a &&
+		git archive --format=tar HEAD:./b >../absubtree.tar
+	) &&
+	make_dir extract &&
+	"$TAR" xf absubtree.tar -C extract &&
+	check_dir extract bf c c/cf
+'
+
+test_expect_success 'archive subtree from subdir with treeish and pathspec' '
+	(
+		cd a &&
+		git archive --format=tar HEAD:./b c >../absubtree.tar
+	) &&
+	make_dir extract &&
+	"$TAR" xf absubtree.tar -C extract &&
+	check_dir extract c c/cf
+'
+
+test_expect_success 'archive subtree from subdir with alt treeish' '
+	(
+		cd a &&
+		git archive --format=tar HEAD:b >../abxsubtree.tar
+	) &&
+	make_dir extract &&
+	"$TAR" xf abxsubtree.tar -C extract &&
+	check_dir extract bf c c/cf
+'
+
 test_done
-- 
1.8.5

On 3 Dec 2013, at 09:54, Junio C Hamano <gitster@pobox.com> wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>> +test_expect_success 'archive subtree from subdir' '
>>> +       cd a &&
>>> +       git archive --format=tar HEAD >../asubtree.tar &&
>>> +       cd .. &&
>>> +       make_dir extract &&
>>> +       "$TAR" xf asubtree.tar -C extract &&
>>> +       check_dir extract af b b/bf b/c b/c/cf
>>> +'
>> 
>> If git-archive fails, the subsequent 'cd ..' will not be invoked,
>> hence all tests following this one will fail since the current
>> directory has not been restored. If you place the 'cd a' in a
>> subshell, then the current directory remains unchanged for commands
>> outside the subshell (and you can drop the 'cd ..'):
>> 
>>    (
>>    cd a &&
>>    git archive ...
>>    ) &&
>>    make_dir ...
>>    ...
> 
> Thanks, and please indent the commands run in the subshell for
> better readability.
