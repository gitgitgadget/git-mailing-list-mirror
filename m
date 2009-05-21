From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 1/2] parse-options: add PARSE_OPT_LITERAL_ARGHELP for complicated argh's
Date: Thu, 21 May 2009 00:33:17 -0700
Message-ID: <fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 10:04:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M73Fy-0005s6-9J
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 10:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbZEUIDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 04:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbZEUIDw
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 04:03:52 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:41130 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZEUIDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 04:03:49 -0400
X-Greylist: delayed 1418 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2009 04:03:49 EDT
Received: by pzk7 with SMTP id 7so535667pzk.33
        for <git@vger.kernel.org>; Thu, 21 May 2009 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=2nKjNFWICyVh79mz+YixtVNp76Ibd3NBCuVGjOGgzEY=;
        b=n1R8Na4liC9Bj5C+bs3gRqzy9bNbrsxGIf2VI0pV+RnYu/gXI42Wbi6FtTvG+0iYkT
         0rnyGUMHmU8By2390ByAfm0jSVo6XR+IS3Yo8Ul5WRltacMjvrnakBUotj34D914Jdm0
         007Hs2ZzEKmldqzZQP/SeWfVNDjyZ/9Z7WlrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=chznai2S6ScC5d9cSGG0uKDE4CzgS2oUACbvjfIGo6JL4oIt0KaY/iD/Zw6kOcyoBX
         dHP9LWhJospzAPxlk9/i33JOs0YT1ue5hIqppYxuP0qtkPLVZ6Bve37rAi+HxXkvi2g8
         xNdwHu1AlwbMBPnWnl6q41piRL2XcMhsMHalw=
Received: by 10.114.136.16 with SMTP id j16mr4544997wad.209.1242891202231;
        Thu, 21 May 2009 00:33:22 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id c26sm4882126waa.15.2009.05.21.00.33.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 00:33:21 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 21 May 2009 00:33:18 -0700
X-Mailer: git-send-email 1.6.3.1.61.g065b0
In-Reply-To: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119660>

Usually, the argh element in struct option points at a placeholder value
(e.g. "val"), and is shown in the usage message as

    --option=<val>

by enclosing the string inside of angle brackets.

When the option is more complex (e.g. optional arguments separated by a
comma), you would want to produce a usage message that looks like

    --option=<val1>[,<val2>]

In such a case, the caller can pass a string to argh with placeholders
already enclosed in necessary angle brackets (e.g.  "<val1>[,<val2>]")
and set this flag.

[nicer description from Junio Hamano]

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I've decided to appease the pirate haters :-)

 parse-options.c |   26 +++++++++++++++++---------
 parse-options.h |    4 ++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cf71bcf..2b880b1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -361,6 +361,20 @@ int parse_options(int argc, const char **argv, const struct option *options,
 	return parse_options_end(&ctx);
 }
 
+static int usage_argh(const struct option *opts, int pos)
+{
+	const char *s;
+	int literal = opts->flags & PARSE_OPT_LITERAL_ARGHELP;
+	if (opts->flags & PARSE_OPT_OPTARG)
+		if (opts->long_name)
+			s = literal ? "[=%s]" : "[=<%s>]";
+		else
+			s = literal ? "[%s]" : "[<%s>]";
+	else
+		s = literal ? " %s" : " <%s>";
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
index b54eec1..910aa1e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -31,6 +31,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NONEG   = 4,
 	PARSE_OPT_HIDDEN  = 8,
 	PARSE_OPT_LASTARG_DEFAULT = 16,
+	PARSE_OPT_LITERAL_ARGHELP = 64,
 };
 
 struct option;
@@ -66,6 +67,9 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
  *                    the long one.
+ *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
+ *				(i.e. '<argh>') in the help message.
+ *				Useful for options with multiple parameters.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK.
-- 
1.6.3.1.61.g065b0
