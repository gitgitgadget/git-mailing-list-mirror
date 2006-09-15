From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add "git show-ref" builtin command
Date: Fri, 15 Sep 2006 15:54:36 -0700
Message-ID: <7vy7skeo5v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org>
	<7vmz90g80m.fsf@assigned-by-dhcp.cox.net> <eef5m8$euj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 00:54:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOMa4-0003SF-Na
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 00:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWIOWyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 18:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWIOWyj
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 18:54:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:7078 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932348AbWIOWyi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 18:54:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915225437.BATC6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 15 Sep 2006 18:54:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NmuR1V00b1kojtg0000000
	Fri, 15 Sep 2006 18:54:26 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eef5m8$euj$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	15 Sep 2006 23:24:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27105>

Jakub Narebski <jnareb@gmail.com> writes:

> Wouldn't it be better to be able to use (or be able to enable, like echo -e
> option) interpretation of the  backslash-escaped characters, like 
> \t, \n, \0?

I've been thinking about letting the --format to specify
embedding arbitrary byte value in the output.

This option however is mostly to help Porcelain written in
languages other than C (and that is where the language specific
quoting styles come in) to allow a template of a scriptlet to be
specified, as you have probably seen in the examples in the
documentation page, so I think it is more user friendly to leave
backslash as just a literal character.

My current thinking is to allow you to say %XX (a per-cent
followed by exactly two hexadecimal digits) to do embed a
literal byte value.  Then a Porcelain written in Perl that does
not want to eval output can do something like this:

	my $fmt = 'r%(refname)%00o%(objectname)%00%00';
	open R, '-|', 'git-for-each-ref', "--format=$fmt";
	my $all = join('', <R>);
	close R;        	        
        for (split(/\0\0/, $all)) {
		/r(.*?)\0o(.*)/ &&
                print "ref = $1, obj = $2\n";
        }

Another thing is that originally I picked %(name) syntax because
I thought we might want to do fancier "%20(column)d" like Python
does with its string formatting operator.  But I now think it
makes more sense to output whatever is asked as string literals
and have host language worry about formatting.  So in that
sense, using %() as our formatting specifier will get in the way
for people who writes in Python.  Maybe I should change it to
something like %{name} instead (not ${name} -- that would
interfere with the shell and Perl).

Anyhow, on top of the previous one, this will let you say %00 to
embed a NUL in your string.

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index f064e7e..698618b 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -710,12 +710,39 @@ static void print_value(struct refinfo *
 	}
 }
 
+static int hex1(char ch)
+{
+	if ('0' <= ch && ch <= '9')
+		return ch - '0';
+	else if ('a' <= ch && ch <= 'f')
+		return ch - 'a' + 10;
+	else if ('A' <= ch && ch <= 'F')
+		return ch - 'A' + 10;
+	return -1;
+}
+static int hex2(const char *cp)
+{
+	if (cp[0] && cp[1])
+		return (hex1(cp[0]) << 4) | hex1(cp[1]);
+	else
+		return -1;
+}
+
 static void emit(const char *cp, const char *ep)
 {
 	while (*cp && (!ep || cp < ep)) {
-		if (*cp == '%')
+		if (*cp == '%') {
 			if (cp[1] == '%')
 				cp++;
+			else {
+				int ch = hex2(cp + 1);
+				if (0 <= ch) {
+					putchar(ch);
+					cp += 3;
+					continue;
+				}
+			}
+		}
 		putchar(*cp);
 		cp++;
 	}
@@ -731,8 +758,10 @@ static void show_ref(struct refinfo *inf
 			emit(cp, sp);
 		print_value(info, parse_atom(sp + 2, ep), quote_style);
 	}
-	if (*cp)
-		fputs(cp, stdout);
+	if (*cp) {
+		sp = cp + strlen(cp);
+		emit(cp, sp);
+	}
 	putchar('\n');
 }
 
