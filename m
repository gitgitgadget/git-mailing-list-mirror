From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
	available repositories
Date: Wed, 28 Jul 2010 18:52:49 -0500
Message-ID: <20100728235249.GA29156@dert.cs.uchicago.edu>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu> <20100726232855.GA3157@burratino> <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com> <201007270916.59210.j.sixt@viscovery.net> <20100727174105.GA5578@burratino> <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com> <20100728003336.GA2248@dert.cs.uchicago.edu> <AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com> <20100728064251.GB743@dert.cs.uchicago.edu> <1280358894.31999.9.camel@balanced-tree>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Brockman <gdb@mit.edu>, Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Jul 29 01:53:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeGQj-000815-A4
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 01:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab0G1Xww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 19:52:52 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:33604 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0G1Xwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 19:52:51 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 4ABBFA1E2;
	Wed, 28 Jul 2010 18:52:50 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 14CD06914; Wed, 28 Jul 2010 18:52:49 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280358894.31999.9.camel@balanced-tree>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152130>

Anders Kaseorg wrote:
> On Wed, 2010-07-28 at 01:42 -0500, Jonathan Nieder wrote:

>> (if you use getpwent instead of getenv to fetch $HOME).
>
> That seems like it could lead to problems with multiple users with th=
e
> same UID, and possibly also on Windows.  If it=E2=80=99s important to=
 be
> paranoid here, what about all the other places Git already uses
> getenv("HOME"), including where it reads ~/.gitconfig?

Thanks for a sanity check.  I do not see the multiple-user problem
(git-shell is meant to be the login shell, no?) but I think you are
right about using getwpwent instead of $HOME being a pointless
precaution.  My confusion came from a misreading of how 'su' works.

Here was my worry: that a user could do something like this:

 $ mkdir /tmp/git-shell-commands
 $ ln -s /bin/sh /tmp/git-shell-commands/sh
 $ HOME=3D/tmp su git -m -c sh;		# (1)

and get a shell with the privileges of the user with git-shell
as login shell, which is exactly what a restricted shell like
this should be preventing.

Now if that is possible, what is to stop me from this?

 $ PAGER=3Devilscript su git -m -c git-receive-pack --help; # (2)

which became possible (modulo the su bit) as an unintended
consequence when receive-pack became builtin.

If I understand the manual correctly, then at least on some
systems, luckily su protects correctly against such problems.

	-m
		Preserve the current environment.

		If the target user has a restricted shell,
		this option has no effect (unless su is
		called by root).

Is that behavior portable?  It certainly seems like the
only sane way to behave.  It=E2=80=99s a moot question for the
inclusion of this patch series: if we need to worry about
(1), then it is still not a regression because (2) was possible
already.

The same discussion would seem to apply to ssh with
PermitUserEnvironment enabled.
