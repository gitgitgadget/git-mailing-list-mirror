From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] check_everything_connected replacement
Date: Sun, 31 Mar 2013 18:09:04 +0700
Message-ID: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 13:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMG8l-0007EW-AJ
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 13:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab3CaLJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 07:09:06 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:46102 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3CaLJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 07:09:05 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so916761pab.10
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=RRfptuHhpwuzDdtPUMe7W6wFlYD9U1rxS6Dg6tg23v4=;
        b=JAVsVNN/sTLx7MxBQffkFYb065zxw+d9togONAHeOkciQ4DTgCt059vCKLjHrtWHde
         RGEvhHVYixT7yNphzK7bD573x9Kfv8AH5Kh4K+6kL47+TYnn5YAy41zYna79GHUz2TWh
         wQwPTD723EgL5fHSgwKOrVte0uvnkl/Vmjw2CisBgBFP06keEz1kwDY8ln8dtyUS1ehy
         BLe/POuX+bqNNKoCGXkR4kHms+V/qGfjdo3BIFdt6OI1sp3CjVyd08Cvdisus5P/QF1I
         moN2SwuNGntRJNAyYSJQ9au3SMfMiUXMFGD/q4yFGu7Sin3vpBAgZ1eSqItSp2dLy/Ro
         Kxvg==
X-Received: by 10.66.246.9 with SMTP id xs9mr13608995pac.123.1364728143711;
        Sun, 31 Mar 2013 04:09:03 -0700 (PDT)
Received: from lanh ([115.74.58.181])
        by mx.google.com with ESMTPS id ti8sm9730495pbc.12.2013.03.31.04.09.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 04:09:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Mar 2013 18:09:09 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219611>

My investigation in lowering connectivity check cost in git-clone [1]
led me to try 'index-pack --strict' code. Without calling fsck_object()=
,
--strict seems to be cheaper than check_everything_connected() while
accomplishing the same thing (imo).

The first patch is a bug fix running git-clone --depth with
fetch.fsckObjects on. The second is "fix while i'm there". The third
introduces check_everything_connected alternative. The fourth makes
use of it.

The last use of check_everything_connected after this series is
fetch.c:quickfetch(), which I think is unnecessary. It can only catch
errors if we have incomplete object islands in repo, which could
happen before this series. After this series, incomplete object
islands can't enter the repository, at least via git transport. So
maybe we should remove that check_everything_connected too (maybe
after a few years, enough time for the laziest user to run fsck/repack
once).

[1] http://article.gmane.org/gmane.comp.version-control.git/219602

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  fetch-pack: save shallow file before fetching the pack
  index-pack: remove dead code (it should never happen)
  index-pack, unpack-objects: add --not-so-strict for connectivity chec=
k
  Use --not-so-strict on all pack transfer for connectivity check

 builtin/fetch.c                 |  6 ----
 builtin/index-pack.c            | 10 ++++--
 builtin/receive-pack.c          | 22 +++----------
 builtin/unpack-objects.c        |  9 ++++--
 fetch-pack.c                    | 72 +++++++++++++++++++++++----------=
--------
 t/t5500-fetch-pack.sh           |  7 ++++
 t/t5504-fetch-receive-strict.sh |  2 +-
 7 files changed, 66 insertions(+), 62 deletions(-)

--=20
1.8.2.83.gc99314b
