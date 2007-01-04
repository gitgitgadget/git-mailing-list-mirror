From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/5] Add contrib/stg-whatchanged: look at what would be changed by refreshing.
Date: Fri, 05 Jan 2007 00:46:47 +0100
Message-ID: <20070104234647.13580.50428.stgit@gandelf.nowhere.earth>
References: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 00:48:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2cJV-0004EC-Im
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 00:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbXADXry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 18:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbXADXrx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 18:47:53 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:53976 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030289AbXADXrw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 18:47:52 -0500
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 0BE0E898682
	for <git@vger.kernel.org>; Thu,  4 Jan 2007 23:47:57 +0100 (CET)
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id B4E3E54D0;
	Fri,  5 Jan 2007 00:46:50 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H2cIT-0001l5-Ri; Fri, 05 Jan 2007 00:46:57 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35963>


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
index 0000000..978749c
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
+    current_cmd="stg-show-old"
+else
+    current_cmd="stg show"
+fi
+
+colordiff "$@" \
+    -I '^index [0-9a-b]*..[0-9a-b]*' \
+    -I '^@@ .* @@' \
+    <($current_cmd) <(stg diff -r//bottom) | less -RFX
