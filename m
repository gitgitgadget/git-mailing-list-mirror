From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Wed, 16 Dec 2015 13:14:57 +0100 (CET)
Message-ID: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 13:15:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9AzB-0001M4-QR
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 13:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbbLPMPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 07:15:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:61760 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081AbbLPMPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 07:15:05 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MCcvy-1a0xmq2nUg-009O6r; Wed, 16 Dec 2015 13:14:58
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:CmIsDWVSj8OsdQJsR+cIZPFOkTFTtK/vdaKuvnBGmO7mvE/6p+C
 wjWOYpZ/1ra7S59BFK65c1XNEcFKC0pv1HZzU0iVjpTLcL7ERRZIFIJKJR+/nOi112055O7
 oRg8HjSH/bpl3FhT2rKgIvWFG8e68ZvtM9LS1AiKDBKvkYb7pMlSlSBkWIDSFfNdLe8pbZX
 7NxiVb53i6HsFHzBM1Hkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1hbROsws8V0=:xTCdEEjWwDvOHxwxdt05eU
 n0GQljVPlY81dT3ArCXQJT9zOb08FK+gJYs268u0pgiIsOFjnXXfztLBN+75Tc+DFGXbgVIC1
 r6f40eos47s3KEqewPo8Ad3ZG9srP49iG/jGyXNqGd+SItdma2Lcb4M2yR34AHWvfuJj+d+1J
 tYB7Ce77NVhgQq2W2iwabPkf4ZxksT/OnKm50nM5BUDTTEr3ggn5T9KFxya5UV1iI1L53VuL1
 VtpElQ/b+VNWlzPbno43xMG3oBJh5sBENfVBDJTJbUDyLC1iRpQkgW5IToo9ufNtTdX1NVqQF
 8CfBJOKKJnT+/QMawyiOndycZnZj395q/IoS5Eq7dOxpFddMXVce81ORbZG17bL3GlJ2MPEHk
 tlSdVgBAWj9zzJBsrMA+xaibfLojwz0KxUZdqaHMdzAAeuBXP5jaMIvD4dqsGN8WU2YS1QowQ
 DK1Jx3M3iLiRWB3cKJRMyLjZeQnuLiHnaicya+nc9mR6cZP+djH9BLGOjQo+peiKbp2sxtBtw
 /PLSuCXhjUKX+zzzujGIifdHQFRv3BsHFqf9kQtum1YCUS0JM1eSjf+WZkyeTA3XHLCpvVbFy
 w6bKsK6CBMOUaYU04CXFkY0OV+FPhWKDHUyatgHXvYTnDBjnJJk9XDax3Z4o3WD9OJ5YGFzit
 1Q7SWp3Ijokx678qvrnorkapzFAgaWYetgqlbCYj7vf8Mraku8FT40ob3zqZnblB7cNFNX1VK
 ttt417AUMyKl2nhx75N++7kkhWAcOafNjd3Tk1zc0r1WbCHnoTWmUd9l1WEHrYFPVZx1f0pD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282549>

On Windows, when writing to a pipe fails, errno is always
EINVAL. However, Git expects it to be EPIPE.

According to the documentation, there are two cases in which write()
triggers EINVAL: the buffer is NULL, or the length is odd but the mode
is 16-bit Unicode (the broken pipe is not mentioned as possible cause).
Git never sets the file mode to anything but binary, therefore we know
that errno should actually be EPIPE if it is EINVAL and the buffer is
not NULL.

See https://msdn.microsoft.com/en-us/library/1570wh78.aspx for more
details.

This works around t5571.11 failing with v2.6.4 on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 738865c..2aca347 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -210,6 +210,24 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
 int mingw_fflush(FILE *stream);
 #define fflush mingw_fflush
 
+static inline ssize_t mingw_write(int fd, const void *buf, size_t len)
+{
+	ssize_t result = write(fd, buf, len);
+
+	if (result < 0 && errno == EINVAL && buf) {
+		/* check if fd is a pipe */
+		HANDLE h = (HANDLE) _get_osfhandle(fd);
+		if (GetFileType(h) == FILE_TYPE_PIPE)
+			errno = EPIPE;
+		else
+			errno = EINVAL;
+	}
+
+	return result;
+}
+
+#define write mingw_write
+
 int mingw_access(const char *filename, int mode);
 #undef access
 #define access mingw_access
-- 
2.6.3.windows.1.300.g1c25e49
