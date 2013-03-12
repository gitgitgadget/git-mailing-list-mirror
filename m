From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/13] Exclude optimizations
Date: Tue, 12 Mar 2013 20:04:47 +0700
Message-ID: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOu2-0007HA-6I
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab3CLNFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:05:36 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:50918 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab3CLNFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:05:18 -0400
Received: by mail-da0-f51.google.com with SMTP id z17so1253121dal.24
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=D7oKnTE6PMbRLn3uJRWhHHKqv1qi0QvuPWvsceqqRLI=;
        b=x3VIG30b8cGe5EtkhUT3cOxG231k1xt69a646CM2NufpuuZd2iiM23Etykyfwm/OG0
         DFmNeik1wyQ0chz2yqTmqTD4Bw6/49oNVVZ4uwfXxA0Yn0EEbyT5oAnQKoePt1uHnmL1
         5rSkVSK7Mx8KAg5hGIApQM6ZtY9HCkR3ObMQgGbKd/MNiPPv0y/j2zZLrQapL2nlawwh
         ygSTWe+P8OXYv5KsBvpljYtgGpzUgLR3WMsRufrX0BjB5WZBMyUm6lNzb95DvIlhjgh4
         kUI3KXMgVeTx72tzeHy2gobBS4PgLJaSrL34/Yx+BwYYkQqL7dxWE5Bq02EgMXnLUo8R
         Bsbw==
X-Received: by 10.68.189.199 with SMTP id gk7mr30025309pbc.164.1363093517086;
        Tue, 12 Mar 2013 06:05:17 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id pn9sm24992339pbb.22.2013.03.12.06.05.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:05:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:09 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217950>

Result of today. I cherry-picked nd/read-directory-recursive-optim to
see how far I can get after pulling all the tricks. This is a slower
machine so time is longer. Anyway, read_directory time is reduced
about 70% in the end.

function              before after
----------------------------------
treat_leading_path:   0.000  0.000
read_directory:       4.102  1.235
+treat_one_path:      2.843  0.531
++is_excluded:        2.632  0.102
+++prep_exclude:      0.225  0.040
+++matching:          2.054  0.035
++dir_exist:          0.035  0.035
++index_name_exists:  0.292  0.225
lazy_init_name_hash:  0.258  0.155
+simplify_away:       0.085  0.083
+dir_add_name:        0.446  0.000

I don't expect all these patches to go in. The meat is
nd/read-directory-recursive-optim (or 10/13) and 09/13. Some other
patches are safe even if they do not contribute much to the gain. The
last two are probably not worth the trouble.


Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (13):
  dir.c: add MEASURE_EXCLUDE code for tracking exclude performance
  match_pathname: avoid calling strncmp if baselen is 0
  dir.c: inline convenient *_icase helpers
  match_basename: use strncmp instead of strcmp
  match_{base,path}name: replace strncmp_icase with memequal_icase
  dir: pass pathname length to last_exclude_matching
  exclude: avoid calling prep_exclude on entries of the same directory
  exclude: record baselen in the pattern
  exclude: filter out patterns not applicable to the current directory
  read_directory: avoid invoking exclude machinery on tracked files
  Preallocate hash tables when the number of inserts are known in advan=
ce
  name-hash: allow to lookup a name with precalculated base hash
  read_directory: calculate name hashes incrementally

 Makefile          |   1 +
 attr.c            |   6 +-
 cache.h           |   2 -
 diffcore-rename.c |   1 +
 dir.c             | 392 ++++++++++++++++++++++++++++++++++++++++++++--=
--------
 dir.h             |  26 +++-
 hash.h            |   7 +
 name-hash.c       |  49 ++++---
 name-hash.h (new) |  45 +++++++
 read-cache.c      |   1 +
 unpack-trees.c    |   1 +
 11 files changed, 431 insertions(+), 100 deletions(-)
 create mode 100644 name-hash.h

--=20
1.8.1.2.536.gf441e6d
