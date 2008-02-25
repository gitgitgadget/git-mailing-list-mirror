From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move worktree setup out of setup_git_directory*
Date: Sun, 24 Feb 2008 17:13:52 -0800
Message-ID: <7vr6f1sur3.fsf@gitster.siamese.dyndns.org>
References: <20080224044650.GA25343@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 02:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTRw1-0003zY-33
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 02:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYBYBOL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 20:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYBYBOK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 20:14:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbYBYBOJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2008 20:14:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5082625B9;
	Sun, 24 Feb 2008 20:14:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3F42D25B8; Sun, 24 Feb 2008 20:14:00 -0500 (EST)
In-Reply-To: <20080224044650.GA25343@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message of "Sun, 24 Feb 2008 11:46:51
 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74979>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> setup_git_directory* now work as if there is no worktree.  It may set
> some worktree-related variables but its prefix (and current directory=
)
> should not be affected by worktree settings.
> ...
> setup_work_tree() will now take the role of recalculating prefix when
> worktree is required.

This definitely needs documented in-tree, Documentation/technical/.

I think we have a good understanding from the end-user point-of-view
how these things work:

 - If you have GIT_DIR exported, then no discovery is attempted.
   We use the GIT_DIR you set it, and the repository lives
   there.  $GIT_DIR/config is the repository config.

 - Otherwise we do the usual discovery going up to find the
   repository.

 - If you have GIT_WORK_TREE exported, or otherwise if the
   config has core.worktree, that's where your worktree is.
   Otherwise, if you have GIT_DIR exported, you do not have a
   worktree.  Else one level above your $GIT_DIR is the toplevel
   of your worktree.

We would need a set of rules for application writers, written
like this (here is just an example of _how_ the rules might be
written, I do not think the contents are correct):

 - At startup:

   - If the command always need to run from a repository, call
     setup_git_directory(), which would complain and die if you
     are outside.

   - If the command can optionally run in a repository, use
     setup_git_directory_gently(&nongit_ok); it won't complain
     but sets nongit_ok to true if run outside a repository.

   In either case, they return prefix string to be used for
   setup_work_tree() later.

   In either case, there is no chdir() done at this point.

 - After calling setup_git_directory(), or you made sure you are
   in a repository after callilng setup_git_directory_gently(),
   call setup_work_tree().  This will chdir to the top of the
   work tree.

 - When you need to know where $GIT_DIR is, call get_git_dir().
   When you need to know where the work tree is, call
   get_git_work_tree().  However, it is an error to call these
   functions before calling setup_git_directory and
   setup_work_tree.
