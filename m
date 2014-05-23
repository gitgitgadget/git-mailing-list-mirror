From: =?ISO-8859-1?Q?Jens_Lindstr=F6m?= <jl@opera.com>
Subject: [PATCH v2 1/3] remote rm: delete remote configuration as the last
Date: Fri, 23 May 2014 12:28:43 +0200
Message-ID: <537F22DB.7070102@opera.com>
References: <537B2FA4.7020001@opera.com> <537F2252.3010101@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 12:29:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnmiw-0002B7-Rf
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbaEWK3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 06:29:11 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:50506 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbaEWK3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:29:09 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so3887751lab.24
        for <git@vger.kernel.org>; Fri, 23 May 2014 03:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=OadFfrbZYCvFT+cROWvT4pWzRqBWXZ/+CJJoX5NUGns=;
        b=KipBvFNAFXmO6s5RujA6aJPOBiN1k2l8wt7BZGjOubZHrtC5ocZ/o+sa5WAGJTl5qd
         qkcJ4UQqT6g+ySTIn2GrlUOrEW1EN3BbNiDH5zwkORqVXv3l+H+MApsKm3uziEOFBmNE
         a0agkMlad480m8ChmsqA8UrDSlvmvYfUJg/S3syLm0zRCuQjY5DjQAi9KhFUbvzq5+Qb
         ryQMEWaALZ/DaHY7wrZw/j5w/ZEGfxn+vNhDXC0lyeuDjx9xdBtI/zqstSjHQdmmR8Mj
         0UI5Ge4gRpKidB4stKg6YlfztJDALGFcoNiFB2NmLQmsw+Xr2pvT8+uuq+ZqJTWbGlij
         +H3g==
X-Gm-Message-State: ALoCoQmK//RirGYtTtBUNZSyzsxnGdbzhFZK+NXoogWjnDGnu+NJ3i26wa9Nzqk2SYx851xC02k/
X-Received: by 10.113.4.70 with SMTP id cc6mr2612830lbd.21.1400840948427;
        Fri, 23 May 2014 03:29:08 -0700 (PDT)
Received: from [10.34.0.102] (77.72.99.119.c.fiberdirekt.net. [77.72.99.119])
        by mx.google.com with ESMTPSA id bg4sm2543721lbb.6.2014.05.23.03.29.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 03:29:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <537F2252.3010101@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249982>

When removing a remote, delete the remote-tracking branches before
deleting the remote configuration.  This way, if the operation fails or
is aborted while deleting the remote-tracking branches, the command can
be rerun to complete the operation.

Signed-off-by: Jens Lindstr=F6m <jl@opera.com>
---
 builtin/remote.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..84802cd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -789,10 +789,6 @@ static int rm(int argc, const char **argv)
 	known_remotes.to_delete =3D remote;
 	for_each_remote(add_known_remote, &known_remotes);
=20
-	strbuf_addf(&buf, "remote.%s", remote->name);
-	if (git_config_rename_section(buf.buf, NULL) < 1)
-		return error(_("Could not remove config section '%s'"), buf.buf);
-
 	read_branches();
 	for (i =3D 0; i < branch_list.nr; i++) {
 		struct string_list_item *item =3D branch_list.items + i;
@@ -837,6 +833,12 @@ static int rm(int argc, const char **argv)
 	}
 	string_list_clear(&skipped, 0);
=20
+	if (!result) {
+		strbuf_addf(&buf, "remote.%s", remote->name);
+		if (git_config_rename_section(buf.buf, NULL) < 1)
+			return error(_("Could not remove config section '%s'"), buf.buf);
+	}
+
 	return result;
 }
=20
--=20
1.9.1
