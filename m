From: =?utf-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
Subject: publish from certain commit onward, keeping earlier history private, but provable
Date: Wed, 9 Dec 2015 14:45:44 +0100
Message-ID: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 14:56:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6fDx-0001Fi-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 14:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbbLINzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2015 08:55:53 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:49124 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbLINzu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2015 08:55:50 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2015 08:55:49 EST
Received: from [131.246.194.42] (helo=port-4143.kl.dfki.de)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.84)
	(envelope-from <dev@joernhees.de>)
	id 1a6f3w-0004I6-38
	for git@vger.kernel.org; Wed, 09 Dec 2015 14:45:44 +0100
X-Mailer: Apple Mail (2.2104)
X-Df-Sender: bWFpbEBqb2VybmhlZXMuZGU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282191>

Hi,

I've been hacking away on a library for quite some time and have a lot =
of commits in my private repository:

A -> B -> C -> D -> E

=46inally, I'm nearing completion of a first version, and want to publi=
sh it to a remote called public from D onward keeping A..C to myself, s=
o public should afterwards look like this:

D -> E

My main motivation is that i don't really want to put ridiculously firs=
t trials online, but still (on demand) I'd like to be able to prove how=
 i arrived at D (think of copyright claims, etc).

As (at the moment) it's pretty much impossible to reverse-engineer the =
hashes of commits in the chain with times and changesets, i thought jus=
t keeping D's parent pointer to C would be one of the genius advantages=
 of git. Sadly i can't find a way to actually make this work.

Can i somehow push D -> E to public making it a fully functional public=
 repository with all the necessary objects included to checkout D or E =
and D still pointing to C as parent? If not, why is that?

What doesn't seem to work:

- push with range
 =20
  git push public D..E:master
  error: src refspec D..E does not match any.
  error: failed to push some refs to '<public>'

- any form of squashing / history rewriting
 =20
  As far as i know squashing A..D would introduce a new commit removing=
 the parent pointer to C and thereby removing provability of the existe=
nce of A..C. (Simple example: say C reversed B, then you'd never be abl=
e to prove B was in there at some point.)
 =20
  I could obviously manually note the hash of C in the description of t=
he squash commit, but there already is a parent pointer field, why not =
use it?
 =20
  Also in order to contribute further changes to public I'd have to reb=
ase my private branches on top of this new squashed commit, which just =
seems as wrong...

- push from local clone with limited depth
 =20
  I thought i found a solution to this by first creating a local clone =
local_public with the desired depth before pushing that clone to public=
 like this:
 =20
  git clone --depth 2 file:///<abspath_private> local_public
 =20
  With
 =20
  git log --pretty=3Draw
 =20
  I can verify that local_public only contains D -> E and that the comm=
it, tree and parent hashes are the same, which is exactly what i want.
 =20
  The problem is that when i try to push to an added public remote from=
 local_public i get an error like this:
 =20
  ! [remote rejected] master -> master (shallow update not allowed)


Any ideas how to make this work?

Cheers,
J=C3=B6rn
