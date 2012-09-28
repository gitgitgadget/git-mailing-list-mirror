From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] revision: make --grep search in notes too if shown
Date: Fri, 28 Sep 2012 14:01:22 +0700
Message-ID: <1348815682-18696-3-git-send-email-pclouds@gmail.com>
References: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
 <1348815682-18696-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 09:02:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THUak-0006Cb-K1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 09:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab2I1HCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 03:02:21 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59471 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2I1HCU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 03:02:20 -0400
Received: by padhz1 with SMTP id hz1so2022595pad.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SB9x3WEpAbZ4n9T9t19BeG3VudBIY7M/lJno1WD8/R0=;
        b=tzEkxH1c8C+y63L+G7cJ3jQFSZ/1I2hg0yPVls+eTlT8FJ4NdhgqcZUx6z7XqbWxCm
         iYoy9DoAFZyNE1NR2WptOr7MiOqEeExnmXAK8KGnQMD9OB3zmOXlDtRGZ51rZldTRa55
         XoJ5hVsDVmxlnthvBEadreor+lY2xVPYjkh0SsGITndlIi6uXPv3GC/RzQa1xG6gMF38
         aZ8y5h7TDyTbpzvHJ+TqvHmTHrSEYiB0qhb9gzsJwnSVeOZ4SfEEf8ibRX6yFv8eO7iM
         s0x1cDL2Y7rqw1KMvMAhZGvlPGh+BQWKaJke83hIMR6n53g/iwiQdT665hdfLxrhhrWO
         x/OA==
Received: by 10.68.218.132 with SMTP id pg4mr18112848pbc.100.1348815740561;
        Fri, 28 Sep 2012 00:02:20 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wl4sm5141566pbc.17.2012.09.28.00.02.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 00:02:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 28 Sep 2012 14:02:13 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1348815682-18696-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206541>

Notes are shown after commit body. From user perspective it looks
pretty much like commit body and they may assume --grep would search
in that part too. Make it so.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Sep 28, 2012 at 1:16 AM, Junio C Hamano <gitster@pobox.com>
 wrote:
 > The output from "log --show-notes", on the other hand, is even more
 > conflated and a casual user would view it as part of the message,
 > so
 > I would imagine that if we ever do the extention to cover notes
 > data, the normal "--grep" should apply to it.

 Something like this?

 revision.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index cfa0e2e..febb4d7 100644
--- a/revision.c
+++ b/revision.c
@@ -2223,6 +2223,12 @@ static int commit_match(struct commit *commit, s=
truct rev_info *opt)
 		strbuf_addch(&buf, '\n');
 		strbuf_addstr(&buf, commit->buffer);
 	}
+	if (opt->show_notes) {
+		if (!buf.len)
+			strbuf_addstr(&buf, commit->buffer);
+		format_display_notes(commit->object.sha1, &buf,
+				     get_log_output_encoding(), 0);
+	}
 	if (buf.len)
 		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
 	else
--=20
1.7.12.1.405.gb727dc9
