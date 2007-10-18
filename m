From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git on afs
Date: Thu, 18 Oct 2007 16:57:32 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0710181645580.30020@torch.nrlssc.navy.mil>
References: <20071018203106.GA13518@fries.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IidNP-0000hH-CT
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 23:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbXJRV5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 17:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181AbXJRV5r
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 17:57:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58545 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbXJRV5q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 17:57:46 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9ILvW8J016787;
	Thu, 18 Oct 2007 16:57:33 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Oct 2007 16:57:32 -0500
In-Reply-To: <20071018203106.GA13518@fries.net>
X-OriginalArrivalTime: 18 Oct 2007 21:57:32.0543 (UTC) FILETIME=[E27848F0:01C811D1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--12.338300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDg4Ny03MDI1?=
	=?us-ascii?B?OTctNzAwMDc1LTEzOTAxMC0xODgwMTktNzAxNjE4LTEyMTY2NS03?=
	=?us-ascii?B?MDMxODctNzAwNjQ4LTcwMTQ1NS03MDYyOTAtNzA0NzQ3LTcwNDQy?=
	=?us-ascii?B?MS03MDcyMjUtNzAxMjk2LTcwMzUyOS03MDQ0NzMtNzAxODM3LTcw?=
	=?us-ascii?B?MTU3Ni03MDIzNTgtNzAyNzkxLTE0ODAzOS0xNDgwNTAtMjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61561>

On Thu, 18 Oct 2007, Todd T. Fries wrote:

> 2) git presumes that DTYPE(de) != DT_DIR .. means the dirent is not a dir
>   this is not true for afs
>
> I have been using this to sync several git trees, including linux-2.6 for the
> past week without issues writing to a local afs server.
>
> What do you guys think?
>
> diff --git a/dir.c b/dir.c
> index eb6c3ab..a3e53a5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -487,9 +487,19 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
> 			    && in_pathspec(fullname, baselen + len, simplify))
> 				dir_add_ignored(dir, fullname, baselen + len);
> 			if (exclude != dir->show_ignored) {
> -				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
> +				if (!dir->show_ignored)

you're missing an open bracket                          ^^^

> 					continue;
> 				}

or delete this one             ^^^

> +				if (DTYPE(de) == DT_UNKNOWN) {
> +					struct stat st;
> +					if (lstat(fullname, &st))
> +						continue;
> +					if (!S_ISDIR(st.st_mode))
> +						continue;
> +				} else {
> +					if (DTYPE(de) != DT_DIR)
> +						continue;
> +				}
> 			}
>
> 			switch (DTYPE(de)) {

seems sane to me.

If no one else brings up any issues, you should retest and submit
a signed patch with a good comment. Use -s with git-commit.
Then git-format-patch will produce the proper output.

-brandon
