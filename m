From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Fix an off by one bug in pretty.c
Date: Sat, 5 Jan 2008 23:55:37 +0100
Message-ID: <e5bfff550801051455i3d589c4q9375aeab0cb6aa47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBHw2-00068q-IW
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 23:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYAEWzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 17:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbYAEWzl
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 17:55:41 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:23109 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbYAEWzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 17:55:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6588885rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 14:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Dq5wKbkGnvol1Zl/EPWijkpq9rkP4YJTJKreMS2fdYk=;
        b=lGF9wnEgXb4c6i60FeLnPefHn12Jikm+vRcGvmCosn9cnUPGgpeUX/xcJTfC4XIMQHD0EpKlz/eFUg2n0w+7i/K60vHMIZ18lOa3jHnPc6D7Di3zBcQXHC+8FNVf/zB/s9d860poPSV5y1SNeE3Kf8C4PMYukTFVRwThwlAxNQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=v20tGJBLeRe3HeQ6rK5eX+axKC5zHeBgMngpZ0+LffLi0+DvyWQsF2dVv+de8muvO2pozuE1RUfkdltKh3n2qq+VLYtu6YrPGYxJhtSm9xE6qCScCVtUW/30amNSfc2YY0N3csE5Zl8Y6wUb7uW29yVrjDVzVKNEvFXW4NdfQM4=
Received: by 10.141.68.12 with SMTP id v12mr403427rvk.111.1199573737792;
        Sat, 05 Jan 2008 14:55:37 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 5 Jan 2008 14:55:37 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69691>

In case author email is <> then we have the following
bug in function 'format_person_part'

/* parse name */
for (end = 0; end < len && msg[end] != '<'; end++)
       ; /* do nothing */

start = end + 1; /* now start points to '>' */

-- cut ---

/* parse email */
for (end = start + 1; end < len && msg[end] != '>'; end++)

And here 'end' is initialized with 'start + 1'
instead of 'start'. This turns out in empty commit
date when git log is used with --pretty=format option.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 pretty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5b1078b..0b2f187 100644
--- a/pretty.c
+++ b/pretty.c
@@ -292,7 +292,7 @@ static void format_person_part
 	/* parse name */
 	for (end = 0; end < len && msg[end] != '<'; end++)
 		; /* do nothing */
-	start = end + 1;
+	start = end;
 	while (end > 0 && isspace(msg[end - 1]))
 		end--;
 	if (part == 'n') {	/* name */
-- 
1.5.4.rc2.38.gd6da3-dirty
