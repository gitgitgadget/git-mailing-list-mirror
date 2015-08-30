From: Gabor Bernat <bernat@primeranks.net>
Subject: Add passed and estimated seconds to the filter-branch on demand via
 --progress-eta flag
Date: Sun, 30 Aug 2015 13:45:27 +0200
Message-ID: <CANy2qHcz2Kk2_S29hyPf-yMe0AgjRZkd1=R33cY10sc6v91ixA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 30 13:45:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW13Z-0001fv-E5
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 13:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbH3Lpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 07:45:49 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36144 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbbH3Lps convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 07:45:48 -0400
Received: by wicfv10 with SMTP id fv10so40147467wic.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0PQywZcJzc8XbHnByMD6I3JxkoZcyi9gxqckZ8ze8Cg=;
        b=TVhqARwu78BKBafJPbjiXwzbF76pzhpP5+kLkij4Ur4K6oPU+m5fUAktktxZvdncDV
         iDrigWRAmfSZu+2OkP7CYJisicRuYsQCQLj/JvQqXS1tXMnjxLioXhKp9TsBGz7+RUxe
         87GSwN/yYPF5kivXYYsr8JSjwAzisPo6SdX0i5P7DvESuaLxWlMpid6Rxap1Ly6G9y5r
         Bku7/x4ocE4oQwcS354qt8veb3Y8M3b8VXaJY1nuYHqJTrKarUjUAEgwKVfiJXaEstaK
         nP6IHo2M7SizbM2DXqbImELXkeKdvGyKC8MaeL6odbEqK+4FumeAC7Jbfmg9j4LNVzKE
         K7Sw==
X-Received: by 10.181.13.241 with SMTP id fb17mr14941108wid.13.1440935147109;
 Sun, 30 Aug 2015 04:45:47 -0700 (PDT)
Received: by 10.194.192.201 with HTTP; Sun, 30 Aug 2015 04:45:27 -0700 (PDT)
X-Google-Sender-Auth: H7f5vb5SQ2XGDCTOrOPA9Lh_ro8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276817>

Hello,

I've submitted this first to this list as a feature request, however
in the meantime with the help of Jeff King <peff@peff.net>, Junio C
Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
and Mikael Magnusson <mikachu@gmail.com> came up with solution, so now
I submit it as a patch. Here follows a patch, I really hope I got
right the format:

=46rom 620e69d10a1bfcfcace347cbb95991d75fd23a1d Mon Sep 17 00:00:00 200=
1
=46rom: Gabor Bernat <gabor.bernat@gravityrd.com>
Date: Thu, 27 Aug 2015 00:46:52 +0200
Subject: [PATCH] Add to the git filter-branch a --progress-eta flag whi=
ch when
 enabled will print with the progress also the number of seconds passed=
 since
 started plus the number of seconds predicted until the operation finis=
hes.

Signed-off-by: Gabor Bernat <gabor.bernat@gravityrd.com>
---
 Documentation/git-filter-branch.txt |  6 ++++++
 git-filter-branch.sh                | 29 ++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt
b/Documentation/git-filter-branch.txt
index 73fd9e8..6ca9d6e 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -194,6 +194,12 @@ to other tags will be rewritten to point to the
underlying commit.
  directory or when there are already refs starting with
  'refs/original/', unless forced.

+--progress-eta::
+ If specified will print the number of seconds elapsed and the predict=
ed
+ count of seconds remaining until the operation is expected to finish.=
 Note
+ that for calculating the eta the global speed up to the current point=
 is
+ used.
+
 <rev-list options>...::
  Arguments for 'git rev-list'.  All positive refs included by
  these options are rewritten.  You may also specify options
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..7b565fb 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -105,6 +105,7 @@ filter_subdir=3D
 orig_namespace=3Drefs/original/
 force=3D
 prune_empty=3D
+progress_eta=3D
 remap_to_ancestor=3D
 while :
 do
@@ -129,6 +130,11 @@ do
  prune_empty=3Dt
  continue
  ;;
+ --progress-eta)
+ shift
+ progress_eta=3Dt
+ continue
+ ;;
  -*)
  ;;
  *)
@@ -277,9 +283,30 @@ test $commits -eq 0 && die "Found nothing to rewri=
te"
 # Rewrite the commits

 git_filter_branch__commit_count=3D0
+
+case "$progress_eta" in
+ t)
+ start=3D$(PATH=3D`getconf PATH` awk 'BEGIN{srand();print srand()}')
+ ;;
+ '')
+ ;;
+esac
+
 while read commit parents; do
  git_filter_branch__commit_count=3D$(($git_filter_branch__commit_count=
+1))
- printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)=
"
+
+ case "$progress_eta" in
+ t)
+ now=3D$(PATH=3D`getconf PATH` awk 'BEGIN{srand();print srand()}')
+ elapsed=3D$(($now - $start))
+ remaining_second=3D$(( ($commits - $git_filter_branch__commit_count) =
*
$elapsed / $git_filter_branch__commit_count ))
+ progress=3D" ($elapsed seconds passed, remaining $remaining_second pr=
edicted)"
+ ;;
+ '')
+ progress=3D""
+ esac
+
+ printf "\rRewrite $commit
($git_filter_branch__commit_count/$commits)$progress"

  case "$filter_subdir" in
  "")
--=20
2.5.1.408.g14905ed.dirty

Let me know if this works for adding it to the main repository,

Thanks a lot,


Bern=C3=A1t G=C3=81BOR
