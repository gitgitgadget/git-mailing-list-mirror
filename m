Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79A11F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeGQRlz (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:41:55 -0400
Received: from kitenet.net ([66.228.36.95]:54258 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbeGQRlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:41:55 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2018 13:41:54 EDT
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1531846714; bh=sSNTpxMfF9j+iDtJLWKT9FsJlPY7869k6HfVeKWuikc=;
        h=Date:From:To:Cc:Subject:From;
        b=dLbNB0OzOztCq4lbj4u0DYhavl7VuhI1U1drOJ8IS1l8MKVzk9yaGE9errFcx+DRY
         tX5v+SGZcQf23hYumv2YFEvqE7OQ6pHyiEsszCUInWHreidTn/Cw7FtSJJklzsW5Qy
         707aqJaS06agOQvrErGJ30wPcEmLo+K7ilqHpGzM=
Date:   Tue, 17 Jul 2018 12:58:34 -0400
From:   Joey Hess <id@joeyh.name>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: clean filter run in top of repo with wrong GIT_WORK_TREE
Message-ID: <20180717165834.GA5615@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When git is running inside a subdirectory of the repository,=20
and needs to run the clean filter, it runs it chdired back to the top of
the repository. However, if git was run with a relative --work-tree,
it passes that relative path in GIT_WORK_TREE on to the clean filter.

If git was run with eg, "--work-tree=3D..", the clean filter sees a work
tree that is outside the repository. It might then read files located
outside the repository. That seems like it could have security
consequences, but it's certianly a surprising problem to need to deal
with when writing a clean filter.

Brian posted a fix for a very similar bug in sequencer.c on the 14th,=20
so it seems likely there are other occurances of the same problem
elsewhere.

Demonstration of this bug:

joey@darkstar:~/tmp/repo>cat .gitattributes
* filter=3Dfoo
joey@darkstar:~/tmp/repo>git config filter.foo.clean
clean-filter %f
joey@darkstar:~/tmp/repo>cat ~/bin/clean-filter=20
#!/bin/sh
pwd >&2
echo $GIT_WORK_TREE >&2
ls "$GIT_WORK_TREE/$1"
joey@darkstar:~/tmp/repo>cd foo/bar/
joey@darkstar:~/tmp/repo/foo/bar>ls
x
joey@darkstar:~/tmp/repo/foo/bar>touch x
joey@darkstar:~/tmp/repo/foo/bar>git --work-tree=3D../.. ls-files --modified
/home/joey/tmp/repo
=2E./..
ls: cannot access '../../foo/bar/x': No such file or directory

git version 2.18.0

--=20
see shy jo

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAltOIDgACgkQ2xLbD/Bf
jzgvRw//U7WWvwjw+dh6rVRvaKqwK99gN8DiHQFWAtfUccA+KLIQ8UMDoor+HgL6
OdOu6d1cx1inw3ZLKl/1QdngEozG9dl1/AhuY6oA/mh7EUvLYCFrhwEttOn3bOIC
tJd+3X/ohqynT/+LIU0Ub0s1PDpwCOyGWQqpEjqVvAv6eYjZs9XwaxdDxniTFPMg
zx3Hrtsh2cspb2e3NsDCmaU434kIh7t1IUCDOeB/KtDAedUNzh1U3oMdZy6cGT16
R0cMWqdkl2tQrdhFjfF7GIQE3AQlYNC1PW/yqUI0F1sq8yD7k8kuLhK4JT2A0Ljc
tCmNTOFbdtd2+ni7qxfTsaRDQqhEoTlfKCbNVPAclWX++QHgKSMU2xa9reYzRFde
httfGigztjZYllL0atHakEEqty4lI+edynOQPDV2BGJobDzlVwm3PcHU8jGKVVdW
jPdK0p5yFEB1JkRjL7PoKI4lV5o1vIlLtUAIFZt/+iL5olIs/0GKLajHVW6Q0/6V
DJC2VTSdN0g3ZK4KKSUOvQ0mzgDYdBJOUA/3fznhufNC+WEOJxQoAypSvLHYqlXx
Vu9vJfY/+QtcgdcAyWCDJ7jI8baUal8bBGm1zLjcqR8kjyQsBNCktdRERiTwULa2
t3XOuDG6MXmVo6wm077S/rYkc2uVfsG9/AMvGRpFzw5FW0R/jmo=
=0tha
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
