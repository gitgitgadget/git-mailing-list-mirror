From: Philip Hofstetter <phofstetter@sensational.ch>
Subject: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 15:20:48 +0100
Message-ID: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 15:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAlr2-0002hw-C0
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 15:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbZKROtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 09:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757292AbZKROtj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 09:49:39 -0500
Received: from mail.sensational.ch ([195.226.6.199]:53894 "EHLO
	mail.sensational.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242AbZKROti convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 09:49:38 -0500
X-Greylist: delayed 1712 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2009 09:49:38 EST
Received: from [209.85.160.53] (helo=mail-pw0-f53.google.com)
	by mail.sensational.ch with esmtp (Exim 4.50)
	id 1NAlPD-0006od-28
	for git@vger.kernel.org; Wed, 18 Nov 2009 15:21:11 +0100
Received: by pwj11 with SMTP id 11so709644pwj.12
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 06:21:09 -0800 (PST)
Received: by 10.140.172.20 with SMTP id u20mr657728rve.23.1258554068094; Wed, 
	18 Nov 2009 06:21:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133180>

Hello,

today, after working on a topic branch and trying to rebase it on top
of the updated master, the rebase failed, complaining about an invalid
email address.

Some investigating revealed an interesting quirk in git-mailinfo which
seems to be a bit too eager to extract author information: Instead of
just looking at the From:-Line in a mails header (git-rebase seems to
use git-am which in turn uses git-mailinfo), it searches for "from:"
*anywhere* in the mail and uses the last found information as the
source for the author information.

In this case, git-format-patch has generated a file that looks
something like this:

--------------8<---------------

=46rom d28f21ea8ca64681ba7756417799ceea81ad6873 Mon Sep 17 00:00:00 200=
1
=46rom: Foo Bar <foo@bar.com>
Date: Tue, 17 Nov 2009 15:27:25 +0100
Subject: blah, blah, blah

from:
- this is a
- list for stuff
---
 list/of/changed/files                   |    1 -
 list/of/changed/files2                  |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

the actual diff down here

--------------8<---------------

And when you feed this into mailinfo, this is what you get:

pilif@celes ~/git % git mailinfo /dev/null /dev/null < somepatch.patch
Author:
Email:
Subject: blah, blah, blah
Date: Tue, 17 Nov 2009 15:27:25 +0100

pilif@celes ~/git %

and consequently, anything that depends on the correct author being
extracted then fails.

While I know it's rude to have a line beginning with "from:" (and it's
even ruder to have a line beginning with "from "), IMHO the header
ends at the first blank line and I see no reason to extract author
information past the header.

And if this is in fact intended behavior, it should probably not be
permitted to create a commit that later on can't be rebased or applied
using git-am.

I had a look at the source of git-mailinfo to fix it myself, but this
thing does too much for my minimal knowledge in C.

Philip

--=20
Sensational AG
Giessh=FCbelstrasse 62c, Postfach 1966, 8021 Z=FCrich
Tel. +41 43 544 09 60, Mobile  +41 79 341 01 99
info@sensational.ch, http://www.sensational.ch
