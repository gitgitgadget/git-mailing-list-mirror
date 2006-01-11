From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Exec git programs without using PATH.
Date: Tue, 10 Jan 2006 22:13:05 -0800
Message-ID: <7v4q4bwavi.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	<1136900174.11717.537.camel@brick.watson.ibm.com>
	<43C3CC4A.4030805@op5.se>
	<1136910406.11717.579.camel@brick.watson.ibm.com>
	<43C4075E.4070407@op5.se> <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
	<1136924980.11717.603.camel@brick.watson.ibm.com>
	<7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
	<1136945538.11717.643.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 07:13:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwZEO-00089y-Ot
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 07:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWAKGNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 01:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWAKGNJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 01:13:09 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29571 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751381AbWAKGNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 01:13:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111061219.EWMQ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 01:12:19 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14480>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

>  exec_cmd.c     |  118
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This is a giveaway sign that your MUA is wrapping lines, so
please double-check before sending things out next time around.

It seems yours is not as bad as others I've seen; I could manage
to trivially hand-edit to make it appliable (although I am
inclined to ask you to polish it a bit further).

> +ifneq ($(shell cat .exec_cmd.gitexecdir 2>/dev/null),$(gitexecdir))
> +.PHONY: exec_cmd.c
> +$(shell echo $(gitexecdir) > .exec_cmd.gitexecdir)
> +endif

Although this check is much better than the last round, I changed
my mind about this part.  We do not do the equivalent checks and
rebuild when somebody once builds with NO_OPENSSL and then tries
to rebuild without, or for any other compile time configuration
(template_dir, for example).  Ideally we _could_ keep track of
all of them but I suspect that would be an overkill, so I am
inclined to drop this part.

We need to make sure that we clean .exec_cmd.gitexecdir on the
clean: target in the Makefile, if we _were_ to keep this, OTOH.

> +exec_cmd.o: CFLAGS+=-DGIT_EXEC_PATH=\"$(gitexecdir)\"

Please do not override CFLAGS like this; it breaks this common
usage:

	$ make CFLAGS='-g -O1' exec_cmd.o

> diff --git a/exec_cmd.c b/exec_cmd.c
> +void git_set_exec_path(const char *exec_path)
> +{
> +	current_exec_path = exec_path;
> +}

I've always wondered what we should do when --exec-path is given
more than once, but you decided it for me.  I agree that
silently overwriting is just fine.

> +	const char *paths[] = { current_exec_path,
> +				getenv("GIT_EXEC_PATH"),
> +				builtin_exec_path,
> +				NULL };

I do not think you need the last NULL element in paths[] here,
given what the loop that uses this array does.

