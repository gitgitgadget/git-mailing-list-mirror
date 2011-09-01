From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] rev-list --verify-object
Date: Thu,  1 Sep 2011 15:43:34 -0700
Message-ID: <1314917015-3587-3-git-send-email-gitster@pobox.com>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <1314917015-3587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 00:43:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzFzH-0000h6-He
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 00:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab1IAWnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 18:43:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572Ab1IAWnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 18:43:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A636E5245
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=X4UQ
	Jwcu0h1akY/s1VyqyS9XF8w=; b=hp8MSOTG36sf5RuSw+NWKlCAXObkegzyLcCt
	Z+4wqZjXw98YRoya5L0muW+RNi3rkwYGVRJZmu5cWUfv5i8qR8AfB6zGzu0IiGHW
	D1SGt0RYfAVTybo9btnd55+NDPbhhTkzTiRZviVhn2avVZE0hsPB+PqIm0J7jldt
	UxPvKxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=sxmklj
	51EHheImASb2oKpW31vfh2WTCqtiS7NaPxEjYcc2nFNzaw3PzfEFFk7EsZp6ndA6
	MEWZbUfwz7V8EO9fgyb/gDF16q+qucalzTrtFuWmP8A/e5QHE83+ah7NGbB6U2VV
	Qi3bgPx3TeeoZHOyvcTPN6ot0vO+0OFZazQGc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D9E95244
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C84F5243 for
 <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.72.g4b5ea
In-Reply-To: <1314917015-3587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D67B44F8-D4EB-11E0-BF64-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180580>

Often we want to verify everything reachable from a given set of commits
are present in our repository and connected without a gap to the tips of
our refs. We used to do this for this purpose:

    $ rev-list --objects $commits_to_be_tested --not --all

Even though this is good enough for catching missing commits and trees,
we show the object name but do not verify their existence, let alone their
well-formedness, for the blob objects at the leaf level.

Add a new "--verify-object" option so that we can catch missing and broken
blobs as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-list.c |    4 ++++
 revision.c         |    5 +++++
 revision.h         |    1 +
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 920b91c..ab3be7c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -180,7 +180,11 @@ static void show_object(struct object *obj,
 			const struct name_path *path, const char *component,
 			void *cb_data)
 {
+	struct rev_info *info = cb_data;
+
 	finish_object(obj, path, component, cb_data);
+	if (info->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
+		parse_object(obj->sha1);
 	show_object_with_name(stdout, obj, path, component);
 }
 
diff --git a/revision.c b/revision.c
index 072ddac..5ef498b 100644
--- a/revision.c
+++ b/revision.c
@@ -1383,6 +1383,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->tree_objects = 1;
 		revs->blob_objects = 1;
 		revs->edge_hint = 1;
+	} else if (!strcmp(arg, "--verify-objects")) {
+		revs->tag_objects = 1;
+		revs->tree_objects = 1;
+		revs->blob_objects = 1;
+		revs->verify_objects = 1;
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked = 1;
 	} else if (!prefixcmp(arg, "--unpacked=")) {
diff --git a/revision.h b/revision.h
index da00a58..648876b 100644
--- a/revision.h
+++ b/revision.h
@@ -53,6 +53,7 @@ struct rev_info {
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
+			verify_objects:1,
 			edge_hint:1,
 			limited:1,
 			unpacked:1,
-- 
1.7.7.rc0.72.g4b5ea
