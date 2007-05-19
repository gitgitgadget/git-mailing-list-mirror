From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/5] Fix config caching so that get, set, get works
Date: Sat, 19 May 2007 02:09:51 +0200
Message-ID: <20070519000951.4906.61408.stgit@yoghurt>
References: <20070519000451.4906.87089.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:10:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCWK-0002GJ-H8
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbXESAJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 20:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754768AbXESAJ5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:09:57 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51677 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754645AbXESAJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 20:09:56 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:54507 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HpCWA-0006fp-5r; Sat, 19 May 2007 02:09:55 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HpCW7-0001K4-Oi; Sat, 19 May 2007 02:09:51 +0200
In-Reply-To: <20070519000451.4906.87089.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HpCWA-0006fp-5r.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HpCWA-0006fp-5r d94d18086bf513d6ccbd62f2764dfe21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47686>

The config caching was never invalidated or updated, which caused the
two gets to always return the same value regardless of the value
passed to set.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/config.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index 79cd12f..2fd1273 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -99,12 +99,15 @@ class GitConfig:
=20
     def rename_section(self, from_name, to_name):
         self.__run('git-repo-config --rename-section', [from_name, to_=
name])
+        self.__cache.clear()
=20
     def set(self, name, value):
         self.__run('git-repo-config', [name, value])
+        self.__cache[name] =3D value
=20
     def unset(self, name):
         self.__run('git-repo-config --unset', [name])
+        self.__cache[name] =3D None
=20
     def sections_matching(self, regexp):
         """Takes a regexp with a single group, matches it against all
