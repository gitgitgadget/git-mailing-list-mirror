From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: fetch: Auto-following tags should check connectivity, not existence
Date: Tue, 17 Apr 2007 18:10:43 +0200
Organization: eudaptics software gmbh
Message-ID: <4624F183.D4B6BBB1@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 18:11:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdqH5-0003oj-3d
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031123AbXDQQKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031127AbXDQQKu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:10:50 -0400
Received: from main.gmane.org ([80.91.229.2]:53192 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031123AbXDQQKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 12:10:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HdqGH-0000DS-0L
	for git@vger.kernel.org; Tue, 17 Apr 2007 18:10:33 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 18:10:32 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 18:10:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44790>

git-fetch's auto-following of tags fetches all tags for which it finds
objects in the local repository. I feel it were better if not object
existence, but connectivity to the existing refs was checked, like this:

diff --git a/git-fetch.sh b/git-fetch.sh
index fd70696..1b3c459 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -314,11 +314,12 @@ case "$no_tags$tags" in
        taglist=$(IFS=' ' &&
        echo "$ls_remote_result" |
        git-show-ref --exclude-existing=refs/tags/ |
        while read sha1 name
        do
-           git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
+           t=$(git-rev-list --max-count=1 "$sha1" --not --all 2>
/dev/null) &&
+           test -z "$t" || continue
            echo >&2 "Auto-following $name"
            echo ".${name}:${name}"
        done)
    esac
    case "$taglist" in

Is this considered in the shell-to-C rewrite that's currently going on?

The background is that I sometimes fetch a branch with tags, but then
decide to remove it (and the tags as well). git-gc and git-prune do not
guarantee that the objects go away because they could be reachable from
reflogs. Now the next git-fetch will fetch the tags again even though I
do not have any refs from which they would be reachable.

-- Hannes
