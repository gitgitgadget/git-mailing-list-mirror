From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/12] pack v4 support in index-pack
Date: Sat,  7 Sep 2013 17:43:07 +0700
Message-ID: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFwY-0002T1-O7
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab3IGKkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:40:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44098 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3IGKkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:40:36 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4251603pbb.33
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wVO0ocxiyKxIyADThVIl8QiltwGMuqZ78CCnDY8feBM=;
        b=d51UAtuXgYxTqS/fXJRVmN2h4P2c6jl02A3o9Eg8/r1DMrSjUcf4jM0w+czgvJHpUY
         P0VnehPEBlORFiGcKkumQ8tPi4MG6g1HNJZKD5Jjz763ul1Gzz3dsO/NT5cRXYHUvVUv
         trf0CR3f3dMVSlcHEhqNHhKnZH77tXqcaZ8UMWpCNMoQv6DA+mUwylRHbWiB63onNhSk
         D7+PZHir/UuZcjQgJfmMc+ic4SLoSgsvygSadmXdcVFWC4S1O1JiFJzjHrwlJIWOr3my
         RO8mkhm7iLyXbBap5JYuzOPrlLNeiBJmC9FTpLC7DVIXF4zHLoaUGPN6nnEZncln0sse
         7Y6w==
X-Received: by 10.68.178.35 with SMTP id cv3mr1156472pbc.160.1378550436037;
        Sat, 07 Sep 2013 03:40:36 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id fl3sm3944904pad.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:40:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:43:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234118>

This makes index-pack recognize pack v4. It still lacks:

 - the ability to walk through multi-base trees
 - thin pack support

The first is not easy to solve imo and but does not impact us in short
term because pack-objects probably will not learn to produce such
trees any time soon.

The second should be done after pack-objects can produce thin packs,
else it's hard to verify that the code works as expected.

This bases on Nico's tree, which does not really match the series this
post is replied to due to some format changes. I don't know, maybe we
could share more code with packv4-parse.c. Right now I just need
something that works and somewhat maintainable.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  pack v4: split pv4_create_dict() out of load_dict()
  index-pack: split out varint decoding code
  index-pack: do not allocate buffer for unpacking deltas in the first =
pass
  index-pack: split inflate/digest code out of unpack_entry_data
  index-pack: parse v4 header and dictionaries
  index-pack: make sure all objects are registered in v4's SHA-1 table
  index-pack: parse v4 commit format
  index-pack: parse v4 tree format
  index-pack: move delta base queuing code to unpack_raw_entry
  index-pack: record all delta bases in v4 (tree and ref-delta)
  index-pack: skip looking for ofs-deltas in v4 as they are not allowed
  index-pack: resolve v4 one-base trees

 builtin/index-pack.c | 679 +++++++++++++++++++++++++++++++++++++++++++=
+-------
 packv4-parse.c       |  63 ++---
 packv4-parse.h       |   8 +
 3 files changed, 627 insertions(+), 123 deletions(-)

--=20
1.8.2.83.gc99314b
