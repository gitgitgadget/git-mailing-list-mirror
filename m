From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] convert: add a helper to determine the correct EOL for
 a given path
Date: Fri, 22 Jan 2016 18:01:16 +0100 (CET)
Message-ID: <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:01:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMf5W-0003mw-97
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbcAVRB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:01:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:58846 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373AbcAVRBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:01:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MJjUO-1aNlXt1rXw-0017aT; Fri, 22 Jan 2016 18:01:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453482052.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:svyeVxQoIH41UiOpex6gwT+oc7ZH5pSxClzcrp642Lcq7021k+D
 Zh8nqranz1GjqIqn68wLI70mwmk64vpBLCmWpoPin5i0tBLRzmAd9J1xAuB1WfbfhQ5ks9U
 NtZI64Ou1nmKIo94XqGq8iQAekTKXdAHs0k/8A0rMHSgb+eG2rZ0N19b+fMkE04N6Vl1Qrz
 jYu1m2fw3PqK7NGkbliUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9gSf0Jg1A7s=:J7h/b8PRO1y25H2QyRYGGO
 YsngJ/7I/vh9bfliyqr7oT7kUs2p0jnGIE3r21jQCBhLI3qiO6ZfqliRyf0b96DfMFCRLYoZT
 tFWVdVSCZAg2eEO47rro7ZpsgiFansqn9OKUyTKeQUjYqjUnbdC6hRXQNQP1caYQDS7yBpkxi
 CpVvoXdB0/yhUcf7FjkFb0NmA0Xk03WG651m6y0Vs7AbisdJX3x2Dtw3YiDOqVVf31i/TwXn2
 djN7bfm2JyHGpKxTjhMf5pQVE1uvkpa4Xnr9ppC7jJ+VW65hYM1H/+vm/sJQ3Sp+TJX/kZwC9
 T3dk5P7V1qXy6FED/9+x8beTHLiyHzG5XTASYQvihbx30UbTgxEZ/i9HhV0kX3mP8GtBvxP+J
 MQaxv1PdYHTI3LDW51d1BUMysSkRfd0bT0RJYvtEj7hWQxqhgjmbUBcM/dGJpK3InMBTjxKl6
 TzwD1ZQ0UwQYb1LTesKj/jobkKBIzuXaUYM7GM4BvJFBstTLxmgJoNO3K2bR43wKk+SNQXrU8
 KyjJjmmHvBLVYAcxBC2kc4X/DWH1INLD8bd2GRap+CSW6BF3V4LTVi8SUeT0KLLYkcl3Kdq7T
 hzw+Q4dyQSBeRHHaObv7prwjBszGDP/NggeAtY6kAs+NeazFUS1VjzDhlTST9QoJqWn+ik+Fp
 sl+gBOidZKc+vuyVMkDO+uNwaI/Lhej40fzESPEC8MWxaMooBpgWgvgaEtmxQ60kznD0pj98s
 9EfA1ShtVVlFbSZvUvQLs93+kMriCltem/r6JW83l9V9jstyRVS4PNM5YxiQ2RlGRWeT+bdL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284564>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c | 29 +++++++++++++++++++++++++++++
 convert.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/convert.c b/convert.c
index 814e814..b458734 100644
--- a/convert.c
+++ b/convert.c
@@ -758,6 +758,35 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 	}
 }
 
+enum eol eol_for_path(const char *path, const char *src, size_t len)
+{
+	struct conv_attrs ca;
+	struct text_stat stats;
+
+	if (!path) {
+		memset(&ca, 0, sizeof(ca));
+		ca.crlf_action = CRLF_AUTO;
+		ca.eol_attr = EOL_UNSET;
+	} else {
+		convert_attrs(&ca, path);
+		if (ca.eol_attr == EOL_UNSET)
+			ca.eol_attr = output_eol(ca.crlf_action);
+		if (ca.eol_attr != EOL_UNSET)
+			return ca.eol_attr;
+	}
+	if (!len || (ca.crlf_action != CRLF_AUTO &&
+				ca.crlf_action != CRLF_GUESS))
+		return core_eol;
+	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
+	gather_stats(src, len, &stats);
+	if (ca.crlf_action == CRLF_GUESS && stats.cr > stats.crlf)
+		return core_eol;
+	else if (stats.crlf)
+		return EOL_CRLF;
+	else
+		return EOL_LF;
+}
+
 int would_convert_to_git_filter_fd(const char *path)
 {
 	struct conv_attrs ca;
diff --git a/convert.h b/convert.h
index d9d853c..1892867 100644
--- a/convert.h
+++ b/convert.h
@@ -33,6 +33,8 @@ enum eol {
 
 extern enum eol core_eol;
 
+extern enum eol eol_for_path(const char *path, const char *src, size_t len);
+
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
-- 
2.7.0.windows.1.7.g55a05c8
