From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] http-backend: Fix bad treatment of uintmax_t in
	Content-Length
Date: Wed, 11 Nov 2009 20:42:41 -0800
Message-ID: <20091112044240.GP11919@spearce.org>
References: <7vzl6wz36r.fsf@alter.siamese.dyndns.org> <905315640911100910r5116779eh24796fa5788f4aef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 05:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8RXE-0005fk-6l
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 05:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbZKLEmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 23:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbZKLEmg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 23:42:36 -0500
Received: from george.spearce.org ([209.20.77.23]:36167 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbZKLEmf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 23:42:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 164EAE0005; Thu, 12 Nov 2009 04:42:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <905315640911100910r5116779eh24796fa5788f4aef@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132735>

Our Content-Length needs to report an off_t, which could be larger
precision than size_t on this system (e.g. 32 bit binary built with
64 bit large file support).

We also shouldn't be passing a size_t parameter to printf when
we've used PRIuMAX as the format specifier.

Fix both issues by using uintmax_t for the hdr_int() routine,
allowing strbuf's size_t to automatically upcast, and off_t to
always fit.

Also fixed the copy loop we use inside of send_local_file(), we never
actually updated the size variable so we might as well not use it.

Reported-by: Tarmigan <tarmigan+git@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

  Tarmigan <tarmigan+git@gmail.com> wrote:
  > unhappy.  Curl returns 18 (CURLE_PARTIAL_FILE), the test takes a long
  > time to fail, and the "out" file looks OK (compared to a linux machine
  > where the test passes) expect for "Content-Length: 37847251812411".
  > 
  > Digging into it a bit more with gdb, the call to hdr_int() in
  > http-backend.c looks OK, but then something goes wrong in
  > format_write().  Hmmm it looks like my setup does not like PRIuMAX
  > with size_t, which puts some garbage in the upper bytes of

  Yup, only the right fix is to keep using PRIuMAX... patch below.
  
 http-backend.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f8ea9d7..7f48406 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -134,7 +134,7 @@ static void hdr_str(const char *name, const char *value)
 	format_write(1, "%s: %s\r\n", name, value);
 }
 
-static void hdr_int(const char *name, size_t value)
+static void hdr_int(const char *name, uintmax_t value)
 {
 	format_write(1, "%s: %" PRIuMAX "\r\n", name, value);
 }
@@ -216,7 +216,6 @@ static void send_local_file(const char *the_type, const char *name)
 	char *buf = xmalloc(buf_alloc);
 	int fd;
 	struct stat sb;
-	size_t size;
 
 	fd = open(p, O_RDONLY);
 	if (fd < 0)
@@ -224,14 +223,12 @@ static void send_local_file(const char *the_type, const char *name)
 	if (fstat(fd, &sb) < 0)
 		die_errno("Cannot stat '%s'", p);
 
-	size = xsize_t(sb.st_size);
-
-	hdr_int(content_length, size);
+	hdr_int(content_length, sb.st_size);
 	hdr_str(content_type, the_type);
 	hdr_date(last_modified, sb.st_mtime);
 	end_headers();
 
-	while (size) {
+	for (;;) {
 		ssize_t n = xread(fd, buf, buf_alloc);
 		if (n < 0)
 			die_errno("Cannot read '%s'", p);
-- 
1.6.5.2.351.g09432
