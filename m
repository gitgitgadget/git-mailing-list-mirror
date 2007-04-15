From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sat, 14 Apr 2007 19:34:32 -0700
Message-ID: <7v8xcu5ps7.fsf@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
	<7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
	<7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 04:34:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcuZq-0007i1-6v
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 04:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXDOCee (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 22:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbXDOCee
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 22:34:34 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54822 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbXDOCee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 22:34:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415023433.ZILJ1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Apr 2007 22:34:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nEaY1W00b1kojtg0000000; Sat, 14 Apr 2007 22:34:33 -0400
In-Reply-To: <7vr6qm5r73.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 14 Apr 2007 19:04:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44484>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Why would 
>>
>> 	* diff crlf
>>
>> be "obviously sane"?
>>
>> In fact, I'd call it obviously insane.
>>
>> We do *not* want to default crlf to all files. We want the default to be 
>> "automatic crlf depending on content". 
>
> You do not have to worry.
>
> That's how "crlf" is defined.  Paths you explicitly say !crlf
> will _not_ go through the existing core.autocrlf mechanism.
>
> "* crlf" just says, by default everybody is subject to core.autocrlf,
> and on sane platforms, core.autocrlf is by default off, hence you will
> not get LF <-> CRLF applied.

Having said that, if we really wanted to, we could introduce a
way to explicitly say "Even if the contents do not look like
text, apply line ending conversion, always", by redefining the
meaning of 'crlf' attribute.

But I do not know if that makes much sense.  Being able to turn
_off_ would be a good thing because a particular file that looks
like CRLF terminated text might not be text.  But the other way
around?  IOW, I do not think of a case where a file that does
not even look like a text wants CRLF conversion.

---

diff --git a/convert.c b/convert.c
index 20c744a..f9e5d63 100644
--- a/convert.c
+++ b/convert.c
@@ -191,7 +191,7 @@ static void setup_crlf_check(struct git_attr_check *check)
 	check->attr = attr_crlf;
 }
 
-static int git_path_is_binary(const char *path)
+static int git_path_check_crlf(const char *path)
 {
 	struct git_attr_check attr_crlf_check;
 
@@ -202,20 +202,31 @@ static int git_path_is_binary(const char *path)
 	 * disable autocrlf only when crlf attribute is explicitly
 	 * unset.
 	 */
-	return (!git_checkattr(path, 1, &attr_crlf_check) &&
-		(0 == attr_crlf_check.isset));
+	if (!git_checkattr(path, 1, &attr_crlf_check))
+		return -1;
+	return attr_crlf_check.isset;
 }
 
 int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 {
-	if (git_path_is_binary(path))
+	switch (git_path_check_crlf(path)) {
+	case 0:
 		return 0;
-	return autocrlf_to_git(path, bufp, sizep);
+	case 1:
+		return forcecrlf_to_git(path, bufp, sizep);
+	default:
+		return autocrlf_to_git(path, bufp, sizep);
+	}
 }
 
 int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
 {
-	if (git_path_is_binary(path))
+	switch (git_path_check_crlf(path)) {
+	case 0:
 		return 0;
-	return autocrlf_to_working_tree(path, bufp, sizep);
+	case 1:
+		return forcecrlf_to_working_tree(path, bufp, sizep);
+	default:
+		return autocrlf_to_working_tree(path, bufp, sizep);
+	}
 }
