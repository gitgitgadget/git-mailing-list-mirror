From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 16:42:06 +0400
Message-ID: <20050914124206.GC24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 14:44:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFWbh-0001bN-75
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 14:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVINMmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 08:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVINMmT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 08:42:19 -0400
Received: from mivlgu.ru ([81.18.140.87]:63424 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S965144AbVINMmS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 08:42:18 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id A69FF180119; Wed, 14 Sep 2005 16:42:06 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8519>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

The current implementation of git-http-fetch, git-local-fetch,
git-ssh-fetch has a problem: if a fetch was interrupted in the middle,
some objects in the local repository will be missing, and there is no
easy way to recover.  If you just attempt to repeat the fetch, it will
notice that you already have the most recent commit object, and will
not fetch anything more - the repository will stay broken.  Seems that
the only way to go forward is to prune the repository (which will
remove the fetched objects, because they are not referenced) and
repeat the fetch again from the beginning, but this is obviously
wasteful.

The problem is caused by the behavior of fetch.c:process_commit() - it
skips parent commits which already exist locally.  This is a good
optimization if your repository is OK, but after an interrupted fetch
there will be some missing objects in the object tree; the only way to
find them is to scan the whole tree, so stopping at the existing
commits is wrong.

This set of patches adds the recovery mode to git-*-fetch and the
git-fetch script, which is enabled by the --recover option; in this
mode the program will walk through the whole object tree and try to
download any missing objects.  Obviously, this could take some time,
but it is better than throwing away all already fetched objects after
an error in the middle of a long fetch operation.

--=20
Sergey Vlasov

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDKBqeW82GfkQfsqIRAiZwAJ4r50aPYZjWz4P0tgkHqyIpiOlo2wCfVlgT
GorYmWVLWjii51WqDO6jHko=
=KApw
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
