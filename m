From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] git-remote-testgit: avoid process substitution
Date: Mon, 29 Apr 2013 10:41:53 -0700
Message-ID: <1367257315-12009-2-git-send-email-gitster@pobox.com>
References: <7vehdtjl2n.fsf@alter.siamese.dyndns.org>
 <1367257315-12009-1-git-send-email-gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 19:42:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWs5W-0003U5-HO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852Ab3D2RmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:42:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757275Ab3D2Rl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:41:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 429671ABA7;
	Mon, 29 Apr 2013 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qW+b
	FRjYw+RkuWQNYjIOpFRIt7A=; b=OR8hiis6+V1hSVfFs4OrEsbwmJ345xLpgCYy
	Hfbw5JCbWczzdQExenpLv46cG4H+PexxWl2+UGzqt+rMK8DK7hm40Q5JFpmmuV5x
	OjrSi1u5QZhQ2ZhrfGwAJdH2v8UABG/sAnXzQ+y5xmMa5HQVnG9ansGXR87ATr5S
	kcYyA28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	wpit3GEUZwl6XnusLY+aweIFKXGdjz7ltUep62Ej/21XrVy2nEfyfGgcW00gITSf
	EJhEmjrGxzcDexGhLkLXlXYGRviya8KBYKymka2w/eoRTERYGYfe4Vt2qkND+XYC
	vPQgUVmTVUwvxEJqg/tgedN/KjKYdkw0JdIctKKF1q0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ADBC1ABA6;
	Mon, 29 Apr 2013 17:41:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF4191ABA4;
	Mon, 29 Apr 2013 17:41:58 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-rc0-121-gda9b90f
In-Reply-To: <1367257315-12009-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 177F0184-B0F4-11E2-9DF3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222824>

From: Johannes Sixt <j6t@kdbg.org>

The implementation of bash on Windows does not offer process substitution.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote-testgit | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 5fd09f9..643e4ae 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -86,17 +86,18 @@ do
 			exit 1
 		fi
 
-		before=$(git for-each-ref --format='%(refname) %(objectname)')
+		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
 
 		git fast-import "${testgitmarks_args[@]}" --quiet
 
-		after=$(git for-each-ref --format='%(refname) %(objectname)')
-
 		# figure out which refs were updated
-		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
-		while read ref a b
+		git for-each-ref --format='%(refname) %(objectname)' |
+		while read ref a
 		do
-			test $a == $b && continue
+			case "$before" in
+			*" $ref $a "*)
+				continue ;;	# unchanged
+			esac
 			echo "ok $ref"
 		done
 
-- 
1.8.3-rc0-121-gda9b90f
