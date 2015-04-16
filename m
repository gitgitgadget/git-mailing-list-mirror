From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log -L: improve error message on malformed argument
Date: Thu, 16 Apr 2015 13:59:06 -0700
Message-ID: <xmqqzj67hjs5.fsf@gitster.dls.corp.google.com>
References: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Apr 16 22:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiqsU-0004Ev-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 22:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbbDPU7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 16:59:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752686AbbDPU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 16:59:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1E804B782;
	Thu, 16 Apr 2015 16:59:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y/hFXTIEOwDo0NOmCNJeVHKdqq8=; b=yVrwMU
	bV4jKARh/pb54RMCVDcSWd1LInLnaoebyFR+m85K1my0DSNQvvoz3GdQ+lQgtq5M
	ZuplPj4T6mJdznOTm4VFPvG1YRwHXc5L7FxGm+q2Yy557+erTDEJjgt6TWzU81Aq
	7mBhd2ljD6FTS3AtpBF71faFLL13auckNhoQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tyowrgVj88m9YVNApMx1BDFzR4czIYb7
	D9xuu6DWoSKOOpiUY1EmURf7YuQRc49DAM4zYzDtla0E206dL/BDXU3nk+2I1W7S
	mdtFeXHHpR1G/bO8Bh3kekPphmoaDY7jejrUs1hnidj+Gwie+N1RswUpHWs5oV8j
	bhMvB0pu9gk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA8804B781;
	Thu, 16 Apr 2015 16:59:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D4914B780;
	Thu, 16 Apr 2015 16:59:07 -0400 (EDT)
In-Reply-To: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 16 Apr 2015 16:43:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C135BCA-E47B-11E4-97E7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267334>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The old message did not mention the :regex:file form.
>
> To avoid overly long lines, split the message into two lines (in case
> item->string is long, it will be the only part truncated in a narrow
> terminal).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  line-log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/line-log.c b/line-log.c
> index a490efe..e725248 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -575,7 +575,8 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
>  
>  		name_part = skip_range_arg(item->string);
>  		if (!name_part || *name_part != ':' || !name_part[1])
> -			die("-L argument '%s' not of the form start,end:file",
> +			die("invalid -L argument '%s'.\n"
> +			    "It should be of the form start,end:file or :regex:file.",
>  			    item->string);
>  		range_part = xstrndup(item->string, name_part - item->string);
>  		name_part++;

Hmm.

While I understand and even agree with the reasoning behind chomping
the line after a potentially long user-supplied argument, it
somewhat bothers me that the output of subsequent lines would begin
without the prefix.

Do we have any other multi-line die/error/warning message?

I am tempted to suggest doing something along the lines of the
attached, if we were to start using multi-line die/error/warning
like this one.  Obviously we would need something similar on the
vwritef() side as well.

 usage.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/usage.c b/usage.c
index ed14645..09710fa 100644
--- a/usage.c
+++ b/usage.c
@@ -8,9 +8,26 @@
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {
-	char msg[4096];
-	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	char msg[4096], *bol;
+	int len;
+
+	len = vsnprintf(msg, sizeof(msg), err, params);
+	if (sizeof(msg) < len)
+		len = sizeof(msg);
+	bol = msg;
+	while (1) {
+		int linelen;
+		char *eol = memchr(bol, '\n', len);
+		if (!eol)
+			linelen = len;
+		else
+			linelen = eol - bol;
+		fprintf(stderr, "%s%.*s\n", prefix, linelen, bol);
+		if (!eol)
+			break;
+		bol = eol + 1;
+		len -= linelen + 1;
+	}
 }
 
 void vwritef(int fd, const char *prefix, const char *err, va_list params)
