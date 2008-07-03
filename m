From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 0/3] Making remote tracking statistics available to other
 tools
Date: Thu, 03 Jul 2008 18:26:11 +0200
Message-ID: <486CFDA3.9070704@free.fr>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net> <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org> <7v3amsg1wx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 18:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KERdm-0001DF-89
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 18:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbYGCQZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 12:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYGCQZk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 12:25:40 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:55753 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbYGCQZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 12:25:39 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 85B9E12B746;
	Thu,  3 Jul 2008 18:25:38 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0134812B75C;
	Thu,  3 Jul 2008 18:25:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v3amsg1wx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87295>

Junio C Hamano a =E9crit :
> The one I sent out was a bit hacky as the existing implementation ins=
ide
> git-checkout was not designed to be cleanly reusable.
>=20
> Here is a cleaned up series that could be applied.
>=20
> [PATCH 1/3] Refactor "tracking statistics" code used by "git checkout=
"
> [PATCH 2/3] git-status: show the remote tracking statistics
> [PATCH 3/3] git-branch -v: show the remote tracking statistics

Sorry, but the third patch does not work for me. FWIU, the problem come=
s from
the revision walking code that is not reentrant because of the object c=
ache.
IOW, calling stats_tracking_info() more than once does not work: object=
s
states changed after first call.

I do not understand the code enough yet and I failed to fix it. The onl=
y way
I found is by clearing obj_hash (object.c) but this seems the wrong thi=
ng to
do.

Ideas?

This test case should trigger the bug:

$ for i in a b c; do echo $i>$i && git add $i && git commit -m $i; done
$ git clone . clone1
$ cd clone1
$ git checkout -b b1 origin/master
$ git reset --hard HEAD~
$ echo d>d && git add d && git commit -m d
$ git checkout -b b2 origin/master
$ git reset --hard HEAD~
$ git merge b1

$ git branch -v
  b1     c07015a [ahead 1, behind 1] d
* b2     c07015a d
  master 08ca18b c

b1 and b2 are both 1 commit ahead and 1 commit behind.

$ git branch -D b1
$ git branch -v
* b2     c07015a [ahead 1, behind 1] d
  master 08ca18b c

deleting b1 show us the side effect.

Olivier.
