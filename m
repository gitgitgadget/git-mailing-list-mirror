From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Tue, 2 Dec 2014 09:21:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412020909020.13845@s15462909.onlinehome-server.info>
References: <cover.1417033080.git.johannes.schindelin@gmx.de> <cover.1417041787.git.johannes.schindelin@gmx.de> <ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de> <xmqqr3wjnd65.fsf@gitster.dls.corp.google.com>
 <xmqqk32aoowa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 09:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvihr-0004ad-Kc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 09:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbaLBIVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 03:21:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:61214 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbaLBIVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 03:21:06 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Lx83d-1Xxfim2VVB-016brW;
 Tue, 02 Dec 2014 09:21:01 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqk32aoowa.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:FVNgJ/iH675n+czvcMIiibXw6qIB4hObA9PHp4s+ZuMNNTmEjYb
 izndCXpDTMsvpWvL/91zOxduT3xS0OoVm+Wc5Hdpf3xGmXvOoAls06TalUkD8ag7OU2R7g2
 lctItGB74qWlLHP8PJ5MH7F4qW2oboniMap9CA4J69K0ap9wIAJvu3N5sLXn77779tAp7c6
 A+52wwCyCHcP/EvMzx9XA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260549>

Hi Junio,

On Mon, 1 Dec 2014, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> +static const char *update_worktree(unsigned char *sha1)
> >> +{
> >> +...
> >> +	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
> >
> > I overlooked this one, but is there a reason why this has to look at
> > an internal implementatino detail which is git_work_tree_cfg,
> > instead of asking get_git_work_tree()?
> >
> > I am wondering if that reason is a valid rationale to fix whatever
> > makes get_git_work_tree() unsuitable for this purpose.
> >
> > Cc'ing Duy who has been working on the part of the system to
> > determine and set-up work-tree and git-dir.
> 
> Answering myself...
> 
> This is because you know receive-pack runs inside the $GIT_DIR,
> whether it is a bare or non-bare repository, so either core.worktree
> points at a directory that is otherwise unrelated to the $GIT_DIR
> (but is the correct $GIT_WORK_TREE), or the top of the working tree
> must be ".." for a non-bare repository.  I haven't checked the code,
> but we probably are not even doing the repository/working-tree
> discovery to set up the data necessary for get_git_work_tree() to
> give us a correct answer.

Excellent analysis. Indeed, we do not enter the
setup_git_directory_gently() path that would interpret core.worktree and
call set_git_work_tree() explicitly. Instead, we are using the
enter_repo() code path in cmd_receive_pack() because only minimal setup is
required for the default operation of git receive-pack.

> Doing an optional set-up to make get_git_work_tree() work would
> involve more damage to the codebase than necessary, I would suspect,
> so let's keep this part of the code as-is.

Indeed, that is the exact reason why I did not want to go down that rabbit
hole. There are so many things that are skipped when using enter_repo()
instead of setup_git_directory() that the performance impact of switching
alone would probably pose a major regression for big hosters like GitHub
or Atlassian.

I have to admit also that I never used the work tree feature myself,
therefore the support for it is pretty much untested (I *think* that I
briefly tested it years ago, when I came up with the original
updateInstead patch, but that is *long* ago). We could of course simply go
the safe route and error out if we detect that git_work_tree_cfg is set,
leaving the work to support it and to add a proper unit test to somebody
who actually needs this. Hmm?

Ciao,
Johannes
