From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: BUG: git request-pull broken for plain branches
Date: Wed, 25 Jun 2014 11:55:35 +0200
Message-ID: <20140625095535.GA27365@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzjvh-0007KG-Aq
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 11:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124AbaFYJzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2014 05:55:45 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50632 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbaFYJzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 05:55:43 -0400
Received: from ptx.hi.pengutronix.de ([2001:6f8:1178:2:5054:ff:fec0:8e10] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1WzjvW-0006yF-3A; Wed, 25 Jun 2014 11:55:38 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1WzjvT-0001TW-TT; Wed, 25 Jun 2014 11:55:35 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:5054:ff:fec0:8e10
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252439>

Hello,

I have git from Debian's 2.0.0-2 package:

	$ git version
	git version 2.0.0

git request-pull is broken for me:

	$ git rev-parse HEAD
	9e065e4a5a58308f1a0da4bb80b830929dfa90b3
	$ git ls-remote origin | grep 9e065e4a5a58308f1a0da4bb80b830929dfa90b3
	9e065e4a5a58308f1a0da4bb80b830929dfa90b3	refs/heads/ukl/for-mainline
	$ git request-pull origin/master origin HEAD > /dev/null
	warn: No match for commit 9e065e4a5a58308f1a0da4bb80b830929dfa90b3 fou=
nd at origin
	warn: Are you sure you pushed 'HEAD' there?

The same happens on 2.0.0.421.g786a89d.

The problem is in git-request-pull.sh's find_matching_ref. This code ha=
s
more than one problem (looking on 2.0.0.421.g786a89d):

	- find_matching_ref doesn't assign to $found if none of the if
	  conditions in the loop match (this results in my problem);
	- find_matching_ref happily overwrites $found even if the
	  previous ref was better according to the metric specified
	  above the definition of find_matching_ref; and
	- the output generated uses $pretty_remote without asserting
	  that it matches $ref. In my case this results in a branch
	  specification of "HEAD" even if I fix find_matching_ref to
	  return refs/heads/ukl/for-mainline.

I tried to add this case to t/t5150-request-pull.sh, but didn't
understand how after starring at it for half an hour. :-(

Bisection points on 024d34cb0813 (request-pull: more strictly match
local/remote branches) as first bad commit. Apart from introducing the
warning, it also changes the branch spec from "ukl/for-mainline" (which
is correct) to the name of the current branch (which is bogus). Also
024d34cb0813 makes 5 out of 7 tests in t/t5150-request-pull.sh fail.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
