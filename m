From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] parse-options: add PARSE_OPT_CUSTOM_ARGH for complicated argh's
Date: Sun, 17 May 2009 03:47:03 -0700
Message-ID: <1242557224-8411-2-git-send-email-bebarino@gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 12:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5dtp-0005YO-Ns
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 12:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbZEQKrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 06:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755666AbZEQKrM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 06:47:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:13775 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbZEQKrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 06:47:09 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1417638rvb.1
        for <git@vger.kernel.org>; Sun, 17 May 2009 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=B76ZcL9jrQg4GK0mJePTDQzgtpNr37wDw+feoFDioK4=;
        b=b2igdc9PBLsCAvES2Q3XJN1vJotrrZudANgiM7FLUigiSB17zr9D/LY0opNdW9fOMW
         kuCFYdTsQvbOe8d0XjfKdBJ5hJaSx9VvJB5zB1m5kCX/iOYfrP+UjHJGE1AJxUVOCvJY
         n/pkyNdOpSZR/yVMe8j7k1MNV7YVO/S9mlNX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FEU3Vs5RdABrChupasIMPzld7QT6PCMv6e0fBr/DgrSZHUo5IisWbNUZUZRJnOWMGt
         z7h7UmIsmQCvDuka1eAO52sf2Vw020iRBXE3Q57kGQdmkPjjepVovkZN2HzRii3anEKO
         KwYgrL9IXCE2Q3LOEHB2hnJtC2pKtr7T7JPGk=
Received: by 10.141.87.13 with SMTP id p13mr2025716rvl.229.1242557230717;
        Sun, 17 May 2009 03:47:10 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id f42sm9633069rvb.1.2009.05.17.03.47.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 03:47:10 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 17 May 2009 03:47:07 -0700
X-Mailer: git-send-email 1.6.3.1.30.g55524
In-Reply-To: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119390>

If argh is complicated, i.e. the option takes more than one argument,
don't add the brackets around argh in the usage message.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

    This is used in the next patch to for --reflog[=<n>[,<base>]]

    Maybe someone can think of a better name?

 parse-options.c |   26 +++++++++++++++++---------
 parse-options.h |    4 ++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cf71bcf..cd9ab4f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -361,6 +361,20 @@ int parse_options(int argc, const char **argv, const struct option *options,
 	return parse_options_end(&ctx);
 }
 
+static int usage_argh(const struct option *opts, int pos)
+{
+	const char *s;
+	int custom = opts->flags & PARSE_OPT_CUSTOM_ARGH;
+	if (opts->flags & PARSE_OPT_OPTARG)
+		if (opts->long_name)
+			s = custom ? "[=%s]" : "[=<%s>]";
+		else
+			s = custom ? "[%s]" : "[<%s>]";
+	else
+		s = custom ? " %s" : " <%s>";
+	return pos + fprintf(stderr, s, opts->argh);
+}
+
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
@@ -421,15 +435,9 @@ int usage_with_options_internal(const char * const *usagestr,
 				break;
 			/* FALLTHROUGH */
 		case OPTION_STRING:
-			if (opts->argh) {
-				if (opts->flags & PARSE_OPT_OPTARG)
-					if (opts->long_name)
-						pos += fprintf(stderr, "[=<%s>]", opts->argh);
-					else
-						pos += fprintf(stderr, "[<%s>]", opts->argh);
-				else
-					pos += fprintf(stderr, " <%s>", opts->argh);
-			} else {
+			if (opts->argh)
+				pos += usage_argh(opts, pos);
+			else {
 				if (opts->flags & PARSE_OPT_OPTARG)
 					if (opts->long_name)
 						pos += fprintf(stderr, "[=...]");
diff --git a/parse-options.h b/parse-options.h
index b54eec1..671a635 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -31,6 +31,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NONEG   = 4,
 	PARSE_OPT_HIDDEN  = 8,
 	PARSE_OPT_LASTARG_DEFAULT = 16,
+	PARSE_OPT_CUSTOM_ARGH = 64,
 };
 
 struct option;
@@ -66,6 +67,9 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
  *                    the long one.
+ *   PARSE_OPT_CUSTOM_ARGH: says that argh shouldn't be enclosed in brackets
+ *			    (i.e. '<argh>') in the help message.
+ *			    Useful for options with multiple parameters.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK.
-- 
1.6.3.1.30.g55524
