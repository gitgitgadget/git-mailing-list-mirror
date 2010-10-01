From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: prepare grep for submodules
Date: Fri, 1 Oct 2010 21:37:55 +0700
Message-ID: <AANLkTikH+sd2kPAraGSTB-ik-Toz3s2nTLoLVOj86oSm@mail.gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
	<1285792134-26339-3-git-send-email-judge.packham@gmail.com>
	<AANLkTik3bvJneak9gjG8O1A=LZeivPkFc6MF5_T7nbWo@mail.gmail.com>
	<4CA4D820.5040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Jens.Lehmann" <Jens.Lehmann@web.de>, git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 16:38:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1gkO-0000Xs-QU
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 16:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874Ab0JAOh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 10:37:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53378 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669Ab0JAOh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 10:37:57 -0400
Received: by wyb28 with SMTP id 28so2974875wyb.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=WI4GOnTpzPHgehyqJx37d7LmTHrRnI34g5w7ib/rl/8=;
        b=GKlpStO8MTdpoiz794lPYovap8q3fe6luBvSI1KE1HUTTX16t6JzPKAbsFZogLApvw
         SvOo28gTA3pXUuRDkxFik7sJHqDh0bUc+0m8YpJoTHryW95g1x+MwQRHKnlEqhNMnrBR
         3JhMrJb2unUCCEVjo00+yUfFPYkEHb0ThUrwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=w0AuxE3e47DrcqQAVvS7iYN8Qhz3vC6R9Phg2X6Fsnoi8SOtJmQA0LOrRL0aTQHof9
         k5G/p8z4hqVpmgAgfNXNaeRjBbiF2kAfYalt/5Imd3GCubqpYTlq4ZsNToiZnWOEa02N
         /xwLswG3I+mVGjRHUJMfIVLwXrSQSBAVpTaR4=
Received: by 10.216.159.72 with SMTP id r50mr4539313wek.92.1285943875582; Fri,
 01 Oct 2010 07:37:55 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Fri, 1 Oct 2010 07:37:55 -0700 (PDT)
In-Reply-To: <4CA4D820.5040100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157753>

On 10/1/10, Chris Packham <judge.packham@gmail.com> wrote:
>  > You can make setup_explicit_git_dir() realize that situation (current
>  > working directory outside $GIT_WORK_TREE), then calculate and save the
>  > submodule prefix in startup_info struct. Then "git grep" or any
>  > commands can just read startup_info to find out the submodule prefix.
>
>
> Here's my first naive attempt at implementing what you describe. Needs
>  tests, more comments, sign-off etc.

Thanks.

>  One situation that could be handled better is when the cwd is a
>  subdirectory of the specified worktree. At the moment this ends up
>  giving the full path to the worktree, the output would look much nicer
>  if it gave the relative path (e.g. ../../).

Hmm.. if cwd is inside a worktree, prefix (the 3rd parameter in
cmd_grep) should be correctly set and "git grep" should also show
relative path. Or are you talking about another command?

>
>  ---8<---
>  From: Chris Packham <judge.packham@gmail.com>
>  Date: Thu, 30 Sep 2010 11:19:29 -0700
>  Subject: [RFC PATCH] save the work tree prefix in startup_info
>
>  This is the relative path between the cwd and the worktree or the
>  absolute path of the worktree if the worktree is not a subdirectory
>  of the worktree.
>  ---
>   cache.h |    1 +
>   dir.c   |   26 ++++++++++++++++++++++++++
>   dir.h   |    1 +
>   setup.c |    4 ++++
>   4 files changed, 32 insertions(+), 0 deletions(-)
>
>  diff --git a/cache.h b/cache.h
>  index e1d3ffd..f320e78 100644
>  --- a/cache.h
>  +++ b/cache.h
>  @@ -1111,6 +1111,7 @@ const char *split_cmdline_strerror(int cmdline_errno);
>   /* git.c */
>   struct startup_info {
>         int have_repository;
>  +       const char *prefix;

You should use another name here to avoid confusion with the current
prefix, relative to worktree toplevel directory. I'm thinking of
outer_prefix or cwd_prefix, but I'm usually bad at naming.

>   };
>   extern struct startup_info *startup_info;
>
>  diff --git a/dir.c b/dir.c
>  index 58ec1a1..2148730 100644
>  --- a/dir.c
>  +++ b/dir.c
>  @@ -1036,6 +1036,32 @@ char *get_relative_cwd(char *buffer, int size,
>  const char *dir)
>         }
>   }
>
>  +char *get_relative_wt(char *buffer, int size, const char *dir)
>  +{
>  +       char *cwd = buffer;
>  +
>  +       if (!dir)
>  +               return NULL;
>  +       if (!getcwd(buffer, size))
>  +               die_errno("can't find the current directory");
>  +       if (!is_absolute_path(dir))
>  +               dir = make_absolute_path(dir);
>  +       if (strstr(dir, cwd)) {

Why not strncmp?

>  +               dir += strlen(cwd);
>  +               switch(*dir){
>  +               case '\0':
>  +                       return NULL;
>  +               case '/':
>  +                       dir++;
>  +                       break;

Yeah.

>  +               default:
>  +                       break;

Should we properly handle relative path that includes ".." here too?

>  +               }
>  +       }
>  +       strncpy(buffer, dir, size);

So if "cwd" is inside "dir", an absolute "dir" is returned? That does
not look like a prefix to me.

>  +       return buffer;
>  +}
>  +
>   int is_inside_dir(const char *dir)
>   {
>         char buffer[PATH_MAX];
>  diff --git a/dir.h b/dir.h
>  index b3e2104..d3c161f 100644
>  --- a/dir.h
>  +++ b/dir.h
>  @@ -81,6 +81,7 @@ extern void add_exclude(const char *string, const char
>  *base,
>   extern int file_exists(const char *);
>
>   extern char *get_relative_cwd(char *buffer, int size, const char *dir);
>  +extern char *get_relative_wt(char *buffer, int size, const char *dir);
>   extern int is_inside_dir(const char *dir);
>
>   static inline int is_dot_or_dotdot(const char *name)
>  diff --git a/setup.c b/setup.c
>  index a3b76de..bd9d9fd 100644
>  --- a/setup.c
>  +++ b/setup.c
>  @@ -317,6 +317,7 @@ static const char *setup_explicit_git_dir(const char
>  *gitdirenv,
>                                 const char *work_tree_env, int *nongit_ok)
>   {
>         static char buffer[1024 + 1];
>  +       static char wtbuf[1024 + 1];
>         const char *retval;
>
>         if (PATH_MAX - 40 < strlen(gitdirenv))
>  @@ -337,6 +338,9 @@ static const char *setup_explicit_git_dir(const char
>  *gitdirenv,
>         }
>         if (check_repository_format_gently(nongit_ok))
>                 return NULL;
>  +
>  +       startup_info->prefix=get_relative_wt(wtbuf, sizeof(wtbuf) - 1,
>  +                       get_git_work_tree());
>         retval = get_relative_cwd(buffer, sizeof(buffer) - 1,
>                         get_git_work_tree());
>         if (!retval || !*retval)
>
> --
>  1.7.3.1
>
>


-- 
Duy
