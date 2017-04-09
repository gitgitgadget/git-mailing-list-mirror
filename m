Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFF91FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 13:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbdDINBc (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 09:01:32 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:38441 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbdDINBb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 09:01:31 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sun, 09 Apr 2017 15:01:29 +0200
  id 0000000000000019.0000000058EA30AA.00004699
Date:   Sun, 9 Apr 2017 15:01:26 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     git@vger.kernel.org
Subject: Unexpected working directory in post-receive hook in non-bare
 repository
Message-ID: <20170409130126.uqmjop25jidhblhd@ruderich.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-18073-1491742890-0001-2"
Content-Disposition: inline
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-18073-1491742890-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

The following snippet reproduces the issue for me (note the
remote: line in its output):

    git --version

    rm -rf a b

    git init a
    cd a
    echo first >data
    git add data
    git commit -m initial
    cat >>.git/hooks/post-receive <<EOF
    #!/bin/sh
    pwd
    EOF
    chmod +x .git/hooks/post-receive
    cd ..

    git clone a b
    cd b
    echo second >>data
    git add data
    git commit -m test
    git push origin master:not-master

According to man githooks "Before Git invokes a hook, it changes
its working directory to either the root of the working tree in a
non-bare repository, [...]". In this case "a" is non-bare and I
expected the command to be run in the working tree; but instead
it's run inside .git. (This caused some confusion in my case
because I ran "git merge" in the hook which put files in the .git
directory and I didn't notice it at first. I know running merge
in receive-hooks is "bad practice" but it works fine in my
setup.)

The same happens for all hooks executed by git-receive-pack:
pre-receive, update, post-receive, post-update.

Is this a documentation issue or unexpected behavior?

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-18073-1491742890-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAljqMJ8ACgkQkv79t+RM
MvmZmBAAhTbkSStEoUAghbrLeMLAn2Vtq7sBpg43MH8zEBZb7KfuNVqAPZlMmLzO
CREWeqoxCdGnXXFNKDPiDKej+ZE4vjhsVXoDCaViDXyKEpTKBJrER8pmkWKOJKgv
ptNhCnb2hm2JRyhN7NppHbRGDFLtoYxoclt62iAvth8yOTewigoPHdBxEI/ybK+B
ORYtX/CbFiNyFtyDtVgqBoDJhZVkLSi6pYKpxNYTsHnNg/AEbL2DJ5Dus9I67uJU
mJD2qqCGkNfs6Ox2QvGPg5QQ0nrysVYKA0CXMMaSNDZTHPd2ycAR1J8SufFs3/5T
qilCsdb+RwqnL+eNcQGItiUbdWfF3ScbdKKgOpbMopvnmMFjcyj+43RF70nGWV8A
Ak5A3weMfdh58iFWPObp705X9Of7yKqfsFDJnlXtq08yp20vZw3FTbZsdXEH6F6X
/dMoMqyyfLRko6Cy/AF7oVPRcS4ispWzVT3KOJ9nwr+E9Oebp6YpNNJwBweAAa/7
7hP7OxhLJYkCpQ2bDLxRCJUEP/LGGoDiSmq36y/qZ2rduYQaIfCxBkDJWTMSJUnh
vpLxHTdVJo8KEV3DrVQNJa0DGJV8XuZ//NefcjXJ3clhqF7vnNc5oj/0ugilL5rZ
xrw9X7TpJ78K/DgI0SdFbfWrrT4dXvXIxCmO5ji0TMxGEqx7ZHw=
=55q+
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-18073-1491742890-0001-2--
