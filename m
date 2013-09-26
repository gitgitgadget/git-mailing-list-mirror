From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/10] pack v4 UI support
Date: Thu, 26 Sep 2013 09:26:39 +0700
Message-ID: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1IL-0002Ma-56
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab3IZC1E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:04 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51633 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3IZC1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:03 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so483437pbc.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=GCsU0SwtIF1uuvirkL0sR9cP/7x2ViNkVt3HFq4d+Kg=;
        b=Q18Kx9+CeDM3PsbXFHU2Ixgc9fznXXY4Gc+VYg2iWgDM6FO83fCbi0OxyvXgaur/55
         QGGMR5Gk2lVUvmwVvjEKeSLdHA7pwR5UZgX78yteF6Y4kZhGXL6Qw+WPW2mj3d/8CIyL
         gtXy4ftaZLh6tJDCjUBzrb242WzR+nsLajAtSYqoB4CZhUgsvgwhEWvCB7Y1vDNRfrXM
         vHh4rSBYVsCAhkkqUlg1yxZNuc+nyLe9xdW76C1mF6YMG4VCPJ4fc1W/ah7+mlhUO4wW
         hck65htGvQ1jeYhJuzWQ99imanbtqY4GYZIo7Y2tt5FZoi8gb6FlV+7zM+P3P9JZil6B
         opjA==
X-Received: by 10.68.253.67 with SMTP id zy3mr13954351pbc.137.1380162421994;
        Wed, 25 Sep 2013 19:27:01 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id 7sm1305437paf.22.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:26:56 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235387>

This adds

 - clone, fetch and repack learn --pack-version (backends also learn
   new options, check out the patches for details)

 - core.preferredPackVersion to specify the default pack version for
   fetch, clone, repack and the receiver of push.
  =20
   This config is supposed to be used by porcelain commands only (with
   the exception of receive-pack). All other plumbing will default to
   pack v2 forever.

 - git and remote helper protocols learn about packv4 capabilities

I think the UI changes for pack v4 are done with this series. Well,
git-bundle needs --pack-version too but it's not part of core
user interaction. The remaining work for v4 would be optimization
(that includes multi-base tree support) and more v4 tests. Let me know
if I missed anything here.

I'm aware that repack is being rewritten in C, so it'll cause
conflicts when np/pack-v4 is re-pulled to 'pu' again. I suggest that
the new tests in t7700 are marked failed at the merge. We can add
--pack-version to the C-based repack and enable the tests later.

About the "packv4" capability in git protocol. I considered a more
generic cap "packver=3Dver[,ver[,ver...]]" that represents all supporte=
d
versions, with the order of preference from the first ver (most preferr=
ed)
to the last (least preferred). But it adds more parsing code
and frankly I don't think we'll have pack v5 in the next five years.
So I dropped it.

Multi-base tree support is not part of "packv4" capability. Let's see
if such support comes before the series is merged to master. If so we
can drop that line from protocol-capabilities.txt. Otherwise a new
capability can be added for multi-base trees.

Another capability could be added for sending the actual number of
objects in a thin pack for more accurate display in index-pack. Low
priority in my opinion.

There's also the pack conversion issue. Suppose the client requests v4
but, for performance purposes, the server sends v2. Should index-pack
convert the received pack to v4? My answer is no because there's no
way we can do it without saving v2 first. And if we have to save v2
anyway, pack-objects (or repack) will do the conversion better. We can
adjust git-gc to maybe repack more often when the number of v2 packs
is over a limit, or just repack v2 packs into one v4 pack.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  test-dump: new test program to examine binary data
  config: add core.preferredPackVersion
  upload-pack: new capability to send pack v4
  fetch: new option to set preferred pack version for transfer
  clone: new option to set preferred pack version for transfer
  fetch: pack v4 support on smart http
  receive-pack: request for packv4 if it's the preferred version
  send-pack: support pack v4
  repack: add --pack-version and fall back to core.preferredPackVersion
  count-objects: report pack v4 usage

 .gitignore                                        |  1 +
 Documentation/config.txt                          |  5 ++++
 Documentation/fetch-options.txt                   |  5 ++++
 Documentation/git-clone.txt                       |  4 +++
 Documentation/git-count-objects.txt               |  4 +++
 Documentation/git-fetch-pack.txt                  |  4 +++
 Documentation/git-repack.txt                      |  6 +++-
 Documentation/gitremote-helpers.txt               |  3 ++
 Documentation/technical/protocol-capabilities.txt | 14 +++++++++
 Makefile                                          |  1 +
 builtin/clone.c                                   | 19 ++++++++++++
 builtin/count-objects.c                           | 23 +++++++++++++--
 builtin/fetch-pack.c                              |  7 +++++
 builtin/fetch.c                                   | 10 +++++++
 builtin/receive-pack.c                            |  3 +-
 cache.h                                           |  1 +
 config.c                                          |  5 ++++
 environment.c                                     |  1 +
 fetch-pack.c                                      |  3 ++
 fetch-pack.h                                      |  1 +
 git-repack.sh                                     |  8 +++++-
 remote-curl.c                                     | 14 ++++++++-
 send-pack.c                                       |  5 ++++
 send-pack.h                                       |  1 +
 t/t5510-fetch.sh                                  | 13 +++++++++
 t/t5516-fetch-push.sh                             | 12 ++++++++
 t/t5551-http-fetch.sh                             |  9 ++++++
 t/t5601-clone.sh                                  | 12 ++++++++
 t/t7700-repack.sh                                 | 35 +++++++++++++++=
++++++++
 test-dump.c (new)                                 | 27 +++++++++++++++=
++
 transport-helper.c                                |  3 ++
 transport.c                                       |  4 +++
 transport.h                                       |  5 ++++
 upload-pack.c                                     | 16 +++++++++--
 34 files changed, 274 insertions(+), 10 deletions(-)
 create mode 100644 test-dump.c

--=20
1.8.2.82.gc24b958
