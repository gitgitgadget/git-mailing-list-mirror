From: Julian Brost <julian@0x4a42.net>
Subject: Trust issues with hooks and config files
Date: Thu, 06 Mar 2014 22:47:43 +0100
Message-ID: <5318ECFF.40908@0x4a42.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 22:47:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLg8v-0004Jy-67
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbaCFVrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:47:48 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:33098 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaCFVrr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:47:47 -0500
Received: by mail-ee0-f52.google.com with SMTP id e49so1375675eek.11
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 13:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x4a42.net; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=p4Tp+Cjx2p5stBiOV1Uea4wPg+Q4nrb0qLIE3mb1cwo=;
        b=F6fVAlNaS6EC97WDjhW65vy35T+cFWsfgGsvyrssInlfmiimr2DoaQJx/RqrQirHa8
         7UzJfbVihjPGSWH5uvGZ1Hipv9EtwB9fNRpNHumQWRjtkaY2b0IIP2GoiWjPm1NZcmWt
         FTUkP165WBMPU8kNPA2PqytuvNub3V9l2+dzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=p4Tp+Cjx2p5stBiOV1Uea4wPg+Q4nrb0qLIE3mb1cwo=;
        b=ZQiXxytUjKQZXbGIMylQq2IlHoUR8z6gtd6LAdwHjirm5UxdQryIDh+0lhI0XvM7PQ
         iWYnloVS32nWrE+aF04W2AgV8+scdoV+qLTgozM88XlI3u5xL7QuaHV2J7I5tmp0n/9f
         WXT7gbDGSWWfpe19uJbyNNcA9RKaAtx1WO3lmRECS2MAdPJNB/shaAPj54aZJJ1x5LaQ
         RTWucQTMr2SbZSqNYyNd+lJefRWDzyMkevBmmbSIUn1qKk6djBfdS88UfGwSbozDQggi
         UNUguxt6pIs69xkzEP1c4MyyA8EstWhgAaZ3P+nPrZVZlhfRGaEnEWh6o2c53J12X3e2
         M7Fg==
X-Gm-Message-State: ALoCoQnZd19PSehiu5x0ZmCwkkZgrJ8tFcQMr7vN1uOozOq/E57melsTdiAoKJUI/kpRjK2TocwE
X-Received: by 10.15.24.65 with SMTP id i41mr15106208eeu.21.1394142466091;
        Thu, 06 Mar 2014 13:47:46 -0800 (PST)
Received: from ?IPv6:2001:4dd0:f944:0:2677:3ff:fea3:17c4? ([2001:4dd0:f944:0:2677:3ff:fea3:17c4])
        by mx.google.com with ESMTPSA id i1sm26758933eeo.16.2014.03.06.13.47.44
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Mar 2014 13:47:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243560>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

I've noticed some behavior of git that might lead to some security
issues if the user is not aware of this.

Assume we have an evil user on a system, let's call him eve. He
prepares a repository where he allows other user to push changes to.
If he now adds a post-receive hook, git will happly execute it as
whatever user pushes to this repository:

  root@argon /tmp/git-eve # ls -l /tmp/git-eve/hooks/post-receive
  -rwxr-xr-x 1 eve users [...] /tmp/git-eve/hooks/post-receive
  root@argon /tmp/git-root # cat /tmp/git-eve/hooks/post-receive
  #!/bin/sh
  id
  root@argon /tmp/git-root # git push /tmp/git-eve master
  Counting objects: 3, done.
  Writing objects: 100% (3/3), 185 bytes | 0 bytes/s, done.
  Total 3 (delta 0), reused 0 (delta 0)
  remote: uid=0(root) gid=0(root) groups=0(root),[...]
  To /tmp/git-eve
   * [new branch]      master -> master

Something similiar might happen if eve adds some alias to the config
file in the repository and grants any other user read access to the
repository. These aliases will be executed when some other user is
running any git command in this repository. Even though git does not
allow defining aliases for existing commands, you might mistype
something, so adding an alias for "lg" instead of "log" might succeed:

  root@argon /tmp/git-eve # ls -l /tmp/git-eve/config
  -rw-r--r-- 1 eve users [...] /tmp/git-eve/config
  root@argon /tmp/git-eve # cat config
  [core]
  	repositoryformatversion = 0
  	filemode = true
  	bare = true
  [alias]
  	lg = !id
  root@argon /tmp/git-eve # git lg
  uid=0(root) gid=0(root) groups=0(root),[...]

This gets even worse if you know something about the aliases your
victim uses, so for example you can override an alias 'l = log'
defined in the user's config with something malicious in the
repository config file.

I'd suggest taking a similar approach as Mercurial [1], i.e. ignoring
configuration files and hooks owned by another user unless the owner
is explicitly trusted.

Regards,
Julian

[1] http://mercurial.selenic.com/wiki/Trust
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTGOz5AAoJECLcYT6QIdBtJLEP/1VPMyRws5IYOVXJDcLukxkh
87RuL6ZCXE9v66VgEmTYYtJx1Umy18YXCx+ufAuJL2xzo/QH/QhWl/npa+U3ac7D
2A/3rXt1PvdzoQeT3514t5ntO9WyquHE2N8Ix+xdxwFo/T+Ve+nDV8/hra9he1Nb
zdldBccyHBDQdEudBLs6tDoJU9fvQ4TAGCGw7CXHCDV4hhyXHt8Nyf9nNOWxXgYh
5QcDs0sj1MCFm5AdN1SOU7FobiwS//Q8QdKdr9O6L18IoUPnSw2a1S2hGJmwQ/IL
Y1nQMdFuSx+4n6KKgUBtlo4WTi38u98FG4N0MXqZOSX7SKDVEOYfF+1W31Trhtuw
KMtojlwBYXsq0CWrW1OQ4Oed91lDGBtLLzF8MSCN1NoG4+Eb/V+RueLzulC5lWU/
IpDr3d14vFBEydHzYY+35P57Rf2Fl5HkXLQzQ0UmROeAmhUVCnduRj4dn35nb47Z
G/73UdgX1FMB4lOD8kD9KX0Sov3XLz4n5u706h+lElapd24wBXlaysWVpsmImuW0
xPLSpX0Dfrtj0sOCvqM0oX40z3bCJ1ibqZOmPGwF0P66DJOOq9sqDYfHlgnvt/qU
pCqsy0+FyCUuGP17UliEWcFAfdzXrUhxkRneQXC8ieX8YSoP4OtjzIPHrsc54s/2
7VR0wCTxaHvd05T8WruK
=kc4p
-----END PGP SIGNATURE-----
