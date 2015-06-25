From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 15:29:45 -0700
Message-ID: <xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
	<xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
	<2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
	<xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Feb-0001tf-Te
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 00:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbFYW3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 18:29:50 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33877 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbFYW3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 18:29:48 -0400
Received: by igcsj18 with SMTP id sj18so19529055igc.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hLPdPsXLmfnzqwQZzZXAw2WNU61qCM6QVZTL5ylSPBw=;
        b=NPThf1cqyMQPvk/laBBSzCNhrwLUJ8zK0AJBEGSrqj2aq9iv0bbNYhbD4sUnE/zTuB
         pHuHT/BziJNHR4V8Kh8QJf51beT0/5IKtteFu+HGx+mlzr1uugHnVMa7FDuMSUxiAolq
         ijSdnCy3Bh390GdX4bKcoiNBXpkeFAYd7nA6cjMEUrP+IIrPuzcUZ9yUannrc4lhtpm8
         TX/xCRef+xQQwPNZfVjVRuonySaAuBsSHcXqiG3wXvKBX3TB/lDWnG7WMPuLj2kaJ9lX
         ZoW4a4AKHb1YoXfNFytuN2y+FS5KxCWu9mJdr93kuPsl4iH+BfEWlWqiOmzRup6UdAk3
         bzuA==
X-Received: by 10.43.0.67 with SMTP id nl3mr45286407icb.59.1435271387934;
        Thu, 25 Jun 2015 15:29:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id u35sm20470655iou.7.2015.06.25.15.29.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 15:29:47 -0700 (PDT)
In-Reply-To: <xmqqoak3wkkq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Jun 2015 14:21:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272743>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> ...
>> If the buffer does *not* contain an empty line, the fsck code runs the
>> danger of looking beyond the allocated memory because it uses
>> functions that assume NUL-terminated strings, while the buffer passed
>> to the fsck code is a counted string.
>> that already, but not all of them.
> ...
> I do not think you necessarily need a NUL.  As you said, your input
> is a counted string, so you know the length of the buffer.  And you
> are verifying line by line.  As long as you make sure the buffer
> ends with "\n" (instead of saying "it has "\n\n" somewhere),
> updating the existing code that does ...
> to do this instead: ...
> shouldn't be rocket science, no?

Here is to illustrate what I meant by the above.

I did only the "tag" side (this is on 'maint'), because I did not
want to conflict with a larger change to fsck you have on 'pu'.

I made it use an updated version of require_end_of_header(), which I
named prescan_headers(), as the new sanity check does not require
\n\n as the only end of header, and also the sanity check (both old
and new) also checks for NUL.

I didn't assess how much more involved to make fsck-commit-buffer to
use prescan-headers (and retire require-end-of-header), though.

 fsck.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index 10bcb65..7d2d07d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -261,6 +261,29 @@ static int require_end_of_header(const void *data, unsigned long size,
 	return error_func(obj, FSCK_ERROR, "unterminated header");
 }
 
+static int prescan_headers(const void *data, unsigned long size,
+			   struct object *obj, fsck_error error_func)
+{
+	const char *buffer = (const char *)data;
+	unsigned long i;
+
+	for (i = 0; i < size; i++) {
+		switch (buffer[i]) {
+		case '\0':
+			return error_func(obj, FSCK_ERROR,
+					  "unterminated header: NUL at offset %d", i);
+		case '\n':
+			if (i + 1 < size && buffer[i + 1] == '\n')
+				return 0; /* end of header */
+		}
+	}
+
+	/* no blank (i.e. headers and nothing else */
+	if (size && buffer[size - 1] == '\n')
+		return 0;
+	return error_func(obj, FSCK_ERROR, "unterminated header");
+}
+
 static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
 {
 	char *end;
@@ -365,6 +388,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 	unsigned char sha1[20];
 	int ret = 0;
 	const char *buffer;
+	const char *end_buffer;
 	char *to_free = NULL, *eol;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -387,10 +411,12 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		}
 	}
 
-	if (require_end_of_header(buffer, size, &tag->object, error_func))
+	end_buffer = buffer + size;
+	if (prescan_headers(buffer, size, &tag->object, error_func))
 		goto done;
 
-	if (!skip_prefix(buffer, "object ", &buffer)) {
+	if (end_buffer <= buffer ||
+	    !skip_prefix(buffer, "object ", &buffer)) {
 		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
 		goto done;
 	}
@@ -400,7 +426,8 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 	}
 	buffer += 41;
 
-	if (!skip_prefix(buffer, "type ", &buffer)) {
+	if (end_buffer <= buffer ||
+	    !skip_prefix(buffer, "type ", &buffer)) {
 		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'type' line");
 		goto done;
 	}
@@ -415,7 +442,8 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		goto done;
 	buffer = eol + 1;
 
-	if (!skip_prefix(buffer, "tag ", &buffer)) {
+	if (end_buffer <= buffer ||
+	    !skip_prefix(buffer, "tag ", &buffer)) {
 		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
 		goto done;
 	}
@@ -430,7 +458,8 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 			   (int)(eol - buffer), buffer);
 	buffer = eol + 1;
 
-	if (!skip_prefix(buffer, "tagger ", &buffer))
+	if (end_buffer <= buffer ||
+	    !skip_prefix(buffer, "tagger ", &buffer))
 		/* early tags do not contain 'tagger' lines; warn only */
 		error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
 	else
