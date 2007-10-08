From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-shell and git-cvsserver
Date: Mon, 8 Oct 2007 05:51:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080534270.4174@racer.site>
References: <200710051453.47622.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Mon Oct 08 06:51:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iekar-0001Nm-Vd
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 06:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXJHEvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 00:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXJHEvh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 00:51:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:35580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750719AbXJHEvg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 00:51:36 -0400
Received: (qmail invoked by alias); 08 Oct 2007 04:51:34 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp036) with SMTP; 08 Oct 2007 06:51:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DOD54re+DiKJgovEhYkFfYoxzX5bhOUhNi1otbo
	Ffi7L0RDAuzZEu
X-X-Sender: gene099@racer.site
In-Reply-To: <200710051453.47622.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60287>

Hi,

On Fri, 5 Oct 2007, Jan Wielemaker wrote:

> Hi,
> 
> I know, I shouldn't be using git-cvsserver :-( Anyway, I patched
> git-shell to start git-cvsserver if it is started interactively and the
> one and only line given to it is "cvs server".
> 
> The patch to shell.c is below. The trick with the EXEC_PATH is needed
> because git-cvsserver doesn't appear to be working if you do not include
> the git bindir in $PATH. I think that should be fixed in git-cvsserver
> and otherwise we should at least make the value come from the prefix
> make variable.  With this patch I was able to use both Unix and Windows
> cvs clients using git-shell as login shell.
> 
> Note that you must provide ~/.gitconfig with user and email in the
> restricted environment.
> 
> 	Enjoy --- Jan

I think this is a valuable contribution.  That's why I comment...

Please put a useful commit message (less like an email, more like 
something you want to read in git-log) at the beginning of the email, then 
a line containing _just_ "---", and after that some comments that are not 
meant to be stored in the history, like (I know this does not belong 
to...)

After that, there should be a diffstat, and then the patch.

The easiest to have this layout is to do a proper commit in git, use "git 
format-patch" to produce the patch, and then insert what you want to say 
in addition to the commit message between the "---" marker and the 
diffstat.

I strongly disagree (as you yourself, probably) with the notion that this 
does not belong into git-shell.


> +#define EXEC_PATH "/usr/local/bin"

This is definitely wrong.  Use git_exec_path() instead.

> +static int do_cvs_cmd(const char *me, char *arg)
> +{
> +	const char *my_argv[4];

Maybe rename this to cvsserver_args?

> +	const char *oldpath;
> +
> +	if ( !arg )
> +		die("no argument");
> +	if ( strcmp(arg, "server") )
> +		die("only allows git-cvsserver server: %s", arg);
> +
> +	my_argv[0] = "cvsserver";
> +	my_argv[1] = "server";
> +	my_argv[2] = NULL;
> +
> +	if ( (oldpath=getenv("PATH")) ) {

Please lose the spaces after the opening and before the closing brackets.  
And put spaces around the "=" sign.

It is really distracting to read different styles of code in the same 
project, and that's why we're pretty anal about coding styles.  Just have 
a look (in the same file) how we write things, and imitate it as closely 
as possible.

> +		char *newpath = malloc(strlen(oldpath)+strlen(EXEC_PATH)+5+1+1); > +		
> +		sprintf(newpath, "PATH=%s:%s", EXEC_PATH, oldpath);
> +		putenv(newpath);
> +	} else {
> +		char *newpath = malloc(strlen(EXEC_PATH)+5+1);
> +		
> +		sprintf(newpath, "PATH=%s", EXEC_PATH);
> +		putenv(newpath);
> +	}

You have redundant "putenv(newpath);" in both clauses.  AFAICT putenv() is 
deprecated, too, and we use setenv() elsewhere.

In addition, I strongly suggest using strbuf:

	struct strbuf newpath = STRBUF_INIT;

	strbuf_addstr(&newpath, git_exec_path());
	if ((oldpath = getenv("PATH"))) {
		strbuf_addch(&newpath, ':');
		strbuf_addstr(&newpath, oldpath);
	}

	setenv("PATH", strbuf_detach(&newpath, NULL), 1);

> +	return execv_git_cmd(my_argv);

... and then you call execv_git_cmd(), which already does all the details 
of setting up the exec dir correctly AFAIR.

>  int main(int argc, char **argv)
>  {
>  	char *prog;
> +	char buf[256];
>  	struct commands *cmd;
>  
>  	/* We want to see "-c cmd args", and nothing else */
> -	if (argc != 3 || strcmp(argv[1], "-c"))
> -		die("What do you think I am? A shell?");
> +	if (argc == 1) {
> +		if (fgets(buf, sizeof(buf)-1, stdin)) {
> +			char *end;
> +
> +			if ( (end=strchr(buf, '\n')) )
> +			{	while(end>buf && end[-1] <= ' ')
> +					end--;
> +				*end = '\0';
> +			} else {
> +				die("Bad command");
> +			}
> +
> +			prog = buf;
> +		} else {
> +			die("No command");
> +		}
> +	} else {
> +		if (argc != 3 || strcmp(argv[1], "-c"))
> +			die("What do you think I am? A shell?");
> +
> +		prog = argv[2];
> +		argv += 2;
> +		argc -= 2;
> +	}

And this is ugly.  If you want to support "cvs server", then just check 
for that string, and if it matches, return execl_git_cmd("cvsserver");

Otherwise proceed as in the original code.

Ciao,
Dscho
