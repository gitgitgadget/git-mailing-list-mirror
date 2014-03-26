From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 001/142] check-builtins.sh: use the $( ... ) construct for command substitution
Date: Wed, 26 Mar 2014 07:57:37 +0100
Message-ID: <vpqppl98n1a.fsf@anie.imag.fr>
References: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com>
	<1395768283-31135-2-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WShmX-0002SW-Jq
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 07:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaCZG5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 02:57:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34330 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbaCZG5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 02:57:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2Q6va8b002721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Mar 2014 07:57:36 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2Q6vbEg005033;
	Wed, 26 Mar 2014 07:57:37 +0100
In-Reply-To: <1395768283-31135-2-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 25 Mar 2014 10:22:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 26 Mar 2014 07:57:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2Q6va8b002721
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396421858.11246@aBjL4mhvSFQT0hG4sof1+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245159>

Elia Pinto <gitter.spiros@gmail.com> writes:

> for _f in $(find . -name "*.sh")
> do
> =A0 sed -i 's@`\(.*\)`@$(\1)@g' ${_f}
> done

What does this do in the case there are multiple ` on the same line?
(nested backquotes or multiple `...` `...` on the same line)

There are not many instances, and it seems no nested backquotes in Git'=
s
source code:

$ git grep '`.*`.*`' -- '*.sh'
t/t5506-remote-groups.sh:       if test "`git log -1 --pretty=3Dformat:=
%s $1 --`" =3D "`cat mark`"; then
t/t9300-fast-import.sh:  test `git rev-parse master` =3D `git rev-parse=
 TEMP_TAG^`'
t/t9300-fast-import.sh:  test `git rev-parse N2^{tree}` =3D `git rev-pa=
rse N3^{tree}`'
t/t9300-fast-import.sh:  test `git rev-parse N3` =3D `git rev-parse O1`=
'
t/t9300-fast-import.sh:  test `git rev-parse N3` =3D `git rev-parse O2`=
'
t/t9300-fast-import.sh:  test `git rev-parse refs/tags/O3-2nd` =3D `git=
 rev-parse O3^` &&

The instance in t5506-remote-groups.sh is correct (probably fixed by
hand, which would deserve to be in the commit message).

I did not receive the patch about t9300-fast-import.sh (the serie seems
to have stopped at PATCH 105/144).

The other problematic case I can think of is `...` in comments. It seem=
s
I caught the problematic ones in t/t0204-gettext-reencode-sanity.sh and
t/t6111-rev-list-treesame.sh, and git-pull.sh was correct already.

$ git grep '#.*`.*`' -- '*.sh'
git-pull.sh:# Setup default fast-forward options via `pull.ff`
t/t0204-gettext-reencode-sanity.sh:#   FreeBSD: `einfaldar` og "tv=F6fa=
ldar"  [GNU libintl]
t/t4057-diff-combined-paths.sh:# `git diff -c --name-only HEAD HEAD^ HE=
AD^2`
t/t5522-pull-symlink.sh:# "cd `git rev-parse --show-cdup`", it ended up=
 in the wrong
t/t6111-rev-list-treesame.sh:#    `-C-'          `-*I-*J
t/test-lib-functions.sh:#       for i in `test_seq 100`; do
t/test-lib-functions.sh:#               for j in `test_seq 10 20`; do
t/test-lib-functions.sh:#                       for k in `test_seq a z`=
; do

Again, something to mention in commit messages I think.

The first review I did was completely manual, but I would not call it a
thorough one.

It's probably a better idea to publish your branch somewhere than to
continue sending batches of 140 emails to the list for this kind of
topics.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
