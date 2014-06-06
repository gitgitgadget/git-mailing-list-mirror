From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-gui: show staged submodules regardless of ignore config
Date: Fri, 06 Jun 2014 14:10:09 -0700
Message-ID: <xmqqppilpwwe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt1PI-0008Jj-0a
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 23:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbaFFVKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 17:10:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59988 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbaFFVKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 17:10:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8CFC71D559;
	Fri,  6 Jun 2014 17:10:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	7mFcD4u7vq7oMRljX1OZt/8daI=; b=Qy5sDzgREL1vIQV0SLogflbsUh1WqiYtg
	ri5Aa7etdDTUA5XfCgQbYgpcuOqwP9peKRfJVt96o/SuyYZm9yZfxvi/GOXOCv3O
	QKzVp+tpb2erO/Xd/+0MkSEB3UT88s79DAc9dDYcv3El46NnVB66MnEmW7Ka5UTm
	VnRN6D/mQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=EAc5/ELz5WGqA8pgplRuwOmgLbd3D4VTcxF3YG6bSmd9dD0mOSUpVopT
	nUAV/L4c/7Ag7y5/sHcGKeLNkCmIuCROcYsU1OR0E405ce092EtkuJfXsSN4D3n8
	9Cdm+qFf1oGRHsWtp2WQDQkec2OJNTGwaLGuHK/fvUa5tzKhlnE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83CFA1D558;
	Fri,  6 Jun 2014 17:10:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C31D71D54E;
	Fri,  6 Jun 2014 17:10:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1D4D81A-EDBE-11E3-98D4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250968>

From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Tue, 8 Apr 2014 21:30:51 +0200

Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
"all" suppresses all output of submodule changes for git-gui. This is
really confusing, as even when the user chooses to record a new commit for
an ignored submodule by adding it manually this change won't show up under
"Staged Changes (Will Commit)".

Fix that by using the '--ignore-submodules=dirty' option for both callers
of "git diff-index --cached" when the underlying git version supports that
option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Pat, I've been carrying this in my 'pu' but I would prefer
   changes to git-gui fed to me through you.  Could you apply this
   so that I can drop my tentative copy?

 git-gui.sh   | 6 +++++-
 lib/diff.tcl | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index cf2209b..c69bfb3 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1558,7 +1558,11 @@ proc rescan_stage2 {fd after} {
 
 	set rescan_active 2
 	ui_status [mc "Scanning for modified files ..."]
-	set fd_di [git_read diff-index --cached -z [PARENT]]
+	if {[git-version >= "1.7.2"]} {
+		set fd_di [git_read diff-index --cached --ignore-submodules=dirty -z [PARENT]]
+	} else {
+		set fd_di [git_read diff-index --cached -z [PARENT]]
+	}
 	set fd_df [git_read diff-files -z]
 
 	fconfigure $fd_di -blocking 0 -translation binary -encoding binary
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 30d9a79..b0a5180 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -287,6 +287,9 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	if {$w eq $ui_index} {
 		lappend cmd diff-index
 		lappend cmd --cached
+		if {[git-version >= "1.7.2"]} {
+			lappend cmd --ignore-submodules=dirty
+		}
 	} elseif {$w eq $ui_workdir} {
 		if {[string first {U} $m] >= 0} {
 			lappend cmd diff
-- 
2.0.0-531-gbd04298
