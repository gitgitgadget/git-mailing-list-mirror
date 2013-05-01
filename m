From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] check_everything_connected replacement
Date: Wed,  1 May 2013 17:59:29 +0700
Message-ID: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 12:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXUkO-0006z2-CT
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759557Ab3EAK6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 06:58:48 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41870 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab3EAK6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:58:46 -0400
Received: by mail-pb0-f47.google.com with SMTP id uo1so689875pbc.34
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Ia9a+YGd7QjePOSNz//f1dGGqqdGtiO0KyI2hgjQQ7M=;
        b=b6lVJL7eixhs7B1O29twHia8N79A7arT/Em3iR/oH23q+K9IcgoFMH+6SSZcb1Oqml
         PlWPG+EzWEdVvoBsiem/9jJz89jEw/V6dKdkX+Mqgvn+NW7BmhS17oTB3UzYJKWIuLpW
         hM1J7Fm4Ta2FNRgMjOIcUBZ7b+f+Kjxz/IdKTB+o/QWs4ScjHYC6bMkF2hPAmQ5A7lG/
         G/QGbj3MXXRdVp0OWFenRQt1XbpwTbPCPUQEbe9aJxjh4J7gDh3xneITrohlHsW6Hxt3
         YDSZOqazSJyQ3KuJ8MXXr5nLF7R8MbpDjVQ0eYq/zhfqy22kYGiXXmi7P9KhRjCv0g9u
         hUXA==
X-Received: by 10.66.41.11 with SMTP id b11mr4350799pal.183.1367405926169;
        Wed, 01 May 2013 03:58:46 -0700 (PDT)
Received: from lanh ([115.74.47.19])
        by mx.google.com with ESMTPSA id ak1sm2593017pbc.10.2013.05.01.03.58.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 03:58:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 May 2013 17:59:34 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223080>

This series attempts to reduce the cost of check_everything_connected
on the clone case where index-pack is run. For example, cloning
file://../linux-2.6.git:
   =20
        before       after
real    4m23.664s    3m47.280s
user    4m55.613s    4m39.530s
sys     0m14.805s    0m17.728s

The first three patches are improvements or fixes and I think they're
good to go (if no bugs are found). The last two introduce
--not-so-strict as check_everything_connected replacement and use it
where applicable and are debatable (I guess).

The reroll fixes shallow file update issue Junio pointed out
previously. It also does not remove check_everything_connected unless
it knows that index-pack or unpack-objects are run with
--not-so-strict.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  clone: let the user know when check_everything_connected is run
  fetch-pack: prepare updated shallow file before fetching the pack
  index-pack: remove dead code (it should never happen)
  index-pack, unpack-objects: add --not-so-strict for connectivity chec=
k
  Use --not-so-strict on all pack transfer for connectivity check

 Documentation/git-index-pack.txt     |  3 ++
 Documentation/git-unpack-objects.txt |  4 +++
 builtin/clone.c                      | 18 +++++++---
 builtin/fetch.c                      | 11 +++---
 builtin/index-pack.c                 | 10 ++++--
 builtin/receive-pack.c               | 51 +++------------------------
 builtin/unpack-objects.c             |  9 +++--
 commit.h                             |  1 +
 fetch-pack.c                         | 67 ++++++++++++++++++----------=
--------
 fetch-pack.h                         |  3 +-
 shallow.c                            | 30 ++++++++++++++--
 t/t5500-fetch-pack.sh                |  7 ++++
 t/t5504-fetch-receive-strict.sh      |  2 +-
 transport.c                          |  2 ++
 transport.h                          |  1 +
 15 files changed, 120 insertions(+), 99 deletions(-)

--=20
1.8.2.83.gc99314b
