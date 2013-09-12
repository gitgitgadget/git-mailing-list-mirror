From: Lee Carver <Lee.Carver@servicenow.com>
Subject: [PATCH-v4] Allow git-filter-branch to process large repositories
 with lots of branches.
Date: Thu, 12 Sep 2013 17:46:35 +0000
Message-ID: <CE574B31.199C6%lee.carver@corp.service-now.com>
References: <xmqqhadruyu4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Lee Carver <leeca@pnambic.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 19:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKAyY-0008TU-Ui
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 19:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab3ILRqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 13:46:38 -0400
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:52245 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755810Ab3ILRqg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 13:46:36 -0400
Received: from smtprelay.corp.service-now.com ([4.71.115.101]) (using TLSv1) by na3sys009aob129.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUjH9/Ae/QvlBxymKJhDcCU+0PhpHQQbH@postini.com; Thu, 12 Sep 2013 10:46:36 PDT
Received: from SJC4EXDAG01-01.corp.service-now.com
 ([fe80::9d9c:f9e1:ea7b:618c]) by SJC4EXHTCAS01.corp.service-now.com ([::1])
 with mapi id 14.02.0347.000; Thu, 12 Sep 2013 10:46:35 -0700
Thread-Topic: [PATCH-v4] Allow git-filter-branch to process large
 repositories with lots of branches.
Thread-Index: AQHOr+AG2fbBzIU5l0eRKfeLfbcXOA==
In-Reply-To: <xmqqhadruyu4.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.15.40.100]
Content-ID: <1EC29F397039A943A875B5CF3501E356@corp.service-now.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234663>

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

Signed-off-by: Lee Carver <lee.carver@servicenow.com>
---
 git-filter-branch.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ac2a005..2091885 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -255,7 +255,7 @@ else
 	remap_to_ancestor=t
 fi
 
-rev_args=$(git rev-parse --revs-only "$@")
+git rev-parse --revs-only "$@" > ../parse
 
 case "$filter_subdir" in
 "")
@@ -268,7 +268,7 @@ case "$filter_subdir" in
 esac
 
 git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges $rev_args "$@" > ../revs ||
+	--parents --simplify-merges --stdin "$@" < ../parse > ../revs ||
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
-- 
1.8.3.2
