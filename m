From: =?UTF-8?q?Jens=20Lindstr=C3=B6m?= <jl@opera.com>
Subject: [PATCH v2] Clear fd after closing to avoid double-close error
Date: Tue, 22 Oct 2013 15:36:02 +0200
Message-ID: <1382448962-31782-1-git-send-email-jl@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 22 15:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYc88-0008Ln-AE
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 15:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab3JVNgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 09:36:12 -0400
Received: from smtp.opera.com ([213.236.208.81]:46923 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab3JVNgM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 09:36:12 -0400
Received: from insane.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r9MDa9Tp007468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Oct 2013 13:36:09 GMT
Received: from jl by insane.linkoping.osa with local (Exim 4.80)
	(envelope-from <jl@insane.linkoping.osa>)
	id 1VYc7z-0008H8-Hf; Tue, 22 Oct 2013 15:36:07 +0200
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236471>

=46rom: Jens Lindstrom <jl@opera.com>

In send_pack(), clear the fd passed to pack_objects() by setting
it to -1, since pack_objects() closes the fd (via a call to
run_command()).  Likewise, in get_pack(), clear the fd passed to
run_command().

Not doing so risks having git_transport_push(), caller of
send_pack(), closing the fd again, possibly incorrectly closing
some other open file; or similarly with fetch_refs_from_pack(),
indirect caller of get_pack().

Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>
---
 fetch-pack.c | 4 ++++
 send-pack.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index f5d99c1..29b711a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -776,6 +776,10 @@ static int get_pack(struct fetch_pack_args *args,
 		close(cmd.out);
 	}
=20
+	if (!use_sideband)
+		/* Closed by start_command() */
+		xd[0] =3D -1;
+
 	ret =3D finish_command(&cmd);
 	if (!ret || (args->check_self_contained_and_connected && ret =3D=3D 1=
))
 		args->self_contained_and_connected =3D
diff --git a/send-pack.c b/send-pack.c
index 7d172ef..edbfd07 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -300,8 +300,12 @@ int send_pack(struct send_pack_args *args,
 				shutdown(fd[0], SHUT_WR);
 			if (use_sideband)
 				finish_async(&demux);
+			fd[1] =3D -1;
 			return -1;
 		}
+		if (!args->stateless_rpc)
+			/* Closed by pack_objects() via start_command() */
+			fd[1] =3D -1;
 	}
 	if (args->stateless_rpc && cmds_sent)
 		packet_flush(out);
--=20
1.8.1.2
