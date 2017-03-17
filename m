Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EAB20323
	for <e@80x24.org>; Fri, 17 Mar 2017 02:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbdCQCHx (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 22:07:53 -0400
Received: from mail.fairlystable.org ([216.151.3.163]:32928 "EHLO
        mail.fairlystable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdCQCHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 22:07:52 -0400
X-Greylist: delayed 6267 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Mar 2017 22:07:37 EDT
Received: from [174.25.131.71] (helo=localhost)
        by mail.fairlystable.org with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <jrayhawk@fairlystable.org>)
        id 1cofff-0002bC-BS; Thu, 16 Mar 2017 17:23:07 -0700
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha256"; boundary="===============2191712739524319927=="
MIME-Version: 1.0
Content-Disposition: inline
To:     git@vger.kernel.org
Message-ID: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
From:   Joe Rayhawk <jrayhawk@freedesktop.org>
User-Agent: alot/0.3.6
Subject: Shared repositories no longer securable against privilege escalation
Date:   Thu, 16 Mar 2017 17:23:01 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--===============2191712739524319927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Git has started requiring write access to the root of bare repositories
in order to create /HEAD.lock. This is a major security problem in
shared environments as it also entails control over the /config link
i.e. core.hooksPath. Permission to write objects and update refs should
be entirely separate from permission to edit hook execution logic.

Given that /HEAD is not dynamically modified in the normal lifetimes of
bare repositories, /HEAD.lock creation failure should probably be, at
worst, an ignorable soft failure. Alternatively, some form of stale
lockfile handling (currently there is none) could be made to work with
a writable HEAD.lock in a read-only bare repository.

Obigatory HEAD.lock creation was introduced in the following commit:

commit 92b1551b1d407065f961ffd1d972481063a0edcc
Author: Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon Apr 25 15:56:07 2016 +0200

    refs: resolve symbolic refs first

Test case:

root@richardiv:~# GIT_DIR=3D/tmp/test.git git init --bare --shared=3Dgroup
Initialized empty shared Git repository in /tmp/test.git/
root@richardiv:~# cd /tmp/test.git
root@richardiv:/tmp/test.git# touch git-daemon-export-ok packed-refs
root@richardiv:/tmp/test.git# mkdir -p info logs branches
root@richardiv:/tmp/test.git# find refs info branches objects logs         =
 -type d -print0 | xargs -0 chmod 2775
root@richardiv:/tmp/test.git# find refs info branches logs HEAD packed-refs=
 -type f -print0 | xargs -0 chmod 0664
root@richardiv:/tmp/test.git# find objects                                 =
 -type f -print0 | xargs -0 --no-run-if-empty chmod 0644
root@richardiv:/tmp/test.git# find refs info branches objects logs HEAD pac=
ked-refs -print0 | xargs -0 chgrp git-test
root@richardiv:/tmp/test.git# chown root.root . config description git-daem=
on-export-ok hooks
root@richardiv:/tmp/test.git# chmod 0644 config description git-daemon-expo=
rt-ok
root@richardiv:/tmp/test.git# chmod 00755 . hooks
root@richardiv:/tmp/test.git# sudo -i -u user1
user1@richardiv:~$ git clone /tmp/test.git
Cloning into 'test'...
warning: You appear to have cloned an empty repository.
done.
user1@richardiv:~$ cd test
user1@richardiv:~/test$ touch test
user1@richardiv:~/test$ git add test
user1@richardiv:~/test$ git commit -m test test
[master (root-commit) ff21d72] test
 1 file changed, 0 insertions(+), 0 deletions(-)
create mode 100644 test
user1@richardiv:~/test$ git push
Counting objects: 3, done.
Writing objects: 100% (3/3), 206 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: error: cannot lock ref 'HEAD': Unable to create '/tmp/test.git/HEAD=
.lock': Permission denied
To /tmp/test.git
 ! [remote rejected] master -> master (failed to update ref)
error: failed to push some refs to '/tmp/test.git'
user1@richardiv:~/test$ logout
root@richardiv:/tmp/test.git# chgrp git-test .
root@richardiv:/tmp/test.git# chmod 2775 .
root@richardiv:/tmp/test.git# sudo -s -u user1
user1@richardiv:/tmp/test.git$ mv config config-old
user1@richardiv:/tmp/test.git$ touch config # POWER ALMIGHTY
user1@richardiv:/tmp/test.git$

Please CC me on this thread; I am not on the mailing list.


--===============2191712739524319927==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0W3/Ls5On90y4dmX35w74P7tvu8FAljLLDsACgkQ35w74P7t
vu/AFw/+JIKahCTesYSyHeALs4CYwM2iHuwkKoml+dw3rcbCkLe87Y2LGcD6vpMd
IrZQBCvNfpNpN2+PrCswhAaxMRwRmh9iLps2oTFhqR0AmPA5deP6f0zzvKjK5mbz
z33LveA11Dh0ydcqsMSpFF3gipwd2tWK6Jor06E2JYX7oBUn+jArjCf2uNRz5kpJ
WCbfJyqbJ4dILA3P+YgCFpT2841A0plqA8m/jBheTVnmG04Rs9jb4YjBHvQyq9E3
AEQHa3yJCfKCLjH7DxYiGeIJAsm6XhfRmCpvWXYMiq3EyLhwRL63zrrjgUOXD8rh
XHmaUjjDxQdD41/Q3ZwKKh9cvNpDIJ/8Hdh970n397sn1cuVNVlikLmnm3rLuybr
UOlfwgKlmT+CjNp0QndCbfQZqv6Q+0tsNCnHd9N6Yb5Ky1xDyoEuIN7A6+JdAEx/
UwxhI9q+n4ooV+1uyuNVsUAuk7tvCZ98OJiV8Qy9Tf5iYH31yKpLNPRAWjKu2b8n
yEVfekSFKZmELaMFRzStaDSdJ1S3vhqCJkaFSa/NJmczkVftB/WQnatiqb2pS6PF
tOV6KDv4G6bg5L6loY1aBP6vX3fSdc8zlyyayWznXkGoKPfbw+F6m1T2zc8HfA/p
/9ssS6ZBahq44+enaGqg/mR7PLkuBGOAk7H/mDzQ2n5kMdlQCrE=
=w1ni
-----END PGP SIGNATURE-----

--===============2191712739524319927==--
