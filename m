From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: permissions
Date: Wed, 9 Jun 2010 14:06:50 +0200
Message-ID: <201006091406.50955.trast@student.ethz.ch>
References: <4C0A19FE.1020802@wpursell.net> <AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com> <4C0F6CF0.3020603@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, <git@vger.kernel.org>
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 14:07:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMK3u-0003AW-ID
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 14:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab0FIMHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 08:07:09 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:5849 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757009Ab0FIMHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 08:07:06 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 9 Jun
 2010 14:07:04 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 9 Jun
 2010 14:06:52 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <4C0F6CF0.3020603@wpursell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148762>

William Pursell wrote:
> Alex Riesen wrote:
> > On Wed, Jun 9, 2010 at 00:27, William Pursell <bill.pursell@gmail.com> wrote:
> >> Junio C Hamano wrote:
> >>> Alex Riesen <raa.lkml@gmail.com> writes:
> >>>
> >>>> The patch moves the function is_git_directory at the level of user
> >>>> interface where it wasn't before: it now complains and die.
> >>>> Not all callers of the function call it only to die if it fails.
> >>> Thanks for shooting it down before I had to look at it ;-)
> >> The point of the patch is that it now complains and dies.
> > 
> > At wrong point. Points, actually. There are many callers of the
> > function you modified. You should have looked at them all.
> 
> I did look at all 4 calls, and it seemed to me
> that localizing the change in one location is a better
> design than adding logic to 4 different locations.
> 
> >> Perhaps I'm being obtuse, but can you describe a situation
> >> in which this causes git to terminate inappropriately?
> > 
> > Maybe. BTW, can you? (if you try, I mean).
> 
> No, I can't.  As far as I can tell, the patch adds
> exactly the functionality that I want it to add.  You
> do make good points about its problems below, however,
> and you are right that I did miss the point of
> your criticism.  Thank you for clarifying.

Maybe I'm missing something, but I think that also apart from any
meta-criticism the patch is wrong.  From the use of
setup_git_directory_gently() in cmd_apply() [for example; there are
other commands that are supposed to work both in- and outside of
repos], I conclude that the invocation of is_git_directory() must not
die() because it is *okay* if the directory is, after all, not a git
repo.

And I think the same goes for your new patch

> @@ -407,6 +413,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                 }
>                 if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
>                         break;
> +               if (access(DEFAULT_GIT_DIR_ENVIRONMENT, X_OK)
> +                                && errno != ENOENT )
> +                       die_errno("Unable to access %s/%s",
> +                                cwd, DEFAULT_GIT_DIR_ENVIRONMENT);
> +
>                 if (is_git_directory(".")) {
>                         inside_git_dir = 1;
>                         if (!work_tree_env)

[DEFAULT_GIT_DIR_ENVIRONMENT is ".git"]

Unless I'm missing something, this effectively prevents git-apply and
friends from working outside any repos if your BOFH sysadmin thinks it
funny to place an unreadable .git somewhere on the way up to /.

Or maybe we don't care about BOFH ideas?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
