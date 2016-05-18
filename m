From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr: add counted string version of git_check_attr()
Date: Wed, 18 May 2016 14:01:29 -0700
Message-ID: <xmqqshxfqdw6.fsf_-_@gitster.mtv.corp.google.com>
References: <20160518190222.28105-1-sbeller@google.com>
	<20160518190222.28105-6-sbeller@google.com>
	<xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
	<xmqqy477qfr2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:01:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b38bG-0004tV-Re
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbcERVBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 17:01:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754019AbcERVBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:01:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 66EB61C46F;
	Wed, 18 May 2016 17:01:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UPCkRz1fla3zny4r/Ukt6Fbrc98=; b=gKHGGl
	ve8hI7MvNzVubbT96m6v6YaMAWxwWssZSGFX/AHI68/D8NAdKCP3RhA6d4XcYFqL
	GAoanLCsKAWl08hlIxzL8SjB1ierxbSE1P28b0rI5VKNDijG+eJovwlpmRj3oUPU
	0Xhh7Hr4ziqereqij+FTw5spp98O+3Iu6ate8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v5H1OXaHpKM8u8OOo9fcVCfhkulnaRIi
	MgyMtnGANHMPGWV+VQQ8zIeojTsu2+9/mZkzA0KvCdTO5cz5VdB/HnPKgShnFWHH
	zmaBror9w6BNemUtSO2ZOxkd/xkHeldPH5X9xfUovQTxELIYnH7gpmG+hnPZAYDr
	wvIYQc+2mx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F7221C46E;
	Wed, 18 May 2016 17:01:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D38061C46D;
	Wed, 18 May 2016 17:01:31 -0400 (EDT)
In-Reply-To: <xmqqy477qfr2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 May 2016 13:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B2A4FC16-1D3B-11E6-A8BD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295008>

Often a potential caller has <path, pathlen> pair that
represents the path it wants to ask attributes for; when
path[pathlen] is not NUL, the caller has to xmemdupz()
only to call git_check_attr().

Add git_check_attr_counted() that takes such a counted
string instead of "const char *path".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This time with a log message

 attr.c | 23 ++++++++++++++---------
 attr.h |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index e0f7965..eeb29e6 100644
--- a/attr.c
+++ b/attr.c
@@ -725,20 +725,19 @@ static int macroexpand_one(int nr, int rem)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int num,
+static void collect_some_attrs(const char *path, int pathlen, int num,
 			       struct git_attr_check_elem *check)
 
 {
 	struct attr_stack *stk;
-	int i, pathlen, rem, dirlen;
+	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
 
-	for (cp = path; *cp; cp++) {
+	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
 			last_slash = cp;
 	}
-	pathlen = cp - path;
 	if (last_slash) {
 		basename_offset = last_slash + 1 - path;
 		dirlen = last_slash - path;
@@ -769,12 +768,12 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int num,
+static int git_check_attrs(const char *path, int pathlen, int num,
 			   struct git_attr_check_elem *check)
 {
 	int i;
 
-	collect_some_attrs(path, num, check);
+	collect_some_attrs(path, pathlen, num, check);
 
 	for (i = 0; i < num; i++) {
 		const char *value = check_all_attr[check[i].attr->attr_nr].value;
@@ -791,7 +790,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, 0, NULL);
+	collect_some_attrs(path, strlen(path), 0, NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -816,10 +815,16 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-int git_check_attr(const char *path, struct git_attr_check *check)
+int git_check_attr_counted(const char *path, int pathlen,
+			   struct git_attr_check *check)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, check->check_nr, check->check);
+	return git_check_attrs(path, pathlen, check->check_nr, check->check);
+}
+
+int git_check_attr(const char *path, struct git_attr_check *check)
+{
+	return git_check_attr_counted(path, strlen(path), check);
 }
 
 struct git_attr_check *git_attr_check_initl(const char *one, ...)
diff --git a/attr.h b/attr.h
index 51ca36d..4a4ac76 100644
--- a/attr.h
+++ b/attr.h
@@ -38,6 +38,7 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
+extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern void git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.8.2-759-geb611ab
