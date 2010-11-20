From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] get_cwd_relative(): do not misinterpret root path
Date: Sat, 20 Nov 2010 13:50:51 +0700
Message-ID: <1290235851-23276-1-git-send-email-pclouds@gmail.com>
References: <20101119204159.GA28622@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: fullung@gmail.com, matthijs@stdin.nl, j.sixt@viscovery.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	drizzd@aon.at
X-From: git-owner@vger.kernel.org Sat Nov 20 07:52:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJhJP-000364-1J
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 07:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415Ab0KTGwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Nov 2010 01:52:04 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41371 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab0KTGwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 01:52:03 -0500
Received: by pvh1 with SMTP id 1so840377pvh.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 22:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QFpK9OAV5TvGd7QB39SAFShzvaMBIeXy8W4JXZwrhC0=;
        b=BxjAJvK63KvM6G79jlog449dKOF5okPaGtuaccGQFYobvIrixNdpkXwEVFQzJHE0+B
         Jeu1y4e6MCQQgOumLlfpkzp+CCh6A+feN6QFpJ8SqN4vCLt/mqyXoR6YqV7J7Ox7MlVW
         TBHPzexoVv6BrCPt0dzYUuy+0J+RcVCwjD29k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EIsb5P09+tE+Zf24sHhPgCv3gQKwDBJSwUmVLyf90OgOd+90oG8tyYi2aBC3PXy7Yf
         HRy2/MLEEwiah3nJcWl8crItuXFh3Sr+t0MnYxZPgGNvu9BvsXtwCz3/g50CAbEM9Y5L
         PeRgwfM08zOkjvVKHcYLP2j2CvjEDq+XhQtUM=
Received: by 10.142.150.19 with SMTP id x19mr2625314wfd.189.1290235922586;
        Fri, 19 Nov 2010 22:52:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.199.2])
        by mx.google.com with ESMTPS id q13sm2897375wfc.17.2010.11.19.22.51.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 22:52:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Nov 2010 13:50:53 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <20101119204159.GA28622@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161825>

Commit 490544b (get_cwd_relative(): do not misinterpret suffix as
subdirectory) handles case where:

dir =3D "/path/work";
cwd =3D "/path/work-xyz";

When it comes to the end of get_cwd_relative(), dir is at '\0' and cwd
is at '-'. The rest of cwd, "-xyz", clearly cannot be the relative
path from dir to cwd. However there is another case where:

dir =3D "/";          /* or even "c:/" */
cwd =3D "/path/to/here";

In this special case, while *cwd =3D=3D 'p', which is not a path
separator, the rest of cwd, "path/to/here", can be returned as a
relative path from dir to cwd.

Handle this case and make t1509 pass again.

Reported-by: Albert Strasheim <fullung@gmail.com>
Reported-by: Matthijs Kooijman <matthijs@stdin.nl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2010/11/20 Clemens Buchacher <drizzd@aon.at>:
 > make_absolute_path() already rewrites dir to contain slashes only.
 > I think it is confusing to use is_dir_sep() here, when we only
 > check for / above.

 I was thinking about GIT_WORK_TREE=3D"c:\" (so dir would be "c:\") whe=
n
 I wrote that. It is recognized as absolute path, no normalization
 will be done.

 But then the comparison part earlier in this function would fail becau=
se
 getcwd in Windows port always return '/'.

 I will make a patch to convert GIT_WORK_TREE (and GIT_DIR too?) to '/'
 so everything is consistent.

 dir.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index b2dfb69..b687504 100644
--- a/dir.c
+++ b/dir.c
@@ -965,6 +965,12 @@ char *get_relative_cwd(char *buffer, int size, con=
st char *dir)
 	case '/':
 		return cwd + 1;
 	default:
+		/*
+		 * dir can end with a path separator when it's root
+		 * directory. Return proper prefix in that case.
+		 */
+		if (dir[-1] =3D=3D '/')
+			return cwd;
 		return NULL;
 	}
 }
--=20
1.7.3.2.316.gda8b3
