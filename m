From: David Reiss <dreiss@facebook.com>
Subject: Re: [PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Thu, 15 May 2008 15:45:06 -0700
Message-ID: <482CBCF2.6030202@facebook.com>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 00:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwmD8-0000BC-4y
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 00:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761505AbYEOWpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 18:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760948AbYEOWpM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 18:45:12 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:60622 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760314AbYEOWpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 18:45:10 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4FMj721007132;
	Thu, 15 May 2008 15:45:07 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 May 2008 15:42:15 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.DEB.1.00.0805152327440.30431@racer>
X-OriginalArrivalTime: 15 May 2008 22:42:15.0332 (UTC) FILETIME=[EC48E640:01C8B6DC]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-15_04:2008-05-14,2008-05-15,2008-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805150193
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82238>

This meets my needs.

Junio, if you'd like, I can incorporate your suggestions of normalizing paths
internally and testing more corner cases.  But if you just want to take this
version, I'll be fine.

--David

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 15 May 2008, David Reiss wrote:
> 
>> longest_prefix is just a textual check.  It doesn't verify that the prefix
>> is actually a full directory component of the cwd.
> 
> Okay.
> 
>> Also, I think it is better to move the 'chdir("..")' after the do loop,
>> so that git won't even chdir up into the ceiling directory.  This
>> actually doesn't matter to me, but I figured that it might be nice for
>> someone.
> 
> I'd rather go with the minimal diff, unless there is a good reason to
> change it.
> 
>> Finally, just a small thing.  The documentation still says
>> "GIT_CEILING_DIRS".
> 
> Okay.
> 
> How about this on top (still pretty simple):
> 
> ---
> 
>  Documentation/git.txt          |    2 +-
>  path.c                         |   10 ++++++++--
>  t/t1504-ceiling-directories.sh |    8 ++++++++
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index a12d1f8..e4413bf 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -415,7 +415,7 @@ git so take care if using Cogito etc.
>         This can also be controlled by the '--work-tree' command line
>         option and the core.worktree configuration variable.
> 
> -'GIT_CEILING_DIRS'::
> +'GIT_CEILING_DIRECTORIES'::
>         If set (to a colon delimited list of absolute directories), Git
>         will refuse to look for the .git/ directory further when hitting
>         one of those directories (otherwise it would traverse the parent
> diff --git a/path.c b/path.c
> index c0d7364..a097ecc 100644
> --- a/path.c
> +++ b/path.c
> @@ -358,13 +358,18 @@ const char *make_absolute_path(const char *path)
>         return buf;
>  }
> 
> +static int is_separator(char c)
> +{
> +       return !c || c == '/';
> +}
> +
>  int longest_prefix(const char *path, const char *prefix_list)
>  {
>         int max_length = 0, length = 0, i;
> 
>         for (i = 0; prefix_list[i]; i++)
>                 if (prefix_list[i] == ':') {
> -                       if (length > max_length)
> +                       if (length > max_length &&
> is_separator(path[length]))
>                                 max_length = length;
>                         length = 0;
>                 }
> @@ -374,5 +379,6 @@ int longest_prefix(const char *path, const char
> *prefix_list)
>                         else
>                                 length = -1;
>                 }
> -       return max_length > length ? max_length : length;
> +       return max_length > length || !is_separator(path[length]) ?
> +               max_length : length;
>  }
> diff --git a/t/t1504-ceiling-directories.sh b/t/t1504-ceiling-directories.sh
> index 1d8ef0b..6c8757d 100644
> --- a/t/t1504-ceiling-directories.sh
> +++ b/t/t1504-ceiling-directories.sh
> @@ -43,4 +43,12 @@ test_expect_success 'with matching ceiling directories' '
> 
>  '
> 
> +test_expect_success 'with non-directory prefix' '
> +
> +       GIT_CEILING_DIRECTORIES="$CWD/sub" &&
> +       export GIT_CEILING_DIRECTORIES &&
> +       (cd subdir && git rev-parse --git-dir)
> +
> +'
> +
>  test_done
> 
