From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Mon, 10 May 2010 04:31:20 -0500
Message-ID: <20100510093120.GA4445@progeny.tock>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
 <20100509210654.GA1637@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 11:31:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPKk-0002Q5-2N
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab0EJJbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 05:31:25 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:47215 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0EJJbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:31:24 -0400
Received: by qyk13 with SMTP id 13so5804884qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4Ym/822AzPSBS3MgcoXsBxv0Z9BtoeLbNDEV2HPDvdo=;
        b=xxC8S4eOLQXOyaXLNxMivtFFGM3gx0xzTD7HUhjppBlMyT7HIs4jhXyxLGAIbJcUDk
         k0e3R36f67BL8iSv7IzurASaUdNuFCUothvdCFXZ8RJxopiFKfL+JOgy2Gs5YUHRYcCs
         Gh/D0n8sVLRXvKXrdU7b4rFN5PI+Jj5zolCus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=f22edKqialIFvkDz2fVYvlW155b/q5+N0n96cjM/Ge/aqGPpN8QBRNeoHxlBrauiRM
         ad3f4JjMdcZxKL4JBktN3njwHbdnFX6+UD9E5OC5hgmP8mg4olX8HAonak9MiX2aV9XD
         yC5eGRkeih2nD+/D+uNgnoeLAvf7JT5soxmo4=
Received: by 10.229.213.140 with SMTP id gw12mr2913411qcb.96.1273483882345;
        Mon, 10 May 2010 02:31:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v37sm3835155qce.18.2010.05.10.02.31.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 02:31:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509210654.GA1637@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146778>

Jonathan Nieder wrote:

>   If -- is found, any
>   -L arguments before the -- apply to all files specified.  Unclaimed
>   arguments before the -- are revision specifiers.

More comments.

The -L arguments describe lines in some particular revision of the
files, so how would arbitrary =E2=80=98rev-list=E2=80=99-style revision=
 specifiers
work here?  They don=E2=80=99t: in =E2=80=98blame=E2=80=99, one "positi=
ve" revision is allowed
and the rest must be negative.  Good.

The modified proposal was, roughly:

  git blame [options, no -L among them] revs ((-L range)... filespec)..=
=2E
  git blame [options, -L permitted] revs -- [filespec...]
  git blame [options, -L permitted] revs [filespec...]

=E2=80=9C...=E2=80=9D means =E2=80=9Cone or more=E2=80=9D.  How to know=
 whether the -L or revision
arguments are encountered first?  One approach is to abuse
STOP_AT_NON_OPTION to catch the -L, revisions, and filespecs as they
appear.  Probably better would be to make -L an unknown option and
rely on parse_revision_opt leaving a residue of any revisions it
finds, so that after the first pass, the first syntax can be
distinguished from the others by the first argument starting with "-L".

=46eel free to do something else entirely (including another syntax) if
you prefer, of course.

Here=E2=80=99s a patch that makes STOP_AT_NON_OPTION easier to abuse, w=
ithout
affecting current users.  Maybe it would make it easier to play
around.

Good night,
Jonathan

 parse-options.c |    3 ++-
 parse-options.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8546d85..4e3532b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -372,7 +372,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (parse_nodash_opt(ctx, arg, options) =3D=3D 0)
 				continue;
 			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
-				break;
+				return PARSE_OPT_NON_OPTION;
 			ctx->out[ctx->cpidx++] =3D ctx->argv[0];
 			continue;
 		}
@@ -454,6 +454,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
+	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
diff --git a/parse-options.h b/parse-options.h
index 7581e93..4773cf9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -160,6 +160,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 enum {
 	PARSE_OPT_HELP =3D -1,
 	PARSE_OPT_DONE,
+	PARSE_OPT_NON_OPTION,
 	PARSE_OPT_UNKNOWN,
 };
=20
--=20
1.7.1
