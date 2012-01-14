From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/3] nd/index-pack-no-recurse
Date: Sat, 14 Jan 2012 19:19:52 +0700
Message-ID: <1326543595-28300-1-git-send-email-pclouds@gmail.com>
References: <1326081546-29320-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 13:20:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm2bK-0002IC-UH
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 13:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab2ANMU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 07:20:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36772 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2ANMUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 07:20:25 -0500
Received: by iaby12 with SMTP id y12so695187iab.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 04:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xpHvE0+Qcqk0P3N0WOYbp2lCQ+qXu28idLj1Dm1r8Jg=;
        b=cSBhr173LEJbMa2Rr0SPsfscClK26I0BdbNKGJzYr/SQJjSpLxaceUKKp3GhT7fgGc
         o2Mvmja3RlrBpf+MNY1anCdqBca/Nhyo3T11xMIq+vxXSTXLznCioW1ikYBqSZ0GIJdm
         IG1Iv5PsVM45rPE1F4U68qH4ZHLsrIE4I2RrA=
Received: by 10.50.15.161 with SMTP id y1mr5929458igc.4.1326543625189;
        Sat, 14 Jan 2012 04:20:25 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.201])
        by mx.google.com with ESMTPS id q30sm40529225ibc.1.2012.01.14.04.20.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Jan 2012 04:20:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 14 Jan 2012 19:19:56 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1326081546-29320-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188563>

This round adds more explanation in commit message of 2/3 and comment
before get_base_data() in 3/3. Changes in 3/3 does not really address
Junio's concern regarding maintainability though.

It also fixes a regression in 3/3. In current code, get_base_data()
goes up as far as the first deflated parent. v2 of this series always
goes up to top parent. v3 fixes this.

Junio raised a point about depth-first vs breadth-first search in 1/3. =
I
have not addressed that either, but it makes me wonder if we may
benefit from using bfs in find_unresolved_deltas(), 2/3. If the delta
chains form a fork-like figure (e.g. long delta chains sharing common
base), then we may run out of cache doing dfs on one chain, by the
time we get back on the common base, we would need to deflate them
again.

Another observation is recursion in get_base_data() is unlikely to be
called in real life. With 16M default delta base cache, git.git does
not trigger it at all. Perhaps repos with large blobs have better chanc=
e..

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  Eliminate recursion in setting/clearing marks in commit list
  index-pack: eliminate recursion in find_unresolved_deltas
  index-pack: eliminate unlimited recursion in get_base_data()

 builtin/index-pack.c |  164 ++++++++++++++++++++++++++++++++++--------=
-------
 commit.c             |   13 ++++-
 revision.c           |   45 +++++++++-----
 3 files changed, 154 insertions(+), 68 deletions(-)

--=20
1.7.8.36.g69ee2
