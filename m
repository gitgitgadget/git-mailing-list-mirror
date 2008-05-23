From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Repository specific git commands
Date: Fri, 23 May 2008 17:20:25 +0300
Message-ID: <8e04b5820805230720p2117fa9cp5a44c16c99457c69@mail.gmail.com>
References: <8e04b5820801070415j5166c2eco53760cffe1ab1efb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 16:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY92-00083Z-4n
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbYEWOU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755063AbYEWOU2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:20:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:55391 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbYEWOU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:20:27 -0400
Received: by wr-out-0506.google.com with SMTP id c48so396039wra.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yrmI+3aQrPjhlYW/lSEDbgtlr4G0+7rIxRhmTSzJc/8=;
        b=DtJTUMwKzaUKX09LraAGxxSzuAcoRH9CHY+u26rZ7yKbafr9v02+ziO937baoxaT2EOM7iCAbLaJT9QGVskQzYWJeLuYNAJHFR1GfMFoe+HQNI1Tee/bGQ8z6ZLaR8KgYG7K7OnU60TVGAft9+vOjye2wQgRyTDmzhNkpSbpNv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TZn5sLy/XHfufR0rW6Rnd66hJSyIV55MHMP2gizklHwqN+InaenLrnlTklcn5HzmUU0NsWDBpvc4KOdk6vwMl5cHG1eR3JaROBUsXjZ5rlZZsJNTDgzARXsrK9ru3mWbsgy2XVyjnFBGQZiHxu3iZCzJBoEbfoSf10MU0+H238U=
Received: by 10.141.44.13 with SMTP id w13mr693035rvj.13.1211552425596;
        Fri, 23 May 2008 07:20:25 -0700 (PDT)
Received: by 10.141.37.3 with HTTP; Fri, 23 May 2008 07:20:25 -0700 (PDT)
In-Reply-To: <8e04b5820801070415j5166c2eco53760cffe1ab1efb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82711>

    Hello all!

    A few months ago, I've proposed a feature (and accompaning patch)
that would enable users to create a "bin" folder inside the .git
folder, where they were allowed to put special git commands, that
would be accessible just like any other git command, but only for that
specific repository.

    Now the problem is that in the new Git v1.5.5.1 something has
changed, and I can not figure out what I shall do...

    In previous versions it was easy: just add a new path in the array
inside the execv_git_cmd function.

    But now the paths were moved to the setup_path function, and I'm
not able to make it work (see my patch bellow). The problem is that
all the commands start with the current folder being the top worktree
folder...

    Any suggestions, help, documentation?

    Thanks all,
    Ciprian.


diff --git a/exec_cmd.c b/exec_cmd.c
index e189cac..2166ae3 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -41,6 +41,28 @@ static void add_path(struct strbuf *out, const char *path)
 	}
 }

+static const char *git_repo_exec_path(void)
+{
+	static char path_buffer[PATH_MAX + 1];
+	static char *path = NULL;
+	char *git_dir;
+	int nongit_ok = 1; // ????
+	
+	if (!path) {
+		path = path_buffer;
+		path[0] = '\0';
+		setup_git_directory_gently(&nongit_ok);
+		git_dir = get_git_dir();
+		if (!nongit_ok && git_dir) {
+			strncat(path, git_dir, PATH_MAX);
+			strncat(path, "/", PATH_MAX);
+			strncat(path, "bin", PATH_MAX);
+		}
+	}
+	
+	return path;
+}
+
 void setup_path(const char *cmd_path)
 {
 	const char *old_path = getenv("PATH");
@@ -48,6 +70,7 @@ void setup_path(const char *cmd_path)

 	strbuf_init(&new_path, 0);

+	add_path(&new_path, git_repo_exec_path());
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
 	add_path(&new_path, builtin_exec_path);


On Mon, Jan 7, 2008 at 3:15 PM, Ciprian Dorin Craciun
<ciprian.craciun@gmail.com> wrote:
>    Hello all!
>
>    I have a question / proposal: I see on the mailing list a lot of
> situations when some commands (or group of commands) are very often
> used and the users demand (or would like to have) a special "git xxx"
> command for them. But adding such a command -- in almost all cases --
> is not worth the effort or increases the number of available commands
> (thus confusing even more the users).
>
>    Thus the users are left with only two possibilities:
>    -- either define an alias -- but usually it is very restrictive in
> terms of what the alias can do;
>    -- create a custom git command "git-xxx" and place it in the
> executable path -- but this requires root access.
>    (-- or write a custom script but this can not be invoked as "git xxx")
>    => Thus neither option is very useful.
>
>    So my proposal is to let the users create a special folder inside
> the .git directory, for example ".git/bin" where they can place custom
> built git files like "git-xxx", and when they issue "git xxx" this
> folder is searched first, and if the command is found it will be
> executed as any other "git-xxx".
>
>    For this I attach a very simple patch that implements it. (It
> modifies the execv_git_cmd function by adding a new path in the paths
> array.)
>
>    Comments? Opinions? Other solutions that I am not aware of?
>
>    (Please note that I am a git user for only a couple of months, and
> this is the first time I look over git source code...)
>
>    Thanks,
>    Ciprian Craciun.
>
