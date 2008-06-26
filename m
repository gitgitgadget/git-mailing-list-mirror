From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] daemon: accept "git program" as well
Date: Fri, 27 Jun 2008 01:38:20 +0200
Message-ID: <4864286C.80609@free.fr>
References: <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org> <20080625053848.GJ11793@spearce.org> <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org> <20080625230228.GR11793@spearce.org> <7vmyl9w0y1.fsf@gitster.siamese.dyndns.org> <20080626082013.GT22344@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 01:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC13O-0002zL-MG
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 01:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbYFZXiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 19:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbYFZXiI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 19:38:08 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:53945 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440AbYFZXiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 19:38:05 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A24BB12B6CA;
	Fri, 27 Jun 2008 01:38:02 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D2C9F12B6C5;
	Fri, 27 Jun 2008 01:38:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080626082013.GT22344@eagain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86503>

Hi,

Tommi Virtanen a =C3=A9crit :
> On Wed, Jun 25, 2008 at 04:26:46PM -0700, Junio C Hamano wrote:
>>
>> In gitosis/serve.py, there are COMMANDS_READONLY and COMMANDS_WRITE =
array
>> that holds 'git-upload-pack' and 'git-receive-pack' commands, and th=
ey are
>> compared with user commands after doing:
>=20
> Yeah, that's pretty much a trivial change, doing it now to future-pro=
of
> gitosis.
>=20

This just happened to me with a dashless client, so I tried your patch =
but it
does not work. The problem comes from git-shell that do not support das=
hless
argument, yet (IOW: git shell -c 'git upload-pack ...' give an error).

The following patch on top of yours fix the problem. The s/git-shell/gi=
t shell/
part is not really necessary, but why not?

diff --git a/gitosis/serve.py b/gitosis/serve.py
index 9a91fcb..5aac355 100644
--- a/gitosis/serve.py
+++ b/gitosis/serve.py
@@ -21,12 +21,10 @@ ALLOW_RE =3D re.compile("^'/*(?P<path>[a-zA-Z0-9][a=
-zA-Z0-9@._-]*(/[a-zA-Z0-9][a-z
=20
 COMMANDS_READONLY =3D [
     'git-upload-pack',
-    'git upload-pack',
     ]
=20
 COMMANDS_WRITE =3D [
     'git-receive-pack',
-    'git receive-pack',
     ]
=20
 class ServingError(Exception):
@@ -75,7 +73,7 @@ def serve(
             # all known "git foo" commands take one argument; improve
             # if/when needed
             raise UnknownCommandError()
-        verb =3D '%s %s' % (verb, subverb)
+        verb =3D '%s-%s' % (verb, subverb)
=20
     if (verb not in COMMANDS_WRITE
         and verb not in COMMANDS_READONLY):
@@ -201,6 +199,6 @@ class Main(app.App):
             sys.exit(1)
=20
         main_log.debug('Serving %s', newcmd)
-        os.execvp('git-shell', ['git-shell', '-c', newcmd])
-        main_log.error('Cannot execute git-shell.')
+        os.execvp('git', ['git', 'shell', '-c', newcmd])
+        main_log.error('Cannot execute git.')
         sys.exit(1)


Olivier.
