From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] do not loop around deref_tag()
Date: Tue, 14 Jun 2016 13:28:39 -0700
Message-ID: <xmqqfusf8qh4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 22:29:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCuxH-000598-9f
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 22:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbcFNU2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 16:28:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752184AbcFNU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 16:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C3F2198E;
	Tue, 14 Jun 2016 16:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	PSgzkxYxkLPrVgtfqATf8x7tuc=; b=vrQ2i5pqYZ8a9F/4QmHXeYr6H3JsVpQWo
	3Z5rfOqPmx91rMpCmVDd8d87wxP6y33qUVZBTuaOhhB9b6zRlPCTFJ4rL/SmDbSx
	o8DNUS/hAygCtC5o/CxZwOENsMVWAWzGKAcF+M+ngjgbYM5Y6sSObxtCfOHFVbRi
	gNTjEQL13M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=PW/
	OlEaMJYbtI0IHoAdEBZ1EInRaNwp9A+NZ8ZYQh3PSwON0pe3BrZx44t1qwYOWME2
	6fznddbhkAjTuBkOXZPS9e0eb3lGz/sIy2N0F3mmr0dZ/LzfM7kild3cpFOiukhC
	fZln2fMTz9J2nvjwqD+tz6tVTR6GjTBFeBHLhLC0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BEC942198D;
	Tue, 14 Jun 2016 16:28:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E5D42198C;
	Tue, 14 Jun 2016 16:28:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 954289AC-326E-11E6-9F72-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297327>

These callers appear to expect that deref_tag() is to peel one layer
of a tag, but the function does not work that way; it has its own
loop to unwrap tags until an object that is not a tag appears.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c | 6 ++----
 line-log.c      | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..7417edf 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2425,8 +2425,7 @@ static struct commit *find_single_final(struct rev_info *revs,
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		while (obj->type == OBJ_TAG)
-			obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
@@ -2461,8 +2460,7 @@ static char *prepare_initial(struct scoreboard *sb)
 		struct object *obj = revs->pending.objects[i].item;
 		if (!(obj->flags & UNINTERESTING))
 			continue;
-		while (obj->type == OBJ_TAG)
-			obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (sb->final)
diff --git a/line-log.c b/line-log.c
index bbe31ed..1fbbe4f 100644
--- a/line-log.c
+++ b/line-log.c
@@ -480,8 +480,7 @@ static struct commit *check_single_commit(struct rev_info *revs)
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		while (obj->type == OBJ_TAG)
-			obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (commit)
