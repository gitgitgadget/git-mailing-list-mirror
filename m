From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 5/6] transport-helper.c::push_refs(): ignore
 helper-reported status if ref is not to be pushed
Date: Thu, 24 Dec 2009 15:44:45 +0800
Message-ID: <20091224154445.ad4b7a01.rctay89@gmail.com>
References: <20091224154352.ecefd242.rctay89@gmail.com>,
 <20091224154258.08b4fe44.rctay89@gmail.com>,
 <20091224154158.15ba580f.rctay89@gmail.com>,
 <20091224154057.33611ae7.rctay89@gmail.com>,
 <20091224154005.a642c8ec.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 08:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiNV-0007Ir-LG
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbZLXHox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756818AbZLXHox
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:44:53 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:57469 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbZLXHow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:44:52 -0500
Received: by ywh6 with SMTP id 6so8160160ywh.4
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=q1BHDhboMOdosvmdf4Djq9Xc3eUchfPiU3Fmwolo+dE=;
        b=OlB2VuMb2v/Cpbbi3KsefntbIKs2Bo6LWELv/5kWKk4dAHhl8y+dKbVxjUOF6B6bYb
         Jh7xnxvwPMi2jZzESoKU6QP9yTZsI5mOF5+Yt51jSvGeMYAy0t4N8CDbjvJWoVK7NiHb
         wfEVqGR1ExuhyG1fzCQrFfstq9tbR4pZYplk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=e4ZqYw4iWTh7YDFPUhoNN0NC4wAATvRg8C51Cy/fZ8Ms/PYVZ+c+frAjHzp6IZp8x8
         Ei1oh16RinRjk3S4Hk6pu2/GVyj0mfPo7iVA5LG197CP4fCzTQ0U/o4ZwnFoyqGeh+OE
         2gfaaHiH0P4wopzCxuzNUKmnjZ7tBTbr1TEDY=
Received: by 10.90.179.13 with SMTP id b13mr5597061agf.11.1261640692287;
        Wed, 23 Dec 2009 23:44:52 -0800 (PST)
Received: from your-cukc5e3z5n (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4122986gxk.2.2009.12.23.23.44.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 23:44:51 -0800 (PST)
In-Reply-To: <20091224154352.ecefd242.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135648>

If the status of a ref is REF_STATUS_REJECT_NONFASTFORWARD or
REF_STATUS_UPTODATE, the remote helper will not be told to push the ref
(via a 'push' command).

Therefore, if a ref is not to be pushed, ignore the status report by the
remote helper for that ref - don't overwrite the status of the ref with
the status reported by the helper, nor the message in the remote_status
member.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |    2 +-
 transport-helper.c   |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index fee9494..79867bc 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -111,7 +111,7 @@ Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
 section of '"'git push --help'"' for details." output
 '

-test_expect_failure 'push fails for non-fast-forward refs unmatched by remote helper' '
+test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
 	# create a dissimilarly-named ref so that git is unable to match the refs
 	git push origin master:retsam

diff --git a/transport-helper.c b/transport-helper.c
index 6b1f778..bdfa07e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -429,8 +429,18 @@ static int push_refs(struct transport *transport,
 			continue;
 		}

-		ref->status = status;
-		ref->remote_status = msg;
+		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_UPTODATE:
+			/*
+			 * Earlier, the ref was marked not to be pushed, so ignore what
+			 * the remote helper said about the ref.
+			 */
+			continue;
+		default:
+			ref->status = status;
+			ref->remote_status = msg;
+		}
 	}
 	strbuf_release(&buf);
 	return 0;
--
1.6.6.rc1.249.g048b3
