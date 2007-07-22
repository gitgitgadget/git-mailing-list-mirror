From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Avoid to duplicate commit message when is not encoded
Date: Sun, 22 Jul 2007 10:23:05 +0200
Message-ID: <e5bfff550707220123g5826cbf5n3e2ff7256d9b5366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 10:23:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICWih-0002vb-NC
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 10:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbXGVIXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 04:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbXGVIXK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 04:23:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:57009 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbXGVIXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 04:23:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1591742wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 01:23:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BdapPjbP66v5CeUkmsBIEHWTbh1YeFyfg+yldv2MRCeIXsQrPxQhoUBF2ECI2BHvl7cMrw7DRFE9/B7E5Ml5mTWgGjiD9zczCZV3KbAoFMUB2Be91U54xdXb1jrjT9UZbCY5qV/UjijmQfE2rPSpVmWAWJQ18XiWI/h2WfskEG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BB1FuxAArGHJW0d24cef3NKoLkATbv/K/T3wJ1sqxpKnFZfFohiKsK8Q1iRT/3daPujnUNCQg5ORviFn2gUl5ns2Y1TVr4/XUfnIQzMVfDeuSbxnB1SJhRgInPi2/YpGT3KtKUCdSCe21XBsfFI+ssOsO7IF+34b0EESH+47wig=
Received: by 10.114.94.1 with SMTP id r1mr1969902wab.1185092585669;
        Sun, 22 Jul 2007 01:23:05 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 22 Jul 2007 01:23:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53234>

When a commit message doesn't have encoding information
and encoding output is utf-8 (default) then an useless
xstrdup() of commit message is done.

If we assume most of users live in an utf-8 world, this
useless copy is the common case.

Performance issue found with KCachegrind.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 commit.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 4c5dfa9..ba8413b 100644
--- a/commit.c
+++ b/commit.c
@@ -721,7 +721,10 @@ static char *logmsg_reencode(const
 	encoding = get_header(commit, "encoding");
 	use_encoding = encoding ? encoding : utf8;
  	if (!strcmp(use_encoding, output_encoding))
-		out = xstrdup(commit->buffer);
+		if (encoding) // we'll strip encoding header later
+			out = xstrdup(commit->buffer);
+		else
+			return NULL; // nothing to do
 	else
 		out = reencode_string(commit->buffer,
 				      output_encoding, use_encoding);
-- 
1.5.3.rc2.23.g4c77-dirty
