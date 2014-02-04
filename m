From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 13:00:50 -0800
Message-ID: <xmqq4n4e8uf1.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<87lhxqwse8.fsf@fencepost.gnu.org>
	<xmqq8utq8uxn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:01:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAn7G-0004bq-PC
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbaBDVBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:01:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932916AbaBDVA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:00:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5A0169915;
	Tue,  4 Feb 2014 16:00:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFHh4paQKveaM2njtafzCrBmlmc=; b=eM0ERy
	W7sTIMDNIJY0PyKDIUlS2uaHNo6mTjvnhhsFMFBg7BEG+UzGgvWVhIGEZb+DhWL4
	wddBkdkW69MlF2qNs/qmOE0x1Q+D1HjwwHhn1b5yKtfFROPqVx9GxPwUGVdQmPbH
	oSBQDbzD4u2rIF6UlD3v8KPMey8IQU11rSxTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1s2hn57L/eLl//pLS+TdQT2Dh5AdmBq
	xibQI4s7QNjW5B1DkLk56px0GdQdJeM0RghDh/pMLEydmdE7pV5tit9XHVtVbGFk
	nBVJCTfSyny5GbylSEtSCBNBIGe3KKd3iKglGh+bTmsocbu/AwZFfFOPpKJdrvH2
	njYGfKu5d9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91A7A69914;
	Tue,  4 Feb 2014 16:00:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 667CB69906;
	Tue,  4 Feb 2014 16:00:55 -0500 (EST)
In-Reply-To: <xmqq8utq8uxn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Feb 2014 12:49:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7071DEF6-8DDF-11E3-8DF4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241552>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Whitespace error in line 1778.  Should I be reposting?
>
> Heh, let me try to clean it up first and then repost for your
> review.
>
> Thanks.

-- >8 --
From: David Kastrup <dak@gnu.org>

Making a single preparation run for counting the lines will avoid memory
fragmentation.  Also, fix the allocated memory size which was wrong
when sizeof(int *) != sizeof(int), and would have been too small
for sizeof(int *) < sizeof(int), admittedly unlikely.

Signed-off-by: David Kastrup <dak@gnu.org>
---

 One logic difference from what was posted is that sb->lineno[num]
 is filled with the length of the entire buffer when the file ends
 with a complete line.  I do not remember if the rest of the logic
 actually depends on it (I think I use lineno[n+1] - lineno[n] to
 find the end of line, so this may matter for the last line),
 though.

 The original code dates back to 2006 when the author of the code
 was not paid for doing anything for Git but was doing it as a
 weekend and evening hobby, so it may not be so surprising to find
 this kind of "what was I thinking when I wrote it" inefficiency in
 such a code with $0 monetary value ;-)

 builtin/blame.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..2364661 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1772,25 +1772,30 @@ static int prepare_lines(struct scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
 	unsigned long len = sb->final_buf_size;
-	int num = 0, incomplete = 0, bol = 1;
+	const char *end = buf + len;
+	const char *p;
+	int *lineno;
+	int num = 0, incomplete = 0;
+
+	for (p = buf; p < end; p++) {
+		p = memchr(p, '\n', end - p);
+		if (!p)
+			break;
+		num++;
+	}
 
-	if (len && buf[len-1] != '\n')
+	if (len && end[-1] != '\n')
 		incomplete++; /* incomplete line at the end */
-	while (len--) {
-		if (bol) {
-			sb->lineno = xrealloc(sb->lineno,
-					      sizeof(int *) * (num + 1));
-			sb->lineno[num] = buf - sb->final_buf;
-			bol = 0;
-		}
-		if (*buf++ == '\n') {
-			num++;
-			bol = 1;
-		}
+
+	sb->lineno = lineno = xmalloc(sizeof(int) * (num + incomplete + 1));
+
+	for (p = buf; p < end; p++) {
+		*lineno++ = p - buf;
+		p = memchr(p, '\n', end - p);
+		if (!p)
+			break;
 	}
-	sb->lineno = xrealloc(sb->lineno,
-			      sizeof(int *) * (num + incomplete + 1));
-	sb->lineno[num + incomplete] = buf - sb->final_buf;
+	sb->lineno[num + incomplete] = len;
 	sb->num_lines = num + incomplete;
 	return sb->num_lines;
 }
