From: Jeff King <peff@peff.net>
Subject: [PATCH 07/10] cat-file: add %(objectsize:disk) format atom
Date: Wed, 10 Jul 2013 07:46:25 -0400
Message-ID: <20130710114625.GG21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwsqw-0002Pn-7X
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab3GJLqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:46:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:47836 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3GJLqa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:46:30 -0400
Received: (qmail 25481 invoked by uid 102); 10 Jul 2013 11:47:46 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:47:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:46:25 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230048>

This atom is just like %(objectsize), except that it shows
the on-disk size of the object rather than the object's true
size. In other words, it makes the "disk_size" query of
sha1_object_info_extended available via the command-line.

This can be used for rough attribution of disk usage to
particular refs, though see the caveats in the
documentation.

This patch does not include any tests, as the exact numbers
returned are volatile and subject to zlib and packing
decisions. We cannot even reliably guarantee that the
on-disk size is smaller than the object content (though in
general this should be the case for non-trivial objects).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt | 18 ++++++++++++++++++
 builtin/cat-file.c             |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index dd5d6e4..06bdc43 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -106,6 +106,10 @@ newline. The available atoms are:
 	The size, in bytes, of the object (the same as `cat-file -s`
 	reports).
 
+`objectsize:disk`::
+	The size, in bytes, that the object takes up on disk. See the
+	note about on-disk sizes in the `CAVEATS` section below.
+
 If no format is specified, the default format is `%(objectname)
 %(objecttype) %(objectsize)`.
 
@@ -133,6 +137,20 @@ the repository, then `cat-file` will ignore any custom format and print:
 <object> SP missing LF
 ------------
 
+
+CAVEATS
+-------
+
+Note that the sizes of objects on disk are reported accurately, but care
+should be taken in drawing conclusions about which refs or objects are
+responsible for disk usage. The size of a packed non-delta object may be
+much larger than the size of objects which delta against it, but the
+choice of which object is the base and which is the delta is arbitrary
+and is subject to change during a repack. Note also that multiple copies
+of an object may be present in the object database; in this case, it is
+undefined which copy's size will be reported.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b43a0c5..11fa8c0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -118,6 +118,7 @@ struct expand_data {
 	unsigned char sha1[20];
 	enum object_type type;
 	unsigned long size;
+	unsigned long disk_size;
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -155,6 +156,11 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			data->info.sizep = &data->size;
 		else
 			strbuf_addf(sb, "%lu", data->size);
+	} else if (is_atom("objectsize:disk", atom, len)) {
+		if (data->mark_query)
+			data->info.disk_sizep = &data->disk_size;
+		else
+			strbuf_addf(sb, "%lu", data->disk_size);
 	} else
 		die("unknown format element: %.*s", len, atom);
 }
-- 
1.8.3.rc3.24.gec82cb9
