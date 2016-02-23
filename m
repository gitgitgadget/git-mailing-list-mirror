From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdiff/xmerge: fix memory leak in xdl_merge
Date: Tue, 23 Feb 2016 11:09:50 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602231108260.3152@virtualbox>
References: <1456217151-16473-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Feb 23 11:10:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY9ux-0006xz-VX
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 11:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbcBWKKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 05:10:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:60385 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbcBWKJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 05:09:59 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LomN9-1a28160jj1-00glgb; Tue, 23 Feb 2016 11:09:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1456217151-16473-1-git-send-email-ps@pks.im>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:coOGcayxTdEdHR+umyi+T5QXavGaWUtZ7ya6NGZZEv1PyoJ46Er
 wVDBX+Q+7mxkTB6HRSzGFn/oxC8gimzDROjtjhDzV3Ab3cXtPQAzI/QnO7ZjoZPGOmaupOv
 YLw1kyRNsqmg3FRI4EqE/TaCYJMVp82+g4I1wfKil7mYjxJHyfd58ivGXQrqVB7OaeQTe4e
 zfJ9U+sHSZ3t1S3dfUlNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x8ld1Sp32Ls=:BaXuIKIFdK5veZa4mTiC+w
 nT1duaIzbWw/INn3E17CZZNwmxcRHYijDWbpEhjtyswEQhujOPk5Z6HfbsM1dsstDW7NhjE9M
 Zb9K+21QWwN+qlwP747lEOJSzvKAMPdMzov/Q2GcDSw+U8aaT41970hVqZL5/8wL7tLaEr7JF
 NScSFKUJL8lGi7eklImCFL0LmmOY2ZCjMpxIyoZNH/YbuXs9OdXvM0tNxVfkQjc3DTHwC1dB0
 f6lB1ES9TUWzno6qYMZNnmE+tMZ2qcDazawOgPsLQs6ioGBRtlrB1K9JPHjMX+1OGTtKFdH5H
 GB4OOLKDTypBWvLRfmA0jXGcdz0osf5j0Crf2Hdr4ZtVciSo2D4WijpCNaFPzKUl/HRQyRphq
 25TrYa+//LO1k27oqXvFfiaRKbNyr4FsZPVbstWsTluqLcCdDHSmFer60FlTsVNwLhVCJYZfW
 cJ4T1Wpty1pVjlFJZ1LsYpwK+rqiLl07/YrqNdCM31RQChJ63SHgQNUr301F6gvlg/kGvdkDq
 q3J+mirUg72zrZ9FjvAW5dhdfj7oyUzNsLsoy77/eWY9oiyNk7TIRvsswC7Zwhl1bkoWMypEP
 KFR7OOtPRq1EhiYnnmv/BqWrKq6aj793RNmFpY3JcbqI2kg29tQfArXzLaSarbr20xLnesfZ+
 A+Jwsto9Wqe6oBk72fjMJHIji0CFLbP9SwHhWxYqjx/GK0Q3hnwP9E4YAY++Qp4uuw6eZ8Aac
 9p6NI3p14e3iXVEtqG0GjDq8pBPTuUYUM5BrUOF7e7KeOtuT7QrkUYUq/ATYWCGZhkCKGheL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287039>

Hi Patrick,

On Tue, 23 Feb 2016, Patrick Steinhardt wrote:

> When building the script for the second file that is to be merged
> we have already allocated memory for data structures related to
> the first file. When we encounter an error in building the second
> script we only free allocated memory related to the second file
> before erroring out.

ACK.

I wonder, though, whether we need this in addition:

-- snipsnap --
t a/xdiff/xmerge.c b/xdiff/xmerge.c
index 625198e..e5c8745 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -579,8 +579,11 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t
*mf2,
 	result->ptr = NULL;
 	result->size = 0;
 
-	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0 ||
-			xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
+		return -1;
+	}
+	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
+		xdl_free_env(&xe1);
 		return -1;
 	}
 	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
