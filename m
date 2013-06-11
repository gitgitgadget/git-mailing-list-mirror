From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/4] resolve_ref_unsafe(): close race condition reading loose refs
Date: Tue, 11 Jun 2013 16:26:20 +0200
Message-ID: <1370960780-1055-5-git-send-email-mhagger@alum.mit.edu>
References: <20130507023802.GA22940@sigill.intra.peff.net>
 <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 16:27:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPXQ-0005vU-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493Ab3FKO0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:26:50 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51897 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754330Ab3FKO0t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 10:26:49 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-5b-51b733a8ce64
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.F8.17335.8A337B15; Tue, 11 Jun 2013 10:26:48 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BEQVIV026521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 10:26:46 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqLvCeHugwYGlXBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj6edG5oJduhWbJixgamD8ptjFyMEhIWAisf6DVBcjJ5ApJnHh3nq2LkYuDiGBy4wS
	N/6fZYdwLjBJtH5ZzgZSxSagK7Gop5kJxBYRUJOY2HaIBaSIWaCdUeJd8z5mkISwQJDExK3/
	2UFsFgFViekX5zGC2LwCzhJfrl1nhFgnJ/H+zi4WkCs4BVwkTjfKgISFBEokpqx6yzKBkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJCQ4tvB2L5e5hCjAAejEg9v
	AuO2QCHWxLLiytxDjJIcTEqivFMMtgcK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFtlAPK8aYk
	VlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkePcZATUKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEgyIjvhgYGyApHqC9n0HaeYsLEnOBohCtpxh1OTafn/yOUYgl
	Lz8vVUqc9y5IkQBIUUZpHtwKWAJ5xSgO9LEw7y6QKh5g8oGb9ApoCRPQkinqW0CWlCQipKQa
	GJes5lbOKzVe+XuqRFB5k4mHtMDUHdz/hSyCHdlsMzdf2SRyJprTcc5W82fz8w1kkow4zhaf
	TtL/UdCcGiykdbLLwWVBpf+ML2ZVXa+f3a1kWnXaRmzdl8j93zqcMlcfOt/Wc7hE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227447>

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

So instead, wrap the above code in a loop.  If the result of
readline()/open() is a failure that is inconsistent with the result of
the previous lstat(), then just loop again starting with a fresh call
to lstat().

One race is still possible and undetected: another process could
change the file from a regular file into a symlink between the call to
lstat and the call to open().  The open() call would silently follow
the symlink and not know that something is wrong.  I don't see a way
to detect this situation without the use of the O_NOFOLLOW option,
which is not portable and is not used elsewhere in our code base.

However, we don't use symlinks anymore, so this situation is unlikely.
And it doesn't appear that treating a symlink as a regular file would
have grave consequences; after all, this is exactly how the code
handles non-relative symlinks.

Note that this solves only the part of the race within
resolve_ref_unsafe. In the situation described above, we may still be
depending on a cached view of the packed-refs file; that race will be
dealt with in a future patch.

This problem was reported and diagnosed by Jeff King <peff@peff.net>,
and this solution is derived from his patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Please note that if there is some bizarre filesystem somewhere for
which, for a single, static file

    lstat() reports S_ISLNK and readlink() fails with ENOENT or EINVAL

or

    lstat() reports neither S_ISLNK nor S_ISDIR and open() fails with ENOENT

then the inner loop would never terminate.  I can't imagine this
happening, but if somebody is worried about it the solution is simple:
limit the inner loop to 3 iterations or so.

Another obvious way to solve the problem would be to skip the lstat()
call altogether, and to rely on errno to distinguish the cases:

    readlink()
    if error ENOENT:
        loose ref is missing; look for corresponding packed ref
    else if error EINVAL:
        must not be a symlink; fall through to open()
    else if other error:
        report failure
    else:
        handle as symlink

    open()
    if error ENOENT:
        file must have been deleted since readlink(); look for packed ref
    else if other error:
        report failure
    else:
        read() and handle file contents

There is still a gap between readlink() and open(), during which the
file could have been changed from a regular file into a symlink, so
the remaining race mentioned above would still be undetected.  I don't
see a strong reason to prefer the looping code in this patch vs. the
no-lstat() alternative so I took the variant that was closer to the
old code.

 refs.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7a77d76..6e7c1fd 100644
--- a/refs.c
+++ b/refs.c
@@ -1248,6 +1248,15 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
+		/*
+		 * This loop is to avoid race conditions.  First we
+		 * lstat() the file, then we try to read it as a link
+		 * or as a file.  But if somebody changes the type of
+		 * the file (file <-> directory <-> symlink) between
+		 * the lstat() and reading, then we don't want to
+		 * report that as an error but rather try again
+		 * starting with the lstat().
+		 */
 		for (;;) {
 			if (lstat(path, &st) < 0) {
 				if (errno == ENOENT)
@@ -1261,8 +1270,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			/* Follow "normalized" - ie "refs/.." symlinks by hand */
 			if (S_ISLNK(st.st_mode)) {
 				len = readlink(path, buffer, sizeof(buffer)-1);
-				if (len < 0)
-					return NULL;
+				if (len < 0) {
+					if (errno == ENOENT || errno == EINVAL)
+						/* inconsistent with lstat; retry */
+						continue;
+					else
+						return NULL;
+				}
 				buffer[len] = 0;
 				if (!prefixcmp(buffer, "refs/") &&
 				    !check_refname_format(buffer, 0)) {
@@ -1285,8 +1299,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			 * a ref
 			 */
 			fd = open(path, O_RDONLY);
-			if (fd < 0)
-				return NULL;
+			if (fd < 0) {
+				if (errno == ENOENT)
+					/* inconsistent with lstat; retry */
+					continue;
+				else
+					return NULL;
+			}
 			len = read_in_full(fd, buffer, sizeof(buffer)-1);
 			close(fd);
 			if (len < 0)
-- 
1.8.3
