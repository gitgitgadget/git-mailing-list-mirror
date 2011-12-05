From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, v4] git-tag: introduce --cleanup option
Date: Mon, 05 Dec 2011 14:41:26 -0800
Message-ID: <7vvcpuk5ex.fsf@alter.siamese.dyndns.org>
References: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
 <20111205215148.GA22663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 23:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXhE6-0005Kz-Fd
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 23:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab1LEWla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 17:41:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab1LEWl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 17:41:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D25186D99;
	Mon,  5 Dec 2011 17:41:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vHEroC61NX9zYxAAppxT6d8NNM0=; b=pUL7nR
	QBeNPksdKmV6RmKDEbSvy5qcBXJF/DzXLaDzmcnhqQYJo5ky/bgT79IktGEtBRVV
	BuDQxp2FJN16AUgGpOusiszRPQyk+uguNtB1uIaMgDY4fR4OAH+CttMeTwAUG3Qk
	v9J2ZdummSmW5v3+Y6g/8fiToQ78D3kGZsJwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KHJD9nncKCYHemH58mq4fHA++IDbZkNc
	MyoYKGAaNqe6WGP0JBWwMW7BETNkZl4NGSQ6hBfTElKt9ZeREeA2KujfXB79UMnK
	976/vU73645C9qSKE29tVU2EZf0JyVBHDqWlNXAXm7wKU3TKAMotcb7O8kgBz4lp
	wv4dpQLsGVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C94816D98;
	Mon,  5 Dec 2011 17:41:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45A4D6D97; Mon,  5 Dec 2011
 17:41:28 -0500 (EST)
In-Reply-To: <20111205215148.GA22663@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 5 Dec 2011 16:51:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 451BD47C-1F92-11E1-829E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186297>

Jeff King <peff@peff.net> writes:

> More importantly, though, this seems to break t6300 badly. I haven't
> looked into why yet, though.

Probably two issues.

 - opt.message (and the original 'message') was misnamed and confused the
   patch author what "if (!message && !buf->len)" meant.

 - "opt" is a structure meant to be extensible, but is not initialized as
   a whole, inviting future errors.

It still seems to be broken with respect to the primary thing the patch
wanted to do (t7400 "git tag -F commentsfile comments-annotated-tag" does
not seem to produce an expected result), so I'll kick it back to the
Kirill to look at.

Thanks.

 builtin/tag.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 27a66a3..7883720 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -329,7 +329,7 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 }
 
 struct create_tag_options {
-	unsigned int message;
+	unsigned int message_given:1;
 	unsigned int sign;
 	enum {
 		CLEANUP_NONE,
@@ -364,7 +364,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (header_len > sizeof(header_buf) - 1)
 		die(_("tag header too big."));
 
-	if (!opt->message) {
+	if (!opt->message_given) {
 		int fd;
 
 		/* write the template message before editing: */
@@ -393,7 +393,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (opt->cleanup_mode != CLEANUP_NONE)
 		stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
 
-	if (opt->message && !buf->len)
+	if (!opt->message_given && !buf->len)
 		die(_("no tag message?"));
 
 	strbuf_insert(buf, 0, header_buf, header_len);
@@ -486,7 +486,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_tag_config, NULL);
 
-	opt.sign = 0;
+	memset(&opt, 0, sizeof(opt));
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
@@ -552,10 +552,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
-	opt.message = msg.given || msgfile;
+	opt.message_given = msg.given || msgfile;
 
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		opt.cleanup_mode = !opt.message ? CLEANUP_ALL : CLEANUP_SPACE;
+		opt.cleanup_mode = !opt.message_given ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
 		opt.cleanup_mode = CLEANUP_NONE;
 	else if (!strcmp(cleanup_arg, "whitespace"))
