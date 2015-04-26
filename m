From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/14] merge: do not check argc to determine number of remote heads
Date: Sat, 25 Apr 2015 22:25:58 -0700
Message-ID: <1430025967-24479-6-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:27:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5l-0003GC-9K
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbbDZF0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751004AbbDZF0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B36DB466EE;
	Sun, 26 Apr 2015 01:26:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lZab
	sXzhED2fkDee0oJM1zC507U=; b=fYGGXUDzR4Kqnui6j7NUpMlNF2NE5S9RTx7h
	BxNe5tC39sWfxGiH+ptwcyPaVDxU+DVvRLW0wKJkvA+hVuHCBaP8rZ//TG6BrWuq
	I2RGTs2RKTbTteosz/pKEIRQ85vPiRXE7WiyhTMOQEXJlFH6E4zDbQnY+w2Bih3T
	Vv4ihNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kdjOok
	8XhLK6Kl3SujtgLf1Ze+04+iOTmBz7JUB9iD3+d7OUdVn7j84SrrWEK8MI8vyGSZ
	jfTQ4Jw81kON5MVcPFe2ThFX1NLYUZjO101sPpHUPikepA9N5egBSTgJFeIeKVwN
	JqISMqBLHH/ohe9FqpTJ51Fjj8lGj71Wzrdbo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD46E466ED;
	Sun, 26 Apr 2015 01:26:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 347E0466EC;
	Sun, 26 Apr 2015 01:26:15 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C23BF326-EBD4-11E4-BA7C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267821>

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
2.4.0-rc3-238-g36f5934
