X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add verbose comments to split_msg()
Date: Mon, 11 Dec 2006 23:12:51 +0100
Message-ID: <200612112212.51533.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 22:15:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition;
        b=fVEongd2vese0GrQgFwJ5RmVqXhv3VXED4M/qcit5+omIabaa672fLJ01Dl0+R/yY05BxEedUy3R7wwRcfffaF3ObO8JHK/bZojOO1y3oE7aXXTXf9z9UGrXQuKAQl+dpOVMRcOcLPxhBxlFLMibWEawhz7NRCXqjzb6xjiAXWc=
X-TUID: 1d91cf6b21755007
X-UID: 184
X-Length: 2285
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34042>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GttR8-0000UL-Pu for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763163AbWLKWPr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763164AbWLKWPr
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:15:47 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:6527 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1763162AbWLKWPq (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 17:15:46 -0500
Received: by an-out-0708.google.com with SMTP id b33so336823ana for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 14:15:45 -0800 (PST)
Received: by 10.78.172.20 with SMTP id u20mr1713941hue.1165875343890; Mon, 11
 Dec 2006 14:15:43 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 16sm2908369hui.2006.12.11.14.15.43; Mon, 11 Dec
 2006 14:15:43 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I was going to fix a bug in imap-send that was making it include the "From "
line from git-format-patch in the message sent to the IMAP server.  So I
commented up what split_msg already does.

It turns out the bug was fixed in commit
e0b0830726286287744cc9e1a629a534bbe75452.  So comments only, no fix needed.
(cherry picked from 3d5b1768f15b5cd430b869f416e72f4f3afe3d4a commit)

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 imap-send.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a6a6568..110bd54 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1216,35 +1216,48 @@ split_msg( msg_data_t *all_msgs, msg_data_t *msg, int *ofs )
 {
 	char *p, *data;
 
+	/* Clear this message's slot */
 	memset( msg, 0, sizeof *msg );
+	/* If we've run out of data, stop*/
 	if (*ofs >= all_msgs->len)
 		return 0;
 
+	/* Point at the next message chunk */
 	data = &all_msgs->data[ *ofs ];
+	/* This message length is at most, the length of all messages
+	 * minus our current position */
 	msg->len = all_msgs->len - *ofs;
 
+	/* If there isn't enough data remaining for a whole message or there
+	 * is no , give up */
 	if (msg->len < 5 || strncmp( data, "From ", 5 ))
 		return 0;
 
+	/* Find the end of the "From " line */
 	p = strchr( data, '\n' );
 	if (p) {
+		/* Skip this line from the outgoing buffer */
 		p = &p[1];
 		msg->len -= p-data;
 		*ofs += p-data;
 		data = p;
 	}
 
+	/* Find the next message (if any) */
 	p = strstr( data, "\nFrom " );
 	if (p)
 		msg->len = &p[1] - data;
 
+	/* Alloc enough space for this message */
 	msg->data = xmalloc( msg->len + 1 );
 	if (!msg->data)
 		return 0;
 
+	/* Copy the message from "all" to it's own holder and terminate */
 	memcpy( msg->data, data, msg->len );
 	msg->data[ msg->len ] = 0;
 
+	/* Move the data pointer to the next message */
 	*ofs += msg->len;
  	return 1;
 }
-- 
1.4.4.1.geeee8

