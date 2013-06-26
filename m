From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 03/16] quote.c: substitute path_relative with relative_path
Date: Wed, 26 Jun 2013 10:44:03 -0700
Message-ID: <7vli5wwyvw.fsf@alter.siamese.dyndns.org>
References: <cover.1372175282.git.worldhello.net@gmail.com>
	<cover.1372175282.git.worldhello.net@gmail.com>
	<e1aa7e7d2e9ec1cd021ceffa7fd5cc4e858dd30b.1372175282.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 19:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrtlR-0006he-VO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 19:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab3FZRoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 13:44:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab3FZRoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 13:44:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EC3A2BF6F;
	Wed, 26 Jun 2013 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWBkwMtj62Z4+89t2B3X20yT7q8=; b=H+ylRV
	T0DphXIkHgyv9mqG+5Q9edVYxBNh0c+IqNjdWgAGMSiz7pTRjteU0rUSZU4Nzldw
	o+CzPdabbxcagF+eGwUAYxvVg6wZMxZ6C5x6uP0HEZuWxYfA7mwBtlSRhMtIOsLu
	+xeNH/ewcTLeNp/zd+5p3UFJWhrUusrIxXmDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gzIJ38qfHqPhY64kBRhzcK73OrdGhdSz
	NiNvWii2Z82XjL5ECejdJ+b/3fBeNUb6I3+NnlR+7afhZhcGDDv+90ptZ3rgm2ty
	VdY1nNyHG19IkGFQUXzNREWJ60eQfYBgQgnJjPcXrv7mhqlMLmYCzD8UhTfE5ImC
	SJ9uYEp3Asg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 436032BF6E;
	Wed, 26 Jun 2013 17:44:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A4982BF6C;
	Wed, 26 Jun 2013 17:44:04 +0000 (UTC)
In-Reply-To: <e1aa7e7d2e9ec1cd021ceffa7fd5cc4e858dd30b.1372175282.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Tue, 25 Jun 2013 23:53:44 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE6E12C2-DE87-11E2-9A12-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229047>

Jiang Xin <worldhello.net@gmail.com> writes:

> Substitute the function path_relative in quote.c with the function
> relative_path. Function relative_path can be treated as an enhanced
> and robust version of path_relative.
> ...
> And if prefix has no trailing slash, path_relative can not work properly
> either. But since prefix always has a trailing slash, so it's not a
> problem.

Nicely explained.

>  static void write_name(const char* name, size_t len)
>  {
> -	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
> -			line_terminator);
> +	/* Since prefix_len is ignored in write_name_quoted_relative, we
> +	 * should turn off prefix here in case of running "git ls-files"
> +	 * with "--full-name" option */
> +	write_name_quoted_relative(name, len, prefix_len ? prefix : NULL,
> +			prefix_len, stdout, line_terminator);
>  }

I'd tweak this function and write_naem_quoted_relative(), and
explain the reason for doing so in the log message.  Please check
what I'll push out on 'pu' later today.

-- >8 --
Subject: [PATCH] fix write_name() and write_name_quoted_relative() signature

The write_name_quoted_relative() function used to accept its two
parameters as counted strings.  Since it now uses relative_path(),
which requires both input strings to be NUL-terminated, the API of
this function need to be audited carefully.

Luckily, the only one caller is write_name() in builtin/ls-files.c,
and it in turn has only three callers.  They pass the string to be
made relative at this function and all of these strings happen to be
NUL terminated.  We can safely lose "len" parameter of write_name(),
and write_name_quoted_relative() can safely lose the length of its
name parameter as well.

The "prefix_len" parameter of write_name_quoted_relative() is either
0 (when "ls-files --full-name" is used), or the length of the prefix
string (i.e. the path to the current subdirectory).  By checking the
"--full-name" case in the caller, i.e. write_name(), we can make
write_name_quoted_relative() not to require the prefix as a counted
string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 17 ++++++++---------
 quote.c            |  3 +--
 quote.h            |  5 ++---
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 247a8a4..d87e136 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,13 +46,12 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_name(const char* name, size_t len)
+static void write_name(const char *name)
 {
-	/* Since prefix_len is ignored in write_name_quoted_relative, we
-	 * should turn off prefix here in case of running "git ls-files"
-	 * with "--full-name" option */
-	write_name_quoted_relative(name, len, prefix_len ? prefix : NULL,
-			prefix_len, stdout, line_terminator);
+	/* (prefix_len == 0) is for "--full-name" output */
+	write_name_quoted_relative(name,
+				   prefix_len ? prefix : NULL,
+				   stdout, line_terminator);
 }
 
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
@@ -66,7 +65,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_name(ent->name, ent->len);
+	write_name(ent->name);
 }
 
 static void show_other_files(struct dir_struct *dir)
@@ -166,7 +165,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name, ce_namelen(ce));
+	write_name(ce->name);
 	if (debug_mode) {
 		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
 		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
@@ -199,7 +198,7 @@ static void show_ru_info(void)
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 			       find_unique_abbrev(ui->sha1[i], abbrev),
 			       i + 1);
-			write_name(path, len);
+			write_name(path);
 		}
 	}
 }
diff --git a/quote.c b/quote.c
index 64ff344..6af3c83 100644
--- a/quote.c
+++ b/quote.c
@@ -312,8 +312,7 @@ void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
-void write_name_quoted_relative(const char *name, size_t len,
-				const char *prefix, size_t prefix_len,
+void write_name_quoted_relative(const char *name, const char *prefix,
 				FILE *fp, int terminator)
 {
 	struct strbuf sb = STRBUF_INIT;
diff --git a/quote.h b/quote.h
index 133155a..8586bcd 100644
--- a/quote.h
+++ b/quote.h
@@ -60,9 +60,8 @@ extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 extern void write_name_quoted(const char *name, FILE *, int terminator);
 extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
                                  const char *name, FILE *, int terminator);
-extern void write_name_quoted_relative(const char *name, size_t len,
-		const char *prefix, size_t prefix_len,
-		FILE *fp, int terminator);
+extern void write_name_quoted_relative(const char *name, const char *prefix,
+				       FILE *fp, int terminator);
 
 /* quote path as relative to the given prefix */
 extern char *quote_path_relative(const char *in, int len,
-- 
1.8.3.1-773-g7e1bb7d
