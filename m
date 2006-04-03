From: Jim Radford <radford@blackbean.org>
Subject: [PATCH] fix repacking with lots of tags
Date: Sun, 2 Apr 2006 20:50:17 -0700
Message-ID: <20060403035017.GA9249@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 03 05:50:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQG5D-0004SZ-CT
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 05:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWDCDuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 23:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWDCDuY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 23:50:24 -0400
Received: from cpe-67-49-92-118.socal.res.rr.com ([67.49.92.118]:8939 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S932219AbWDCDuX
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 23:50:23 -0400
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.6/8.13.4) with ESMTP id k333oH2W009301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 2 Apr 2006 20:50:17 -0700
Received: (from jim@localhost)
	by home.blackbean.org (8.13.6/8.13.6/Submit) id k333oHR3009298
	for git@vger.kernel.org; Sun, 2 Apr 2006 20:50:17 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on home.blackbean.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18305>

Use git-rev-list's --all instead of git-rev-parse's to keep from
hitting the shell's argument list length limits when repacking
with lots of tags.

diff --git a/git-repack.sh b/git-repack.sh
index bc90112..a5d349f 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -29,12 +29,10 @@ PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
 case ",$all_into_one," in
 ,,)
 	rev_list='--unpacked'
-	rev_parse='--all'
 	pack_objects='--incremental'
 	;;
 ,t,)
 	rev_list=
-	rev_parse='--all'
 	pack_objects=
 
 	# Redundancy check in all-into-one case is trivial.
@@ -43,7 +41,7 @@ case ",$all_into_one," in
 	;;
 esac
 pack_objects="$pack_objects $local $quiet $no_reuse_delta"
-name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) 2>&1 |
+name=$(git-rev-list --objects --all $rev_list 2>&1 |
 	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
 	exit 1
 if [ -z "$name" ]; then
