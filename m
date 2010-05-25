From: Jeff King <peff@peff.net>
Subject: Re: (Mosty harmless) protocol error when pushing
Date: Tue, 25 May 2010 03:28:24 -0400
Message-ID: <20100525072824.GA19612@coredump.intra.peff.net>
References: <AANLkTikbFaNhiDngY7Cgk0Ce0YhmNBGIpXtn7abjXnPR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 09:28:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGoZ0-0008Bw-5U
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab0EYH23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 03:28:29 -0400
Received: from peff.net ([208.65.91.99]:51340 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab0EYH23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 03:28:29 -0400
Received: (qmail 17597 invoked by uid 107); 25 May 2010 07:28:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 03:28:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 03:28:24 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikbFaNhiDngY7Cgk0Ce0YhmNBGIpXtn7abjXnPR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147677>

On Tue, May 25, 2010 at 08:51:34AM +0200, Bj=C3=B6rn Gustavsson wrote:

> I am not sure whether this has been reported before.
> I follow this mailing list, but I don't read all emails in
> detail, so I could have missed a bug report or a fix
> for the problem.

I haven't seen it before, and I do read most of the emails (OK, I skip
some of the boring ones. :) ).

> Counting objects: 270, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (71/71), done.
> Writing objects: 100% (184/184), 151.33 KiB, done.
> Total 184 (delta 157), reused 134 (delta 113)
> Auto packing the repository for optimum performance.
> fatal: protocol error: bad line length character: Remo
> error: error in sideband demultiplexer
> To git@github.com:bjorng/otp.git
>  + 7651a63...874192d bg/nif_error -> bg/nif_error (forced update)
> error: failed to push some refs to 'git@github.com:bjorng/otp.git'

I wasn't able to reproduce here, but I wonder if this would help
(more or less a cut-and-paste from the hook-running code in
receive-pack):

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb34757..c0a6a3b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -843,7 +843,20 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
 			const char *argv_gc_auto[] =3D {
 				"gc", "--auto", "--quiet", NULL,
 			};
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			struct child_process proc;
+
+			memset(&proc, 0, sizeof(proc));
+			proc.no_stdin =3D 1;
+			proc.stdout_to_stderr =3D 1;
+			proc.err =3D use_sideband ? -1 : 0;
+			proc.git_cmd =3D 1;
+			proc.argv =3D argv_gc_auto;
+
+			if (!start_command(&proc)) {
+				if (use_sideband)
+					copy_to_sideband(proc.err, -1, NULL);
+				finish_command(&proc);
+			}
 		}
 		if (auto_update_server_info)
 			update_server_info(0);

Unfortunately I can't actually test it. :)

-Peff
