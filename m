From: Yves Orton <yves.orton@booking.com>
Subject: git-fast-export bug, commits emmitted in incorrect order causing
	parent data to be lost from commits turning essentially linear repo into
	"islands"
Date: Thu, 12 Jun 2008 12:21:40 +0200
Message-ID: <1213266100.6940.207.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 13:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6kb7-00040S-NE
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 13:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbYFLLDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 07:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbYFLLDL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 07:03:11 -0400
Received: from msx1.activehotels.net ([62.190.24.9]:33714 "EHLO
	mx1.activehotels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753909AbYFLLDK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 07:03:10 -0400
X-Greylist: delayed 2482 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 07:03:09 EDT
Received: from p5098d9db.dip0.t-ipconnect.de ([80.152.217.219] helo=[192.168.250.20])
	by mx1.activehotels.net with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.50)
	id 1K6jw5-0004fL-M0
	for git@vger.kernel.org; Thu, 12 Jun 2008 11:21:42 +0100
X-Mailer: Evolution 2.22.2 
X-AH-Spam-Helo: [192.168.250.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84741>

Hi,

Ive been working with git-fast-export a bit recently and Ive hit a bug
that is causing some trouble.=20

Essentially it seems that one of our repos git-fast-export fails to emi=
t
the proper 'from' information for several commits in the repo. These
commits are emitted first without parent data even though their parents
ARE emitted later.

The code responsible for skipping the parent info is in

builtin-fast-export.c around line 402:

        for (i =3D 0, p =3D commit->parents; p; p =3D p->next) {
                int mark =3D get_object_mark(&p->item->object);
                if (!mark)
                        continue;
                if (i =3D=3D 0)
                        printf("from :%d\n", mark);
                else
                        printf("merge :%d\n", mark);
                i++;
        }

If i modify this loop to warn when skipping a parent I get a warning fo=
r
each of the "broken" commits. Apparently because they are emitted befor=
e
their parents the parents have no "mark" assigned to them (via
decoration) and thus are skipped in this emit process. This would make
sense for emitting a limited number of patches, but makes no sense when
the --all option is used. Ive tried to investigate further but i got
lost in a twisty maze of routines in revision.c, which apparently is
responsible for building a list of items to emit in the correct order.=20

However i think it is notable that both gitk and git log seem quite abl=
e
to deal with things properly, thus i find it a bit strange that
fast-export would get it wrong.

Unfortunately I have no idea how to create a minimal repo that
illustrates this problem.=20

Im currently on git version 1.5.6.rc2.29.g3ba9 (latest version from las=
t
night), however this problem shows itself on 1.5.4.3 as well, as well a=
s
an earlier version whose exact number i no longer know.=20

Other evidence that might be useful

	=EF=BB=BFgit log --pretty=3Dformat:"%H:%P"=20

shows that every commit but one (the root) has parents. And gitk render=
s
the original repo fine. The repo can be cloned and etc, without trouble=
=2E
The problem seems to be strictly related to fast-export.

Im not on list so please cc me on any replies.=20

Thanks a lot!
Yves
