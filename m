From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 5/6] transport-helper.c::push_refs(): ignore helper-reported status if ref is not to be pushed
Date: Fri,  8 Jan 2010 10:12:44 +0800
Message-ID: <1262916765-3728-6-git-send-email-rctay89@gmail.com>
References: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
 <1262916765-3728-2-git-send-email-rctay89@gmail.com>
 <1262916765-3728-3-git-send-email-rctay89@gmail.com>
 <1262916765-3728-4-git-send-email-rctay89@gmail.com>
 <1262916765-3728-5-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:14:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4Ml-0005XW-J5
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab0AHCNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352Ab0AHCNy
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:13:54 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51560 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0AHCNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:13:53 -0500
Received: by ywh6 with SMTP id 6so19095420ywh.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:references;
        bh=Xy/m611q4iqD5KNMDKhzIJVCMTQg6vUkfqUNaZNtIdg=;
        b=xGcE13TvyibJeLQKkhKt0TqWzTIl/t+l0+rlBql/CGcsU1Ya64EZXO32uTK/4w2L/F
         4ykJeOmEmvywDoNaL8H9Dyb6uWNhV9DruhX5ecn/vkKMDvPiuY/VSWCb2MopCJ8L+YHo
         tCb2osV0dEWUxOhSWPrZqsQViqwRdU9Pixkuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q7FlbBfRpwTQShehQMAAjJfZEsvzmpifjNIwwrMqIv6m6iSTJM2eFpNUGRo9Dgmjo/
         iWcwRO7WE98RSSAigq7rxqEy6b75QCavNC6UG7NHQubu4S4zlAe90a3BjUE6RT8Nm0+O
         7z+u0Kn0BQCtmIzyzF3gja1lOteg7RdsE6uXk=
Received: by 10.101.180.14 with SMTP id h14mr21741069anp.175.1262916832204;
        Thu, 07 Jan 2010 18:13:52 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm10999449gxk.10.2010.01.07.18.13.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 18:13:51 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262916765-3728-5-git-send-email-rctay89@gmail.com>
References: <20091224154445.ad4b7a01.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136410>

If the status of a ref is REF_STATUS_NONE, the remote helper will not
be told to push the ref (via a 'push' command).

However, the remote helper may still act on these refs.

If the helper does act on the ref, and prints a status for it, ignore
the report (ie. don't overwrite the status of the ref with it, nor the
message in the remote_status member) if the reported status is 'no
match'.

This allows the user to be alerted to more "interesting" ref statuses,
like REF_STATUS_NONFASTFORWARD.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v3:
 - consider a ref as marked not for pushing if its status is _not_
   none, rather than checking if the status is nonff or uptodate.
 - ignore ref status reported by remote helper only if it reported 'no
   match'

 t/t5541-http-push.sh |    2 +-
 transport-helper.c   |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 979624d..83a8e14 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -111,7 +111,7 @@ Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
 section of '"'git push --help'"' for details." output
 '

-test_expect_failure 'push fails for non-fast-forward refs unmatched by remote helper' '
+test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
 	# create a dissimilarly-named remote ref so that git is unable to match the
 	# two refs (viz. local, remote) unless an explicit refspec is provided.
 	git push origin master:retsam
diff --git a/transport-helper.c b/transport-helper.c
index 7c9b569..71a1e50 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -430,6 +430,15 @@ static int push_refs(struct transport *transport,
 			continue;
 		}

+		if (ref->status != REF_STATUS_NONE) {
+			/*
+			 * Earlier, the ref was marked not to be pushed, so ignore the ref
+			 * status reported by the remote helper if the latter is 'no match'.
+			 */
+			if (status == REF_STATUS_NONE)
+				continue;
+		}
+
 		ref->status = status;
 		ref->remote_status = msg;
 	}
--
1.6.6.341.ga7aec
