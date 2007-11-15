From: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [PATCH] Fix "identifier redeclared" compilation error with SUN cc.
Date: Thu, 15 Nov 2007 02:15:03 +0100
Message-ID: <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: raa.lkml@gmail.com, git@ostkamp.fastmail.fm, git@vger.kernel.org,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 15 02:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTKI-0006IT-SG
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760391AbXKOBPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 20:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760175AbXKOBPI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:15:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:58060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759741AbXKOBPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 20:15:06 -0500
Received: (qmail invoked by alias); 15 Nov 2007 01:15:04 -0000
Received: from i577BBF04.versanet.de (EHLO localhost) [87.123.191.4]
  by mail.gmx.net (mp045) with SMTP; 15 Nov 2007 02:15:04 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18eN2kfVzQev463T4JWaM7BOVEWWqCwWH7rwqeNie
	WDj99ycXoW9TgX
X-Mailer: git-send-email 1.5.3.5.643.g40e25
In-Reply-To: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65037>

Some versions of SUN's cc have a bug that causes them to complain about
a redeclared identifier when you use a function declaration that takes =
a
struct with a FAM and this struct has only been declared but not yet
defined.

IOW, this will fail:
	struct foo;

	void bar(struct foo *);

	struct foo {
		int v;
		long *a[];
	};

	void bar(struct foo *foo) {} // SUN cc bug strikes here

So when we detect a SUN cc, we use an array size of 1 to workaround tha=
t
bug.

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
---
Guido, could you please test this patch?

I have no clue which versions of SUN's cc are affected, so I simply ena=
bled
the workaround for all versions. Someone with more knowledge about that
should probably limit the check to only do that for the broken versions=
=2E

 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index ede9408..c3ff4b4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -6,6 +6,8 @@
 #ifndef FLEX_ARRAY
 #if defined(__GNUC__) && (__GNUC__ < 3)
 #define FLEX_ARRAY 0
+#elif defined(sun) || defined(__SUN__)
+#define FLEX_ARRAY 1
 #else
 #define FLEX_ARRAY /* empty */
 #endif
--=20
1.5.3.5.643.g40e25
