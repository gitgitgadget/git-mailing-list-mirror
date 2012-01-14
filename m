From: Jeff King <peff@peff.net>
Subject: Re: git-upload-archive help was not shown correctly
Date: Sat, 14 Jan 2012 15:56:11 -0500
Message-ID: <20120114205611.GA21756@sigill.intra.peff.net>
References: <1326548416.5992.1.camel@devendra-Linux>
 <20120114154633.GA3444@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: devendra <dev@savarinetworks.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:56:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmAeC-00068f-V6
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 21:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264Ab2ANU4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 15:56:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38668
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932173Ab2ANU4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 15:56:15 -0500
Received: (qmail 19132 invoked by uid 107); 14 Jan 2012 21:03:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Jan 2012 16:03:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jan 2012 15:56:11 -0500
Content-Disposition: inline
In-Reply-To: <20120114154633.GA3444@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188578>

On Sat, Jan 14, 2012 at 04:46:33PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> On Sat, Jan 14, 2012 at 07:10:16PM +0530, devendra wrote:
> > Hi git folks,
> >=20
> > the command git-upload-archive is not properly showing usage info w=
hen
> > ran barely with out any args.
>=20
> git-upload-package is not for human use. It's what gets run on the
> remote end when you run e.g. 'git archive --remote=3Dorigin HEAD'

Yeah, but notice that it does detect the error condition; it just wraps
it in a bunch of cruft. More explanation (and a patch) are below, thoug=
h
I'm lukewarm on the patch.

> > it shows some kind of unwanted garbage instead of showing a nice he=
lp
> > message.
>=20
> It's trying to talk to git. What you see is the "Git Smart
> Protocol". What were you trying to do?

Yeah, this is the more important question. You shouldn't generally ever
be running git-upload-* yourself.

-- >8 --
Subject: upload-archive: detect bad command-line arguments early

The upload-archive command spawns a helper process to
actually generate the archive (passing along all of its
command-line arguments), and the parent process then
multiplexes the stdout and stderr of the helper back to the
client.

This means an incorrect invocation (which in this case means
failing to provide a single <repo> argument) will cause the
helper to complain, and the error will be sent to the client
over the multiplexed channel.

This is not ideal for two reasons:

  1. An invocation error in upload-pack is almost certainly
     not something the client can do anything about. It
     generally implies a bug in either git-daemon or
     git-archive. The one exception is something like:

       git archive --remote=3Dssh_host:repo.git \
                   --exec=3D"git upload-archive bogus" \

  2. For local users who are experimenting with git
     commands, running "upload-archive" appears to generate
     a bunch of barely-readable garbage (which is in fact
     the git protocol intermingled with stderr). It's nicer
     if we provide them with a readable error message.

Instead, we can detect a bad command-line before we spawn
the helper and give a more human-readable complaint (i.e.,
helping reason (2) above). This doesn't hurt case (1) as
much as you might think, because in the ssh case, the user
should be receiving stderr from the parent process anyway.

So before they saw:

  $ git archive --remote=3D... --exec=3D'git upload-archive bogus'
  fatal: sent error to the client: git upload-archive: archiver died wi=
th error
  remote: usage: git upload-archive <repo>
  remote: git upload-archive: archiver died with error

and now they see:

  usage: git upload-archive <repo>
  fatal: The remote end hung up unexpectedly

Signed-off-by: Jeff King <peff@peff.net>
---
I'm lukewarm on this patch. I actually think the original output is
slightly nicer, so you are hurting case (1) for people in case (2). But
case (2), running random programs to see what happens, is not something
we probably need to be encouraging.

 builtin/upload-archive.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index b928beb..0733775 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -10,6 +10,8 @@
=20
 static const char upload_archive_usage[] =3D
 	"git upload-archive <repo>";
+static const char upload_archive_writer_usage[] =3D
+	"git upload-archive--writer <repo>";
=20
 static const char deadchild[] =3D
 "git upload-archive: archiver died with error";
@@ -25,7 +27,7 @@ int cmd_upload_archive_writer(int argc, const char **=
argv, const char *prefix)
 	int len;
=20
 	if (argc !=3D 2)
-		usage(upload_archive_usage);
+		usage(upload_archive_writer_usage);
=20
 	if (strlen(argv[1]) + 1 > sizeof(buf))
 		die("insanely long repository name");
@@ -96,6 +98,9 @@ int cmd_upload_archive(int argc, const char **argv, c=
onst char *prefix)
 {
 	struct child_process writer =3D { argv };
=20
+	if (argc !=3D 2)
+		usage(upload_archive_usage);
+
 	/*
 	 * Set up sideband subprocess.
 	 *
--=20
1.7.9.rc0.33.gd3c17
