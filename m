From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: $(git notes merge FETCH_HEAD) doesn't work
Date: Thu, 20 Feb 2014 16:30:45 +0100
Message-ID: <20140220153045.GI6988@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de, Johan Herland <johan@herland.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 20 16:31:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGVaj-0001Ig-J2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 16:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbaBTPa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 10:30:56 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48645 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbaBTPay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 10:30:54 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1WGVaM-0005uN-0P; Thu, 20 Feb 2014 16:30:50 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.82)
	(envelope-from <ukl@pengutronix.de>)
	id 1WGVaH-0006zU-64; Thu, 20 Feb 2014 16:30:45 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242434>

Hello,

I started playing around with sharing git notes and so was happy to see
that git-notes learned about merging since I last tried.

My first try looked as follows (using git 1:1.9.0-1 from Debian):

	$ git fetch $someremote refs/notes/commits
	...
	$ git notes merge FETCH_HEAD
	$ echo $?
	0
	$ git log --oneline refs/notes/commits..FETCH_HEAD | wc -l
	2

Looking at the source I see:

	/* argv[0] holds "FETCH_HEAD" here */
	strbuf_addstr(&remote_ref, argv[0]);
	expand_notes_ref(&remote_ref);

After the call to expand_notes_ref remote_ref contains
"refs/notes/FETCH_HEAD" which isn't what I intended and I'm quite
surprised by. The problem seems to be:

	/* Dereference o->remote_ref into remote_sha1 */
	if (get_sha1(o->remote_ref, remote_sha1)) {
		/*
		 * Failed to get remote_sha1. If o->remote_ref looks like an
		 * unborn ref, perform the merge using an empty notes tree.
		 */
		if (!check_refname_format(o->remote_ref, 0)) {
			hashclr(remote_sha1);
			remote =3D NULL;
		} else {
			die("Failed to resolve remote notes ref '%s'",
			    o->remote_ref);
		}
	} ...

The workaround is obvious (i.e. git update-ref refs/notes/somestring
=46ETCH_HEAD; git notes merge somestring), but still I think this
behaviour is not optimal. I don't know why one might want to treat a
broken remote side as empty but at least a diagnostic message would be
nice. The same happens if I pass an explicit sha1 instead of
"FETCH_HEAD".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
