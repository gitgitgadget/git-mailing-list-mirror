From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: the war on trailing whitespace
Date: Sun, 26 Feb 2006 09:29:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
References: <20060225174047.0e9a6d29.akpm@osdl.org> <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
 <20060225210712.29b30f59.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 18:29:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDPhq-0001KH-Vu
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 18:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWBZR3H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWBZR3G
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 12:29:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbWBZR3F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 12:29:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1QHT1DZ032524
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 09:29:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1QHT08B017773;
	Sun, 26 Feb 2006 09:29:00 -0800
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060225210712.29b30f59.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16784>



On Sat, 25 Feb 2006, Andrew Morton wrote:
> 
> I'd suggest a) git will simply refuse to apply such a patch unless given a
> special `forcing' flag, b) even when thus forced, it will still warn and c)
> with a different flag, it will strip-then-apply, without generating a
> warning.

This doesn't do the "strip-then-apply" thing, but it allows you to make 
git-apply generate a warning or error on extraneous whitespace.

Use --whitespace=warn to warn, and (surprise, surprise) --whitespace=error 
to make it a fatal error to have whitespace at the end.

Totally untested, of course. But it compiles, so it must be fine.

HOWEVER! Note that this literally will check every single patch-line with 
"+" at the beginning. Which means that if you fix a simple typo, and the 
line had a space at the end before, and you didn't remove it, that's still 
considered a "new line with whitespace at the end", even though obviously 
the line wasn't really new.

I assume this is what you wanted, and there isn't really any sane 
alternatives (you could make the warning activate only for _pure_ 
additions with no deletions at all in that hunk, but that sounds a bit 
insane).

		Linus

---
diff --git a/apply.c b/apply.c
index 244718c..e7b3dca 100644
--- a/apply.c
+++ b/apply.c
@@ -34,6 +34,12 @@ static int line_termination = '\n';
 static const char apply_usage[] =
 "git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM] <patch>...";
 
+static enum whitespace_eol {
+	nowarn,
+	warn_on_whitespace,
+	error_on_whitespace
+} new_whitespace = nowarn;
+
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
  * we've seen, and the longest filename. That allows us to do simple
@@ -815,6 +821,22 @@ static int parse_fragment(char *line, un
 			oldlines--;
 			break;
 		case '+':
+			/*
+			 * We know len is at least two, since we have a '+' and
+			 * we checked that the last character was a '\n' above
+			 */
+			if (isspace(line[len-2])) {
+				switch (new_whitespace) {
+				case nowarn:
+					break;
+				case warn_on_whitespace:
+					new_whitespace = nowarn;	/* Just once */
+					error("Added whitespace at end of line at line %d", linenr);
+					break;
+				case error_on_whitespace:
+					die("Added whitespace at end of line at line %d", linenr);
+				}
+			}
 			added++;
 			newlines--;
 			break;
@@ -1839,6 +1861,17 @@ int main(int argc, char **argv)
 			line_termination = 0;
 			continue;
 		}
+		if (!strncmp(arg, "--whitespace=", 13)) {
+			if (strcmp(arg+13, "warn")) {
+				new_whitespace = warn_on_whitespace;
+				continue;
+			}
+			if (strcmp(arg+13, "error")) {
+				new_whitespace = error_on_whitespace;
+				continue;
+			}
+			die("unrecognixed whitespace option '%s'", arg+13);
+		}
 
 		if (check_index && prefix_length < 0) {
 			prefix = setup_git_directory();
