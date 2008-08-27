From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Test that stg coalesce handles head != top
	gracefully
Date: Thu, 28 Aug 2008 00:06:49 +0200
Message-ID: <20080827220649.3607.89509.stgit@yoghurt>
References: <20080827220606.3607.17134.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Sandberg <mandolaerik@gmail.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTBr-00074M-Gk
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058AbYH0WHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 18:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbYH0WHA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:07:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1279 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbYH0WG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:06:59 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KYTVj-0007lk-00; Wed, 27 Aug 2008 23:29:07 +0100
In-Reply-To: <20080827220606.3607.17134.stgit@yoghurt>
User-Agent: StGIT/0.14.3.232.g9dfa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93964>

It currently doesn't quite: it will roll back the transaction just
fine, but not before asking the user for a commit message which is
lost in the rollback.

Bug discovered by Erik Sandberg <mandolaerik@gmail.com>:
https://gna.org/bugs/?12204

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t2600-coalesce.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)


diff --git a/t/t2600-coalesce.sh b/t/t2600-coalesce.sh
index ef5bf99..33c073d 100755
--- a/t/t2600-coalesce.sh
+++ b/t/t2600-coalesce.sh
@@ -28,4 +28,17 @@ test_expect_success 'Coalesce at stack top' '
     [ "$(echo $(stg series --unapplied --noprefix))" =3D "" ]
 '
=20
+cat > editor <<EOF
+#!/bin/sh
+echo "Editor was invoked" | tee editor-invoked
+EOF
+chmod a+x editor
+test_expect_failure 'Coalesce with top !=3D head' '
+    echo blahonga >> foo.txt &&
+    git commit -a -m "a new commit" &&
+    EDITOR=3D./editor command_error stg coalesce --name=3Dr0 p0 q1 &&
+    test "$(echo $(stg series))" =3D "+ p0 > q1" &&
+    test ! -e editor-invoked
+'
+
 test_done
