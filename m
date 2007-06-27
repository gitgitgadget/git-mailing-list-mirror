From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 16:28:53 +0200
Message-ID: <87odj1mpy2.fsf@rho.meyering.net>
References: <87wsxpobf0.fsf@rho.meyering.net>
	<81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	<87r6nxo8iq.fsf_-_@rho.meyering.net>
	<EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 16:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3YW9-0006Es-7b
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 16:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbXF0O2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 10:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757892AbXF0O2z
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 10:28:55 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51959 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388AbXF0O2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 10:28:54 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B8C5D5A348;
	Wed, 27 Jun 2007 16:28:53 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9830C8D56; Wed, 27 Jun 2007 16:28:53 +0200 (CEST)
In-Reply-To: <EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com> (Geert Bosch's message of "Wed\, 27 Jun 2007 09\:54\:57 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51048>

Geert Bosch <bosch@adacore.com> wrote:
> If we really case about catching such errors, write
> the code as:
> 	if (!use_stdout)
> 		realstdout = xfdopen(dup(1), "w");

Thanks for the suggestion.
Here's a patch doing just that (and same for dup/xdup):

Subject: [PATCH] git-log: detect dup and fdopen failure
 git-compat-util.h (xdup, xfdopen): Define functions.


Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-log.c     |    2 +-
 git-compat-util.h |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 073a2a1..a4186ea 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -589,7 +589,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		get_patch_ids(&rev, &ids, prefix);

 	if (!use_stdout)
-		realstdout = fdopen(dup(1), "w");
+		realstdout = xfdopen(xdup(1), "w");

 	prepare_revision_walk(&rev);
 	while ((commit = get_revision(&rev)) != NULL) {
diff --git a/git-compat-util.h b/git-compat-util.h
index b2ab3f8..362e040 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -287,6 +287,22 @@ static inline ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }

+static inline int xdup(int fd)
+{
+	int ret = dup(fd);
+	if (ret < 0)
+		die("dup failed: %s", strerror(errno));
+	return ret;
+}
+
+static inline FILE *xfdopen(int fd, const char *mode)
+{
+	FILE *stream = fdopen(fd, mode);
+	if (stream == NULL)
+		die("Out of memory? fdopen failed: %s", strerror(errno));
+	return stream;
+}
+
 static inline size_t xsize_t(off_t len)
 {
 	return (size_t)len;
