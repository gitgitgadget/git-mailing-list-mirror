From: sean <seanlkml@sympatico.ca>
Subject: Re: git-grep documentation
Date: Sat, 21 Jan 2006 14:19:53 -0500
Message-ID: <BAYC1-PASMTP04A8A5F7BEE906FE8E4924AE1E0@CEZ.ICE>
References: <BAYC1-PASMTP07F7EA1F3B544C07AA01F8AE1F0@CEZ.ICE>
	<7vvewet330.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP031BAB23C3237DA15F88D3AE1E0@CEZ.ICE>
	<7vzmlpo0y4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:25:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OM3-0002SF-Gt
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWAUTYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWAUTYr
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:24:47 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:46948 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932192AbWAUTYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 14:24:47 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Jan 2006 11:24:46 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 636A2644C23;
	Sat, 21 Jan 2006 14:24:45 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060121141953.2a1a4624.seanlkml@sympatico.ca>
In-Reply-To: <7vzmlpo0y4.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Jan 2006 19:24:46.0815 (UTC) FILETIME=[56F5EEF0:01C61EC0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Jan 2006 11:06:27 -0800
Junio C Hamano <junkio@cox.net> wrote:

> I've thought about this but it is not any more correct than what
> we have now (both are technically incorrect).  If you do not use
> an `-e` and let a non-option terminate the option processing,
> double dashes are not removed, so you do not want it there.

I think this should be fixed rather than requiring the user
to remember such an obscure detail.   It's easy to fix git-grep
to deal with it instead (see below).

> Does it?  I think if you give -- without -e it will look for a
> path that matches -- because we pass our own -- to ls-files.
> 

You're right,  in the patch below I added a specific test to handle
this case so the documentation can be simplified and the user is
free to use any combination of -e and --. 

> When people make an improvement proposal, I'd often prefer to
> see a patch that is on top of the patch being discussed, not a
> replacement.
> 

Yes, I can see how that would be easier to review.   Below
is a patch on top of your original that now includes the tweak
mentioned above:


diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 55d3bed..7fd675b 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -8,7 +8,7 @@ git-grep - print lines matching a patter
 
 SYNOPSIS
 --------
-'git-grep' [<option>...] [-e] <pattern> [<path>...]
+'git-grep' [<option>...] [-e] <pattern> [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -24,26 +24,18 @@ OPTIONS
 
 <option>...::
 	Either an option to pass to `grep` or `git-ls-files`.
-	Some `grep` options, such as `-C` and `-m`, that take
-	parameters are known to `git-grep`.  Among options
-	applicable to git-ls-files`, `--others` and
-	`--exclude=*` (and other variants of exclusion) may be
-	of interest.  Only `-o` is recognized as an option to
-	`git-ls-files` in the short form (e.g. `-d` and `-m` are
-	given to `grep`, not to `git-ls-files` as synonym
-	for `--deleted` and `--modifed`), so you need to spell
-	out `git-ls-files` options in longer form
-	e.g. `--deleted`.
+
+	The following are the specific `git-ls-files` options
+	that may be given: `-o`, `--cached`, `--deleted`, `--others`, 
+	`--killed`, `--ignored`, `--modified`, `--exclude=*`, 
+	`--exclude-from=*`, and `--exclude-per-directory=*`.
+
+	All other options will be passed to `grep`.
 
 <pattern>::
 	The pattern to look for.  The first non option is taken
 	as the pattern; if your pattern begins with a dash, use
-	`-e <pattern>`.  When a pattern is found without `-e`, it
-	also terminates the option processing and the rest of
-	the parameters are used as the `<path>...`, and you do
-	not specifically add `--` to protect the path limiter
-	that happens to begin with a dash from being mistaken as
-	an option.
+	`-e <pattern>`.  
 
 <path>...::
 	Optional paths to limit the set of files to be searched;
diff --git a/git-grep.sh b/git-grep.sh
index 23b1e03..4f06093 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -36,7 +36,7 @@ while : ; do
 		shift
 		;;
 	--)
-		# The rest are git-ls-files paths (or flags)
+		# The rest are git-ls-files paths 
 		shift
 		break
 		;;
@@ -49,6 +49,7 @@ while : ; do
 			got_pattern "$1"
 			shift
 		fi
+		[ "$1" = -- ] && shift
 		break
 		;;
 	esac
