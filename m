From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH resend 2/3] transport-helper.c::push_refs(): know more about
 refs before pushing
Date: Fri, 4 Dec 2009 14:57:55 +0800
Message-ID: <20091204145755.4d793b0b.rctay89@gmail.com>
References: <20091204145643.296ec414.rctay89@gmail.com>,
 <20091204145437.1a9910db.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 07:58:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGS7N-0001na-GU
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 07:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbZLDG6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 01:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZLDG6F
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 01:58:05 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:48756 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZLDG6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 01:58:04 -0500
Received: by yxe17 with SMTP id 17so1870519yxe.33
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 22:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=kaFO+pVZiCaTfxrsTUfHc3xsY6SmC0vqoLRJRbkBer8=;
        b=OtKzoB3Hw5W1z4KcuOWI1VXB2fZkEhTMWUEDFyN8o8Mpx5LIZjFn6mvaM785UqByGi
         oHO7cpYjk8HoZHhO4aJgMKEOLZwPuC6ccXZIIVkfrHPuNDfdurPqciR6tGsgX7bw066p
         nZyeHSkNNpJM0GPeicwHyprTDHHIpe6jrvv2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=UmyqRjdLMJ4w4PKDydVZa0H5kJVqPdoicz2z7MV0tgQgzr5HEL2Ed+n+wkSzMjyWUb
         gG+dd7es+FH8JHqjWUH16PKvZaKWsU5w4Z+cbxeJJAMKgwGDuF00MqvIGTxc9TBr4guF
         vsSiMfEnoZ3GwO6swc+Csd5FsF7iZntMoLOH4=
Received: by 10.90.179.13 with SMTP id b13mr3078495agf.11.1259909881507;
        Thu, 03 Dec 2009 22:58:01 -0800 (PST)
Received: from your-cukc5e3z5n (cm81.zeta152.maxonline.com.sg [116.87.152.81])
        by mx.google.com with ESMTPS id 34sm1433978yxf.47.2009.12.03.22.57.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 22:58:00 -0800 (PST)
In-Reply-To: <20091204145437.1a9910db.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134496>

Know about rejected non-fast-forward refs, in addition to up-to-date
ones, by calling set_ref_status_for_push() in remote.[ch], before
passing push commands to the helper.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport-helper.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 11f3d7e..6ed7b55 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -334,16 +334,12 @@ static int push_refs(struct transport *transport,
 		else if (!mirror)
 			continue;

-		ref->deletion = is_null_sha1(ref->new_sha1);
-		if (!ref->deletion &&
-			!hashcmp(ref->old_sha1, ref->new_sha1)) {
-			ref->status = REF_STATUS_UPTODATE;
-			continue;
-		}
-
 		if (force_all)
 			ref->force = 1;

+		if (set_ref_status_for_push(ref, force_all))
+			continue;
+
 		strbuf_addstr(&buf, "push ");
 		if (!ref->deletion) {
 			if (ref->force)
--
1.6.6.rc1.286.gbc15a
