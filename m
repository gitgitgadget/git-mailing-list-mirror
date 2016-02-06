From: Matt McCutchen <matt@mattmccutchen.net>
Subject: update_linked_gitdir writes relative path to
 .git/worktrees/<id>/gitdir
Date: Sat, 06 Feb 2016 15:12:28 -0500
Message-ID: <1454789548.23898.223.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 07 09:15:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSKVL-00042D-AP
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 09:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbcBGIPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 03:15:31 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:51179 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbcBGIP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 03:15:29 -0500
X-Greylist: delayed 43375 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Feb 2016 03:15:29 EST
Received: from homiemail-a14.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
	by hapkido.dreamhost.com (Postfix) with ESMTP id C6109A92D7
	for <git@vger.kernel.org>; Sat,  6 Feb 2016 12:12:33 -0800 (PST)
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id 597EE392077
	for <git@vger.kernel.org>; Sat,  6 Feb 2016 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	message-id:subject:from:to:date:content-type:mime-version:
	content-transfer-encoding; s=mattmccutchen.net; bh=jOI0NP8U6By04
	yj4QIHEG5p7pGw=; b=SAcHK8r5EKesYrDl/EFtY0a71xys9dOhTqA9T3OvHBTtV
	XlUD4tjVWpHO3yFtQzonVsggaX24Csl9xoadOhkaxWsgxDc4B42YC05t/3xFapYm
	T3WRjjFY9rUybTC74MOOgFXSelmADKTn5RtKHwOKO1PoX8/ZivN8Yi4PmKKtik=
Received: from main (dhcp-18-189-13-223.dyn.mit.edu [18.189.13.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 13632392075
	for <git@vger.kernel.org>; Sat,  6 Feb 2016 12:12:32 -0800 (PST)
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285717>

I noticed that when update_linked_gitdir chooses to update
=2Egit/worktrees/<id>/gitdir, the path it writes is relative, at least
under some circumstances. =C2=A0This contradicts the gitrepository-layo=
ut
man page, which says:

worktrees/<id>/gitdir::
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A text file containing =
the absolute path back to the .git file
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0that points to here.

IIUC, this behavior defeats one of the three safeguards that is
supposed to prevent "git worktree prune" from pruning information for
worktrees that still exist.

A simple script to reproduce:

#!/bin/bash
set -e -x
rm -rf repo worktree2
git init repo
cd repo
touch foo
git add foo
git commit -m 'dummy commit'
git worktree add ../worktree2 -b branch2
cat .git/worktrees/worktree2/gitdir
touch -d '2 days ago' .git/worktrees/worktree2/gitdir
(cd ../worktree2 && git status)
cat .git/worktrees/worktree2/gitdir

Trying this on master as of earlier today (ff4ea60), I get:

[...]
/PATH/REDACTED/worktree2/.git
[...]
=2Egit

Matt
