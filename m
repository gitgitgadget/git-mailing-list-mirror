From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-pack: remove --keep-auto and make it the default.
Date: Thu, 25 Jan 2007 19:05:01 -0800
Message-ID: <7vhcue4heq.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0701231101040.3011@xanadu.home>
	<7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701250922260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vejpiaj2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 26 04:05:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAHOo-0003v7-0a
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 04:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030714AbXAZDFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 22:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030718AbXAZDFF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 22:05:05 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40522 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030714AbXAZDFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 22:05:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126030502.GLBY20530.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 22:05:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ff441W00E1kojtg0000000; Thu, 25 Jan 2007 22:04:05 -0500
In-Reply-To: <7vejpiaj2f.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 25 Jan 2007 13:32:40 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37792>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Wed, 24 Jan 2007, Junio C Hamano wrote:
>>
>>>   Ok, how about this, on top of the previous ones?
>>
>> Thanks!
>>
>>> @@ -653,6 +663,8 @@ int main(int argc, char **argv)
>>>  	struct stat st;
>>>  
>>>  	setup_git_directory();
>>> +	setup_ident();
>>> +	git_config(fetch_pack_config);
>>
>> Why do you need setup_ident()?
>
> Because presumably you would be updating the reflog that records
> who did the fetch?
>
> But then we should do the same ignore_missing_committer_name()
> we have in receive-pack to allow anonymous fetchers to fetch
> from outside world, I guess.

This turns out to be more serious than I expected.

The code that uses committer_info() in reflog can barf and die.
And I do not think calling ignore_missing_committer_name()
upfront like recent receive-pack did in the aplication is a
reasonable workaround.

So I am thinking about doing something like the attached patch.

What the patch does.

 - git_committer_info() takes one parameter.  It used to be "if
   this is true, then die() if the name is not available due to
   bad GECOS, otherwise issue a warning once but leave the name
   empty".  The reason was because we wanted to prevent bad
   commits from being made by git-commit-tree (and its
   callers).  The value 0 is only used by "git var -l". 

   Now it takes -1, 0 or 1.  When set to -1, it does not
   complain but uses the pw->pw_name when name is not
   available.  Existing 0 and 1 values mean the same thing as
   they used to mean before.  0 means issue warnings and leave
   it empty, 1 means barf and die.

 - ignore_missing_committer_name() and its existing caller
   (receive-pack, to set the reflog) have been removed.

 - git-format-patch, to come up with the phoney message ID when
   asked to thread, now passes -1 to git_committer_info().  This
   codepath uses only the e-mail part, ignoring the name.  It
   used to barf and die.  The other call in the same program
   when asked to add signed-off-by line based on committer
   identity still passes 1 to make sure it barfs instead of
   adding a bogus s-o-b line.

 - log_ref_write in refs.c, to come up with the name to record
   who initiated the ref update in the reflog, passes -1.  It
   used to barf and die.

The last change means that git-update-ref, git-branch, and
commit walker backends can now be used in a repository with
reflog by somebody who does not have the user identity required
to make a commit.  They all used to barf and die.

I've run tests and all of them seem to pass, and also tried "git
clone" as a user whose GECOS is empty -- git clone works again
now (it was broken when reflog was enabled by default).

But this definitely needs extra sets of eyeballs.

---
diff --git a/builtin-log.c b/builtin-log.c
index 503cd1e..56acc13 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -352,7 +352,7 @@ static void get_patch_ids(struct rev_info *rev, struct diff_options *options, co
 
 static void gen_message_id(char *dest, unsigned int length, char *base)
 {
-	const char *committer = git_committer_info(1);
+	const char *committer = git_committer_info(-1);
 	const char *email_start = strrchr(committer, '<');
 	const char *email_end = strrchr(committer, '>');
 	if(!email_start || !email_end || email_start > email_end - 1)
diff --git a/cache.h b/cache.h
index 473197d..9486132 100644
--- a/cache.h
+++ b/cache.h
@@ -320,7 +320,6 @@ void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
 
 extern int setup_ident(void);
-extern void ignore_missing_committer_name(void);
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 4df7450..83a1d7b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -671,8 +671,6 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 	setup_ident();
-	/* don't die if gecos is empty */
-	ignore_missing_committer_name();
 	git_config(fetch_pack_config);
 
 	if (0 <= transfer_unpack_limit)
diff --git a/ident.c b/ident.c
index 6ad8fed..f967790 100644
--- a/ident.c
+++ b/ident.c
@@ -180,12 +180,21 @@ static const char *get_ident(const char *name, const char *email,
 		email = git_default_email;
 
 	if (!*name) {
-		if (name == git_default_name && env_hint) {
+		struct passwd *pw;
+
+		if (0 <= error_on_no_name &&
+		    name == git_default_name && env_hint) {
 			fprintf(stderr, env_hint, au_env, co_env);
 			env_hint = NULL; /* warn only once, for "git-var -l" */
 		}
-		if (error_on_no_name)
+		if (0 < error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);
+		pw = getpwuid(getuid());
+		if (!pw)
+			die("You don't exist. Go away!");
+		strlcpy(git_default_name, pw->pw_name,
+			sizeof(git_default_name));
+		name = git_default_name;
 	}
 
 	strcpy(date, git_default_date);
@@ -218,18 +227,3 @@ const char *git_committer_info(int error_on_no_name)
 			 getenv("GIT_COMMITTER_DATE"),
 			 error_on_no_name);
 }
-
-void ignore_missing_committer_name()
-{
-	/* If we did not get a name from the user's gecos entry then
-	 * git_default_name is empty; so instead load the username
-	 * into it as a 'good enough for now' approximation of who
-	 * this user is.
-	 */
-	if (!*git_default_name) {
-		struct passwd *pw = getpwuid(getuid());
-		if (!pw)
-			die("You don't exist. Go away!");
-		strlcpy(git_default_name, pw->pw_name, sizeof(git_default_name));
-	}
-}
diff --git a/receive-pack.c b/receive-pack.c
index 8b59b32..7d26326 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -430,8 +430,6 @@ int main(int argc, char **argv)
 		die("attempt to push into a shallow repository");
 
 	setup_ident();
-	/* don't die if gecos is empty */
-	ignore_missing_committer_name();
 	git_config(receive_pack_config);
 
 	if (0 <= transfer_unpack_limit)
diff --git a/refs.c b/refs.c
index 8117328..4323e9a 100644
--- a/refs.c
+++ b/refs.c
@@ -958,7 +958,7 @@ static int log_ref_write(struct ref_lock *lock,
 				     lock->log_file, strerror(errno));
 	}
 
-	committer = git_committer_info(1);
+	committer = git_committer_info(-1);
 	if (msg) {
 		maxlen = strlen(committer) + strlen(msg) + 2*40 + 5;
 		logrec = xmalloc(maxlen);
