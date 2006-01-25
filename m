From: Junio C Hamano <junkio@cox.net>
Subject: Re: git describe fails without tags
Date: Wed, 25 Jan 2006 01:52:38 -0800
Message-ID: <7vek2wws61.fsf@assigned-by-dhcp.cox.net>
References: <20060125074725.GA2768@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 10:53:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1hL2-00059Q-4M
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 10:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWAYJwm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 04:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWAYJwm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 04:52:42 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:18381 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751090AbWAYJwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 04:52:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125095034.SMLP17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 04:50:34 -0500
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15126>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> I wonder if it would be sane to assume an implicit tag for the empty
> repository, s.t. git describe results in 
>
> 	<empty>-62ac6c16
>
> (whatever name is choosen for <empty>).
>
> Any opinions?

The value of 'describe' is not in the 62ac6c part, but in the
tag part, which lets us find out that the rev in question is at
least newer than that tag.  If the reason you are doing
"describe" is to find out an usable abbreviated name, you could
feed the first few hexdigits to "git rev-parse --verify",
lengthening the prefix longer by one until it says you have a
unique prefix [*1*].

In other words, not particularly interested, although it is
trivial to implement, like this:

diff --git a/describe.c b/describe.c
index 4866510..aeaf0fb 100644
--- a/describe.c
+++ b/describe.c
@@ -137,7 +137,7 @@ static void describe(char *arg, int last
 			return;
 		}
 	}
-	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+	printf("%s\n", find_unique_abbrev(cmit->object.sha1, abbrev));
 }
 
 int main(int argc, char **argv)


[Footnote]

*1* If you do this often, we could introduce

	$ git rev-parse --abbrev=<n> HEAD

    that quacks like --verify (i.e. makes sure there is a single
    "extended SHA1 expression" that evaluates to a valid object
    name) but outputs the result abbreviated to at least <n>
    hexdigits.
    
    This has an added advantage that it would work on a
    non-commit object name.


-- >8 --
[PATCH] rev-parse: --abbrev option.

The new option behaves just like --verify, but outputs an
abbreviated object name that is unique within the repository.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 rev-parse.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

3c7c31a913c3c4060e85f2919e2136412928dcec
diff --git a/rev-parse.c b/rev-parse.c
index 0c951af..c1646e4 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -20,6 +20,7 @@ static char *def = NULL;
 #define REVERSED 1
 static int show_type = NORMAL;
 static int symbolic = 0;
+static int abbrev = 0;
 static int output_sq = 0;
 
 static int revs_count = 0;
@@ -95,6 +96,8 @@ static void show_rev(int type, const uns
 		putchar('^');
 	if (symbolic && name)
 		show(name);
+	else if (abbrev)
+		show(find_unique_abbrev(sha1, abbrev));
 	else
 		show(sha1_to_hex(sha1));
 }
@@ -195,6 +198,17 @@ int main(int argc, char **argv)
 				verify = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--abbrev") ||
+			    !strncmp(arg, "--abbrev=", 9)) {
+				filter &= ~(DO_FLAGS|DO_NOREV);
+				verify = 1;
+				abbrev = DEFAULT_ABBREV;
+				if (arg[8] == '=')
+					abbrev = strtoul(arg + 9, NULL, 10);
+				if (abbrev < 0 || 40 <= abbrev)
+					abbrev = DEFAULT_ABBREV;
+				continue;
+			}
 			if (!strcmp(arg, "--sq")) {
 				output_sq = 1;
 				continue;
-- 
1.1.4.g869a
