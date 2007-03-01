From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/8] Add contrib/stg-whatchanged: look at what would be
	changed by refreshing.
Date: Fri, 02 Mar 2007 00:03:40 +0100
Message-ID: <20070301230339.32459.18579.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuJc-0003th-JR
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbXCAXDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbXCAXDv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:03:51 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49818 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161200AbXCAXDu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:03:50 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0DF5538F0;
	Fri,  2 Mar 2007 00:03:49 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 0CF1A1F084;
	Fri,  2 Mar 2007 00:03:40 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41143>


This script outputs a "metadiff" (diff of diffs, ie. diff between 2
versions of a single patch).  This is somewhat a proof of concept, and some
work is indeed needed in the way to present the results.  Consider
filtering the output at least through colordiff.

I have 2 uses for this script:
- when simply editing a patch, provides a 3rd way to check what I've done
  before refreshing (in addition to "stg diff" and "stg diff -r //bottom")
- most usefully, when resolving conflicts caused by a push, to ease
  checking of the merge result.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-whatchanged |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-whatchanged b/contrib/stg-whatchanged
new file mode 100755
index 0000000..f80d0a1
--- /dev/null
+++ b/contrib/stg-whatchanged
@@ -0,0 +1,37 @@
+#!/bin/bash
+set -e
+
+# stg-whatchanged - show a metadiff for the patch being modified,
+# especially when resolving a merge.
+
+# Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+# FIXME:
+# - should only exclude hunk headers differing only in line offsets
+# - diff coloring should show changes in context lines differently than
+#   changes in contents
+# - filter on ^index lines is a bit wide
+# - we should be able to ask diff to force a new hunk on "^@@ " to better
+#   handle them
+# - we should always show the hunk header for any changes within a hunk
+
+# default to unified diff
+if [ "$#" = 0 ]; then
+    set -- -u
+fi
+
+# Merges via "push" leave top=bottom so we must look at old patch
+# in this case (unlike, eg., "pick --fold")
+patchdir="$(git-rev-parse --git-dir)/patches/$(stg branch)/$(stg top)"
+if [ $(cat "$patchdir/bottom") = $(cat "$patchdir/top") ];
+then
+    current_cmd="stg show //top.old"
+else
+    current_cmd="stg show"
+fi
+
+colordiff "$@" \
+    -I '^index [0-9a-b]*..[0-9a-b]*' \
+    -I '^@@ .* @@' \
+    <($current_cmd) <(stg diff -r//bottom) | less -RFX
