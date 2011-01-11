From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] userdiff: simplify word-diff safeguard
Date: Tue, 11 Jan 2011 15:48:50 -0600
Message-ID: <20110111214850.GC29133@burratino>
References: <cover.1292688058.git.trast@student.ethz.ch>
 <854c8b6fa8a368bb34cc22d3fc948ae7136ed177.1292688058.git.trast@student.ethz.ch>
 <20110111214707.GA29133@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 11 22:49:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcm5X-0002rb-7x
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 22:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab1AKVtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 16:49:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37155 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab1AKVtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 16:49:03 -0500
Received: by vws16 with SMTP id 16so8709003vws.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pYBbE4x3KOnrQOGgmiJTEZvdJtL8IVi8fs6oxfcobi0=;
        b=nfWri2s2TbLj/mtXytxbk74ZUoY2uPtqK//E3WXZzDkmn/8o8Qe1oXqQo0ek/ucPp6
         bwPpGbXeGkkFthiGkhl3cmpnDsbYB95iYVoESyvcT7wmkN76h4dDaTbS9BPHdGFCq71d
         NjKoAjcoxx4Ond466VyLDLIpRd8LfblBpDikI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oD3BUnalj1CoGG0fbkNZYxfZYkHP9Jzv3n99mbp4Uxz+M2mX7ExMNYonQr6kVaJd99
         1J3tXIiv2sLOs2vlcztadkyuqPvHyqXmjaGKHFgPdK3JMtxqWU/fgPycIGNHXP0cBRaP
         2AzKuFrabLfmlbT0jww16CzIN2cpRYELgaDAc=
Received: by 10.220.75.209 with SMTP id z17mr27437vcj.225.1294782542051;
        Tue, 11 Jan 2011 13:49:02 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id f17sm11770413vbv.6.2011.01.11.13.49.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 13:49:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110111214707.GA29133@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164994>

git's diff-words support has a detail that can be a little dangerous:
any text not matched by a given language's tokenization pattern is
treated as whitespace and changes in such text would go unnoticed.
Therefore each of the built-in regexes allows a special token type
consisting of a single non-whitespace character [^[:space:]].

To make sure UTF-8 sequences remain human readable, the builtin
regexes also have a special token type for runs of bytes with the high
bit set.  In English, non-ASCII characters are usually isolated so
this is analogous to the [^[:space:]] pattern, except it matches a
single _multibyte_ character despite use of the C locale.

Unfortunately it is easy to make typos or forget entirely to include
these catch-all token types when adding support for new languages (see
v1.7.3.5~16, userdiff: fix typo in ruby and python word regexes,
2010-12-18).  Avoid this by including them automatically within the
PATTERNS and IPATTERN macros.

While at it, change the UTF-8 sequence token type to match exactly one
non-ASCII multi-byte character, rather than an arbitrary run of them.

Suggested-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 userdiff.c |   37 +++++++++++++++----------------------
 1 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 2d54536..91586cf 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -8,9 +8,11 @@ static int ndrivers;
 static int drivers_alloc;
 
 #define PATTERNS(name, pattern, word_regex)			\
-	{ name, NULL, -1, { pattern, REG_EXTENDED }, word_regex }
+	{ name, NULL, -1, { pattern, REG_EXTENDED },		\
+	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
 #define IPATTERN(name, pattern, word_regex)			\
-	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, word_regex }
+	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
+	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
 static struct userdiff_driver builtin_drivers[] = {
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
@@ -24,10 +26,9 @@ IPATTERN("fortran",
 	  * Don't worry about format statements without leading digits since
 	  * they would have been matched above as a variable anyway. */
 	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-zA-Z0-9_]*)?"
-	 "|//|\\*\\*|::|[/<>=]="
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|//|\\*\\*|::|[/<>=]="),
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
-	 "[^<>= \t]+|[^[:space:]]|[\x80-\xff]+"),
+	 "[^<>= \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
@@ -35,8 +36,7 @@ PATTERNS("java",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
-	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
@@ -49,8 +49,7 @@ PATTERNS("objc",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 PATTERNS("pascal",
 	 "^((procedure|function|constructor|destructor|interface|"
 		"implementation|initialization|finalization)[ \t]*.*)$"
@@ -59,33 +58,29 @@ PATTERNS("pascal",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
-	 "|<>|<=|>=|:=|\\.\\."
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|<>|<=|>=|:=|\\.\\."),
 PATTERNS("php",
 	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
 	 "^[\t ]*(class.*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
-	 "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"),
 PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
 	 /* -- */
 PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 /* -- */
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
-	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+|[^[:space:]]"),
+	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
 PATTERNS("cpp",
 	 /* Jump targets or access declarations */
 	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
@@ -96,8 +91,7 @@ PATTERNS("cpp",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 PATTERNS("csharp",
 	 /* Keywords */
 	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
@@ -112,8 +106,7 @@ PATTERNS("csharp",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
-	 "|[^[:space:]]|[\x80-\xff]+"),
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
1.7.4.rc1
