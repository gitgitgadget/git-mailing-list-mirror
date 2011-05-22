From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/7] userdiff/perl: tighten BEGIN/END block pattern to reject
 here-doc delimiters
Date: Sun, 22 May 2011 12:29:32 -0500
Message-ID: <20110522172932.GA21159@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
 <20110521193826.GG10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 19:29:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOCTR-00018F-TD
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 19:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab1EVR3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 13:29:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41835 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab1EVR3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 13:29:41 -0400
Received: by iwn34 with SMTP id 34so4162517iwn.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ug4sEtQPAdpKEkfXEvbAQYDgVHJmxV6ItuK9kHc1b/Y=;
        b=rMfM23P+krLBo+wp4ycGKCF2lwGWyjclC66s0+0pCmy1KpxBWUWAwd8wMQA7/QIX+M
         eN/322thx+AW4me2ouNrxsAKeBda2uzoAfu0ngssFXz6k3go1/tUeAijo3zmrxsKXdAS
         xeMshpf0Fc2snMYgGz0xXHnY3jKVCoIatrJ/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=odQFGaWCLWpsZN9BikwT7BkvV4LBAU821rAnDflbHkDlvYcF/rIYUKJR0D+Pt84PUB
         BByBMRzM/qoDbNfNp1nw9q7dyvs9yf3X6XNVyHJZ+dStok5qWTk7GmuuSZXOrute0Bxp
         vJR9B0EN2zM8H7k5WQG2FYM2pC5Zh2aFiYGvg=
Received: by 10.42.151.72 with SMTP id d8mr7810817icw.26.1306085380919;
        Sun, 22 May 2011 10:29:40 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.ameritech.net [69.209.78.180])
        by mx.google.com with ESMTPS id o3sm2481801ibd.61.2011.05.22.10.29.39
        (version=SSLv3 cipher=OTHER);
        Sun, 22 May 2011 10:29:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521193826.GG10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174193>

A naive method of treating BEGIN/END blocks with a brace on the second
line as diff/grep funcname context involves also matching unrelated
lines that consist of all-caps letters:

	sub foo {
		print <<'EOF'
	text goes here
	...
	EOF
		... rest of foo ...
	}

That's not so great, because it means that "git diff" and "git grep
--show-function" would write "=EOF" or "@@ EOF" as context instead of
a more useful reminder like "@@ sub foo {".

To avoid this, tighten the pattern to only match the special block
names that perl accepts (namely BEGIN, END, INIT, CHECK, UNITCHECK,
AUTOLOAD, and DESTROY).  The list is taken from perl's toke.c.

Suggested-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> Accept
>
> 	sub foo
> 	{
> 	}
>
> as an alternative to a more common style that introduces perl
> functions with a brace on the first line (and likewise for BEGIN/END
> blocks).

I just remembered that this pattern is overzealous since it will match
here-document terminators, as in:

	sub foo {
		print <<'FINIS'
	here-doc goes here
	FINIS
		... rest of foo, a change to which might be described in
		a diff ...
	}

Fix follows.

 t/t4018-diff-funcname.sh |   17 +++++++++++++++--
 userdiff.c               |    2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index b2fd1a9..b68c56b 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -29,7 +29,7 @@ public class Beer
 }
 EOF
 sed 's/beer\\/beer,\\/' <Beer.java >Beer-correct.java
-cat >Beer.perl <<\EOF
+cat >Beer.perl <<\EOT
 package Beer;
 
 use strict;
@@ -56,6 +56,15 @@ sub finalround
 	print "99 bottles of beer on the wall.\n");
 }
 
+sub withheredocument {
+	print <<"EOF"
+decoy here-doc
+EOF
+	# some lines of context
+	# to pad it out
+	print "hello\n";
+}
+
 __END__
 
 =head1 NAME
@@ -76,7 +85,7 @@ Beer - subroutine to output fragment of a drinking song
 	song;
 
 =cut
-EOF
+EOT
 sed -e '
 	s/hello/goodbye/
 	s/beer\\/beer,\\/
@@ -138,6 +147,10 @@ test_expect_success 'perl pattern accepts K&R style brace placement, too' '
 	test_expect_funcname "sub finalround\$" perl
 '
 
+test_expect_success 'but is not distracted by end of <<here document' '
+	test_expect_funcname "sub withheredocument {\$" perl
+'
+
 test_expect_success 'perl pattern is not distracted by sub within POD' '
 	test_expect_funcname "=head" perl
 '
diff --git a/userdiff.c b/userdiff.c
index 42b86ac..e55310c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -74,7 +74,7 @@ PATTERNS("perl",
 		"(:[^;#]*)?"
 		"(\\{[ \t]*)?" /* brace can come here or on the next line */
 		"(#.*)?$\n" /* comment */
-	 "^[A-Z]+[ \t]*"	/* BEGIN, END, ... */
+	 "^(BEGIN|END|INIT|CHECK|UNITCHECK|AUTOLOAD|DESTROY)[ \t]*"
 		"(\\{[ \t]*)?" /* brace can come here or on the next line */
 		"(#.*)?$\n"
 	 "^=head[0-9] .*",	/* POD */
-- 
1.7.5.1
