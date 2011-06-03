From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] index-pack: a miniscule refactor
Date: Fri,  3 Jun 2011 15:32:14 -0700
Message-ID: <1307140337-27676-2-git-send-email-gitster@pobox.com>
References: <1307140337-27676-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QScvA-0005VB-6w
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 00:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab1FCWcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 18:32:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab1FCWcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 18:32:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97A4056E8
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ONmo
	Ihz6igdkja9nDpt3B/bVZDo=; b=EF2g63jCZx2Q7+3Vaja97Y6L3sbpgG/mEVoT
	oSJ2bTk1U4+LcA5Fud/9zMLTWcVyka/UpCIJETg9ttVCBEoiPWefsJXsM8Vk+37E
	EngoU93qjpZx/YyvbACP/q5EOTV8YDZbuM0PTyKy6vrDgpskeBBoUw+r6jRTFD5V
	MdFwAo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CW9ywI
	AhIx1EkXfVdJV4LzWGnrhDPGRfuldoGF0DxnBcrGyBdMwWOPA5cxx+4VGgby7s7u
	6OfC++A/yAHxbhlvzenKEWcdSJQrgEfMBJFXc02wCxwA5jE9vBc3szyNLgOqpDrI
	LNqknSic+TDLOcuLEDz3d2ozKrf4MJCOCs2f0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9470056E7
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AA8356E6 for
 <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc0.106.g68174
In-Reply-To: <1307140337-27676-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A6DE88E6-8E31-11E0-9611-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175034>

Introduce a helper function that takes the type of an object and
tell if it is a delta, as we seem to use this check in many places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 513fbbc..0216af7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -498,12 +498,17 @@ static void sha1_object(const void *data, unsigned long size,
 	}
 }
 
+static int is_delta_type(enum object_type type)
+{
+	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
+}
+
 static void *get_base_data(struct base_data *c)
 {
 	if (!c->data) {
 		struct object_entry *obj = c->obj;
 
-		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
+		if (is_delta_type(obj->type)) {
 			void *base = get_base_data(c->base);
 			void *raw = get_data_from_pack(obj);
 			c->data = patch_delta(
@@ -629,7 +634,7 @@ static void parse_pack_objects(unsigned char *sha1)
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &delta->base);
 		obj->real_type = obj->type;
-		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
+		if (is_delta_type(obj->type)) {
 			nr_deltas++;
 			delta->obj_no = i;
 			delta++;
@@ -676,7 +681,7 @@ static void parse_pack_objects(unsigned char *sha1)
 		struct object_entry *obj = &objects[i];
 		struct base_data base_obj;
 
-		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
+		if (is_delta_type(obj->type))
 			continue;
 		base_obj.obj = obj;
 		base_obj.data = NULL;
-- 
1.7.6.rc0.106.g68174
