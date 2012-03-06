From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH] fix deletion of .git/objects sub-directories
 in git-prune/repack
Date: Tue, 06 Mar 2012 19:32:41 +0100
Message-ID: <4F565849.80303@kdbg.org>
References: <OF93114E93.E64C1F7D-ONC12579B9.0032A592-C12579B9.00332D78@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: karsten.blees@dcon.de
X-From: git-owner@vger.kernel.org Tue Mar 06 19:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zBs-0007QM-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939Ab2CFScr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:32:47 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:12627 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964785Ab2CFScq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 13:32:46 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8CFD1A7EB9;
	Tue,  6 Mar 2012 19:33:35 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6608719F604;
	Tue,  6 Mar 2012 19:32:42 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <OF93114E93.E64C1F7D-ONC12579B9.0032A592-C12579B9.00332D78@dcon.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192371>

Am 06.03.2012 10:18, schrieb karsten.blees@dcon.de:
> On some systems (e.g. Windows XP), directories cannot be deleted while
> they're open. Both git-prune and git-repack (and thus, git-gc) try to
> rmdir while holding a DIR* handle on the directory, leaving dangling
> empty directories in the .git/objects store.
> 
> Fix it by swapping the rmdir / closedir calls.

The reasoning makes a lot of sense. I wonder why object directories are
pruned nevertheless when I run git gc --prune (I run git master plus a
few topics from pu).

> diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
> index f9463de..a834417 100644
> --- a/builtin/prune-packed.c
> +++ b/builtin/prune-packed.c
> @@ -36,7 +36,6 @@ static void prune_dir(int i, DIR *dir, char *pathname, 
> int len, int opts)
>                 display_progress(progress, i + 1);
>         }
>         pathname[len] = 0;
> -       rmdir(pathname);

After moving the rmdir() away from prune_dir(), the truncation of the
pathname does not logically belong here anymore. It should be moved with
the rmdir(). Looks good otherwise.

>  }
>  
>  void prune_packed_objects(int opts)
> @@ -65,6 +64,7 @@ void prune_packed_objects(int opts)
>                         continue;
>                 prune_dir(i, d, pathname, len + 3, opts);
>                 closedir(d);
> +               rmdir(pathname);
>         }
>         stop_progress(&progress);
>  }
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 58d7cb8..b99b635 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -85,9 +85,9 @@ static int prune_dir(int i, char *path)
>                 }
>                 fprintf(stderr, "bad sha1 file: %s/%s\n", path, 
> de->d_name);
>         }
> +       closedir(dir);
>         if (!show_only)
>                 rmdir(path);
> -       closedir(dir);
>         return 0;
>  }
>  
