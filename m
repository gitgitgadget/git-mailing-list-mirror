From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 3/3] Teach --dirstat to not completely ignore rearranged lines
Date: Fri, 8 Apr 2011 16:55:37 +0200
Message-ID: <201104081655.38075.johan@herland.net>
References: <201104071549.37187.johan@herland.net> <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com> <201104081646.35750.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 16:56:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8D73-0002rG-OB
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 16:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab1DHO4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 10:56:36 -0400
Received: from smtp.opera.com ([213.236.208.81]:47291 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab1DHO4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 10:56:35 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p38EtcfH009850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Apr 2011 14:55:38 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <201104081646.35750.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171127>

Currently, the --dirstat analysis fails to detect some kinds of changes.
For example, rearranging lines in a file causes the "damage" calculated
by show_dirstat() to be 0. However, when we process the diff queue in
show_dirstat(), we already now that there should be at least _some_
damage assigned to each entry, because truly _unchanged_ entries are
simply not present in the diff queue.

This patch teaches show_dirstat() to assign a minimum amount of damage
(== 1) to entries for which the analysis otherwise yields zero damage.
Obviously this is not a complete fix, but it's at least better to
underrepresent these changes, rather than simply pretending that they
don't exist.

Signed-off-by: Johan Herland <johan@herland.net>
---

This is a somewhat quick and ugly solution to make --dirstat at least
show _something_ for changes that consist solely of rearranging lines
in a file. Sure, those changes would be thoroughly underrepresented by
--dirstat (probably falling below the default 3% threshold in many
cases), but I figure it's better to underrepresent them rather than
ignoring them completely.

As with 2/3, this patch also relies on the assumption that the diff
queue never contains entries that should be considered "unchanged" by
--dirstat.

 Documentation/diff-options.txt                |    4 ++--
 diff.c                                        |    8 ++++++++
 t/t4013-diff-various.sh                       |    2 --
 t/t4013/diff.diff_--dirstat_initial_rearrange |    1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 25e48c4..61a8409 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -75,8 +75,8 @@ endif::git-format-patch[]
 +
 Note that `--dirstat` does not use the regular diff machinery to calculate
 the changes (rather it is based on the rename detection machinery). Therefore,
-`--dirstat` may skip some changes that `--stat` does not skip. For example,
-rearranging the lines in a file will not be detected by `--dirstat`.
+`--dirstat` will count some changes differently than `--stat`. For example,
+rearranged lines in a file will be underrepresented by `--dirstat`.
 
 --dirstat-by-file[=<limit>]::
 	Same as `--dirstat`, but counts changed files instead of lines.
diff --git a/diff.c b/diff.c
index 28d9293..0d82082 100644
--- a/diff.c
+++ b/diff.c
@@ -1578,8 +1578,16 @@ static void show_dirstat(struct diff_options *options)
 		 * Original minus copied is the removed material,
 		 * added is the new material.  They are both damages
 		 * made to the preimage.
+		 * If the resulting damage is zero, we know that
+		 * diffcore_count_changes() considers the two entries
+		 * to be identical, but since they are in the diff
+		 * queue at all, we now that there must have been
+		 * _some_ kind of change, so we force all entries to
+		 * have at least a minimum of damage.
 		 */
 		damage = (p->one->size - copied) + added;
+		if (!damage)
+			damage = 1;
 
 found_damage:
 		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e8240f2..93a6f20 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -300,9 +300,7 @@ diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
 diff master master^ side
 diff --dirstat master~1 master~2
-# --dirstat does NOT pick up changes that simply rearrange existing lines
 diff --dirstat initial rearrange
-# ...but --dirstat-by-file DOES pick up rearranged lines
 diff --dirstat-by-file initial rearrange
 EOF
 
diff --git a/t/t4013/diff.diff_--dirstat_initial_rearrange b/t/t4013/diff.diff_--dirstat_initial_rearrange
index fb2e17d..5fb02c1 100644
--- a/t/t4013/diff.diff_--dirstat_initial_rearrange
+++ b/t/t4013/diff.diff_--dirstat_initial_rearrange
@@ -1,2 +1,3 @@
 $ git diff --dirstat initial rearrange
+ 100.0% dir/
 $
-- 
1.7.5.rc1
