From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] transport: do not allow to push over git:// protocol
Date: Sat,  1 Oct 2011 11:26:55 +1000
Message-ID: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 03:27:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9oMN-0007mL-12
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 03:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1JAB1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 21:27:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54449 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1JAB1N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 21:27:13 -0400
Received: by yxl31 with SMTP id 31so2069105yxl.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 18:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=v35AhVWkJaJUz/FWE8B67ihU5wqU2E0CaB6zdpKMhas=;
        b=ZoaLyV9YnbhGemWYK/WDZdwfNSdgIQ40V4i4rCQ+9AyfFhBNXGqWTuZJcEAeFWixx0
         Fuc/MVWtZEOGKbj+HourqRb8P0Ehp6xVUqfjMg8WfWZo5PLNtCuqJcpmdKMEaqG0QgmW
         Hn/n/pNBB2isnze4bT7IllGeBoCFgMpqTHTlM=
Received: by 10.68.4.132 with SMTP id k4mr61327840pbk.78.1317432430948;
        Fri, 30 Sep 2011 18:27:10 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id i3sm23857721pbg.10.2011.09.30.18.27.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 18:27:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 01 Oct 2011 11:26:58 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182529>

This protocol has never been designed for pushing. Attempts to push
over git:// usually result in

  fatal: The remote end hung up unexpectedly

That message does not really point out the reason. With this patch, we =
get

  error: this protocol does not support pushing
  error: failed to push some refs to 'git://some-host.com/my/repo'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I wanted to advise using remote.*.pushurl too, more friendly. But then=
 I
 had to detect if url comes from command line or config, and I gave up.

 transport.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index fa279d5..b109145 100644
--- a/transport.c
+++ b/transport.c
@@ -933,7 +933,8 @@ struct transport *transport_get(struct remote *remo=
te, const char *url)
 		ret->set_option =3D NULL;
 		ret->get_refs_list =3D get_refs_via_connect;
 		ret->fetch =3D fetch_refs_via_pack;
-		ret->push_refs =3D git_transport_push;
+		if (prefixcmp(url, "git://"))
+			ret->push_refs =3D git_transport_push;
 		ret->connect =3D connect_git;
 		ret->disconnect =3D disconnect_git;
 		ret->smart_options =3D &(data->options);
@@ -1075,6 +1076,8 @@ int transport_push(struct transport *transport,
=20
 		return ret;
 	}
+	else
+		return error("this protocol does not support pushing");
 	return 1;
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
