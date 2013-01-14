From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] cvsimport: introduce a version-switch wrapper
Date: Sun, 13 Jan 2013 23:25:48 -0800
Message-ID: <1358148351-31552-4-git-send-email-gitster@pobox.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358148351-31552-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 08:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueRK-0002iO-BO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab3ANH0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:26:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61279 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495Ab3ANH0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:26:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBFAAB8B3
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AQGf
	+9BEJPTwRlar2ve9LXtt+20=; b=fqsANCWgjbu7mch7wkqKJhxNY/14Mf+G8plg
	jrh3kPY0Kr6XI1L1EtK7TT5fJrRX2mwN+jKzv1/WjJOlZyrCFfYXbpwDQ145r8H7
	LIDFPZQzms9403RhgYDmOqCqWcnseL94rHiQoieD78R1M/ZcR4fBiauZeWsclTOH
	a9dx6yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nge6qb
	DRiWwO/NrvOwhUxsvDf+Vekpx/HlYj0W14b1bkDqqO3L9trEerSQeqvwz3MffjK8
	+TlQBLPRzDv3e0xC/SpKjfrQ5tTsBak8EARMRZFdtZe0KXMQ1bj9c2zkYZT18OY7
	pyQn9MCiL9+S/lyjomf2Y7lTX6rQI44EoF2hw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1634B8B2
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3479FB8AF for
 <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:59 -0500 (EST)
X-Mailer: git-send-email 1.8.1.421.g6236851
In-Reply-To: <1358148351-31552-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A48AB23E-5E1B-11E2-8F7B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213465>

In preparation to have both old and new cvsimport during the
transition period, rename the cvsimport script to cvsimport-2
and introduce a small wrapper that we can later change it to
allow users to run either frontend (with their corresponding
cvsps backends).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                                 | 1 +
 Makefile                                   | 9 ++++++++-
 git-cvsimport.perl => git-cvsimport-2.perl | 0
 git-cvsimport.sh                           | 5 +++++
 4 files changed, 14 insertions(+), 1 deletion(-)
 rename git-cvsimport.perl => git-cvsimport-2.perl (100%)
 create mode 100755 git-cvsimport.sh

diff --git a/.gitignore b/.gitignore
index aa258a6..8cb799c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,6 +40,7 @@
 /git-credential-store
 /git-cvsexportcommit
 /git-cvsimport
+/git-cvsimport-2
 /git-cvsserver
 /git-daemon
 /git-diff
diff --git a/Makefile b/Makefile
index dd2a024..f3113a9 100644
--- a/Makefile
+++ b/Makefile
@@ -253,6 +253,9 @@ all::
 #
 # Define NO_PYTHON if you do not want Python scripts or libraries at all.
 #
+# Define CVSPS2_PATH if you cannot invoke cvsps (version 2.x) as "cvsps"
+# using your $PATH; if you do not have any, define CVSPS2_PATH=NoThanks.
+#
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
 # The TCL_PATH variable governs the location of the Tcl interpreter
@@ -440,6 +443,7 @@ unexport CDPATH
 
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
+SCRIPT_SH += git-cvsimport.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
@@ -468,12 +472,15 @@ SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
-SCRIPT_PERL += git-cvsimport.perl
+ifneq ($(CVSPS2_PATH),NoThanks)
+SCRIPT_PERL += git-cvsimport-2.perl
+endif
 SCRIPT_PERL += git-cvsserver.perl
 SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
+SCRIPT_PYTHON += git-p4.py
 SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
diff --git a/git-cvsimport.perl b/git-cvsimport-2.perl
similarity index 100%
rename from git-cvsimport.perl
rename to git-cvsimport-2.perl
diff --git a/git-cvsimport.sh b/git-cvsimport.sh
new file mode 100755
index 0000000..71ba11d
--- /dev/null
+++ b/git-cvsimport.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+GIT_CVSPS_VERSION=2
+
+exec git cvsimport-$GIT_CVSPS_VERSION "$@"
-- 
1.8.1.421.g6236851
