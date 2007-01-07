From: Baz <brian.ewins@gmail.com>
Subject: [BUG] cogito: cg-push fails when using stg
Date: Sun, 7 Jan 2007 18:57:34 +0000
Message-ID: <2faad3050701071057s2d4b55dcp4e957db6846a54e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 07 19:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3dD9-0001Tf-KH
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 19:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbXAGS5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 13:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbXAGS5g
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 13:57:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:29730 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964910AbXAGS5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 13:57:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6066227uga
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 10:57:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N4Vnu7b8E9N6Prbf6u2U24Ax28CsdK8FZLtXKtv86A0PIm6K8EcNu/E80PQt+oXDVoquywGqLRJJ+0AmjantIGK1vtcMQKgV0FNVx0GSzkD8Q3rRqI4LCQTKdv1XyR0sUmBfSghwnsnyVJTvBiDn165t6fs7N1FiLUDWbCCMnMk=
Received: by 10.67.22.14 with SMTP id z14mr32413327ugi.1168196254713;
        Sun, 07 Jan 2007 10:57:34 -0800 (PST)
Received: by 10.66.221.1 with HTTP; Sun, 7 Jan 2007 10:57:34 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36184>

Hi,
I've been using cogito and stg together on cairo and I ran into
problems attempting to do a cg-push.

$ cg-push
error: src refspec master matches more than one.
fatal: unexpected EOF

It turns out this is matching refs/heads/master and refs/bases/master;
the second of these is an stg artifact, but not the current branch. I
think there's a bug in cogito here, in cg-Xlib:

[ ! -s "$_git/HEAD" ] || { _git_head="$(git-symbolic-ref HEAD)";
_git_head="${_git_head#refs/heads/}"; }

This sets _git_head (which is eventually used as the src refspec for
the cg-push) to the unambiguous refs/heads/master, but then makes it
ambiguous again by stripping off the prefix.

You can work around this by doing:
cg-push -r refs/heads/master

which is just as odd, since thats a refspec, not a branch name - the
same logic to resolve the name isn't being applied. So alternatively,
the bug is here (in cg-push):
locbranch="$_git_head"
... should be
locbranch="refs/heads/$_git_head"
and
locbranch="$OPTARG"
should be
locbranch="refs/heads/$OPTARG"

Comments?

Baz
