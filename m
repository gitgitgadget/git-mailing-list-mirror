From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v3] Do not decode url protocol.
Date: Tue, 22 Jun 2010 13:58:17 +0200
Message-ID: <AANLkTik2M4Wxa-C6iRf7ShlcrwXu1ALNXtKwbA-mO5ge@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 22 13:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR27T-0003vp-V3
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 13:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab0FVL6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 07:58:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39550 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab0FVL6S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 07:58:18 -0400
Received: by gwaa12 with SMTP id a12so897060gwa.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 04:58:17 -0700 (PDT)
Received: by 10.101.144.18 with SMTP id w18mr5047868ann.247.1277207897258; 
	Tue, 22 Jun 2010 04:58:17 -0700 (PDT)
Received: by 10.100.171.12 with HTTP; Tue, 22 Jun 2010 04:58:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149479>

When using the protocol git+ssh:// for example we do not want to
decode the '+' as a space.

This fixes a regression introduced in 9d2e942.
---
 url.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/url.c b/url.c
index cd32b92..94a42a5 100644
--- a/url.c
+++ b/url.c
@@ -70,9 +70,18 @@ static int url_decode_char(const char *q)
 static char *url_decode_internal(const char **query, const char *stop_at)
 {
 	const char *q = *query;
+	const char *first_slash;
 	struct strbuf out;

 	strbuf_init(&out, 16);
+
+	/* Skip protocol. */
+	first_slash = strchr(*query, '/');
+
+	while (q < first_slash) {
+		strbuf_addch(&out, *q++);
+	}
+
 	do {
 		unsigned char c = *q;

-- 
1.7.1.524.g6df2f

Ok, given Matthieu comments here is another version of the patch which
should apply cleanly
and won't clobber log message with my comments!

Note that it is safe to do this in url_decode_internal as we know that
here we have an url
with a protocol specified.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
