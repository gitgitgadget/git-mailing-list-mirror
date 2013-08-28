From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH] Add testcase for needless objects during a shallow fetch
Date: Wed, 28 Aug 2013 18:02:02 +0200
Message-ID: <1377705722-17053-1-git-send-email-matthijs@stdin.nl>
References: <20130828153638.GF10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 18:31:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEiek-0003Vl-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 18:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab3H1Qbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 12:31:36 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:56729 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755082Ab3H1Qbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 12:31:35 -0400
X-Greylist: delayed 1757 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2013 12:31:35 EDT
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
	(envelope-from <matthijs@stdin.nl>)
	id 1VEiC4-0004Rc-UU; Wed, 28 Aug 2013 18:02:04 +0200
X-Mailer: git-send-email 1.8.4.rc1
In-Reply-To: <20130828153638.GF10217@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233191>

This is a testcase that checks for a problem where, during a specific
shallow fetch where the client does not have any commits that are a
successor of the new shallow root (i.e., the fetch creates a new
detached piece of history), the server would simply send over _all_
objects, instead of taking into account the objects already present in
the client.

The actual problem was fixed by a recent patch series by Nguy=E1=BB=85n=
 Th=C3=A1i
Ng=E1=BB=8Dc Duy already.

Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 t/t5500-fetch-pack.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index fd2598e..a022d65 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -393,6 +393,17 @@ test_expect_success 'fetch in shallow repo unreach=
able shallow objects' '
 		git fsck --no-dangling
 	)
 '
+test_expect_success 'fetch creating new shallow root' '
+	(
+		git clone "file://$(pwd)/." shallow10 &&
+		git commit --allow-empty -m empty &&
+		cd shallow10 &&
+		git fetch --depth=3D1 --progress 2> actual &&
+		# This should fetch only the empty commit, no tree or
+		# blob objects
+		grep "remote: Total 1" actual
+	)
+'
=20
 test_expect_success 'setup tests for the --stdin parameter' '
 	for head in C D E F
--=20
1.8.4.rc1
