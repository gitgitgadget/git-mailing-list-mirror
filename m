From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rerere: plug memory leaks upon "rerere forget" failure
Date: Wed, 11 May 2016 16:32:34 -0700
Message-ID: <xmqqpossi31p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:32:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0dcR-00074j-EE
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 01:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbcEKXcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 19:32:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751129AbcEKXci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 19:32:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BF551A546;
	Wed, 11 May 2016 19:32:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=b
	mxSfFHPbplENa6zG/bQex5v1Nk=; b=k4BrBfXl0+eLS/EDwmE+SAt/u6d+q0d0M
	5zSZd8MDOvHWWQ0Loi0VY7IhZEqQePeSW4MWRpJiitIXvmroWjs536Yxmnw1X8lR
	DptF4/kTqIOiFzwPtfqboLB/9F5CydKuoJfLPkmcQzTXjfR4IK0dn5woXQZV1UdY
	/nnvscLopI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WJb
	C8Lhpx/56+Yo6MVZdmyG681D+Rcfvp7uICvU214bGnAMWuPmtt5zpa3WS47jPQWz
	DLsi9KBoYs8HdhdGp8kJgltkibopVtpCuNUTVV1vlLpUK4lF3rpCc2DNqR9VWFVY
	A6u3C/TQHmMJr8KwE3Ohlfo/MjH9tXEExDpePZWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13A041A545;
	Wed, 11 May 2016 19:32:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88F741A544;
	Wed, 11 May 2016 19:32:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A4BAEEE6-17D0-11E6-8623-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294375>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/rerere.c b/rerere.c
index 1693866..a804171 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1052,8 +1052,8 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 		handle_cache(path, sha1, rerere_path(id, "thisimage"));
 		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
 			free(cur.ptr);
-			return error("Failed to update conflicted state in '%s'",
-				     path);
+			error("Failed to update conflicted state in '%s'", path);
+			goto fail_exit;
 		}
 		cleanly_resolved = !try_merge(id, path, &cur, &result);
 		free(result.ptr);
@@ -1062,14 +1062,19 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 			break;
 	}
 
-	if (id->collection->status_nr <= id->variant)
-		return error("no remembered resolution for '%s'", path);
+	if (id->collection->status_nr <= id->variant) {
+		error("no remembered resolution for '%s'", path);
+		goto fail_exit;
+	}
 
 	filename = rerere_path(id, "postimage");
-	if (unlink(filename))
-		return (errno == ENOENT
-			? error("no remembered resolution for %s", path)
-			: error("cannot unlink %s: %s", filename, strerror(errno)));
+	if (unlink(filename)) {
+		if (errno == ENOENT)
+			error("no remembered resolution for %s", path);
+		else
+			error("cannot unlink %s: %s", filename, strerror(errno));
+		goto fail_exit;
+	};
 
 	/*
 	 * Update the preimage so that the user can resolve the
@@ -1088,6 +1093,10 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	item->util = id;
 	fprintf(stderr, "Forgot resolution for %s\n", path);
 	return 0;
+
+fail_exit:
+	free(id);
+	return -1;
 }
 
 int rerere_forget(struct pathspec *pathspec)
-- 
2.8.2-679-g91c6421