> +	for (i = 0; i < 4; ++i) {

If your paths[] is fixed size, please do this instead:

	for (i = 0; sizeof(paths)/sizeof(paths[0]); i++)

Then I do not have to remember that I need to update "4" when I
update paths[].

> diff --git a/exec_cmd.h b/exec_cmd.h

> +extern const char* git_exec_path();

ANSI C please: extern const char* git_exec_path(void);

> diff --git a/git.c b/git.c

>  	if (errno == ENOENT)
> -		cmd_usage(exec_path, "'%s' is not a git-command", argv[i]);
> +		cmd_usage(git_exec_path(), "'%s' is not a git-command",
> +			  argv[i]);

You have assigned to exec_path before the failed execv_git_cmd()
already; I think change in this line is unneeded.

> diff --git a/receive-pack.c b/receive-pack.c
> index f847ec2..8e78e32 100644
> --- a/receive-pack.c
> +++ b/receive-pack.c
> @@ -257,7 +257,7 @@ static void read_head_info(void)
>  
>  static const char *unpack(int *error_code)
>  {
> -	int code = run_command(unpacker, NULL);
> +	int code = run_command_v_opt(1, &unpacker, RUN_GIT_CMD);

This one is questionable; run_command_v_opt() calls
execv_git_cmd() which expects the second argument of
run_command_v_opt() to be NULL terminated, doesn't it?

> diff --git a/shell.c b/shell.c
> index cd31618..0d4891f 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -12,7 +12,7 @@ static int do_generic_cmd(const char *me
>  	my_argv[1] = arg;
>  	my_argv[2] = NULL;
>  
> -	return execvp(me, (char**) my_argv);
> +	return execv_git_cmd((char**) my_argv);
>  }

Here my_argv comes from cmd_list[] which has "git-" prefix to
their command name, but I thought your exec[vl]_git_cmd() took
command names without.

Here is my suggestion on top of your patch, summarizing all of
the above comments.

-- >8 --

diff --git a/Makefile b/Makefile
index e7c7763..6694627 100644
--- a/Makefile
+++ b/Makefile
@@ -185,16 +185,6 @@ LIB_OBJS = \
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
-
-# .exec_cmd.gitexecdir stores $(gitexecir) used to compile exec_cmd.o
-# If it has changed, store the new value and force exec_cmd.o to be rebuilt
-ifneq ($(shell cat .exec_cmd.gitexecdir 2>/dev/null),$(gitexecdir))
-.PHONY: exec_cmd.c
-$(shell echo $(gitexecdir) > .exec_cmd.gitexecdir)
-endif
-
-exec_cmd.o: CFLAGS+=-DGIT_EXEC_PATH=\"$(gitexecdir)\"
-
 # Shell quote;
 # Result of this needs to be placed inside ''
 shq = $(subst ','\'',$(1))
@@ -423,6 +413,8 @@ git$X git.spec \
 %.o: %.S
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
+exec_cmd.o: ALL_CFLAGS += -DGIT_EXEC_PATH=\"$(gitexecdir)\"
+
 git-%$X: %.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
diff --git a/exec_cmd.c b/exec_cmd.c
index a3bd40a..55af33b 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -36,10 +36,9 @@ int execv_git_cmd(char **argv)
 	int len, err, i;
 	const char *paths[] = { current_exec_path,
 				getenv("GIT_EXEC_PATH"),
-				builtin_exec_path,
-				NULL };
+				builtin_exec_path };
 
-	for (i = 0; i < 4; ++i) {
+	for (i = 0; i < sizeof(paths)/sizeof(paths[0]); ++i) {
 		const char *exec_dir = paths[i];
 		if (!exec_dir) continue;
 
diff --git a/exec_cmd.h b/exec_cmd.h
index 06d5ec3..5150ee2 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -2,7 +2,7 @@
 #define __GIT_EXEC_CMD_H_
 
 extern void git_set_exec_path(const char *exec_path);
-extern const char* git_exec_path();
+extern const char* git_exec_path(void);
 extern int execv_git_cmd(char **argv); /* NULL terminated */
 extern int execl_git_cmd(char *cmd, ...);
 
diff --git a/git.c b/git.c
index fdd02ed..e3a0b59 100644
--- a/git.c
+++ b/git.c
@@ -285,10 +285,10 @@ int main(int argc, char **argv, char **e
 	execv_git_cmd(argv + i);
 
 	if (errno == ENOENT)
-		cmd_usage(git_exec_path(), "'%s' is not a git-command",
-			  argv[i]);
+		cmd_usage(exec_path, "'%s' is not a git-command", argv[i]);
 
 	fprintf(stderr, "Failed to run command '%s': %s\n",
 		git_command, strerror(errno));
+
 	return 1;
 }
diff --git a/receive-pack.c b/receive-pack.c
index 8e78e32..6120dbe 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -6,7 +6,7 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
-static const char unpacker[] = "git-unpack-objects";
+static char *unpacker[] = { "git-unpack-objects", NULL };
 
 static int report_status = 0;
 
@@ -257,7 +257,7 @@ static void read_head_info(void)
 
 static const char *unpack(int *error_code)
 {
-	int code = run_command_v_opt(1, &unpacker, RUN_GIT_CMD);
+	int code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
 
 	*error_code = 0;
 	switch (code) {
diff --git a/shell.c b/shell.c
index 0d4891f..d40dfe4 100644
--- a/shell.c
+++ b/shell.c
@@ -7,8 +7,10 @@ static int do_generic_cmd(const char *me
 
 	if (!arg || !(arg = sq_dequote(arg)))
 		die("bad argument");
+	if (strncmp(me, "git-", 4))
+		die("bad command");
 
-	my_argv[0] = me;
+	my_argv[0] = me + 4;
 	my_argv[1] = arg;
 	my_argv[2] = NULL;
 
