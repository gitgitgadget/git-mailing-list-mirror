From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 13:37:41 +0400
Message-ID: <20060614133741.73cd80cb.vsu@altlinux.ru>
References: <1150269478.20536.150.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__14_Jun_2006_13_37_41_+0400_acQSBuAKXcQNlvqQ"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 11:38:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqRoy-0004Pp-Ez
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 11:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWFNJhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 05:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFNJhx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 05:37:53 -0400
Received: from mivlgu.ru ([81.18.140.87]:24028 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S932157AbWFNJhx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 05:37:53 -0400
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id 95613804E; Wed, 14 Jun 2006 13:37:45 +0400 (MSD)
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1150269478.20536.150.camel@neko.keithp.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21836>

--Signature=_Wed__14_Jun_2006_13_37_41_+0400_acQSBuAKXcQNlvqQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jun 2006 00:17:58 -0700 Keith Packard wrote:

> parsecvs scans every ,v file and creates a blob for every revision of
> every file right up front. Once these are created, it discards the
> actual file contents and deals solely with the hash values.
>=20
> The problem is that while this is going on, the repository consists
> solely of disconnected objects, and I can't make git-repack put those
> into pack objects. This leaves the directories bloated, and operations
> within the tree quite sluggish. I'm importing a project with 30000 files
> and 30000 revisions (the CVS repository is about 700MB), and after
> scanning the files, and constructing (in memory) a complete revision
> history, the actual construction of the commits is happening at about 2
> per second, and about 70% of that time is in the kernel, presumably
> playing around in the repository.
>=20
> I'm assuming that if I could get these disconnected blobs all neatly
> tucked into a pack object, things might go a bit faster.

git-repack.sh basically does:

  git-rev-list --objects --all | git-pack-objects .tmp-pack

When you have only disconnected blobs, obviously the first part does
not work - git-rev-list cannot find these blobs.  However, you can do
that part manually - e.g., when you add a blob, do:

  fprintf(list_file, "%s %s\n", sha1, path);

(path should be a relative path in the repo without ",v" or "Attic" -
it is used for delta packing optimization, so getting it wrong will
not cause any corruption, but the pack may become significantly
larger).  You may output some duplicate sha1 values, but
git-pack-objects should handle duplicates correctly.

Then just invoke "git-pack-objects --non-empty .tmp_pack <list_file";
it will output the resulting pack sha1 to stdout.  Then you need to
move the pack into place and call git-prune-packed (which does not
use object lists, so it should work even with unreachable objects).

You may even want to repack more than once during the import;
probably the simplest way to do it is to truncate list_file after
each repack and use "git-pack-objects --incremental".

--Signature=_Wed__14_Jun_2006_13_37_41_+0400_acQSBuAKXcQNlvqQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEj9jpW82GfkQfsqIRAjkVAJ4t43OUXzprvjQw7j1grC0SwlKZjACgjII3
ALLGiEWe0E+JInEAeb2koy8=
=A/Pe
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Jun_2006_13_37_41_+0400_acQSBuAKXcQNlvqQ--
