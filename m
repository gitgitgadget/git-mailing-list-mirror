From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: update-index --index-info producing spurious submodule commits
Date: Fri, 19 Aug 2011 07:00:10 -0400
Message-ID: <rmi39gxacp1.fsf@fnord.ir.bbn.com>
References: <rmivctuv12s.fsf@fnord.ir.bbn.com>
	<7vd3g272tk.fsf@alter.siamese.dyndns.org>
	<rmiliuq2qlg.fsf@fnord.ir.bbn.com>
	<7vpqk2593g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 13:00:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuMoM-0004Rm-Cm
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 13:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab1HSLAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 07:00:21 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:50768 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798Ab1HSLAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 07:00:20 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 2139A53AA; Fri, 19 Aug 2011 07:00:18 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:110819:git@vger.kernel.org::PYfTJiYuFSxbF0rJ:00000000000000000000000000000000000000000005kn
X-Hashcash: 1:20:110819:rhansen@bbn.com::KLHiWKHAHcjC86/K:000L2h
X-Hashcash: 1:20:110819:gitster@pobox.com::Fs9BbDNGp6mzRFUO:000000000000000000000000000000000000000000002oS9
In-Reply-To: <7vpqk2593g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 18 Aug 2011 21:16:51 -0700")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179690>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

> Greg Troxel <gdt@ir.bbn.com> writes:
>
>> If what I'm doing is an abuse of update-index, do you or anyone else
>> have a suggestion to make a directory in the index match a tree object?
>
> "ls-tree -r HEAD foo" is probably what you meant to say.

Thanks very much for the clue - that works.  The update-index
documentation should probably say that only blobs (or perhaps commits
intended to be submodules??) are acceptable, and perhaps say "ls-tree
-r" instead of ls-tree.  It could easily seem reasonable to someone to
pass in a tree and expect that to result in that tree being logically in
the index and to appear in the resulting commit.

For anyone else who is trying to do something like this, here's a
revised script that (I think) correctly reverts a directory to another commit.

#!/bin/sh

if [ -d .git ]; then
   echo "existing .git"
   exit 1
fi

set -x

git init
mkdir foo
touch foo/bar
git add foo
git commit -m'initial content'
git tag initial

touch foo/baz
git add foo/baz
git commit -m 'add baz'

git cat-file -p initial
git cat-file -p initial:
git rm --cached -r foo
git ls-tree initial foo
git ls-tree -r initial foo
git ls-tree -r initial foo | git update-index --index-info

git diff
git diff --staged
git commit -m'munged foo'

git cat-file -p HEAD
git cat-file -p HEAD:

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iEYEARECAAYFAk5OQjoACgkQ+vesoDJhHiVjRwCfb3U1HZcj+WKW8uW2GKYtFTjy
w5oAn1nbiohGhtvWlrN3QfqAl00UwMfO
=C+/f
-----END PGP SIGNATURE-----
--=-=-=--
