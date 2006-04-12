From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some Commit Messages Scare git-rev-list
Date: Wed, 12 Apr 2006 12:39:25 -0700
Message-ID: <7vy7ya37o2.fsf@assigned-by-dhcp.cox.net>
References: <1144847462.5213.6.camel@localhost.localdomain>
	<Pine.LNX.4.64.0604121002220.14565@g5.osdl.org>
	<7v3bgi4op7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darrin Thompson <darrint@progeny.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Apr 12 21:39:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTlBb-0004rq-V4
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 21:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDLTj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 15:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWDLTj2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 15:39:28 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:23783 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932115AbWDLTj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 15:39:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060412193926.LFUM17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Apr 2006 15:39:26 -0400
To: git@vger.kernel.org
In-Reply-To: <7v3bgi4op7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 12 Apr 2006 11:46:12 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18637>

Junio C Hamano <junkio@cox.net> writes:

> We still need the "do we have anything to commit?" check by
> running "status" (which has to know what to do in different
> cases with -i/-o/-a), but there is no point appending its output
> to the proposed commit message given by the user.

BTW, this does not quite work as expected if you did something
like this:

	echo -n 'incomplete line' | git commit -a -s -F -

because we would want to append the Signed-off-by: line.  I am
almost tempted to say "then do not do it", but it might make
sense to do this as well.

-- >8 --
[PATCH] stripspace: make sure not to leave an incomplete line.

When dealing with a commit log message for human consumption, it
never makes sense to keep a log that ends with an incomplete
line, so make it a part of the clean-up process done with
git-stripspace.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/stripspace.c b/stripspace.c
index 96cd0a8..dee1ef0 100644
--- a/stripspace.c
+++ b/stripspace.c
@@ -6,9 +6,9 @@ #include <ctype.h>
  * Remove empty lines from the beginning and end.
  *
  * Turn multiple consecutive empty lines into just one
- * empty line.
+ * empty line.  Return true if it is an incomplete line.
  */
-static void cleanup(char *line)
+static int cleanup(char *line)
 {
 	int len = strlen(line);
 
@@ -21,16 +21,19 @@ static void cleanup(char *line)
 			len--;
 			line[len] = 0;
 		} while (len > 1);
+		return 0;
 	}
+	return 1;
 }
 
 int main(int argc, char **argv)
 {
 	int empties = -1;
+	int incomplete = 0;
 	char line[1024];
 
 	while (fgets(line, sizeof(line), stdin)) {
-		cleanup(line);
+		incomplete = cleanup(line);
 
 		/* Not just an empty line? */
 		if (line[0] != '\n') {
@@ -44,5 +47,7 @@ int main(int argc, char **argv)
 			continue;
 		empties++;
 	}
+	if (incomplete)
+		putchar('\n');
 	return 0;
 }
