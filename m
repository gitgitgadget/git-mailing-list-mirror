From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/3] resolve_ref_unsafe(): close race condition reading loose refs
Date: Wed, 19 Jun 2013 08:36:28 +0200
Message-ID: <1371623788-7227-4-git-send-email-mhagger@alum.mit.edu>
References: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 08:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpC0m-0005JS-U8
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 08:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537Ab3FSGgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 02:36:51 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58191 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756393Ab3FSGgt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 02:36:49 -0400
X-AuditID: 12074414-b7f626d0000001f1-c7-51c15181eb9e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 59.72.00497.18151C15; Wed, 19 Jun 2013 02:36:49 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J6aXcV032032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 02:36:47 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqNsYeDDQYNthZouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ3yafpKxYIZKxaqf5Q2Mu6S7GDk5JARMJO5PnsoEYYtJXLi3nq2L
	kYtDSOAyo8Sk6V+ZIZzbTBLzex6yg1SxCehKLOppBusQEVCTmNh2iAWkiFlgI6PE8av7GEES
	wgKhEpNvTAGzWQRUJQ6/mc4CYvMKOEs0vzvJDrFOQWLKw/fMIDangIvEvb/PgVazA21zlrjg
	MYGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkCAT2cF45KTcIUYB
	DkYlHt4bqw8ECrEmlhVX5h5ilORgUhLlDQ04GCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFfP
	ASjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBWwYyVLAoNT21Ii0z
	pwQhzcTBCTKcS0qkODUvJbUosbQkIx4UF/HFwMgASfEA7U0DaectLkjMBYpCtJ5i1OWYfHbL
	e0Yhlrz8vFQpcV4XkCIBkKKM0jy4FbCU8opRHOhjYd5SkCoeYDqCm/QKaAkT0BKh7/tAlpQk
	IqSkGhi7w9N5+hkbV55t/Bxw++MvviT3YM3mOCEObZ2DbDNiFzLcPuIy0y8iOMdDt26ZB4+b
	KefVHaaizCsqDoauO8o7V2jxbterp0QzN7/Lumv+x2w/U5qOv0eh66IHWQ0LomUf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228354>

We read loose references in two steps.  The code is roughly:

    lstat()
    if error ENOENT:
        loose ref is missing; look for corresponding packed ref
    else if S_ISLNK:
        readlink()
        if error:
            report failure
    else if S_ISDIR:
        report failure
    else
        open()
        if error:
            report failure
        read()

The problem is that the first filesystem call, to lstat(), is not
atomic with the second filesystem call, to readlink() or open().
Therefore it is possible for another process to change the file
between our two calls, for example:

* If the other process deletes the file, our second call will fail
  with ENOENT, which we *should* interpret as "loose ref is missing;
  look for corresponding packed ref".  This can arise if the other
  process is pack-refs; it might have just written a new packed-refs
  file containing the old contents of the reference then deleted the
  loose ref.

* If the other process changes a symlink into a plain file, our call
  to readlink() will fail with EINVAL, which we *should* respond to by
  trying to open() and read() the file.

The old code treats the reference as missing in both of these cases,
which is incorrect.

So instead, handle errors more selectively: if the result of
readline()/open() is a failure that is inconsistent with the result of
the previous lstat(), then something is fishy.  In this case jump back
and start over again with a fresh call to lstat().

One race is still possible and undetected: another process could
change the file from a regular file into a symlink between the call to
lstat and the call to open().  The open() call would silently follow
the symlink and not know that something is wrong.  This situation
could be detected in two ways:

* On systems that support O_NOFOLLOW, pass that option to the open().

* On other systems, call fstat() on the fd returned by open() and make
  sure that it agrees with the stat info from the original lstat().

However, we don't use symlinks anymore, so this situation is unlikely.
Moreover, it doesn't appear that treating a symlink as a regular file
would have grave consequences; after all, this is exactly how the code
handles non-relative symlinks.  So this commit leaves that race
unaddressed.

Note that this solves only the part of the race within
resolve_ref_unsafe. In the situation described above, we may still be
depending on a cached view of the packed-refs file; that race will be
dealt with in a future patch.

This problem was reported and diagnosed by Jeff King <peff@peff.net>,
and this solution is derived from his patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 867cf9f..70b2c82 100644
--- a/refs.c
+++ b/refs.c
@@ -1252,6 +1252,16 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
+		/*
+		 * We might have to loop back here to avoid a race
+		 * condition: first we lstat() the file, then we try
+		 * to read it as a link or as a file.  But if somebody
+		 * changes the type of the file (file <-> directory
+		 * <-> symlink) between the lstat() and reading, then
+		 * we don't want to report that as an error but rather
+		 * try again starting with the lstat().
+		 */
+	stat_ref:
 		if (lstat(path, &st) < 0) {
 			if (errno == ENOENT)
 				return handle_missing_loose_ref(refname, sha1,
@@ -1263,8 +1273,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
 			len = readlink(path, buffer, sizeof(buffer)-1);
-			if (len < 0)
-				return NULL;
+			if (len < 0) {
+				if (errno == ENOENT || errno == EINVAL)
+					/* inconsistent with lstat; retry */
+					goto stat_ref;
+				else
+					return NULL;
+			}
 			buffer[len] = 0;
 			if (!prefixcmp(buffer, "refs/") &&
 					!check_refname_format(buffer, 0)) {
@@ -1287,8 +1302,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		 * a ref
 		 */
 		fd = open(path, O_RDONLY);
-		if (fd < 0)
-			return NULL;
+		if (fd < 0) {
+			if (errno == ENOENT)
+				/* inconsistent with lstat; retry */
+				goto stat_ref;
+			else
+				return NULL;
+		}
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 		close(fd);
 		if (len < 0)
-- 
1.8.3.1
