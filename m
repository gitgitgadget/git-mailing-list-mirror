From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] commit: don't use-editor when allow-empty-message
Date: Mon, 27 May 2013 19:33:51 +0530
Message-ID: <1369663431-2405-1-git-send-email-artagnon@gmail.com>
References: <195A1F16-B587-4217-97BF-6A92DA8C0786@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?q?Mislav=20Marohni=C4=87?= <mislav.marohnic@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 16:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugy08-0000KZ-An
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 16:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638Ab3E0OCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 10:02:08 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51723 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537Ab3E0OCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 10:02:07 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so1641091pad.15
        for <git@vger.kernel.org>; Mon, 27 May 2013 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iiD0TRUKjOHhHSPIVNSKSKU5MyD3MF++f00HkRBSOGs=;
        b=HT72yO2dDqqfn+zwSpyUectBAywb2dQHFmHtkLNWJk5DqrZgWbQIL0TdjhoaZf7X1h
         DMKK/KGShFic6hD9XJ/QFoX6GFEa2sXnB0tyzhQKZXDalJDE42Pttxcyza8k6MLgv47i
         WQa9m0B5GHYl6r9Y/aCb0Hov25K02rRWnkmt/fIEVLvTUVPN/ghOn1ErtRDDxspI6sMw
         k4PdgsgtQHsz5TTpFWwLIlRjknJFf5b41VFNgMr1dR1TMSCvGZaOLQgyf/WnFMZWb1Vj
         qdSpp0Y5uWO1Yc3ibIgxeyTbQ5GLXgPNU3e72e6Xg7WfaEpmh+9fqlH4o8d5XUWbbYmZ
         vIyQ==
X-Received: by 10.68.212.168 with SMTP id nl8mr29406234pbc.43.1369663326398;
        Mon, 27 May 2013 07:02:06 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm30735932pac.20.2013.05.27.07.02.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 07:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.g33669de
In-Reply-To: <195A1F16-B587-4217-97BF-6A92DA8C0786@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225589>

Commit a24a41e (git-commit: only append a newline to -m mesg if
necessary, 2013-02-18) introduced a regression: when
--allow-empty-message is used and an empty message is explicitly
specified with -m "", git commit still launches $EDITOR unnecessarily.
The commit (correctly) fixes opt_parse_m() to not fill in two newlines
into the message buffer unconditionally.  The real problem is that
launching $EDITOR only depends on use_editor and whether message is
empty.  Fix the problem by setting use_editor to 0 when
--allow-empty-message is specified in the codepath where an explicit
string is passed via -m.

Reported-by: Mislav Marohni=C4=87 <mislav.marohnic@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index d2f30d9..1f5da9d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -128,6 +128,8 @@ static int opt_parse_m(const struct option *opt, co=
nst char *arg, int unset)
 			strbuf_addch(buf, '\n');
 		strbuf_addstr(buf, arg);
 		strbuf_complete_line(buf);
+		if (allow_empty_message)
+			use_editor =3D 0;
 	}
 	return 0;
 }
--=20
1.8.3.1.g33669de
