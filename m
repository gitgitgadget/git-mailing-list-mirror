From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 05/11] http.c: Don't store destination name in
 request structures
Date: Sun, 18 Apr 2010 11:36:19 +0800
Message-ID: <20100418113619.00007e39@unknown>
References: <20100416100307.0000423f@unknown>
	<1271534864-31944-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 05:36:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3LJH-0005HR-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 05:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100Ab0DRDge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 23:36:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49216 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092Ab0DRDgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 23:36:33 -0400
Received: by gwaa18 with SMTP id a18so2053652gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WN1W9c1hkgCL/G3aLiyNT2mbUDZuL3D0/1gx/5X3jZk=;
        b=QDhFO27tsHD5i+Hr8V9Nbx8DlmqWKNgVb1iXAtue5bktNzyyXhOkpUVzsDNqCuH9xh
         Jj4HPKl3V25f8NJLREFW//DoOmK5muSIUzxnAb8r1su0ZdTxYrQY+r4FJxZr3t7iL/+L
         WZhsfBdiB1HK+q9DDCzNpg4tMk/Ac1Q8KZZGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=KuIBq4j86VROo2QpvcuJZ2DWFU4sdQabfWUeQP2T8YoN5jnGgN2spgQmcdhity6iqP
         e55eLDGHDCQ8DCxgQ+DGt3i1MYFIsxQOpNniXG/Cm1ji02fGHHTGWg1fv20X+0xAxrDt
         59KTKvRuwsGBIiG8rjgh2dpaK7w/fyOlmT18Q=
Received: by 10.101.5.1 with SMTP id h1mr7926113ani.161.1271561792336;
        Sat, 17 Apr 2010 20:36:32 -0700 (PDT)
Received: from unknown (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id y2sm29866579ani.4.2010.04.17.20.36.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 20:36:32 -0700 (PDT)
In-Reply-To: <1271534864-31944-5-git-send-email-spearce@spearce.org>
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145208>

Hi,

On Sat, 17 Apr 2010 13:07:38 -0700
"Shawn O. Pearce" <spearce@spearce.org> wrote:

> The destination name within the object store is easily computed
> on demand, reusing a static buffer held by sha1_file.c.  We don't
> need to copy the entire path into the request structure for safe
> keeping, when it can be easily reformatted after the download has
> been completed.
> 
> This reduces the size of the per-request structure, and removes
> yet another PATH_MAX based limit.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

now that there's a single user of char *filename, we might as well do
away with it.

PS. I think having the below as a separate patch is better than
squashing it in, as it might be detrimental to patch #05's readability
in the latter case.

-->8--
From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http.c::new_http_pack_request: do away with the temp variable filename

Now that the temporary variable char *filename is only used in one
place, do away with it and just call sha1_pack_name() directly.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

diff --git a/http.c b/http.c
index c75eb95..110cff9 100644
--- a/http.c
+++ b/http.c
@@ -1027,7 +1027,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 struct http_pack_request *new_http_pack_request(
        struct packed_git *target, const char *base_url)
 {
-       char *filename;
        long prev_posn = 0;
        char range[RANGE_HEADER_SIZE];
        struct strbuf buf = STRBUF_INIT;
@@ -1042,8 +1041,8 @@ struct http_pack_request *new_http_pack_request(
                sha1_to_hex(target->sha1));
        preq->url = strbuf_detach(&buf, NULL);
 
-       filename = sha1_pack_name(target->sha1);
-       snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp", filename);
+       snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp",
+               sha1_pack_name(target->sha1));
        preq->packfile = fopen(preq->tmpfile, "a");
        if (!preq->packfile) {
                error("Unable to open local file %s for pack",
--

-- 
Cheers,
Ray Chuan
