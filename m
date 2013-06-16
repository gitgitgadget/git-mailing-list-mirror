From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH RFC] git-remote-mediawiki: push-by-rev
Date: Sun, 16 Jun 2013 22:49:16 +0200
Message-ID: <vpq8v29eq7n.fsf@anie.imag.fr>
References: <1371414499-13027-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 16 22:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoJt6-0002PJ-3s
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 22:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3FPUtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Jun 2013 16:49:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37356 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab3FPUtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 16:49:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5GKnEf1017488
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 22:49:14 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoJsy-0003zq-D0; Sun, 16 Jun 2013 22:49:16 +0200
In-Reply-To: <1371414499-13027-1-git-send-email-celestin.matte@ensimag.fr>
	(=?iso-8859-1?Q?=22C=E9lestin?= Matte"'s message of "Sun, 16 Jun 2013
 22:28:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 16 Jun 2013 22:49:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228028>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> This uses subroutines used by the fetch-by-rev strategy. I'm not sure=
 it's
> actually complete: can it be that simple?

The function says:

  # Get the last remote revision without taking in account which pages =
are
  # tracked or not. This function makes a single request to the wiki th=
us
  # avoid a loop onto all tracked pages. This is useful for the fetch-b=
y-rev
  # option.
  sub get_last_global_remote_rev {
  ...

So I don't think this would work when you track only a subset of pages.
If an untracked page has been modified, then the global last revision
has increased and you'll get a non-fast forward. If you try to pull,
it'll tell you there's nothing to import.

You'd have to iterate through revisions between the one given by
get_last_global_remote_rev and the last one the local repo knows about,
and remove ones touching untracked pages from the list.

> However, I tested on a local wiki and it seemed to work perfectly.
> Should I add associate tests?

See what t/t9364-pull-by-rev.sh does. You can set pushStrategy too in
the same file (this won't test all push/pull combinations, but push and
pull should be independant enough, so testing both unset and both set
should be enough).

Not sure we have enough test for push with a subset of pages though.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
