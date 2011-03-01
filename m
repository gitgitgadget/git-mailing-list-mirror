From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs by ':'
Date: Tue,  1 Mar 2011 11:21:17 +0100
Message-ID: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 11:24:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuMl6-00047j-Ca
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 11:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab1CAKYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 05:24:43 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49180 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755920Ab1CAKYm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 05:24:42 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C8B6B20A4B;
	Tue,  1 Mar 2011 05:24:41 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 01 Mar 2011 05:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=OQqPvBUue9kuz+Rh/B8gYHTmHG0=; b=pgh/3XwzJjsmVrhmgirQiH+ckIY9sh02dW87ev6PVA9HHwjy1Gicx9sAtobO98D97r4OLx1VhxiXw7lEYSXvuItqAb+h3it3tpHXqw0zE0Cs1yhBlM/SHyyaBEXXdeDWFsiphU49/ZqkrG6cP9Pj4EMRw3ociHJGp9hwOGd5qgs=
X-Sasl-enc: Z5ne4xcdwi/1DTG8B5y3eilWjRO63LjRaAyHDp2qzrGG 1298975081
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 47BA040BF96;
	Tue,  1 Mar 2011 05:24:41 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.257.gb09fa
In-Reply-To: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168207>

Introduce a leading ':' as the notation for repo-wide pathspecs.

This is in line with our treeish:path notation which defaults to
repowide paths.

Heck: Even ':./path' works for pathspecs, and I have no clue why!

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I have not tested this for adverse side effects, only for the intended ones
with "git grep".

It's an alternative to "--full-tree", more far reaching, maybe too far.
But we seem to accept that paths do not start with ':', and that notation
should make msys happy, but what do I know about msys.

(one could stick this into prefix_path() rather than get_pathspec(), but that
would be way too far)

 setup.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 021d013..e7b05f0 100644
--- a/setup.c
+++ b/setup.c
@@ -147,7 +147,11 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	dst = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
 	while (*src) {
-		const char *p = prefix_path(prefix, prefixlen, *src);
+		const char *p;
+		if ((*src)[0] == ':')
+			p = prefix_path(NULL, 0, (*src)+1);
+		else
+			p = prefix_path(prefix, prefixlen, *src);
 		*(dst++) = p;
 		src++;
 	}
-- 
1.7.4.1.257.gb09fa
