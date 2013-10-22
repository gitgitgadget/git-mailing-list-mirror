From: =?UTF-8?q?Jens=20Lindstr=C3=B6m?= <jl@opera.com>
Subject: [PATCH] Clear fd after closing to avoid double-close error
Date: Tue, 22 Oct 2013 14:10:23 +0200
Message-ID: <1382443823-31317-1-git-send-email-jl@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 22 14:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYawI-0005cN-09
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 14:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab3JVMTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 08:19:54 -0400
Received: from smtp.opera.com ([213.236.208.81]:42322 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab3JVMTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 08:19:53 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2013 08:19:53 EDT
Received: from insane.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r9MCAT4W011276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Oct 2013 12:10:30 GMT
Received: from jl by insane.linkoping.osa with local (Exim 4.80)
	(envelope-from <jl@insane.linkoping.osa>)
	id 1VYan6-00089d-1e; Tue, 22 Oct 2013 14:10:28 +0200
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236464>

=46rom: Jens Lindstrom <jl@opera.com>

In send_pack(), clear the fd passed to pack_objects() by setting
it to -1, since pack_objects() closes the fd (via a call to
run_command()).

Not doing so risks having git_transport_push(), caller of
send_pack(), closing the fd again, possibly incorrectly closing
some other open file.

Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>
---
 send-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 7d172ef..7def2af 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -302,6 +302,9 @@ int send_pack(struct send_pack_args *args,
 				finish_async(&demux);
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
