From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Do not fetch tags on new shallow clones
Date: Wed,  4 Jan 2012 18:35:22 +0700
Message-ID: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 12:36:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiP8W-0006EQ-9V
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 12:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab2ADLfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jan 2012 06:35:52 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55039 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2ADLfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 06:35:50 -0500
Received: by iaeh11 with SMTP id h11so32437404iae.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=MjYHHMgTY3sFKNkiYMt6zX1A+KHNod1itCIDUH7mXKI=;
        b=DrlkkNMxcjn4Bn/NKMKsU3yowdeIQX66x5MWN2FaPd5HtHLgdAQjBKfHTelsnYLEwE
         JGhguNJTXLqVGrvgVQZOYb9BCMXYpI+tC4jVu4vfS7KN5x2msnOl60nlRoH1kqB+LegH
         QUF8G0e854pszs2FsQF9ZW4ctmk83/d1HSHRs=
Received: by 10.50.222.233 with SMTP id qp9mr67147077igc.1.1325676950033;
        Wed, 04 Jan 2012 03:35:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.60.181])
        by mx.google.com with ESMTPS id gh9sm116914763igb.3.2012.01.04.03.35.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Jan 2012 03:35:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 04 Jan 2012 18:35:23 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187920>

The main purpose of shallow clones is to reduce download. Fetching
tags likely defeats this purpose because old-enough repos tend to have
a lot of tags, spreading across history, which may increase the number
of objects to download significantly.

=46or example, "git clone --depth=3D10 git://.../git.git" without chang=
es
fetches ~16M (50k objects). The same command with changes fetches
~6.5M (10k objects).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This could also be applied for normal clones. But I don't think
 there are many use cases for it, enough to deserve new --no-tags
 option.

 We should also fetch a single branch, but because branches are
 usually less crowded and stay close the tip, they do not produce too
 many extra objects. Let's leave it until somebody yells up.

 We should also fetch tags that reference to downloaded objects. But I
 don't know how fetch does that magic, so for now users have to do
 "git fetch" after cloning for tags. I have only gone as far as
 fetching tags along by setting TRANS_OPT_FOLLOWTAGS? Help?

 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 86db954..abd8578 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -428,7 +428,7 @@ static struct ref *wanted_peer_refs(const struct re=
f *refs,
 	struct ref **tail =3D head ? &head->next : &local_refs;
=20
 	get_fetch_map(refs, refspec, &tail, 0);
-	if (!option_mirror)
+	if (!option_mirror && !option_depth)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
=20
 	return local_refs;
--=20
1.7.8.36.g69ee2
