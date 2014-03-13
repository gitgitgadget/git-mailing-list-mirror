From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] fsck.c: Rewrite fsck_commit() to use skip_prefix()
Date: Thu, 13 Mar 2014 12:42:36 -0700
Message-ID: <xmqq38ilj36b.fsf@gitster.dls.corp.google.com>
References: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
	<1394685951-9726-3-git-send-email-yshuiv7@gmail.com>
	<xmqq7g7xj4hz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 20:42:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOBWo-00031r-QK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 20:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbaCMTmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 15:42:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169AbaCMTmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 15:42:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFFCD73FC5;
	Thu, 13 Mar 2014 15:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KUZKF6a0gH35glLuB1d4+G9MA6M=; b=W3W8ea
	SpPYPtWbUxl6ViteDbUvcs5kNtNf4tvZq5f6OUKAEx+UKk0I+3XnV+cnrfj0Li/e
	SRI6N7GLTbLfkSYHLyBSlOqd6iFaH64cn9B0SC9hq3S1YWuH6H5tSURLoWwggPHf
	Z6PIjWCpfHXyyjpFm0ZenrALnwLuAiNaSP+U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wlWiONYITi+TbkCYacTi2Wc+9vAcDv1Y
	fR+0XPmpTocmeLtRdgSh6ko5H/PuISDFbqSVd90Yaa8PWFWY89sjHmpYINdtqPpy
	25AHSSB2JZFYSy1tLMZaf0oXWVRkA/KhonIn7CPjPOIU1i3IhMWXiHPa1PsoBLqR
	IKzXCVTBvHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C963173FC1;
	Thu, 13 Mar 2014 15:42:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2293673FB7;
	Thu, 13 Mar 2014 15:42:39 -0400 (EDT)
In-Reply-To: <xmqq7g7xj4hz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Mar 2014 12:14:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A27CC1FC-AAE7-11E3-8B6B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244048>

Junio C Hamano <gitster@pobox.com> writes:

>> -	if (memcmp(buffer, "tree ", 5))
>> +	buffer = skip_prefix(buffer, "tree ");
>> +	if (buffer == NULL)
>
> We encourage people to write this as:
>
> 	if (!buffer)
>
> The same comment applies to other new lines in this patch.

I also see a lot of repetitions in the code, before or after the
patch.  I wonder if a further refactoring along this line on top of
these two patches might be worth considering.

No, I am not proud of sneaking tree_sha1[] array pointers as a
seemingly boolean-looking must-match-header parameter into the
helper, but this is merely a "how about going in this direction"
weather-balloon patch, so....

 fsck.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6aab23b..a3eea7f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -279,10 +279,55 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 	return 0;
 }
 
+static int fsck_object_line(struct commit *commit, fsck_error error_func,
+			    const char **buffer, const char *header,
+			    unsigned char must_match_header[])
+{
+	unsigned char sha1_buf[20];
+	unsigned char *sha1 = must_match_header ? must_match_header : sha1_buf;
+	const char *buf;
+
+	buf = skip_prefix(*buffer, header);
+	if (!buf) {
+		if (must_match_header)
+			return error_func(&commit->object, FSCK_ERROR,
+					  "invalid format - expected '%.*s' line",
+					  (int) strlen(header) - 1,
+					  header);
+		return 1;
+	}
+	if (get_sha1_hex(buf, sha1) || buf[40] != '\n')
+		return error_func(&commit->object, FSCK_ERROR,
+				  "invalid '%.*s' line format - bad sha1",
+				  (int) strlen(header) - 1,
+				  header);
+	*buffer = buf + 41;
+	return 0;
+}
+
+static int fsck_ident_line(struct commit *commit, fsck_error error_func,
+			   const char **buffer, const char *header)
+{
+	const char *buf;
+	int err;
+
+	buf = skip_prefix(*buffer, header);
+	if (!buf)
+		return error_func(&commit->object, FSCK_ERROR,
+				  "invalid format - expected '%.*s' line",
+				  (int) strlen(header) - 1,
+				  header);
+	err = fsck_ident(&buf, &commit->object, error_func);
+	if (err)
+		return err;
+	*buffer = buf;
+	return 0;
+}
+
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	const char *buffer = commit->buffer, *tmp;
-	unsigned char tree_sha1[20], sha1[20];
+	const char *buffer = commit->buffer;
+	unsigned char tree_sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
 	int err;
@@ -290,18 +335,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	if (commit->date == ULONG_MAX)
 		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
 
-	buffer = skip_prefix(buffer, "tree ");
-	if (!buffer)
-		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
-		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
-	buffer += 41;
-	while ((tmp = skip_prefix(buffer, "parent "))) {
-		buffer = tmp;
-		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
-			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
-		buffer += 41;
-		parents++;
+	err = fsck_object_line(commit, error_func, &buffer, "tree ", tree_sha1);
+	if (err)
+		return err;
+	while (1) {
+		err = fsck_object_line(commit, error_func, &buffer, "parent ", NULL);
+		if (err < 0)
+			return err;
+		else if (!err)
+			parents++;
+		else
+			break;
 	}
 	graft = lookup_commit_graft(commit->object.sha1);
 	if (graft) {
@@ -324,16 +368,11 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	buffer = skip_prefix(buffer, "author ");
-	if (!buffer)
-		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
-	err = fsck_ident(&buffer, &commit->object, error_func);
+
+	err = fsck_ident_line(commit, error_func, &buffer, "author ");
 	if (err)
 		return err;
-	buffer = skip_prefix(buffer, "committer ");
-	if (!buffer)
-		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, &commit->object, error_func);
+	err = fsck_ident_line(commit, error_func, &buffer, "committer ");
 	if (err)
 		return err;
 	if (!commit->tree)
