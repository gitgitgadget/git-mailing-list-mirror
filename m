From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 10/13] bash prompt: combine 'git rev-parse' executions
Date: Tue, 18 Jun 2013 11:49:31 +0200
Message-ID: <20130618094931.GB2204@goldbirke>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
 <1371521826-3225-11-git-send-email-szeder@ira.uka.de>
 <20130618060535.GE5916@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 11:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UosXo-0006bY-Ee
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 11:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425Ab3FRJth convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 05:49:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51550 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab3FRJte (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 05:49:34 -0400
Received: from localhost6.localdomain6 (g230129165.adsl.alicedsl.de [92.230.129.165])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Mhegl-1Ucakx1ZeV-00MHwD; Tue, 18 Jun 2013 11:49:32 +0200
Content-Disposition: inline
In-Reply-To: <20130618060535.GE5916@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:BBQr/23f/oE814Wqbc1nvVa4UrNmthlcwb+ZNPGODA8
 NhYybcPckhWiuYOPZ4qKBa9tdVqzA7pn+ACV1HgCQftL6eJ0kv
 2aj0Bm1wKaTA3lQW29/1dBpFuiBQZD5RCdhPNIsqZfaWzBeEi5
 56BvM758VcI8S20KwnPEzRWB54MY3LEuCb5BPFGFzOwSAV7+3U
 Ff9/3zGi02nVYE9l1IYZ2LA+V0ajYi7Th843qTVnSiApy1/RLP
 1culQ6xnwEXNxT/KSFojbT/o/tV5XTlQDy+x8K0/hiVFIEbb0V
 0AXzhfOvnfBtJFybtNH+xwBS/6NrllpNtW8esAY3q+Hn+MN0Ck
 3VEZ5cwBCKaoXUJ/APVg6VuPJgHo4efod0AXhmcnK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228180>

On Tue, Jun 18, 2013 at 02:05:35AM -0400, Jeff King wrote:
> On Tue, Jun 18, 2013 at 04:17:03AM +0200, SZEDER G=E1bor wrote:
>=20
> > The whole series speeds up the bash prompt on Windows/MSysGit
> > considerably.  Here are some timing results in two scenarios, repea=
ted
> > 10 times:
> >=20
> > At the top of the work tree, before:
> >=20
> >     $ time for i in {0..9} ; do prompt=3D"$(__git_ps1)" ; done
> >=20
> >     real    0m1.716s
> >     user    0m0.301s
> >     sys     0m0.772s
> >=20
> >   After:
> >=20
> >     real    0m0.686s
> >     user    0m0.075s
> >     sys     0m0.287s
> >=20
> > In a subdirectory, during rebase, stash status indicator enabled,
> > before:
> >=20
> >     real    0m3.557s
> >     user    0m0.495s
> >     sys     0m1.767s
> >=20
> >   After:
> >=20
> >     real    0m0.702s
> >     user    0m0.045s
> >     sys     0m0.409s
>=20
> Very nice speedup (or perhaps it is a testament to how bad fork() is =
on
> msys).

Well, it seems it's not just fork() & friends.  The latter case on
Linux, before:

  $ time for i in {0..99}; do prompt=3D"$(__git_ps1)" ; done
 =20
    real    0m2.819s
    user    0m0.180s
    sys     0m0.272s

  After:
 =20
    real    0m0.787s
    user    0m0.000s
    sys     0m0.044s

If you look solely at speedup (Win/MSys: 80%, Linux: 72%), Linux isn't
that much better either, but overall it's about an order of magnitude
faster to begin with (100 repetitions vs. 10).

Btw, it could still be a bit faster in you would care to change your
prompt to run from $PROMPT_COMMAND, because it would avoid that final
$(__git_ps1) command sunstitution, too.  But I didn't measured that
because I find the interface awful ;)  (Hmm, speaking of which, the
patch reading HEAD might break setups using $PROMPT_COMMAND, because
it might do a simple return without updating $PS1...)

> Reading patches 8 and 9, I can't help but feel that "git status"
> is letting us down a little by making us parse all of this data
> ourselves. In theory, __git_ps1() could just be something like:
>=20
>   eval "$(git status --shell)"
>   printf ...
>=20
> and the heavy lifting could be done in a single C process which does =
not
> have to worry about fork overhead. But that is quite far from where w=
e
> are now, so while it might be an interesting place to go in the futur=
e,
> I do not think such dreams would want to hold up current work.

Yeah, that would be one way to go.  It would have the added benefit
that it could support 'core.abbrev' in the non-describable detached
HEAD case without noticable overhead.

OTOH it still requires a command substitution and a git command, so
it's less than ideal.  The previous version of this series more than a
year ago did some tricky things to create a prompt without a single
fork(), let alone exec(), e.g. looking for .git directory with bash
builtins, comparing pwd's prefix with path to .git dir to find out
whether inside .git dir, etc.  As a result even that
subdir+rebase+stash case could be done in 10ms on Windows.  Too bad
that that "inside .git dir" check could misfire on case insensitive
file systems, so we have to do that check with '$(git rev-parse)'.

  http://thread.gmane.org/gmane.comp.version-control.git/197432/focus=3D=
197450


G=E1bor
