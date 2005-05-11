From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 13:03:16 -0700
Message-ID: <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net>
References: <1115839456.22180.79.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 21:56:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVxJH-0007Yi-AU
	for gcvg-git@gmane.org; Wed, 11 May 2005 21:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVEKUDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 16:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVEKUDb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 16:03:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:30442 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262039AbVEKUDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 16:03:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050511200317.NHZ26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 16:03:17 -0400
To: tglx@linutronix.de
In-Reply-To: <1115839456.22180.79.camel@tglx> (Thomas Gleixner's message of
 "Wed, 11 May 2005 19:24:16 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Gleixner <tglx@linutronix.de> writes:

TG> The patch adds an option to stop the output of git-rev-list
TG> on a sha1 match. 

One minor nit and two suggestions.  Otherwise looks good.

TG> Signed-Off: Thomas Gleixner <tglx@linutronix.de>

Nit.  Please spell it "Signed-off-by: ".  I have seen some
people spell "off" with capital "O" so I guess it is also
permitted.

TG>  		} else if (!strncmp(arg, "--min-age=", 10)) {
TG>  			min_age = atoi(arg + 10);
TG> +		} else if (!strncmp(arg, "--to_sha1=", 10)) {
TG> +			to_sha1 = arg + 10;

Suggestion.  How about renaming "--to_sha1" to "--since"?  If
you do not like "--since", then "--stop-at" would also be good.

The point being that I do not think we need to emphasize that
the 40-character object IDs are produced by an algorithm that
happens to use SHA1 hash in one of the steps of the computation.
That is just an implementation detail and irrelevant to the
user.  What you are accepting here is really the object ID of
the commit object.

At the very least, "--to-sha1" (hyphen not underscore) for
consistency, please.

TG> +		sha1hex = sha1_to_hex(commit->object.sha1);
TG> +		if (to_sha1 != NULL && strcmp(to_sha1, sha1hex) == 0)
TG> +			break;

Suggestion.  Instead of running sha1_to_hex on the SHA1 of the
commit and comparing strings for every commit you encounter, how
about keeping 20-byte raw SHA1 of to_sha1 and doing memcmp of
20-byte?  That way you would also detect malformed --to-sha1
parameter when you do the initial conversion upon argument
parsing.  Also the argument parsing using get_sha1() would give
you an added benefit of using mnemonics (tag and heads).

What do you think about this revision?

----------------------------------------
[PATCH] Introduce "rev-list --stop-at=<commit>".

Additional option, --stop-at=<commit>, is introduced.  The
rev-list output stops after showing the named commit.

This is based on Thoms Gleixner's patch but slightly reworked.

Signed-off-by: Junio C Hamano <junkio@cox.net> 
---
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,12 +1,21 @@
 #include "cache.h"
 #include "commit.h"
 
+static const char *rev_list_usage = 
+"usage: rev-list [OPTION] commit-id\n"
+"  --max-count=nr\n"
+"  --max-age=epoch\n"
+"  --min-age=epoch\n"
+"  --stop-at=commit\n";
+
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 	struct commit_list *list = NULL;
 	struct commit *commit;
 	char *commit_arg = NULL;
+	unsigned char stop_at[20];
+	int has_stop_at = 0;
 	int i;
 	unsigned long max_age = -1;
 	unsigned long min_age = -1;
@@ -21,16 +30,17 @@ int main(int argc, char **argv)
 			max_age = atoi(arg + 10);
 		} else if (!strncmp(arg, "--min-age=", 10)) {
 			min_age = atoi(arg + 10);
+		} else if (!strncmp(arg, "--stop-at=", 10)) {
+			if (get_sha1(arg + 10, stop_at))
+				usage(rev_list_usage);
+			has_stop_at = 1;
 		} else {
 			commit_arg = arg;
 		}
 	}
 
 	if (!commit_arg || get_sha1(commit_arg, sha1))
-		usage("usage: rev-list [OPTION] commit-id\n"
-		      "  --max-count=nr\n"
-		      "  --max-age=epoch\n"
-		      "  --min-age=epoch\n");
+		usage(rev_list_usage);
 
 	commit = lookup_commit(sha1);
 	if (!commit || parse_commit(commit) < 0)
@@ -47,6 +57,8 @@ int main(int argc, char **argv)
 		if (max_count != -1 && !max_count--)
 			break;
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
+		if (has_stop_at && !memcmp(stop_at, commit->object.sha1, 20))
+			break;
 	} while (list);
 	return 0;
 }



