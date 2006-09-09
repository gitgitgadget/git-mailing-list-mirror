From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2/4] git-archive: wire up TAR format.
Date: Sat, 9 Sep 2006 17:10:23 +0200
Message-ID: <cda58cb80609090810t6fdab535r761636e65205a0f@mail.gmail.com>
References: <450019C3.4030001@innova-card.com>
	 <11576347252834-git-send-email-vagabon.xyz@gmail.com>
	 <4501D0CF.70306@lsrfire.ath.cx>
	 <7vlkouf32i.fsf@assigned-by-dhcp.cox.net>
	 <7vk64derfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 17:10:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM4TU-0000E3-JE
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 17:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWIIPKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 11:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWIIPKZ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 11:10:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:11674 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932255AbWIIPKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 11:10:24 -0400
Received: by wx-out-0506.google.com with SMTP id s14so982009wxc
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 08:10:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oOMg6TogalpzPg90fjzwaWMhmy5r/5AXA0RKKU0YhAEx3DAn2SSW9ixr8b74PlL3TQJkCWJGUSyAxrM7vbrravYmSZN73JqXsqNE4XhBwa+e9VGMMH8UkYTDqiu9nnVDNK5mKQosAo1QHFVcP2Km4Zr0MsQPhXs+J1G6ZgBAUeQ=
Received: by 10.70.50.10 with SMTP id x10mr2096785wxx;
        Sat, 09 Sep 2006 08:10:24 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sat, 9 Sep 2006 08:10:23 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vk64derfd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26755>

2006/9/9, Junio C Hamano <junkio@cox.net>:
> Junio C Hamano <junkio@cox.net> writes:
>
> > Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> >
> >> I did not sign off this exact patch.  I wrote and submitted the
> >> builtin-tar-tree.c part, with memory leak and all, then sent a note
> >> on where the leak needs to be plugged.  You put it together and
> >> converted it to struct archiver_args.  I'd very much have liked to
> >> see a comment stating this.  Or simply just say "based on code by
> >> Rene" or something.  The same is true for patch 3/4.
> >>...
> >> Especially I would not have signed off this invisible comment. ;)
> >
> > I take your response is a mild NAK.
>
> Just to reduce everybody's pain, why don't I fix them up and
> push out the 4 series in "pu" with attribution clarification and
> review comments from Rene in mind, so that you two can Ack them?
> After that they will be placed on "next".
>

Almost Acked by me, except you've missed some Rene's comments. And
more important I fixed an "uninitialized variable" bug. See patch
below.

> I needed to apply small tweaks on 1/4 (ANSI-C pedantic did not
> like empty struct initializers) and 4/4 (the updated 1/1 needed
> the way struct archiver is initialized and used be different
> from the original one) as well.
>

thanks for that.

-- >8 --

diff --git a/builtin-archive.c b/builtin-archive.c
index 0a02519..9b90d87 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -28,7 +28,7 @@ static int run_remote_archiver(struct ar

 	sprintf(buf, "git-upload-archive");

-	url = strdup(ar->remote);
+	url = xstrdup(ar->remote);
 	pid = git_connect(fd, url, buf);
 	if (pid < 0)
 		return pid;
@@ -101,6 +101,7 @@ void parse_treeish_arg(const char **argv
 		commit_sha1 = commit->object.sha1;
 		archive_time = commit->date;
 	} else {
+		commit_sha1 = NULL;
 		archive_time = time(NULL);
 	}

@@ -141,7 +142,7 @@ int parse_archive_args(int argc, const c
 {
 	const char *extra_argv[MAX_EXTRA_ARGS];
 	int extra_argc = 0;
-	const char *format = NULL; /* some default values */
+	const char *format = NULL;
 	const char *remote = NULL;
 	const char *base = "";
 	int list = 0;
@@ -171,6 +172,8 @@ int parse_archive_args(int argc, const c
 			break;
 		}
 		if (arg[0] == '-') {
+			if (extra_argc > MAX_EXTRA_ARGS - 1)
+				die("Too many extra options");
 			extra_argv[extra_argc++] = arg;
 			continue;
 		}
@@ -185,7 +188,7 @@ int parse_archive_args(int argc, const c
 		die("--list and --remote are mutually exclusive");
 	}
 	if (argc - i < 1) {
-		die("%s", archive_usage);
+		usage(archive_usage);
 	}
 	if (!format){
 		die("You must specify an archive format");
