From: Lee Carver <Lee.Carver@servicenow.com>
Subject: PATCH] Allow git-filter-branch to process large repositories with
 lots of branches.
Date: Sat, 7 Sep 2013 20:22:33 +0000
Message-ID: <CE50D917.191A5%lee.carver@corp.service-now.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Lee Carver <leeca@pnambic.com>
To: "gitster@pobox.com" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 07 22:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIP2j-0006T7-V4
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 22:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab3IGUXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 16:23:37 -0400
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:52664 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834Ab3IGUXg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Sep 2013 16:23:36 -0400
Received: from smtprelay.corp.service-now.com ([4.71.115.101]) (using TLSv1) by na3sys009aob135.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiuLSIpluKX2y58/XzSEQ+O3xhqnpWOh@postini.com; Sat, 07 Sep 2013 13:23:36 PDT
Received: from SJC4EXDAG01-01.corp.service-now.com
 ([fe80::9d9c:f9e1:ea7b:618c]) by SJC4EXHTCAS02.corp.service-now.com ([::1])
 with mapi id 14.02.0347.000; Sat, 7 Sep 2013 13:22:33 -0700
Thread-Topic: PATCH] Allow git-filter-branch to process large repositories
 with lots of branches.
Thread-Index: AQHOrAf7PaTuVgvf1EmGYHtpFR3jZw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.15.239.100]
Content-ID: <96C6359EA8B16343B02A6134D178B8EB@corp.service-now.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234143>

As noted in several forums, a recommended way to move trees between
repositories is to use git-filter-branch to revise the history for a
single tree 
(http://gbayer.com/development/moving-files-from-one-git-repository-to-anot
her-preserving-history/,
http://stackoverflow.com/questions/1365541/how-to-move-files-from-one-git-r
epo-to-another-not-a-clone-preserving-history).

However, this can lead to argument list too long errors when the original
repository has many retained branches (>6k)

/usr/local/git/libexec/git-core/git-filter-branch: line 270:
/usr/local/git/libexec/git-core/git: Argument list too long
Could not get the commits

Piping the output from git rev-parse directly into git rev-list avoids
this problem, since the rev-parse output is not processed as a command
line argument.
---
 git-filter-branch.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ac2a005..d7e0fae 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -255,8 +255,6 @@ else
 	remap_to_ancestor=t
 fi
 
-rev_args=$(git rev-parse --revs-only "$@")
-
 case "$filter_subdir" in
 "")
 	eval set -- "$(git rev-parse --sq --no-revs "$@")"
@@ -267,8 +265,9 @@ case "$filter_subdir" in
 	;;
 esac
 
+git rev-parse --revs-only "$@" | \
 git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges $rev_args "$@" > ../revs ||
+	--parents --simplify-merges --stdin "$@" > ../revs ||
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
-- 
1.8.3.2
