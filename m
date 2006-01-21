From: sean <seanlkml@sympatico.ca>
Subject: Re: git-grep documentation
Date: Sat, 21 Jan 2006 09:13:18 -0500
Message-ID: <BAYC1-PASMTP031BAB23C3237DA15F88D3AE1E0@CEZ.ICE>
References: <BAYC1-PASMTP07F7EA1F3B544C07AA01F8AE1F0@CEZ.ICE>
	<7vvewet330.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 15:18:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0JZm-0008Ks-Uf
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 15:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWAUOSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 09:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWAUOSM
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 09:18:12 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:37894 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932197AbWAUOSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 09:18:11 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Jan 2006 06:18:11 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 78275644C23;
	Sat, 21 Jan 2006 09:18:09 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060121091318.4508466b.seanlkml@sympatico.ca>
In-Reply-To: <7vvewet330.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Jan 2006 14:18:11.0518 (UTC) FILETIME=[82825DE0:01C61E95]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Jan 2006 00:09:07 -0800
Junio C Hamano <junkio@cox.net> wrote:

> I'd prefer to keep the options before path parameters if only
> for the sanity's sake.  How about this instead

Hi Junio,

I like your patch and it fixes the "-e" problem on the command
line nicely.   Some comments below though...



> [PATCH] git-grep: clarification on parameters.
> 
> We forgot to make sure that there is no more than one pattern
> parameter.  Also when looking for files in a directory called
> '--others', it passed that path limiter without preceding the
> end-of-options marker '--' to underlying git-ls-files, which
> misunderstood it as one of its options instead.

Actually I misinterpreted the intent of git-grep as wanting to
allow additional git-ls-files options to be given after the '--'
marker on its command line.   This misconception arose because
of the following comment in git-grep.sh :

        --)
               # The rest are git-ls-files paths (or flags)

So your new patch should also fix that comment to remove the 
"(or flags)" portion.

[...]

> -'git-grep' [<option>...] <pattern> [<path>...]
> +'git-grep' [<option>...] [-e] <pattern> [<path>...]
>
>  DESCRIPTION
>  -----------
> @@ -18,13 +18,32 @@ containing a match to the given pattern.
>  
>  OPTIONS
>  -------
> +`--`::
> +	Signals the end of options; the rest of the parameters
> +	are <path> limiters.
> +

Since you comment on the -- marker here I think it should
also appear in the command line above:

'git-grep' [<option>...] [-e] <pattern> [--] [<path>...]


