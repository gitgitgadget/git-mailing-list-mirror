From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] git-remote-fd
Date: Fri, 1 Oct 2010 16:54:49 -0500
Message-ID: <20101001215449.GB1882@burratino>
References: <1285866422-23964-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285866422-23964-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Oct 01 23:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1ncH-0007rS-5K
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 23:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab0JAV6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 17:58:01 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37518 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0JAV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 17:58:00 -0400
Received: by eyb6 with SMTP id 6so1404407eyb.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 14:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vB2oPFaNKErhtjNZ4ODTiQZLPm0auB1oloThdvtOmE0=;
        b=l0NFSQ5leKcFbWuHmjjdZuCcCNKgpPoJLK3FL8ffkm8P3YsdVMVNhWImak9n8qhiGu
         MDclpmYLIsILDmLDmtAAEuUAF5hAuRfWL6iS5hrj+guPFMlt6eNhnlqqTWjh0WxHKbNl
         y7iD1eDxwp9YgSTudyWKIsnIEnGoBX8HkUTDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Tjk2qfeqU+Oy8++ujVqpS3Eph441tPrEDhuAOyBpylyolWTzXkircMiMtkQlF/c7Me
         McxjsrySHGC3BP7MxDQ0p/jla9w4zz8wNoNYPHbxgcM3qQKABfGskFnljeWp3K6dOv6J
         EqtrjiTz2mdvKjWVbkkFHF0a7PwlSNjmpd5/A=
Received: by 10.213.4.130 with SMTP id 2mr4857335ebr.10.1285970279380;
        Fri, 01 Oct 2010 14:57:59 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v59sm2501699eeh.4.2010.10.01.14.57.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 14:57:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285866422-23964-3-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157786>

Hi again,

Ilari Liusvaara wrote:

> This remote helper reflects raw smart remote transport stream back to the
> calling program.

Fundamentally I think remote-fd (unlike remote-ext) suffers from the
"without-a-user" problem: without an example making use of this, it is
hard to know whether we have the interface right.

For example, might the caller want to use the usual in-stream
service identification as in git:// protocol in some cases?  Should
it would be possible to do

 some-complex-command fd::3

where some-complex-command makes multiple requests?

So personally I would be happier to see remote-fd in contrib/ until
we have at least some experience of what it's like to use.

Anyway, now the documentation is clearer (thanks!).  Some nitpicks
follow; patch at end.

> --- /dev/null
> +++ b/Documentation/git-remote-fd.txt
> @@ -0,0 +1,57 @@
> +git-remote-fd(1)
> +=================
> +
> +NAME
> +----
> +git-remote-fd - Reflect smart transport back to caller.

Has an extra period.  Might be worth including the word "stream":

	git-remote-fd - Reflect a smart transport stream back to caller

This describes what the helper does rather than the URL scheme...

> +SYNOPSIS
> +--------
> +"fd::<fd>[/<anything>]" or "fd::<infd>,<outfd>[/<anything>]" (as URL)

... so maybe the synopsis should describe the remote helper?

	'git remote-fd' <name> <infd>[,<outfd>][/<comment>]

> +
> +DESCRIPTION
> +-----------
> +This helper uses specified file descriptors to connect to remote git server.

Maybe it would make sense to clarify that this is not for end-users.
(see patch)

[...]
> +ENVIRONMENT VARIABLES:
> +----------------------
> +
> +$GIT_TRANSLOOP_DEBUG (passed to git)::
> +	If set, prints debugging information about various reads/writes.
> +

Nits: other manpages do not use the $ or trailing colon

> +EXAMPLES:
> +---------
> +"fd::17" (as URL)::
> +	Connect using socket in file descriptor #17.
[...]

Maybe full commands would be easier to read:

	`git fetch fd::17 master`::
		Fetch branch master, using a socket with file descriptor 17
		to communicate with 'git upload-pack'.

> --- /dev/null
> +++ b/builtin/remote-fd.c
> @@ -0,0 +1,76 @@
[...]
> +static int command_loop()

nit: static int command_loop(void)

Might even be simpler to return void.

