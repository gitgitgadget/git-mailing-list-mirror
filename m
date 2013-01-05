From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive-tar: split long paths more carefully
Date: Sat, 05 Jan 2013 23:49:54 +0100
Message-ID: <50E8AE12.8040102@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:50:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrcZU-0003JX-9e
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 23:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab3AEWt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 17:49:58 -0500
Received: from india601.server4you.de ([85.25.151.105]:36970 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab3AEWt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 17:49:57 -0500
Received: from [192.168.2.105] (p579BE462.dip.t-dialin.net [87.155.228.98])
	by india601.server4you.de (Postfix) with ESMTPSA id 92F5DF4;
	Sat,  5 Jan 2013 23:49:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212732>

The name field of a tar header has a size of 100 characters.  This limit
was extended long ago in a backward compatible way by providing the
additional prefix field, which can hold 155 additional characters.  The
actual path is constructed at extraction time by concatenating the prefix
field, a slash and the name field.

get_path_prefix() is used to determine which slash in the path is used as
the cutting point and thus which part of it is placed into the field
prefix and which into the field name.  It tries to cram as much into the
prefix field as possible.  (And only if we can't fit a path into the
provided 255 characters we use a pax extended header to store it.)

If a path is longer than 100 but shorter than 156 characters and ends
with a slash (i.e. is for a directory) then get_path_prefix() puts the
whole path in the prefix field and leaves the name field empty.  GNU tar
reconstructs the path without complaint, but the tar included with
NetBSD 6 does not: It reports the header to be invalid.

For compatibility with this version of tar, make sure to never leave the
name field empty.  In order to do that, trim the trailing slash from the
part considered as possible prefix, if it exists -- that way the last
path component (or more, but not less) will end up in the name field.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index 0ba3f25..923daf5 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -153,6 +153,8 @@ static unsigned int ustar_header_chksum(const struct ustar_header *header)
 static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 {
 	size_t i = pathlen;
+	if (i > 1 && path[i - 1] == '/')
+		i--;
 	if (i > maxlen)
 		i = maxlen;
 	do {
-- 
1.7.12
