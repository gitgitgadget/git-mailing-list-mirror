From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: GNU-style ChangeLog merge driver for Git (was: Re: git: avoiding merges, rebasing)
Date: Tue, 9 Oct 2007 20:19:51 +0200
Message-ID: <BC06CC09-FD81-4153-AA54-A1A74250946B@lrde.epita.fr>
References: <200709301421.52192.bruno@clisp.org> <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr> <07BCEF3E-90DE-4BB7-8A8C-F03D12293B5F@lrde.epita.fr> <200710091403.26047.bruno@clisp.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7-1045910236"
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git list <git@vger.kernel.org>
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 20:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfJh6-0006vg-Qd
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 20:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbXJISU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 14:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbXJISU1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 14:20:27 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:49359 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbXJISU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 14:20:26 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IfJgu-0004S9-8e; Tue, 09 Oct 2007 20:20:24 +0200
In-Reply-To: <200710091403.26047.bruno@clisp.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60426>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7-1045910236
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 9, 2007, at 2:03 PM, Bruno Haible wrote:

> Hello Benoit,
>
> Thanks for working on this. But this merge driver has a few major  
> nits.
>
>
> 1) While my ChangeLog file was locally unmodified but some pulled  
> in commits
>    should modify it, "git pull" stopped and said:
>
> ChangeLog: needs update
> fatal: Entry 'ChangeLog' not uptodate. Cannot merge.
>
> [I cannot swear on this, because I did not do a "git status" before  
> the
> "git pull", but this is in a directory where I usually have no  
> pending diffs.]

I'll check but I'm afraid that Git bails out before actually trying  
the merge driver.

>
> The ChangeLog in question is the one from gnulib
> (git clone git://git.sv.gnu.org/gnulib).
>
>
> 2) This "merge driver" did much more than sorting in a merge: it  
> sorted the
> entire file! In doing so,
>   - It changed the order of ChangeLog entries in a way that does  
> not represent
>     the historical commit order.
>   - For ChangeLog entries with multiple contributors, it shuffled  
> around these
>     extra contributors to other ChangeLog entries.
>   - Near the end of the file, it made a change that I cannot explain.
>
> Find attached a context diff of all the bad changes that it did.
>

Yes, it's pretty stupid, I hacked this in a hurry.  I'll try to  
improve it so that it doesn't have these undesired side-effects.

>
> In my opinion, a merge driver should not do changes to the file except
> in the range of lines where the conflict occurred. For a ChangeLog  
> driver,
> all uncommitted entries should be collected at the top of the file,  
> because
> 1. ChangeLogs are kept in the order of historical commit in the  
> central
>    repository,
> 2. other developers always look at the top of the ChangeLog; if a  
> ChangeLog
>    entries is inserted second or third after some already present  
> entries,
>    the danger is too high that the change gets unnoticed.
>
> So "git-merge-changelog OLD CURRENT OTHERS" should IMO do the  
> following:
> 1) Collect the changes between OLD and HEAD (I don't know if that  
> is CURRENT
>    or OTHERS?), in two categories:
>      - added entries,
>      - changed and removed entries.
> 2) Back out the added entries, keeping only the changed and removed  
> entries
>    as modifications.
> 3) Do a normal merge between this and the pulled in remote branch  
> (I don't
>    know if that is OTHERS or CURRENT?). If that merge gives a  
> conflict,
>    bail out.
> 4) Insert the added entries at the top, in the same order as they were
>    originally (no sorting).
>
> Bruno
> <git-merge-changelog-blunder>

OK I'll try to rework the driver so that it implements this.  It will  
take some time though, I'm quite busy these days.
Akim Demaille would also like it to squash the commits added by the  
merge (the new commits in OTHERS):

YYYY-MM-DD  Author  <who@where.com>

	Merge whatever:

	YYYY-MM-DD  Someone Else  <foo@bar.com>
	Some change.
	* FileChanged.c: Whatever.

	YYYY-MM-DD  Who Cares  <who@cares.com>
	Some other change.
	* OtherFile.c: Do it.

I thought this was mandated by the GNU Coding Standards but I  
checked, it doesn't say anything about merges.  Would this sort of  
strategy be useful to you?  Should it be default (or enabled by some  
--squash option)?

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-7-1045910236
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHC8ZHwwE67wC8PUkRAj07AKDSR1CpZ6aI7s+1OITtd4pcDqAfPgCfXVdB
gDirXwRy+us04KvbIlPwNY4=
=9Ltz
-----END PGP SIGNATURE-----

--Apple-Mail-7-1045910236--
