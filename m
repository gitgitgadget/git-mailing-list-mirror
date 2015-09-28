From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/4] pack-objects: do not get distracted by broken symrefs
Date: Mon, 28 Sep 2015 16:01:25 +0200
Organization: gmx
Message-ID: <b76346dee63408c37c8afe5366ce7133cdf29be2.1443448748.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1443448748.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 16:01:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgYzr-0004Y0-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 16:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933839AbbI1OBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 10:01:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:59310 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932920AbbI1OBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 10:01:34 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MT60g-1a8aG32X82-00SAdN; Mon, 28 Sep 2015 16:01:25
 +0200
In-Reply-To: <cover.1443448748.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:A8+cAPquGzk/3wGMDkg44ELeLgj4h0MErU4NpvJM41dpWZkCqzs
 wLIdE/CMv7IIJVftF5wM+vZpJOHxMjeCNtIEZORVJzS1/t700/kjhtgtQr5E/w4P2aWukYB
 f3uR36v/tLgW7OUl8KEd2DpuclJDJz3zwBXCaSh/opFf1LGk9rW/HWE/WjC7bsPuJNK8D+P
 SFNrz485pmaWlVyk6o+gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xfH3X4tnhWs=:Uw+acCiJ6WW/Qg+wPEWJ6i
 zU++wAmvWxRnF/nolsfD+2j+2qQ3Ey5di/TV2JmTLRSJkcZclS/ucTnSZ6Y8Dm3/Sp9uLdnOT
 MPezVAOXwfoPQLapwmHmbMTBx2SodQBau56Tu6pMQIlkgeGiS9HiDUwO+5biiq0hwSWO/O+kg
 BHx/+FXu3ZhCIGUr4z8EVsHMMM8fp5t4tslzrSW+a9DPiBu6Ca8BKMm++5slbcrCPP4c8yD/A
 y5nqW0kz803ESPLCwiUGj1qApf8LmUhFhtB7jG7aKou6cjXEppqkTMEvyJAw741PYib/EbXbZ
 qaT5cn6RmXqunkfD5eGCETEBb+lLmKMPrqbkYp5QXyK2nk7lietjTA7YOp00UOlyHe5e5z6mt
 CGzgbfqc/SCYwrAbjbLFaQ1W+d9c1tSfkdiCr6domlPfKGGr64VCDxVTwZwY4tEzrEsHTryRd
 ojCI4Cwv6O2iKCqjQyYjeqdUlUz+W+6lUwJruiLx2HNyaT9M1VkOcnwAEDzTuQwDHm3GBgv4e
 Q26QFI/aHwNGIusZbYEWgL9cyoHijZ1VpmRpNb9sOgSdJ7WuF/YFEnvdaYknxL9By8b7G6qbD
 vWOELpXtJUvdbbp4T0wRUEMqgBhT4WDC5957SwBDeQzgVGfLkWPIhvwAiAxY5V0ecZybQUvzG
 DWz8K3WHGCMdJ0pgOTEEQ5LzsWwASzHmioGEZQE6rf6O8EQTS5o9cq7a/dZ+Ska/W/Wxn4m9H
 mfO5drmxAj/BKsnLor5PMaDJjwFyxpX0prv4UQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278726>

It is quite possible for, say, a remote HEAD to become broken, e.g.
when the default branch was renamed.

We should still be able to pack our objects when such a thing happens;
simply ignore broken symrefs (because they cannot matter for the packing
process anyway).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reachable.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index 9cff25b..64289f3 100644
--- a/reachable.c
+++ b/reachable.c
@@ -25,9 +25,15 @@ static void update_progress(struct connectivity_progress *cp)
 static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *object = parse_object_or_die(oid->hash, path);
 	struct rev_info *revs = (struct rev_info *)cb_data;
+	struct object *object;
 
+	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
+		warning("ref is broken: %s", path);
+		return 0;
+	}
+
+	object = parse_object_or_die(oid->hash, path);
 	add_pending_object(revs, object, "");
 
 	return 0;
-- 
2.5.3.windows.1.3.gc322723
