From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] edit-link: add new builtin
Date: Fri,  5 Apr 2013 00:00:41 +0530
Message-ID: <1365100243-13676-6-git-send-email-artagnon@gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:30:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNovD-0007fT-WB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764550Ab3DDS31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:27 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:41918 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764494Ab3DDS30 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:26 -0400
Received: by mail-da0-f41.google.com with SMTP id w4so1242638dam.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zN3kIHywbI+ekmwcTDcPbCcwJx+Z2p3ersSm/Cn02OI=;
        b=V5xd7k0FeRr/6k3WIgxWkphMuabmxkAwH2mpiNJXVFp/yUIKjNyC1NCkWKbp5R7Lkp
         3ReFWlnd8IwvtZIdTm3eumDFowSft+fKVk42Rs6xc9qHiX7MDG11wbxj5ZU92Hdfotk/
         wj/92SrECfUS83CXgUJPIJJMaDLlaHqEIlktZOHI3muK785eC9Mi5yPVa8ZDJaOmKN7u
         DAd1UC7TxkKH+AUInJ6lqY/JMn5RgVi3LaKMd9d/fz9jYZ8jiB3A7ou9Ok9noBNURCQO
         rnT3KhrpEe9ZpSJLN+LVH/cg4i18y6BEYpboE9UBqHyB/tbsu6exkg7kHeJqxq3DLizv
         l6TQ==
X-Received: by 10.66.240.2 with SMTP id vw2mr10820559pac.157.1365100164711;
        Thu, 04 Apr 2013 11:29:24 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220052>

This is a WIP.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-edit-link.sh | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 git-edit-link.sh

diff --git a/git-edit-link.sh b/git-edit-link.sh
new file mode 100644
index 0000000..3ff0e84
--- /dev/null
+++ b/git-edit-link.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+# Copyright (c) 2013 Ramkumar Ramachandra
+
+dashless=$(basename "$0" | sed -e 's/-/ /')
+USAGE='[--floating] [--ref-name <name>] [--checkout-rev <rev>] [--statthrough] <directory>'
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+START_DIR=`pwd`
+. git-sh-setup
+. git-sh-i18n
+require_work_tree
+cd_to_toplevel
+
+link_spec="$GIT_DIR/LINK_SPEC"
+
+read_and_verify_link_spec () {
+	test -f "$link_spec" || die "fatal: could not open $link_spec."
+
+	## TODO
+	## Rules:
+	#  upstream_url is a mandatory field; others are optional
+	#  if floating is false, checkout_rev has to be a SHA-1 hex
+	#  ref_name must be a valid name, and not conflict with an existing ref
+
+	return 0;
+}
+
+# Prepare an initial link_spec using the command-line options
+rm -f "$link_spec"
+touch "$link_spec" || die "fatal: could not create $link_spec."
+
+total_argc=$#
+while test $# != 0
+do
+	case "$1" in
+		--checkout-rev)
+			shift
+			cat >>"$link_spec" <<-EOF
+			checkout_ref = $1
+			EOF
+			;;
+		--ref-name)
+			shift
+			cat >>"$link_spec" <<-EOF
+			ref_name = $1
+			EOF
+			;;
+		--floating)
+			cat >>"$link_spec" <<-\EOF
+			floating = 1
+			EOF
+			;;
+		--statthrough)
+			cat >>"$link_spec" <<-\EOF
+			statthrough = 1
+			EOF
+			;;
+		--)
+			shift
+			break
+			;;
+	esac
+	shift
+done
+
+link_directory="$1"
+test -d "$link_directory" || die "fatal: $link_directory is not a valid directory."
+
+cd "$link_directory" && {
+	test -f "$link_directory/.git" &&
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
+	die "fatal: $link_directory is not a valid bare working tree."
+
+	# Determine the upstream_url
+	upstream_url=$(git config --get remote.origin.url)
+}
+
+test -z $upstream_url &&
+die "fatal: $link_directory does not have a configured upstream remote origin."
+cat >>"$link_spec" <<-\EOF
+upstream_url = $upstream_url
+EOF
+
+# Launch the editor
+git_editor "$link_spec" || die "$(gettext "Could not execute editor")"
+read_and_verify_link_spec
-- 
1.8.2.380.g0d4e79b
