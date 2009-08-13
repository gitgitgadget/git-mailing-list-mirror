From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 2/6] Add a small patch-mode testing library
Date: Thu, 13 Aug 2009 14:29:40 +0200
Message-ID: <5bbd70c769ada6bf75a899e77a65d12ac5730bdc.1250164190.git.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZS7-0002tc-Ec
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbZHMMaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbZHMMaQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:16 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbZHMMaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:12 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:09 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:01 +0200
X-Mailer: git-send-email 1.6.4.262.gbda8
In-Reply-To: <cover.1250164190.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125811>

The tests for {reset,commit,stash} -p will frequently have to set both
worktree and index states to known values, and verify that the outcome
(again both worktree and index) are what was expected.

Add a small helper library that lets us do these tasks more easily.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/lib-patch-mode.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 t/lib-patch-mode.sh

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
new file mode 100755
index 0000000..afb4b66
--- /dev/null
+++ b/t/lib-patch-mode.sh
@@ -0,0 +1,36 @@
+. ./test-lib.sh
+
+set_state () {
+	echo "$3" > "$1" &&
+	git add "$1" &&
+	echo "$2" > "$1"
+}
+
+save_state () {
+	noslash="$(echo "$1" | tr / _)" &&
+	cat "$1" > _worktree_"$noslash" &&
+	git show :"$1" > _index_"$noslash"
+}
+
+set_and_save_state () {
+	set_state "$@" &&
+	save_state "$1"
+}
+
+verify_state () {
+	test "$(cat "$1")" = "$2" &&
+	test "$(git show :"$1")" = "$3"
+}
+
+verify_saved_state () {
+	noslash="$(echo "$1" | tr / _)" &&
+	verify_state "$1" "$(cat _worktree_"$noslash")" "$(cat _index_"$noslash")"
+}
+
+save_head () {
+	git rev-parse HEAD > _head
+}
+
+verify_saved_head () {
+	test "$(cat _head)" = "$(git rev-parse HEAD)"
+}
-- 
1.6.4.262.gbda8
