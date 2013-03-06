From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH 2/2] p4merge: create a virtual base if none available
Date: Wed,  6 Mar 2013 22:32:58 +0200
Message-ID: <1362601978-16911-3-git-send-email-kevin@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
Cc: David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 21:57:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLP2-0004AP-P4
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 21:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab3CFU5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 15:57:06 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:47304 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752551Ab3CFU5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 15:57:05 -0500
X-Greylist: delayed 899 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2013 15:57:05 EST
Received: from mail406.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 046FBDC15CA
	for <git@vger.kernel.org>; Wed,  6 Mar 2013 21:44:06 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 6 Mar 2013 22:33:47 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 6 Mar 2013 22:33:46 +0200
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc2.5.g1a80410.dirty
In-Reply-To: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 12117216273725427936
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -48
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -48
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217545>

Originally, with no base, Git gave P4Merge $LOCAL as a dummy base:

   p4merge "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"

Commit 0a0ec7bd changed this to:

   p4merge "empty file" "$LOCAL" "$REMOTE" "$MERGED"

to avoid the problem of being unable to save in some circumstances.

Unfortunately this approach does not produce good results at all on
differing inputs. P4Merge really regards the blank file as the base, and
once you have just a couple of differences between the two branches you
end up with one a massive full-file conflict. The diff is not readable,
and you have to invoke "difftool MERGE_HEAD HEAD" manually to see a
2-way diff.

The original form appears to have invoked special 2-way comparison
behaviour that occurs only if the base filename is "" or equal to the
left input.  You get a good diff, and it does not auto-resolve in one
direction or the other. (Normally if one branch equals the base, it
would autoresolve to the other branch).

But there appears to be no way of getting this 2-way behaviour and being
able to reliably save. Having base=left appears to be triggering other
assumptions. There are tricks the user can use to force the save icon
on, but it's not intuitive.

So we now follow a suggestion given in the original patch's discussion:
generate a virtual base, consisting of the lines common to the two
branches. It produces a much nicer 3-way diff view than either of the
original forms, and than I suspect other mergetools are managing.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 git-mergetool--lib.sh | 14 ++++++++++++++
 mergetools/p4merge    |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index e338be5..5b60cf5 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -108,6 +108,20 @@ check_unchanged () {
 	fi
 }
 
+make_virtual_base() {
+		# Copied from git-merge-one-file.sh.
+		# This starts with $LOCAL, and uses git apply to
+		# remove lines that are not in $REMOTE.
+		cp -- "$LOCAL" "$BASE"
+		sz0=`wc -c <"$BASE"`
+		@@DIFF@@ -u -L"a/$BASE" -L"b/$BASE" "$BASE" "$REMOTE" | git apply --no-add
+		sz1=`wc -c <"$BASE"`
+
+		# If we do not have enough common material, it is not
+		# worth trying two-file merge using common subsections.
+		expr $sz0 \< $sz1 \* 2 >/dev/null || : >"$BASE"
+}
+
 valid_tool () {
 	setup_tool "$1" && return 0
 	cmd=$(get_merge_tool_cmd "$1")
diff --git a/mergetools/p4merge b/mergetools/p4merge
index 46b3a5a..f0a893b 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -21,7 +21,7 @@ diff_cmd () {
 
 merge_cmd () {
 	touch "$BACKUP"
-	$base_present || >"$BASE"
+	$base_present || make_virtual_base
 	"$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
 	check_unchanged
 }
-- 
1.8.2.rc2.5.g1a80410.dirty
