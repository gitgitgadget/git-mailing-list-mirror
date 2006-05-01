From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] built-in "git grep" (git grip) - quickfix
Date: Mon, 01 May 2006 00:30:00 -0700
Message-ID: <7vbquirymf.fsf@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 01 09:30:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaSrG-000507-41
	for gcvg-git@gmane.org; Mon, 01 May 2006 09:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWEAHaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 03:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWEAHaE
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 03:30:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:38272 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751314AbWEAHaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 03:30:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501073000.YHXW18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 03:30:00 -0400
To: git@vger.kernel.org
In-Reply-To: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 30 Apr 2006 23:32:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19376>

Junio C Hamano <junkio@cox.net> writes:

> Right now, it does not understand and/or obey many options grep
> should accept, and the pattern matcher using POSIX.2 regex seems
> to be excruciatingly slow...

I forgot to say that unlike the shell script version you need to
give -e in front of the pattern with this version because of the
way the option parser is structured.  Obviously this needs to be
fixed for usability's sake.

But I seem to have managed to fix the "excruciatingly slow" part
trivially.  regexec() is not re.match() but re.search(), and
there is no point looking at each character on the line.  Here
is a patch.

-- >8 --
diff --git a/builtin-grep.c b/builtin-grep.c
index adcdbaa..6230f44 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -42,26 +42,18 @@ static int grep_buffer(struct grep_opt *
 
 	while (left) {
 		regmatch_t pmatch[10];
-		int flags = 0;
-		char *eol, *cp, ch;
+		char *eol, ch;
 		eol = end_of_line(bol, &left);
 		ch = *eol;
 		*eol = 0;
-		for (cp = bol; cp < eol; cp++) { 
-			int status = regexec(&opt->regexp, cp,
-					     ARRAY_SIZE(pmatch), pmatch,
-					     flags);
-			if (status == REG_NOMATCH)
-				flags |= REG_NOTBOL;
-			else if (status == 0) {
-				/* Hit at this line */
-				printf("%s:", name);
-				if (opt->linenum)
-					printf("%d:", lno);
-				printf("%.*s\n", eol-bol, bol);
-				hit = 1;
-				break;
-			}
+		if (!regexec(&opt->regexp, bol,
+			     ARRAY_SIZE(pmatch), pmatch, 0)) {
+			/* Hit at this line */
+			printf("%s:", name);
+			if (opt->linenum)
+				printf("%d:", lno);
+			printf("%.*s\n", eol-bol, bol);
+			hit = 1;
 		}
 		*eol = ch;
 		bol = eol + 1;
