From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/15] merge: do not check argc to determine number of remote heads
Date: Wed, 29 Apr 2015 14:29:24 -0700
Message-ID: <1430342973-30344-7-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYJ-0006RW-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbbD2V3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbbD2V3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 572514DAAF;
	Wed, 29 Apr 2015 17:29:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xdiW
	SuHgjm1/nhgsrLprY7Qdt0M=; b=Anar0aGPdx10xr/k6Lzbt8aI6IylbYrljzxn
	y8QJ7IWVlIzmu4Xb/kVFje3d6mRAaGUB8n9WmWnVpXwnFJMisYa7GD/2HXYuu8Jz
	7VnhurumJ/WZ7Tjx3LQoifQYEw7sIk2BwJTJ9XQ0onXMu+VpmCOVvhePMja/o8N5
	XBJXvao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bsksaq
	vwi1eF8AF8IkFZR1VYY5mNi6SNIEZsXwi/Z/PokQpDXFWptOZG8z/EfSaW6nM7hE
	Mur6x5If89ZdCoGjibtdDeeWyBbmnhzBFtDt99fTFunTrINz5TWm6Y4fHS+qYWiA
	Qizhug2GVeedryaiuANC6JIzVaWMNYRd5Krog=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D1CF4DAAE;
	Wed, 29 Apr 2015 17:29:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D24924DAAB;
	Wed, 29 Apr 2015 17:29:43 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DA1C998E-EEB6-11E4-9FC5-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268014>

To reject merging multiple commits into an unborn branch, we check
argc, thinking that collect_parents() that reads the remaining
command line arguments from <argc, argv> will give us the same
number of commits as its input, i.e. argc.

Because what we really care about is the number of commits, let the
function run and then make sure it returns only one commit instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 878f82a..1d4fbd3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1185,9 +1185,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * to forbid "git merge" into a branch yet to be born.
 		 * We do the same for "git pull".
 		 */
-		if (argc != 1)
-			die(_("Can merge only exactly one commit into "
-				"empty head"));
 		if (squash)
 			die(_("Squash commit into empty head not supported yet"));
 		if (fast_forward == FF_NO)
@@ -1197,6 +1194,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		remote_head = remoteheads->item;
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
+		if (remoteheads->next)
+			die(_("Can merge only exactly one commit into empty head"));
 		read_empty(remote_head->object.sha1, 0);
 		update_ref("initial pull", "HEAD", remote_head->object.sha1,
 			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
-- 
2.4.0-rc3-300-g052d062
