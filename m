From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git am and the wrong chunk of ---
Date: Fri, 10 Aug 2012 09:15:04 -0700
Message-ID: <7v628qlo53.fsf@alter.siamese.dyndns.org>
References: <5024523F.3050208@zytor.com>
 <20120810103612.GA21562@sigill.intra.peff.net>
 <7vsjbuls9h.fsf@alter.siamese.dyndns.org>
 <b661ef79-510e-4be6-bed2-451e9967db6f@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:15:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szrro-0006Xm-BT
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 18:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab2HJQPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 12:15:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab2HJQPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 12:15:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B7F9262;
	Fri, 10 Aug 2012 12:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6DaNXoEB+4DLerIH0kbDQbQEfww=; b=vEjA+0
	yYo4XtGGlq2hSvQJKequKG7KrthVn+uC9r62OqtFuFY8oPH53BZk7Q2KF5qT40H8
	lgfxcMbCpJwM2EpjTOsnrspzGHIasVScmOShF7JwYTYFFzrRysSP5tpXXYErOvO7
	vsxeV00m4h6LQYFuxf47r5iCBgIo8qFKC9LR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d50jTnBSWqt1VomVWwd8jtJnYIXKi/yq
	x88EYTp3Il0UZcJA/hrQihzRgKJ3Hp4rojlq0iWqHRObTDXiXD6QNz7HBQfZeV5F
	kEtBZ5pf6DqhO3Xxi7giLWQfF/gku3MrIXicQewz2OQZUdyRk9VbR9D6Md/TWVR5
	cDsRfrXJmuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1109C9261;
	Fri, 10 Aug 2012 12:15:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59672925E; Fri, 10 Aug 2012
 12:15:06 -0400 (EDT)
In-Reply-To: <b661ef79-510e-4be6-bed2-451e9967db6f@email.android.com> (H.
 Peter Anvin's message of "Fri, 10 Aug 2012 07:48:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C76FA44-E306-11E1-B8B8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203229>

"H. Peter Anvin" <hpa@zytor.com> writes:

> The users I am referring to generally have a --- line, rather than
> a scissor, between the cover text and commit.  Also, there is
> (almost) always a From: line and subject at the top of the patch
> proper.

Oh, so it is more like this?

    From: author name <author@address.xz>
    Date: author date
    Subject: patch title

    Heya,

    I was walking my dog when I found a solution to this
    problem the other day.  Here it is.

    ---
    >From 755e8b3f35e3991a735a6be740eda4567d45a741 Mon Sep 17 00:00:00 2001
    From: author name <author@address.xz>
    Date: random date we do not care
    Subject: patch title

    commit message body

    ---

We could teach "am -c" to recognize the format-patch file magic

    "^[>]From [0-9a-f]{40} Mon Sep 17 00:00:00 2001"

as another form of accepted scissors, I guess.

Something like the attached (untested) patch, perhaps.

But I am fairly negative on it.

Where would it end?  After all, the top "---" is not something our
tools are generating, but is manually typed by the users.

I do not think it is unreasonable to expect that they are capable
and intelligent enough to guess that "---" is _not_ the way to say
"cut here and what follows are the log message", when "---" is
already the way to say "cut here, and what we saw up to this point
is the log message".

 builtin/mailinfo.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index eaf9e15..62ea09d 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -730,6 +730,22 @@ static inline int patchbreak(const struct strbuf *line)
 	return 0;
 }
 
+static int is_format_patch_magic(const struct strbuf *line)
+{
+	const char *buf = line->buf;
+	size_t len = line->len;
+
+	if (len && *buf == '>') {
+		buf++;
+		len--;
+	}
+	if (len < 70)
+		return 0;
+	return (!memcmp(buf, "From ", 5) &&
+		strspn(buf + 5, "0123456789abcdef") == 40 &&
+		!memcmp(buf + 46, "Mon Sep 17 00:00:00 2001", 24));
+}
+
 static int is_scissors_line(const struct strbuf *line)
 {
 	size_t i, len = line->len;
@@ -807,7 +823,7 @@ static int handle_commit_msg(struct strbuf *line)
 	if (metainfo_charset)
 		convert_to_utf8(line, charset.buf);
 
-	if (use_scissors && is_scissors_line(line)) {
+	if (use_scissors && (is_scissors_line(line) || is_format_patch_magic(line))) {
 		int i;
 		if (fseek(cmitmsg, 0L, SEEK_SET))
 			die_errno("Could not rewind output message file");
