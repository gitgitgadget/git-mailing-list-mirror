From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/4] t5520-pull: --rebase with rebased upstream and two branches
Date: Thu, 11 Jun 2009 16:19:20 -0700
Message-ID: <7vhbymfjev.fsf@alter.siamese.dyndns.org>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
	<1244759961-4750-4-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 01:19:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEtYS-0002Ld-7m
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113AbZFKXTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 19:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758295AbZFKXTT
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:19:19 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36499 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbZFKXTT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 19:19:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611231922.SLEV20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jun 2009 19:19:22 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2nKL1c00G4aMwMQ03nKLdM; Thu, 11 Jun 2009 19:19:20 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=FZkQkW6ZZZMA:10 a=LDPNlgZvRcQA:10
 a=3yCQnsJiAAAA:8 a=6wqmeBXHFk5yd6he-n8A:9 a=zkj1xB1TCGqG_U2hwdMA:7
 a=7rYb7o7r5lU1sLrHsHuJJhkNieEA:4 a=cdoSpQTWPqQA:10
X-CM-Score: 0.00
In-Reply-To: <1244759961-4750-4-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Fri\, 12 Jun 2009 00\:39\:20
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121373>

Santi B=C3=A9jar <santi@agolina.net> writes:

> If you have two branches tracking an upstream that is rebased,
> currently you have to do:
>
> git checkout branch1
> git pull --rebase remote branch
> git checkout branch2
> git pull --rebase remote branch

I think the "ah, I see it rebased" computation is done at a wrong place
for the above to work.  You do not even have to do two pull--rebase; I
think you can simply do "git fetch; git pull --rebase" to break it.

My understanding of the current code we have since c85c7927 is that it =
was
done as a quick-and-dirty hack that is merely good enough for CVS style
history where everybody is linear.  Grabbing where it used to be last t=
ime
we looked at before the fetch, and assuming it is the correct original
fork point, will never work, if you updated the remote tracking ref
outside of the current invocation of "pull --rebase" (if everybody is
linear, you by definition have one single branch, so in that special ca=
se,
the hack may happen to work, if you do not fetch).

If you want to fix this, I think you need to use the knowledge of where
the tip of remote/$origin/$branch used to be.  That is kept in the refl=
og
of that remote tracking ref.  So perhaps

 (0) Lose "oldremoteref=3D..." before "git fetch" happens in git-pull.s=
h;

 (1) just before "exec git-rebase", check rtb@{1} is an ancestor of rtb=
,
     if so be happy;

 (2) otherwise, in the same place, for some (hopefully small) posint n,
     see if rtb@{n} is an ancestor of rtb; use that as the "oldremotere=
f"
     when invoking "git-rebase".

where rtb =3D=3D remote tracking branch.
