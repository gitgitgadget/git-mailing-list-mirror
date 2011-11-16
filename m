From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] Bigfile: dynamically allocate buffer for marks file name
Date: Wed, 16 Nov 2011 02:04:20 -0600
Message-ID: <20111116080420.GD13706@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:04:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQaTw-0004lz-17
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab1KPIE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:04:28 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47749 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab1KPIE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:04:27 -0500
Received: by ywt32 with SMTP id 32so4472508ywt.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5I2j9ZX22L7EAhWQ+eMAz/R5N05Jhkv6MnBLwrMmYZA=;
        b=Z/5X6LJz3wx78XSTmU38QP4/xwh7mm9k0RnXOgL4vSQgaIkX0WNG9sbbOg1GPaMhWe
         tIZwS5IQzDrBGpndcG2Y/jag/XF2o6ePWaTzoZtJMrxqyhf2cQt3WDP5G/tQZacijbnk
         JryOqbZbcHKhq720lE0s3Q9Tsr9NPgUk8rZCg=
Received: by 10.101.54.9 with SMTP id g9mr3544079ank.50.1321430666103;
        Wed, 16 Nov 2011 00:04:26 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l18sm54529721anb.22.2011.11.16.00.04.25
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 00:04:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185523>

This prevents a buffer overrun that could otherwise be triggered by
creating a .git file with a long destination path and trying to "git
add" a file larger than the big-file threshold (which defaults to 512
MiB), ever since v1.7.6-rc0~31^2 (Bigfile: teach "git add" to send a
large file straight to a pack, 2011-05-08).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 27f3b9b2..86705bc9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2697,20 +2697,28 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 			unsigned flags)
 {
 	struct child_process fast_import;
-	char export_marks[512];
-	const char *argv[] = { "fast-import", "--quiet", export_marks, NULL };
-	char tmpfile[512];
+	const char *argv[4];	/* command, two args, NULL */
+	const char **arg;
+	struct strbuf export_marks = STRBUF_INIT;
+	char *tmpfile;
 	char fast_import_cmd[512];
 	char buf[512];
 	int len, tmpfd;
 
-	strcpy(tmpfile, git_path("hashstream_XXXXXX"));
+	strbuf_addstr(&export_marks, "--export-marks=");
+	strbuf_addstr(&export_marks, git_path("hashstream_XXXXXX"));
+	tmpfile = export_marks.buf + strlen("--export-marks=");
 	tmpfd = git_mkstemp_mode(tmpfile, 0600);
 	if (tmpfd < 0)
 		die_errno("cannot create tempfile: %s", tmpfile);
 	if (close(tmpfd))
 		die_errno("cannot close tempfile: %s", tmpfile);
-	sprintf(export_marks, "--export-marks=%s", tmpfile);
+
+	arg = argv;
+	*arg++ = "fast-import";
+	*arg++ = "--quiet";
+	*arg++ = export_marks.buf;
+	*arg++ = NULL;
 
 	memset(&fast_import, 0, sizeof(fast_import));
 	fast_import.in = -1;
@@ -2754,6 +2762,8 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 	    memcmp(":1 ", buf, 3) ||
 	    get_sha1_hex(buf + 3, sha1))
 		die_errno("index-stream: unexpected fast-import mark: <%s>", buf);
+
+	strbuf_release(&export_marks);
 	return 0;
 }
 
-- 
1.7.8.rc0
