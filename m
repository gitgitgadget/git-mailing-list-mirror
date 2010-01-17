From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in
 summary
Date: Sun, 17 Jan 2010 00:59:53 -0800
Message-ID: <7vhbql85ti.fsf@alter.siamese.dyndns.org>
References: <20100113173408.GA16652@coredump.intra.peff.net>
 <20100113173951.GC16786@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 10:01:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWR0G-0003Fk-Ao
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0AQJAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311Ab0AQJAJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:00:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0AQJAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:00:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 708619115E;
	Sun, 17 Jan 2010 04:00:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ecIZefh7ehY5ikyo8TSLgZT4IYs=; b=RkgLCh
	PQT/rfFqSgcprfLkhRVpeRVKJsGqHHtjCi4YjuyqtY0A7LW1eE4oP2Fk9T7uIaex
	2Sz6w1wAhG6wY9HVldiqOw4Jwi5KOXzQSGmCtINia+swU9rSzus361Qp4Foed2/Z
	e2loke85jDo6ZQ2qzVXgPASNuTk6dlRvyANcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOV61y7xW1MOvmQLex8c6S/mCOqEdDKg
	jZHMVyo15IqpjI6ipXNwalUT18DxqHDfYshf7qZBiI52KotQ3Z0rPdKkmBrzA78W
	AuMHGKSt5Yy2xwOnqiqDjygSLl/r2CMlBhwn53Xgs3CIi0gtOjo3eaaAIE4tZ8fy
	4Os3v88knK0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31B4C91156;
	Sun, 17 Jan 2010 04:00:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B112691155; Sun, 17 Jan
 2010 03:59:54 -0500 (EST)
In-Reply-To: <20100113173951.GC16786@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 13 Jan 2010 12\:39\:51 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B14E88D4-0346-11DF-AB56-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137280>

Jeff King <peff@peff.net> writes:

> @@ -1046,9 +1058,12 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
>  {
>  	struct rev_info rev;
>  	struct commit *commit;
> -	static const char *format = "format:%h] %s";
> +	struct strbuf format = STRBUF_INIT;
>  	unsigned char junk_sha1[20];
>  	const char *head = resolve_ref("HEAD", junk_sha1, 0, NULL);
> +	struct pretty_print_context pctx = {0};
> +	struct strbuf author_ident = STRBUF_INIT;
> +	struct strbuf committer_ident = STRBUF_INIT;
>  
>  	commit = lookup_commit(sha1);
>  	if (!commit)
> @@ -1056,6 +1071,23 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
>  	if (!commit || parse_commit(commit))
>  		die("could not parse newly created commit");
>  
> +	strbuf_addstr(&format, "format:%h] %s");
> + ...
> +	if (strbuf_cmp(&author_ident, &committer_ident)) {
> +		strbuf_addstr(&format, "\n Author: ");
> +		strbuf_addbuf_percentquote(&format, &author_ident);
> +	}
> +	if (!user_ident_explicitly_given) {
> +		strbuf_addstr(&format, "\n Committer: ");
> +		strbuf_addbuf_percentquote(&format, &committer_ident);
> +		strbuf_addch(&format, '\n');
> +		strbuf_addstr(&format, implicit_ident_advice);
> +	}
> + ...
> -	get_commit_format(format, &rev);
> +	get_commit_format(format.buf, &rev);
> +	strbuf_release(&format);
>  	rev.always_show_header = 0;
>  	rev.diffopt.detect_rename = 1;
>  	rev.diffopt.rename_limit = 100;

This prepares the user format for log_tree_commit(); get_commit_format()
copies it away in its userformat, so it appears we are done with format
strbuf we built, and we release...

> @@ -1085,7 +1118,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
>  		struct pretty_print_context ctx = {0};
>  		struct strbuf buf = STRBUF_INIT;
>  		ctx.date_mode = DATE_NORMAL;
> -		format_commit_message(commit, format + 7, &buf, &ctx);
> +		format_commit_message(commit, format.buf + 7, &buf, &ctx);
>  		printf("%s\n", buf.buf);

But sometimes log_tree_commit() doesn't show the header.  Most notably for
merges.  What string are we using for format_commit_message()?  Oops.

diff --git a/builtin-commit.c b/builtin-commit.c
index a73a532..7f61e87 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1013,7 +1013,6 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
 	get_commit_format(format.buf, &rev);
-	strbuf_release(&format);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
@@ -1036,6 +1035,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}
+	strbuf_release(&format);
 }
 
 static int git_commit_config(const char *k, const char *v, void *cb)
