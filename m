From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/7] First class shallow clone
Date: Wed, 17 Jul 2013 19:47:07 +0700
Message-ID: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 14:47:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzR8U-0004pt-G8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab3GQMrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 08:47:07 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44487 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab3GQMrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:47:05 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so1806493pdj.22
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=62QNwFqromUslr092FABtuRjwx5Z6vjZQ4Qny5VDi+U=;
        b=hR70x2Dwu9Kg5P0Fmt+fLGiaE0aw58uZgNvM6JK/NLrisXmMFIQjBV3a+3FEObDKFd
         YqokSzqkyi0t/RlcWpWSLaqcOYadjTof3ernhKLYZknSaG911Pqx5OIB4EBqhXatrQaL
         vfoPuP8ifBNyXWBxazIGt0QGWA8lDywZ7zhDD8km76cBHz2dP/CfuGa7cuBd3gdO89Y5
         swX5MhNHK93c1Ad05d9thWM6SLss6jykbIT+XMTgWitxrp4LoMsKEfxGblRGOOO/q+/V
         gRHgSri0BOAPWYbthBeJnLvn9zoQJ+VyZGWjxgQDnSQOmVprbltm7BD+7HRLq6L2nWwC
         JF0g==
X-Received: by 10.68.113.2 with SMTP id iu2mr6632340pbb.108.1374065225410;
        Wed, 17 Jul 2013 05:47:05 -0700 (PDT)
Received: from lanh ([115.73.197.79])
        by mx.google.com with ESMTPSA id is3sm1485377pbc.25.2013.07.17.05.47.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:47:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jul 2013 19:47:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230612>

This is probably the first attempt to treat shallow clones just like
ordinary ones. Which means you can push or fetch/clone between any two
repos, regardless of their shallow status. There are two purposes
behind this:

 - to make local/shallow clone <-> (complete) upstream repo workflow
   smoother, the note about shallow clone limitation in git-clone.txt
   can be removed

 - to make it possible for upstream to provide a lightweight repo that
   others can use. For example, big repos with lots of activities can
   be split into new base repo that only contains the work of maximum o=
ne
   year and a complete repo mostly for archive.

This is a naive approach. I might overlook something again, which is
why I publish it early to get more eyes on it.

The idea is simple: in shallow case, we provide the pack _and_
=2Egit/shallow file to the other end. The other end will setup extra
grafting to make sure the updated repo is "complete". More in
individual patch messages.

There might be issues with generating optimum pack for transfer when
both ends are shallow.. There's also an interesting issue, whether we
can take advantage of commit bitmaps in shallow clones if they are
more widely used.. We also might need a config key to protect a repo
from becoming shallow by a fetch or push, if the repo is to be a
backup one..

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
  transport.h: remove send_pack prototype, already defined in send-pack=
=2Eh
  {receive,upload}-pack: advertise shallow graft information
  connect.c: teach get_remote_heads to parse "shallow" lines
  Move setup_alternate_shallow and write_shallow_commits to shallow.c
  fetch-pack: support fetching from a shallow repository
  {send,receive}-pack: support pushing from a shallow clone
  send-pack: support pushing to a shallow clone

 Documentation/technical/pack-protocol.txt |   7 +-
 builtin/fetch-pack.c                      |   6 +-
 builtin/receive-pack.c                    |  54 ++++++++++++----
 builtin/send-pack.c                       |   7 +-
 cache.h                                   |   1 +
 commit.h                                  |   8 +++
 connect.c                                 |  12 +++-
 fetch-pack.c                              |  78 +++++++---------------
 fetch-pack.h                              |   1 +
 remote-curl.c                             |   2 +-
 send-pack.c                               |  41 ++++++++++--
 send-pack.h                               |   4 +-
 shallow.c                                 | 103 ++++++++++++++++++++++=
++++++++
 t/t5536-fetch-shallow.sh (new +x)         |  75 ++++++++++++++++++++++
 t/t5537-push-shallow.sh (new +x)          |  85 ++++++++++++++++++++++=
++
 transport.c                               |  14 ++--
 transport.h                               |   6 --
 upload-pack.c                             |   3 +-
 18 files changed, 414 insertions(+), 93 deletions(-)
 create mode 100755 t/t5536-fetch-shallow.sh
 create mode 100755 t/t5537-push-shallow.sh

--=20
1.8.2.83.gc99314b
