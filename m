From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 08 Feb 2013 16:29:11 -0800
Message-ID: <7vk3qixrc8.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Haller <thom311@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yKC-0000X7-12
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947421Ab3BIA3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:29:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947410Ab3BIA3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:29:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AFC2C933;
	Fri,  8 Feb 2013 19:29:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=18AiBpgvtd9i67NL0qyVJGQgihw=; b=vEzRqR
	7QY5PuRx7QLkQ+ltg1hj5DITHPqc/7gjcuLF9E6OxVTIa30yy0b+SKlCaJwb7RWa
	tIE3ycnrThbfVB6JmqINet81EDTyZbgJ7wUuPocG7WmEZir9GxsPE+T4X/8v/tiG
	GJgh/Vhx3dQeA05zeqHnQIzi9BN3AY6pOV1mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wXlQePM5BJVtiRv6xGlzTdXBUgJ7poLx
	daP+SVxEWu0HONrV+Q+yaRXO02UzFmP6qDjTSN2XpDnJmD+prB/Oir/gaurau1mJ
	CZByWRpLuZIoNral7SvuL5pqN7YXm/XoM7zM++B2F9WYuDfLmlqu1zTx26pAKbHJ
	PaaFDbgWqN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FD8FC932;
	Fri,  8 Feb 2013 19:29:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57D2CC92F; Fri,  8 Feb 2013
 19:29:13 -0500 (EST)
In-Reply-To: <7vobfuxrns.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Feb 2013 16:22:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAA1996E-724F-11E2-9BB7-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215832>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Haller <thom311@gmail.com> writes:
>>
>>> it happens in file revision.c:2306 because "commit->buffer" is zero:
>>>
>>>                 retval = grep_buffer(&opt->grep_filter,
>>>                                      commit->buffer, strlen(commit->buffer));
>>
>> I think this has been fixed at be5c9fb9049e (logmsg_reencode: lazily
>> load missing commit buffers, 2013-01-26); I haven't merged it to any
>> of the maintenance releases, but the tip of 'master' should have it
>> already.
>
> Ah, no, this shares the same roots as the breakage the said commit
> fixed, and the solution should use the same idea, but not fixed.

Perhaps something along this line...

-- >8 --
Subject: "log --grep": commit's buffer may already have been discarded

Following up on be5c9fb9049e (logmsg_reencode: lazily load missing
commit buffers, 2013-01-26), extract the part that reads the commit
buffer data into a separate helper function, and use it when we
apply the grep filter on the commit during the log walk.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 The reproduction recipe in original bug report looked like this:

  git commit -m 'text1' --allow-empty
  git commit -m 'text2' --allow-empty
  git log --graph --no-walk --grep 'text2'

 which does not make any sense to me.  We should simply forbid
 combination of --graph (which inherently wants a connected history)
 and --no-walk (which is a way to tell "This is not about history,
 this is about a single point").

 But that is a separate issue.

 commit.c   | 19 +++++++++++++++++++
 commit.h   |  1 +
 pretty.c   | 14 ++------------
 revision.c | 14 +++++++++++---
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index e8eb0ae..c0acf0f 100644
--- a/commit.c
+++ b/commit.c
@@ -335,6 +335,25 @@ int parse_commit(struct commit *item)
 	return ret;
 }
 
+char *read_commit_object_data(const struct commit *commit, unsigned long *sizep)
+{
+	char *msg;
+	enum object_type type;
+	unsigned long size;
+
+	if (!sizep)
+		sizep = &size;
+
+	msg = read_sha1_file(commit->object.sha1, &type, sizep);
+	if (!msg)
+		die("Cannot read commit object %s",
+		    sha1_to_hex(commit->object.sha1));
+	if (type != OBJ_COMMIT)
+		die("Expected commit for '%s', got %s",
+		    sha1_to_hex(commit->object.sha1), typename(type));
+	return msg;
+}
+
 int find_commit_subject(const char *commit_buffer, const char **subject)
 {
 	const char *eol;
diff --git a/commit.h b/commit.h
index 4138bb4..e314149 100644
--- a/commit.h
+++ b/commit.h
@@ -102,6 +102,7 @@ struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *logmsg_reencode(const struct commit *commit,
 			     const char *output_encoding);
 extern void logmsg_free(char *msg, const struct commit *commit);
+extern char *read_commit_object_data(const struct commit *commit, unsigned long *size);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
diff --git a/pretty.c b/pretty.c
index eae57ad..004d16d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -592,18 +592,8 @@ char *logmsg_reencode(const struct commit *commit,
 	char *msg = commit->buffer;
 	char *out;
 
-	if (!msg) {
-		enum object_type type;
-		unsigned long size;
-
-		msg = read_sha1_file(commit->object.sha1, &type, &size);
-		if (!msg)
-			die("Cannot read commit object %s",
-			    sha1_to_hex(commit->object.sha1));
-		if (type != OBJ_COMMIT)
-			die("Expected commit for '%s', got %s",
-			    sha1_to_hex(commit->object.sha1), typename(type));
-	}
+	if (!msg)
+		msg = read_commit_object_data(commit, NULL);
 
 	if (!output_encoding || !*output_encoding)
 		return msg;
diff --git a/revision.c b/revision.c
index d7562ee..caf8ef3 100644
--- a/revision.c
+++ b/revision.c
@@ -2279,9 +2279,16 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		strbuf_addch(&buf, '\n');
 	}
 
-	/* Copy the commit to temporary if we are using "fake" headers */
-	if (buf.len)
+	if (!commit->buffer) {
+		/* we may not have commit->buffer */
+		unsigned long size;
+		char *msg = read_commit_object_data(commit, &size);
+		strbuf_add(&buf, msg, size);
+		free(msg);
+	} else if (buf.len) {
+		/* Copy the commit to temporary if we are using "fake" headers */
 		strbuf_addstr(&buf, commit->buffer);
+	}
 
 	if (opt->grep_filter.header_list && opt->mailmap) {
 		if (!buf.len)
@@ -2302,9 +2309,10 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	/* Find either in the commit object, or in the temporary */
 	if (buf.len)
 		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
-	else
+	else {
 		retval = grep_buffer(&opt->grep_filter,
 				     commit->buffer, strlen(commit->buffer));
+	}
 	strbuf_release(&buf);
 	return retval;
 }