> +{
> +	char buffer[MAXCOMMAND];
> +
> +	while (1) {
> +		if (!fgets(buffer, MAXCOMMAND - 1, stdin))
> +			exit(0);

This code path is used for errors, no?

		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
			if (ferror(stdin))
				die_errno("input error");
			exit(0);
		}

> +		/* Strip end of line characters. */
> +		while (isspace((unsigned char)buffer[strlen(buffer) - 1]))
> +			buffer[strlen(buffer) - 1] = 0;

Git isspace does not require the cast.  Won't the repeated strlen()
be slow?

		{
			char *p = buffer + strlen(buffer);
			while (p > buffer && isspace(*--p))
				*p = 0;
		}

> +
> +		if (!strcmp(buffer, "capabilities")) {
> +			printf("*connect\n\n");
> +			fflush(stdout);
> +		} else if (!strncmp(buffer, "connect ", 8)) {
> +			printf("\n");
> +			fflush(stdout);
> +			return bidirectional_transfer_loop(input_fd,
> +				output_fd);

If this returns nonzero, that's a fatal error, right?  So

			if (bidir...)
				exit(128);
			exit(0);

> +		} else {
> +			fprintf(stderr, "Bad command");
> +			return 1;

			die("bad command %s", buffer);

might be more useful.

> +int cmd_remote_fd(int argc, const char **argv, const char *prefix)
> +{
> +	char* end;
> +	unsigned long r;

The * should stick to the variable name.

> +	r = strtoul(argv[2], &end, 10);
> +	input_fd = (int)r;

Why not just

	input_fd = (int) strtoul(...

?

> +	if ((*end != ',' && *end !='/' && *end) || end == argv[2])

I find

	if (end == argv[2] || (*end && ...

more idiomatic, but that is serious nitpicking now.

Anyway, perhaps some of the below can be useful.
---
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index c4c0da1..b305c26 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -3,53 +3,68 @@ git-remote-fd(1)
 
 NAME
 ----
-git-remote-fd - Reflect smart transport back to caller.
-
+git-remote-fd - Reflect a smart transport stream back to caller
 
 SYNOPSIS
 --------
-"fd::<fd>[/<anything>]" or "fd::<infd>,<outfd>[/<anything>]" (as URL)
+'git remote-fd' <remote> (<fd> | <in_fd>,<out_fd>)[/<comment>]
 
 DESCRIPTION
 -----------
-This helper uses specified file descriptors to connect to remote git server.
+This is not a command the end user would ever want to run.  This
+documentation is meant for people who are writing Porcelain-ish
+programs that need to intercept the data that 'git' transfers.
+
+The 'git remote-fd' helper is used by git to handle requests for a
+repository with a URL such as `fd::3/git.example.com` (see
+linkgit:git-remote-helpers[7]).  Such requests are handled by reading
+from and writing to file descriptors inherited from the parent process.
 
-Data written to <fd> or <outfd> is assumed to make it unmolested to
-git-upload-pack/git-receive-pack/git-upload-archive, and data from that
-program is assumed to be readable unmolested from <fd> or <infd>.
+Data written to '<fd>' or '<out_fd>' is assumed to make it unmolested
+to 'git upload-pack', 'git receive-pack', or 'git upload-archive',
+and data from that program is assumed to be readable unmolested
+from '<fd>' or '<in_fd>'.
 
-If just <fd> is specified, <fd> is assumed to be socket. Otherwise both
-<infd> and <outfd> are assumed to be pipes.
+If only '<fd>' is specified, '<fd>' is assumed to be a socket.
+Otherwise both '<in_fd>' and '<out_fd>' are assumed to be pipes.
 
-It is assumed that any handshaking procedures have already been completed
-(such as sending service request for git://) before this helper is started.
+It is assumed that any handshaking procedures (such as sending a
+service request in `git://` protocol) have already been completed
+before this helper is started.
 
-<anything> can be any string. It is ignored. It is meant for provoding
-information to user in the "URL".
+The '<comment>' following a trailing `/` can be any string.
+It is ignored. It is meant for providing information to the user
+in the URL, in case the URL gets included in an error message
+shown to the end user.
 
-ENVIRONMENT VARIABLES:
-----------------------
+ENVIRONMENT VARIABLES
+---------------------
 
-$GIT_TRANSLOOP_DEBUG (passed to git)::
-	If set, prints debugging information about various reads/writes.
+'GIT_TRANSLOOP_DEBUG' (passed to git)::
+	If this is set, 'git' will print copious debugging information
+	about the transport data it reads and writes.
 
-EXAMPLES:
----------
-"fd::17" (as URL)::
-	Connect using socket in file descriptor #17.
+EXAMPLES
+--------
+`git fetch fd::17 master`::
+	Fetch branch master, using a socket with file descriptor 17
+	to communicate with 'git upload-pack'.
 
-"fd::17/foo" (as URL)::
+`git fetch fd::17/foo master`::
 	Same as above.
 
-"fd::7,8" (as URL)::
-	Connect using pipes in file descriptors #7 and #8. The incoming
-	pipe is at fd #7 and the outgoing pipe at fd #8.
+`git push fd::7,8 master`::
+	Push branch master, using two pipes with file descriptors 7
+	and 8 to communicate with 'git receive-pack'.
+	'git receive-pack'{apostrophe}s output should be readable
+	via the pipe on fd 7 and its input connected to the outgoing
+	pipe on fd 8.
 
-"fd::7,8/bar" (as URL)::
+`git push fd::7,8/bar master`::
 	Same as above.
 
 Documentation
---------------
+-------------
 Documentation by Ilari Liusvaara and the git list <git@vger.kernel.org>
 
 GIT
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 44c174b..7bc62be 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -16,21 +16,28 @@
  *
  */
 
+static const char builtin_remote_fd_usage[] =
+	"git remote-fd <repository> (<fd> | <in_fd>,<out_fd>)[/<comment>]";
+
 int input_fd = -1;
 int output_fd = -1;
 
-#define MAXCOMMAND 4096
-
-static int command_loop()
+static NORETURN void command_loop(void)
 {
-	char buffer[MAXCOMMAND];
+	char buffer[4096];
 
-	while (1) {
-		if (!fgets(buffer, MAXCOMMAND - 1, stdin))
+	for (;;) {
+		if (!fgets(buffer, sizeof(buffer) - 1, stdin)) {
+			if (ferror(stdin))
+				die_errno("input error");
 			exit(0);
+		}
 		/* Strip end of line characters. */
-		while (isspace((unsigned char)buffer[strlen(buffer) - 1]))
-			buffer[strlen(buffer) - 1] = 0;
+		{
+			char *p = buffer + strlen(buffer);
+			while (p > buffer && isspace(*--p))
+				*p = 0;
+		}
 
 		if (!strcmp(buffer, "capabilities")) {
 			printf("*connect\n\n");
@@ -38,39 +45,34 @@ static int command_loop()
 		} else if (!strncmp(buffer, "connect ", 8)) {
 			printf("\n");
 			fflush(stdout);
-			return bidirectional_transfer_loop(input_fd,
-				output_fd);
+			if (bidirectional_transfer_loop(input_fd, output_fd))
+				exit(128);
+			exit(0);
 		} else {
-			fprintf(stderr, "Bad command");
-			return 1;
+			die("bad command %s", buffer);
 		}
 	}
 }
 
 int cmd_remote_fd(int argc, const char **argv, const char *prefix)
 {
-	char* end;
-	unsigned long r;
+	char *end, *end2;
 
 	if (argc < 3)
-		die("URL missing");
-
-	r = strtoul(argv[2], &end, 10);
-	input_fd = (int)r;
+		usage(builtin_remote_fd_usage);
 
-	if ((*end != ',' && *end !='/' && *end) || end == argv[2])
+	input_fd = (int) strtoul(argv[2], &end, 10);
+	if (end == argv[2] || (*end && *end != ',' && *end != '/'))
 		die("Bad URL syntax");
 
-	if (*end == '/' || !*end) {
+	if (*end != ',') {	/* fd::fd[/comment] */
 		output_fd = input_fd;
-	} else {
-		char* end2;
-		r = strtoul(end + 1, &end2, 10);
-		output_fd = (int)r;
-
-		if ((*end2 !='/' && *end2) || end2 == end + 1)
-			die("Bad URL syntax");
+		command_loop();
 	}
 
-	return command_loop();
+	/* fd::in_fd,out_fd[/comment] */
+	output_fd = (int) strtoul(end + 1, &end2, 10);
+	if (end2 == end + 1 || (*end2 && *end2 != '/'))
+		die("Bad URL syntax");
+	command_loop();
 }
-- 
