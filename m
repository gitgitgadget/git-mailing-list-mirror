From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr: add counted string version of git_attr()
Date: Wed, 18 May 2016 14:03:10 -0700
Message-ID: <xmqqmvnnqdtd.fsf_-_@gitster.mtv.corp.google.com>
References: <20160518190222.28105-1-sbeller@google.com>
	<20160518190222.28105-6-sbeller@google.com>
	<xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
	<xmqqy477qfr2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:03:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b38cg-0005pz-VC
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbcERVDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 17:03:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932090AbcERVDO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:03:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46A1C1D8F6;
	Wed, 18 May 2016 17:03:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r8bSKdfsLtJ0FprDK2+JCnZbYk4=; b=nlqPvq
	fWMCtK+iCUHhijsWnJjTmylvVIwcHaw1BsIhXyaAtKqBQEyXJiktDU3roqRuAOMg
	U6MBEwnPKzH/W+qe+8ZzSkiDLDsLwEuYEP8UWC4/q90uXzhkk0CXlTX6BgyGsj85
	yDWECdgUWG/R1Zyh5T9AyRTQ4LQqyotBz6N9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ekMaU+8kEOVteiTc8APZbCPekuMfmyEd
	EBefd0veBlbGrUb9hF57s063y7TmA2aVV5rlaarlm9vDHeeEYvuZDlu3O4lUBCv/
	PBr4XcW1C17Zi/Fr3EDtOUG1eo3YZfLN9VnBgRniKUv6HCfyubQANhBUzk0zWCYA
	jJa8lU2kIaM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DDAE1D8F5;
	Wed, 18 May 2016 17:03:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4E5F1D8F4;
	Wed, 18 May 2016 17:03:12 -0400 (EDT)
In-Reply-To: <xmqqy477qfr2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 May 2016 13:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEC4E846-1D3B-11E6-978C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295010>

Often a potential caller has <name, namelen> pair that
represents the name it wants to create an attribute out of.

When name[namelen] is not NUL, the caller has to xmemdupz()
only to call git_attr().

Add git_attr_counted() that takes such a counted string instead of
"const char *name".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The same for git_attr()

 attr.c | 8 ++++----
 attr.h | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index eeb29e6..7f20e21 100644
--- a/attr.c
+++ b/attr.c
@@ -78,7 +78,7 @@ static int invalid_attr_name(const char *name, int namelen)
 	return 0;
 }
 
-static struct git_attr *git_attr_internal(const char *name, int len)
+struct git_attr *git_attr_counted(const char *name, size_t len)
 {
 	unsigned hval = hash_name(name, len);
 	unsigned pos = hval % HASHSIZE;
@@ -109,7 +109,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 
 struct git_attr *git_attr(const char *name)
 {
-	return git_attr_internal(name, strlen(name));
+	return git_attr_counted(name, strlen(name));
 }
 
 /* What does a matched pattern decide? */
@@ -199,7 +199,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		else {
 			e->setto = xmemdupz(equals + 1, ep - equals - 1);
 		}
-		e->attr = git_attr_internal(cp, len);
+		e->attr = git_attr_counted(cp, len);
 	}
 	return ep + strspn(ep, blank);
 }
@@ -254,7 +254,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		      sizeof(struct attr_state) * num_attr +
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro) {
-		res->u.attr = git_attr_internal(name, namelen);
+		res->u.attr = git_attr_counted(name, namelen);
 		res->u.attr->maybe_macro = 1;
 	} else {
 		char *p = (char *)&(res->state[num_attr]);
diff --git a/attr.h b/attr.h
index 4a4ac76..78d6d5a 100644
--- a/attr.h
+++ b/attr.h
@@ -8,7 +8,10 @@ struct git_attr;
  * Given a string, return the gitattribute object that
  * corresponds to it.
  */
-struct git_attr *git_attr(const char *);
+extern struct git_attr *git_attr(const char *);
+
+/* The same, but with counted string */
+extern struct git_attr *git_attr_counted(const char *, size_t);
 
 /* Internal use */
 extern const char git_attr__true[];
-- 
2.8.2-759-geb611ab
