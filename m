From: Yann Dirson <dirson@bertin.fr>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 15:00:15 +0200
Organization: Bertin Technologies
Message-ID: <20100420150015.4bd80387@chalon.bertin.fr>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <loom.20100420T085842-887@post.gmane.org>
 <20100420115124.GB22907@coredump.intra.peff.net>
 <20100420120228.GM17930@lake.fysh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Zefram <zefram@fysh.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 15:09:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4DCq-00087Q-RP
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 15:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab0DTNJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 09:09:25 -0400
Received: from blois.bertin.fr ([195.68.26.9]:32812 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444Ab0DTNJY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 09:09:24 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2010 09:09:24 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 96CDF545D5
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 15:02:47 +0200 (CEST)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 727AD545D1
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 15:02:47 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.3.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0L16009CQEWNSV80@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 20 Apr 2010 15:02:47 +0200 (CEST)
In-reply-to: <20100420120228.GM17930@lake.fysh.org>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.12.12; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8146-6.0.0.1038-17330.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145373>

Le Tue, 20 Apr 2010 13:02:28 +0100,
Zefram <zefram@fysh.org> a =C3=A9crit :

> Jeff King wrote:
> >  2. Make a refs/dead hierarchy so that the reflogs don't interfere
> > with new branches. This just pushes off the problem, though, for
> > when you try to delete "foo/bar" and see that "refs/dead/foo" is
> > already blocking its spot in the reflog graveyard.
>=20
> This is easily solved by tweaking the name for dead reflogs.
> logs/dead_refs/foo~ doesn't clash with logs/dead_refs/foo/bar~.
>
> You might also want to stick a sequence number into the filename, for
> when you delete more than one foo/bar branch.

That sounds cool.  A logs/dead_refs/ namespace of some sort seems to be
unavoidable, to avoid the clash between old "logs/refs/foo/bar~"
and new "logs/refs/foo".

We would also need a syntax for accessing those.  Maybe something
reminiscent of Debian "epochs" in version number.  That would
give a syntax like "foo@{1:1}" and "foo@{2:1}" to access the dead and
long-dead refs' logs, respectively looking into foo~<largest> and
foo~<largest-1>.

Going that way, we would probably want to add a "delete" entries in the
reflog when deleting a ref - but that would make "foo@{1:0}" a
non-sense, we could just reject it.


Another option than adding a sequence number would be to move back the
dead_refs/ log back to refs/ when the branch is creating again.  That
way just after resurection we have:

	foo@{0}	: now
	foo@{1} : invalid (deleted state)
	foo@{2} : the ref as it was 2 operations before

That would kinda make sense too, but then if the new "foo" is something
completely unrelated, we may rather want to refer to foo{1:1}
(which is stable until next deletion of foo) rather than foo@{2}, which
varies with current foo.  But the 1st solution could give us that too,
by considering logs/dead_refs/foo~ the logical continuation of
logs/refs/foo.

Would that make sense ?
--=20
Yann
