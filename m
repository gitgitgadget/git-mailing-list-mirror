From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 5/5] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 13:21:21 -0700
Message-ID: <xmqqy477qfr2.fsf@gitster.mtv.corp.google.com>
References: <20160518190222.28105-1-sbeller@google.com>
	<20160518190222.28105-6-sbeller@google.com>
	<xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 22:24:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b381H-00081h-LV
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbcERUXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:23:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933145AbcERUV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:21:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 543111CEC4;
	Wed, 18 May 2016 16:21:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HZwEPgPVZgbnmtA4exCDV0S1jV0=; b=mCU+z+
	LIM8T/tKnnVYFKCgSUvpY6FN45z6SY3Pi8eai63lJuq1PtR5yWrXWqDV/u0LilxZ
	qR2L8dHvtBHFU7jSjWDbTiC4Gafrl/ai/64pK6+cE1F4uEoScTHH8HfykmnzkGG9
	cJcaiNMNsLWO/kSjp1jJw+GUmntu05lemxdBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=imBGMPLDI9lgRrTy3ka8sfzYM5odsnqB
	byMmixnFvWu1r3lt/TDSHjyVQfvu8boWfxAeTsyG6jyHxVirC2ts3Fq8ErRiLhdj
	FCz5bHWKn8vIZDwmOfpmDLxt7JUnvBOpN1VoIKucSbrJYL2vXWoDb8Kx+tOFQXld
	ahO/ciOwfcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A9B31CEC3;
	Wed, 18 May 2016 16:21:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78BE81CEC2;
	Wed, 18 May 2016 16:21:23 -0400 (EDT)
In-Reply-To: <xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 May 2016 12:47:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1724AA3E-1D36-11E6-908F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295006>

Junio C Hamano <gitster@pobox.com> writes:

>> +static int match_attrs(const char *name, int namelen,
>> +		       const struct pathspec_item *item)
>> +{
>> +	char *path;
>> +	int i;
>> +
>> +	path = xmemdupz(name, namelen);
>> +	git_check_attr(path, item->attr_check);
> ...
>> +	}
>> +
>> +	free(path);
>
> Let me see how involved a change would be to allow passing a counted
> string to git_check_attr().

Perhaps the attached is sufficient, and you can avoid copying the
paths in this codepath.

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
