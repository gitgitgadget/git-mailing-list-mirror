From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/3] mailinfo: ensure handle_filter gets only one line at a time
Date: Fri, 15 Feb 2008 16:53:36 -0500
Message-ID: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 22:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8Vf-0007Pw-3g
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 22:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbYBOVxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 16:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757340AbYBOVxn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 16:53:43 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:35923 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbYBOVxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 16:53:42 -0500
Received: by an-out-0708.google.com with SMTP id d31so183898and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wjQdplFc1dCJZMkFDk2RYtyoHbj3mJ5JHNrDiyOmCYI=;
        b=FjF26iJ4EVEja84716b8UzE+8/m6aq18/F6O/bdyZRw6Dz8sowcdL59t/Xfoq6Hp95D3E1gzfLji2wPq6M7g9H/YsTPWowWj2vjGIQL51SeDwhxBZCtlFB2Er4bgOPAd3PVz49YLyxbNkJDg0vHL8foz+KZGoqL9kK82nEmSeuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gdsB+BakLH22LhVnspYt7Obnspn/HDVZYXXri9lspWxwE27jGgS3lF1RQz+FuR4BmR6XT5ndZDctIxYrLUE6AlsVKH3VmgdacrCVJpBVA2or6gmZQjmkE34oSKCGnxpnMGlf9cKSzoStZbBpm1/nHp52bNkYigrWKdow6eo+jZQ=
Received: by 10.101.66.14 with SMTP id t14mr4797004ank.5.1203112421718;
        Fri, 15 Feb 2008 13:53:41 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id b14sm8967656ana.26.2008.02.15.13.53.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 13:53:41 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
In-Reply-To: 1203042077-11385-1-git-send-email-jaysoffian@gmail.com
References: 1203042077-11385-1-git-send-email-jaysoffian@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73987>

handle_filter() is only supposed to get one line at a time.
handle_body() already ensures this after decoding BASE64 messages per
this comment:

/* this is a decoded line that may contain
 * multiple new lines.  Pass only one chunk
 * at a time to handle_filter()
 */

QP messages need to be similarly processed since decoding QP can also
add newlines.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I broke this change out into it's own patch since it's independent of
the format=flowed additions.

 builtin-mailinfo.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2600847..11f154b 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -818,6 +818,7 @@ static void handle_body(void)
 
 		switch (transfer_encoding) {
 		case TE_BASE64:
+		case TE_QP:
 		{
 			char *op = line;
 
-- 
1.5.4.1.1281.g75df