>  <option>...::
>  	Either an option to pass to `grep` or `git-ls-files`.
>  	Some `grep` options, such as `-C` and `-m`, that take
> -	parameters are known to `git-grep`.
> +	parameters are known to `git-grep`.  Among options
> +	applicable to git-ls-files`, `--others` and
> +	`--exclude=*` (and other variants of exclusion) may be
> +	of interest.  Only `-o` is recognized as an option to
> +	`git-ls-files` in the short form (e.g. `-d` and `-m` are
> +	given to `grep`, not to `git-ls-files` as synonym
> +	for `--deleted` and `--modifed`), so you need to spell
> +	out `git-ls-files` options in longer form
> +	e.g. `--deleted`.


I would argue that this is too verbose and strays into the internal
implementation too much.   For example a user doesn't care that
git-grep.sh needs to specially handle "grep" parameters that happen
to take a single parameter (like -C and -m).

Instead it is more useful for them to be told _specificly_ which 
git-ls-files options  are available and that all others will be 
passed to grep.   Somthing like:

  Either an option to pass to `grep` or `git-ls-files`.

  The following are the specific `git-ls-files` options
  that may be given: `-o`, `--cached`, `--deleted`, `--others`,
  `--killed`, `--ignored`, `--modified`, `--exclude=*`,
  `--exclude-from=*`, and `--exclude-per-directory=*`.

  All other options will be passed to `grep`.

>  
>  <pattern>::
> -	The pattern to look for.
> +	The pattern to look for.  The first non option is taken
> +	as the pattern; if your pattern begins with a dash, use
> +	`-e <pattern>`.  When a pattern is found without `-e`, it
> +	also terminates the option processing and the rest of
> +	the parameters are used as the `<path>...`, and you do
> +	not specifically add `--` to protect the path limiter
> +	that happens to begin with a dash from being mistaken as
> +	an option.

And here I think only your first two sentences are needed and the
rest actually isn't.    Your patch fixes the problem case and 
there is no reason now to warn the user away from supplying the --
marker in addition to the "-e"; it'll work properly in either case.


That's it and the rest looked good.  In case you agree with anything
i've said here, find an amended version of your patch below.

Cheers,
Sean





diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2bfd8ed..7fd675b 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -8,7 +8,7 @@ git-grep - print lines matching a patter
 
 SYNOPSIS
 --------
-'git-grep' [<option>...] <pattern> [<path>...]
+'git-grep' [<option>...] [-e] <pattern> [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -18,13 +18,24 @@ containing a match to the given pattern.
 
 OPTIONS
 -------
+`--`::
+	Signals the end of options; the rest of the parameters
+	are <path> limiters.
+
 <option>...::
 	Either an option to pass to `grep` or `git-ls-files`.
-	Some `grep` options, such as `-C` and `-m`, that take
-	parameters are known to `git-grep`.
+
+	The following are the specific `git-ls-files` options
+	that may be given: `-o`, `--cached`, `--deleted`, `--others`, 
+	`--killed`, `--ignored`, `--modified`, `--exclude=*`, 
+	`--exclude-from=*`, and `--exclude-per-directory=*`.
+
+	All other options will be passed to `grep`.
 
 <pattern>::
-	The pattern to look for.
+	The pattern to look for.  The first non option is taken
+	as the pattern; if your pattern begins with a dash, use
+	`-e <pattern>`.  
 
 <path>...::
 	Optional paths to limit the set of files to be searched;
diff --git a/git-grep.sh b/git-grep.sh
index 2ed8e95..d815c09 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -3,22 +3,32 @@
 # Copyright (c) Linus Torvalds, 2005
 #
 
-USAGE='<option>... <pattern> <path>...'
+USAGE='[<option>...] [-e] <pattern> [<path>...]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
+got_pattern () {
+	if [ -z "$no_more_patterns" ]
+	then
+		pattern="$1" no_more_patterns=yes
+	else
+		die "git-grep: do not specify more than one pattern"
+	fi
+}
+
+no_more_patterns=
 pattern=
 flags=()
 git_flags=()
 while : ; do
 	case "$1" in
-	--cached|--deleted|--others|--killed|\
-	--ignored|--exclude=*|\
+	-o|--cached|--deleted|--others|--killed|\
+	--ignored|--modified|--exclude=*|\
 	--exclude-from=*|\--exclude-per-directory=*)
 		git_flags=("${git_flags[@]}" "$1")
 		;;
 	-e)
-		pattern="$2"
+		got_pattern "$2"
 		shift
 		;;
 	-A|-B|-C|-D|-d|-f|-m)
@@ -26,7 +36,7 @@ while : ; do
 		shift
 		;;
 	--)
-		# The rest are git-ls-files paths (or flags)
+		# The rest are git-ls-files paths 
 		shift
 		break
 		;;
@@ -34,8 +44,9 @@ while : ; do
 		flags=("${flags[@]}" "$1")
 		;;
 	*)
-		if [ -z "$pattern" ]; then
-			pattern="$1"
+		if [ -z "$no_more_patterns" ]
+		then
+			got_pattern "$1"
 			shift
 		fi
 		break
@@ -46,5 +57,5 @@ done
 [ "$pattern" ] || {
 	usage
 }
-git-ls-files -z "${git_flags[@]}" "$@" |
-	xargs -0 grep "${flags[@]}" -e "$pattern"
+git-ls-files -z "${git_flags[@]}" -- "$@" |
+	xargs -0 grep "${flags[@]}" -e "$pattern" --
