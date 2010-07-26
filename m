From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] Subtree clone?
Date: Tue, 27 Jul 2010 06:36:08 +0700
Message-ID: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 15:10:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odjv6-0001QP-F1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 15:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab0G0NKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 09:10:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44938 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab0G0NJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 09:09:59 -0400
Received: by pzk26 with SMTP id 26so1338166pzk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2l7xyEmlljtlOnKgKRySOxwSZGRRyU2biZN9TytKN38=;
        b=rWlAGT+ZJyQ3+t6erRd8eCGPvBgjRPZ91DsCYGjief4T4TPpA/Ndr91QJafxv0uRLD
         v0VUqK1DnPI0EYDdxkgcCYdX9OgQrJU0Vaa1rSLmpsD+5AAYChvA5pqE/lp57Q066NbP
         1lAbhyPK1xyKeZZ3I5LQd26IqaFw6qmSuxHcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Ssr+QhyFC4TL7/Xck2xQYuUoZEw1Gpk9jeSzxV/xw5Juv/kOdRr1Js8Up0H1hOn7fg
         ofl6aSZH51vkXbaOWXGcovsTILJgzMyQ7Dj5wQIZwsEs1dK+1+wsb52bK473Xco0+KrS
         ionjkSHPHh+oplmBWdekgVEqOwFGl1NM9u0u8=
Received: by 10.114.137.13 with SMTP id k13mr13270863wad.221.1280236198834;
        Tue, 27 Jul 2010 06:09:58 -0700 (PDT)
Received: from dektop ([119.12.193.247])
        by mx.google.com with ESMTPS id n32sm8826428wag.23.2010.07.27.06.09.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 06:09:57 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 27 Jul 2010 06:36:17 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151937>

This idea sounds quite nice to me. That is, instead of modifying git
core to support narrow/partial clone, {upload,fetch}-pack is modified
to give clients enough objects of so it can reconstruct a valid tree.
Users are free to do whatever they want on that tree. When they want to
push changes back, Git client creates proper commit/tree objects and
push.

The two patches in this series allow git to send objects of a subtree
to client, or just a barebone subtree without blobs. The client can
rewrite commits and throw the old commits.

I don't want to add much computation to server side, subtree looks
like a good fit (i.e. simply prefixcmp). Sparse checkout can then be
used to shape worktree if subtree is not good enough.

All the hard work is at client side, and git-subtree is a good
candidate. Well, the idea is inspired by recent discussions of
git-subtree vs git-submodule anyway.

Lazy clone does something similar. However lazy clone requires
connectivity to upstream. Lazy clone also exposes a security issue,
allowing client to get any object it wants.

Comments?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  upload-pack: support subtree packing
  fetch-pack: support --subtree and --commit-subtree options

 builtin/fetch-pack.c |   15 +++++++++++++++
 upload-pack.c        |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletions(-)
