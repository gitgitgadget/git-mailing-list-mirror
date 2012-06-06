From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] unpack-trees.c: use path_excluded() in
 check_ok_to_remove()
Date: Tue,  5 Jun 2012 22:45:18 -0700
Message-ID: <1338961519-30970-6-git-send-email-gitster@pobox.com>
References: <1338961519-30970-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 07:46:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc94O-0002JF-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 07:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab2FFFps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 01:45:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935Ab2FFFpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 01:45:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BF7C6009
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wCE1
	1oyclUUj+i1UdrHiXixHBJ4=; b=sK3ogfw3AqoAnAaQLYdSscBoapj299RDLKkY
	Y0bWOWwFf95B8tnk6CR9G32lkz40jGu9IHoW15DlEcbZ1ArfxI8FOQAHimr715Tm
	CUrKUiZn7aXMvV1Nku+RSC2qjWtU2kR5imSgRWSGdJxL4sQvcCWh505hdyvblk9L
	FuSeUHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Dj/fRN
	y3hsjDpC1SajF/gWP/l2gSmyWcWjWgdTA5LjB9SOMLmGOMhwS1c6P5jqQG954nmG
	/90pOiGSXB3V59Y5oNLljKrVmJtZTxdOptiuuZtdiT56VZ9Fpc0ByeTSpUakkbTt
	tFMDTVNPgmkc9DjfIzAeMq8ZwCWh4b9sm31UM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83E926008
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 107886007 for
 <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338961519-30970-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D32FB5BA-AF9A-11E1-A947-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199304>

This function is responsible for determining if a path that is not
tracked is ignored and allow "checkout" to overwrite it as needed.
It used excluded() without checking if higher level directory in the
path is ignored; correct it to use path_excluded() for this check.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There are uses of lower-level interface excluded_from_list() in
   the codepath for narrow-checkout hack; they are supposed to be
   already checking each level as they descend, and are not touched
   with this patch.
---
 unpack-trees.c | 11 ++++++++++-
 unpack-trees.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..133f2c9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1016,6 +1016,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			o->el = &el;
 	}
 
+	if (o->dir) {
+		o->path_exclude_check = xmalloc(sizeof(struct path_exclude_check));
+		path_exclude_check_init(o->path_exclude_check, o->dir);
+	}
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized = 1;
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
@@ -1140,6 +1144,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 done:
 	free_excludes(&el);
+	if (o->path_exclude_check) {
+		path_exclude_check_clear(o->path_exclude_check);
+		free(o->path_exclude_check);
+	}
 	return ret;
 
 return_failed:
@@ -1355,7 +1363,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (ignore_case && icase_exists(o, name, len, st))
 		return 0;
 
-	if (o->dir && excluded(o->dir, name, &dtype))
+	if (o->dir &&
+	    path_excluded(o->path_exclude_check, name, -1, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
diff --git a/unpack-trees.h b/unpack-trees.h
index 5e432f5..ec74a9f 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -52,6 +52,7 @@ struct unpack_trees_options {
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
+	struct path_exclude_check *path_exclude_check;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
-- 
1.7.11.rc1.37.g09843ac
