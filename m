From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Get correct column with for options in command usage
Date: Tue, 5 Feb 2013 19:15:52 +0700
Message-ID: <20130205121552.GA16601@lanh>
References: <0b035132df6de2cac56ac59d66b04f30e90ad760.1360049671.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 13:15:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2hR6-0008KK-7P
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 13:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab3BEMPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 07:15:17 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:37591 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab3BEMPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 07:15:16 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so31377dad.10
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 04:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=chGs/RsG3TEdzrQnWX3cJGNhAOTRwG1UaTFxziDEYwM=;
        b=nJLLNInn8X4K1JvIe0FHpEqsx/v+GJeYX9hSbdtmu3P1sklfcPMapQdPVAqM16NG0q
         uZ4csb8TbOSNxB7n1eeXKT7HNJHhL5pwc2guSiugYFx87c/2DTz3HxAd7ZXhB4oQ9Yuv
         sXMdtwTXlwi6LQ0DW1ViijVe0u632ucB0MFVdiEEOZrNcghr2vmdg5lQJYwhy1spC4gu
         VausIZ1rgnTGrxYP45OWVmv2A8CBrun7hGitgxfLxjyTnhujRwjv8nMrRdNWwpZvLhLR
         Bq3x1qI+4Udy5dyA7H+dRCCKfIizTOsDVLqfQAhyHrSbp57TG0i4Zho2j4nfGpcmpl8R
         bO+g==
X-Received: by 10.66.79.202 with SMTP id l10mr63417952pax.36.1360066513843;
        Tue, 05 Feb 2013 04:15:13 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id l5sm28994240pax.10.2013.02.05.04.15.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 05 Feb 2013 04:15:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 05 Feb 2013 19:15:52 +0700
Content-Disposition: inline
In-Reply-To: <0b035132df6de2cac56ac59d66b04f30e90ad760.1360049671.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215496>

On Tue, Feb 05, 2013 at 03:40:32PM +0800, Jiang Xin wrote:
> Command usage would not align well if command options are translated,
> especially to CJK. Call utf8_strwidth in function usage_argh, so that
> the caller will get correct column width.

Yeah, I just noticed a misalignment in Vietnamese translation (just
two spaces to the left, hard to notice unless paying attention).

>  static int usage_argh(const struct option *opts, FILE *outfile)
>  {
> -	const char *s;
> +	const char *s, *p;
>  	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
>  	if (opts->flags & PARSE_OPT_OPTARG)
>  		if (opts->long_name)
> @@ -482,7 +482,9 @@ static int usage_argh(const struct option *opts, FILE *outfile)
>  			s = literal ? "[%s]" : "[<%s>]";
>  	else
>  		s = literal ? " %s" : " <%s>";
> -	return fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
> +	p = opts->argh ? _(opts->argh) : _("...");
> +	fprintf(outfile, s, p);
> +	return utf8_strwidth(p) + strlen(s) - 2;
>  }

First of all, #include "utf8.h" is required for utf8_strwidth().

The "strlen(s) - 2" is quite sensitive to how "s" is written. How
about this? A bit longer but clearer. Your version is OK too with a
comment explaining "strlen(s) - 2".

-- 8< --
diff --git a/parse-options.c b/parse-options.c
index 67e98a6..0f803bd 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -474,6 +474,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
+	struct strbuf sb = STRBUF_INIT;
+	int columns;
 	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
@@ -482,7 +484,11 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 			s = literal ? "[%s]" : "[<%s>]";
 	else
 		s = literal ? " %s" : " <%s>";
-	return fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
+	strbuf_addf(&sb, s, opts->argh ? _(opts->argh) : _("..."));
+	fprintf(outfile, sb.buf);
+	columns = utf8_strwidth(sb.buf);
+	strbuf_release(&sb);
+	return columns;
 }
 
 #define USAGE_OPTS_WIDTH 24
-- 8< --

While looking at parse-options.c, I notice "-NUM" is not marked for
translation. I think you might want to mark it so that you can
translate "NUM" to a similar abbreviation in a local language. A
similar patch like this is required so we get columns for "-NUM"
translation instead of the number of bytes.
--
Duy
