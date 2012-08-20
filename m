From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] precompose-utf8: do not call checks for non-ascii "utf8"
Date: Mon, 20 Aug 2012 11:13:32 -0700
Message-ID: <7vobm5jusz.fsf_-_@alter.siamese.dyndns.org>
References: <7v393mxkpk.fsf@alter.siamese.dyndns.org>
 <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com>
 <7vobm9v32e.fsf@alter.siamese.dyndns.org> <50311DEB.4050700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:13:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3WTu-0003r8-Ga
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 20:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab2HTSNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 14:13:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab2HTSNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 14:13:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BB2F92F5;
	Mon, 20 Aug 2012 14:13:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zsfjofvuql5BWxOWs0R5rvsiQew=; b=XyWrfC
	pZf8oFyHZYdiq6oTYrwMk16/0NAWzloToO/ZF27P6GOJTGM7nWLwkeMYSfr3S5kt
	330XhtssTZpJn5KBim7U9PMeYUO7ikcQCQdzQBQ7vV+YUPQgT22Yu+Cb+rXPzjAC
	ExG2XmIQpnDvNH68OFHKU4S/+6JGMDcuFlJns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KF3D0WY55NPhqAi1Sb2Lc2xCzIgJzMB2
	pkb04K34YYAoVsBjsQ5pxEgVQZLSwlvnJRIuyVKHmDj+LkERGISd8ComgStdPXxN
	xHFCRaUHJmPcJUvIZypOUHNoPxZkx1L+pGDmQk5rh0Ts4J02ZqY8f5wOekzL+ET5
	X2Jr1Qc+K9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8942C92F3;
	Mon, 20 Aug 2012 14:13:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3AF592F2; Mon, 20 Aug 2012
 14:13:33 -0400 (EDT)
In-Reply-To: <50311DEB.4050700@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sun, 19 Aug 2012 19:10:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1090E16-EAF2-11E1-89DC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203864>

As suggested by Linus, this function is not checking UTF-8-ness of the
string; it only is seeing if it is pure US-ASCII.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just for completeness, this on top.

 compat/precompose_utf8.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 3190d50..8cf5955 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -13,20 +13,20 @@ typedef char *iconv_ibp;
 static const char *repo_encoding = "UTF-8";
 static const char *path_encoding = "UTF-8-MAC";
 
-static size_t has_utf8(const char *s, size_t maxlen, size_t *strlen_c)
+static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
 {
-	const uint8_t *utf8p = (const uint8_t *)s;
+	const uint8_t *ptr = (const uint8_t *)s;
 	size_t strlen_chars = 0;
 	size_t ret = 0;
 
-	if (!utf8p || !*utf8p)
+	if (!ptr || !*ptr)
 		return 0;
 
-	while (*utf8p && maxlen) {
-		if (*utf8p & 0x80)
+	while (*ptr && maxlen) {
+		if (*ptr & 0x80)
 			ret++;
 		strlen_chars++;
-		utf8p++;
+		ptr++;
 		maxlen--;
 	}
 	if (strlen_c)
@@ -77,7 +77,7 @@ void precompose_argv(int argc, const char **argv)
 	while (i < argc) {
 		size_t namelen;
 		oldarg = argv[i];
-		if (has_utf8(oldarg, (size_t)-1, &namelen)) {
+		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
 			newarg = reencode_string_iconv(oldarg, namelen, ic_precompose);
 			if (newarg)
 				argv[i] = newarg;
@@ -130,7 +130,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 		prec_dir->dirent_nfc->d_ino  = res->d_ino;
 		prec_dir->dirent_nfc->d_type = res->d_type;
 
-		if ((precomposed_unicode == 1) && has_utf8(res->d_name, (size_t)-1, NULL)) {
+		if ((precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
 			if (prec_dir->ic_precompose == (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
-- 
1.7.12.129.g11de995
