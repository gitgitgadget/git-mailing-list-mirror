From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add missing inside_work_tree setting in setup_git_directory_gently
Date: Fri, 9 Nov 2007 11:32:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091129450.4362@racer.site>
References: <20071103100323.GA25305@laptop> <20071103131806.GA25109@laptop>
 <7vir4ivdcr.fsf@gitster.siamese.dyndns.org> <20071104070307.GA26071@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-784504316-1194607944=:4362"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqS6S-0006qs-Pk
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXKILce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXKILce
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:32:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:50955 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751903AbXKILcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:32:33 -0500
Received: (qmail invoked by alias); 09 Nov 2007 11:32:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 09 Nov 2007 12:32:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19y8Z8HuixyuaUSpQC5m5vsoLFg4ZIxG7rR3qoUyY
	fl2uTDj/ztXA3i
X-X-Sender: gene099@racer.site
In-Reply-To: <20071104070307.GA26071@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64167>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-784504316-1194607944=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 4 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Sat, Nov 03, 2007 at 09:33:40PM -0700, Junio C Hamano wrote:
> > Nguyễn Thái Ngọc Duy <pclouds@gmail.com> writes:
> > 
> > > When both GIT_DIR and GIT_WORK_TREE are set, and
> > > setup_git_directory_gently() changes the current working
> > > directory accordingly, it should also set inside_work_tree = 1.
> > >
> > > Without this, work_tree handling code in setup_git_directory()
> > > will be activated. If you stay in root work tree (no prefix),
> > > it does not harm. It does if you work from a subdirectory though.
> > 
> > Please add automated test script for this, thanks.
> > 
> 
> Thank you for reminding.  I tried to put a test in
> t1501-worktree.sh and found out core.worktree can override
> inside_work_tree previously set by setup_git_directory_gently(),
> activating the worktree code in setup_git_directory() again.
> 
> This made me think setup_git_directory_gently() should use
> get_git_work_tree() instead. But then git_work_tree_cfg may not be
> initialized when get_git_work_tree() is called (starting from
> setup_git_directory(), git_work_tree_cfg is initialized in
> check_repository_format_version(), which is called _after_
> setup_git_directory_gently()).
> 
> The interaction between these variables and functions is really beyond
> my knowledge. Johannes, can you have a look at this? In theory the
> following test should pass:
> 
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index 7ee3820..bdb7720 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -103,6 +103,11 @@ test_expect_success 'repo finds its work tree from work tree, too' '
>  	 test sub/dir/tracked = "$(git ls-files)")
>  '
>  
> +test_expect_success 'Try a command from subdir in worktree' '
> +	(cd repo.git/work/sub &&
> +	GIT_DIR=../.. GIT_WORK_TREE=.. git blame dir/tracked)
> +'
> +
>  test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE' '
>  	cd repo.git/work/sub/dir &&
>  	GIT_DIR=../../.. GIT_WORK_TREE=../.. GIT_PAGER= \

This does not really test work_tree, but if blame uses the work_tree 
machinery correctly.

I will send out a patch to builtin-blame.c in a minute.

However, this test case still fails, since blame needs a HEAD revision!  
And in t1501 there is no commit done yet.

Ciao,
Dscho

--8323584-784504316-1194607944=:4362--
