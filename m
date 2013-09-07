From: Lee Carver <Lee.Carver@servicenow.com>
Subject: [PATCH-v2] Allow git-filter-branch to process large repositories
 with lots of branches.
Date: Sat, 7 Sep 2013 21:03:09 +0000
Message-ID: <CE50E29B.191B8%lee.carver@corp.service-now.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Lee Carver <leeca@pnambic.com>
To: Andreas Schwab <schwab@linux-m68k.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 07 23:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIPfF-0000v4-6K
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 23:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab3IGVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 17:03:12 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46517 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751889Ab3IGVDL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Sep 2013 17:03:11 -0400
Received: from smtprelay.corp.service-now.com ([4.71.115.101]) (using TLSv1) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiuUj+9Ng76wJdVHAim57maMVm7edILN@postini.com; Sat, 07 Sep 2013 14:03:11 PDT
Received: from SJC4EXDAG01-01.corp.service-now.com
 ([fe80::9d9c:f9e1:ea7b:618c]) by SJC4EXHTCAS01.corp.service-now.com ([::1])
 with mapi id 14.02.0347.000; Sat, 7 Sep 2013 14:03:10 -0700
Thread-Topic: [PATCH-v2] Allow git-filter-branch to process large
 repositories with lots of branches.
Thread-Index: AQHOrA2ngyPj47ad8Eaci48+16ovbw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.15.239.100]
Content-ID: <742A1E0786DEDB4EB139084E9D156235@corp.service-now.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234146>

As noted in several forums, a recommended way to move trees between
repositories
is to use git-filter-branch to revise the history for a single tree:

http://gbayer.com/development/moving-files-from-one-git-repository-to-anoth
er-preserving-history/
http://stackoverflow.com/questions/1365541/how-to-move-files-from-one-git-r
epo-to-another-not-a-clone-preserving-history

However, this can lead to argument list too long errors when the original
repository has many retained branches (>6k)

/usr/local/git/libexec/git-core/git-filter-branch: line 270:
/usr/local/git/libexec/git-core/git: Argument list too long
Could not get the commits

Piping the saved output from git rev-parse into git rev-list avoids this
problem, since the rev-parse output is not processed as a command line
argument.
---
 git-filter-branch.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ac2a005..60d239b 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -255,7 +255,7 @@ else
 	remap_to_ancestor=t
 fi
 
-rev_args=$(git rev-parse --revs-only "$@")
+git rev-parse --revs-only "$@" > ../parse
 
 case "$filter_subdir" in
 "")
@@ -267,8 +267,9 @@ case "$filter_subdir" in
 	;;
 esac
 
+cat ../parse | \
 git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges $rev_args "$@" > ../revs ||
+	--parents --simplify-merges --stdin "$@" > ../revs ||
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
-- 
1.8.3.2
