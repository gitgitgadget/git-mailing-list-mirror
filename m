From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Wed, 17 Aug 2011 00:30:23 +0000
Message-ID: <20110817003023.GA30153@dcvr.yhbt.net>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
 <7vty9ijs1i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 02:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtUBE-0007k0-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 02:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab1HQAkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 20:40:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45861 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab1HQAkT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 20:40:19 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Aug 2011 20:40:19 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCC121191;
	Wed, 17 Aug 2011 00:30:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vty9ijs1i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179490>

Junio C Hamano <gitster@pobox.com> wrote:
> Fr=C3=A9d=C3=A9ric Heitzmann  <frederic.heitzmann@gmail.com> writes:
>=20
> > The 'pre-svn-dcommit' hook is called before 'git svn dcommit', whic=
h aborts
> > if return value is not zero. The only parameter given to the hook i=
s the
> > reference given to 'git svn dcommit'. If no paramter was used, hook=
 gets HEAD
> > as its only parameter.
>=20
> It appears that this is in the same spirit as the pre-commit hook use=
d in
> "git commit", so it may not hurt but I do not know if having a separa=
te
> hook is the optimal approach to achieve what it wants to do.
>=20
> I notice that git-svn users have been happily using the subsystem wit=
hout
> need for any hook (not just pre-commit). Does "git svn" need an equiv=
alent
> of pre-commit hook? If so, does it need equivalents to other hooks as
> well? I am not suggesting you to add support for a boatload of other =
hooks
> in this patch---I am trying to see if this is really a necessary chan=
ge to
> begin with.
>=20
> Eric, do you want this one?

I'm not sure.  I feel hooks should be avoided whenever possible, and
a git-svn-specific hook for dcommit wouldn't place the same restriction
as a server-side SVN hook for svn(1) users.

Preventing certain commits from accidentally hitting the SVN server can
be useful, I think.  On the other hand, I'm not sure if people who run
accidental dcommits would remember to the pre-dcommit hook, either.

Perhaps an interactive option for dcommit would be just as useful?

Test cases are required for any new features of git-svn, though.

> > +	system($hook, $head);
> > +	if ($? =3D=3D -1) {
> > +		print "[pre_svn_dcommit_hook] failed to execute $hook: $!\n";
> > +		return 1;
> > +	} elsif ($? & 127) {
> > +		printf "[pre_svn_dcommit_hook] child died with signal %d, %s cor=
edump\n",
> > +		($? & 127),  ($? & 128) ? 'with' : 'without';
> > +		return 1;
> > +	} else {
> > +		return $? >> 8;
> > +	}
> > +}
>=20
> Should these messages go to the standard output?

=46ailure messages should definitely go to stderr.

--=20
Eric Wong
