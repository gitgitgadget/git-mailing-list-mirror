From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V3] git clone: is an URL local or ssh
Date: Wed, 30 Oct 2013 02:42:31 -0400
Message-ID: <20131030064231.GA11317@sigill.intra.peff.net>
References: <201310292207.50869.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com, pclouds@gmail.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 30 07:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPUF-0003Eo-AW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 07:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3J3Gmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 02:42:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:58215 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752111Ab3J3Gme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 02:42:34 -0400
Received: (qmail 13603 invoked by uid 102); 30 Oct 2013 06:42:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 01:42:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 02:42:31 -0400
Content-Disposition: inline
In-Reply-To: <201310292207.50869.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236986>

On Tue, Oct 29, 2013 at 10:07:50PM +0100, Torsten B=C3=B6gershausen wro=
te:

>  Changes since V2:
>  clear_ssh and expect_ssh did come back
>  And I couldn't get it working without the
>  >"$TRASH_DIRECTORY/ssh-output"

Thanks.

>  test_when_finished:
>  I could not get that to work. Probably because of the
>  battle between the quotings: '"' "'" '"'

The quoting should be straight-forward, since you can do it in
expect_ssh, outside of the regular test eval. But what is tricky is tha=
t
you do not actually want "ssh-output" to disappear, but rather you want
it to be an empty file, so that tests which do not trigger ssh can
compare against it using test_cmp.

The patch below makes it work, but I'm thinking that it does not
actually improve readability. While the "clear_ssh" call is something
each test needs to remember, at least it is obvious there that the test
is clearing the state before running the clone.

>  Other note about test_might_fail:
>  The first version did not need it, git clone did
>  always succeed.
>  After a while it always failed.
>  According to my understanding, git clone ssh://xxx.yy
>  should fail (as we can not clone) ??

Cloning over ssh via our fake wrapper should work, as the wrapper finds
the shell command and execs it.  So ssh://host/path should end up
running:

  ssh host 'git-upload-pack path'

and the ssh wrapper converts that to:

  git-upload-pack path

If we want to make it more robust, we could cd into a "hosts/$host"
directory that simulates the remote host, but I don't know if that is
necessary.

---
This is the test_when_finished patch.

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 7db7f48..05afe5a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -291,14 +291,14 @@ test_expect_success 'setup ssh wrapper' '
=20
 	GIT_SSH=3D"$TRASH_DIRECTORY/ssh-wrapper" &&
 	export GIT_SSH &&
-	export TRASH_DIRECTORY
+	export TRASH_DIRECTORY &&
+	>"$TRASH_DIRECTORY"/ssh-output
 '
=20
-clear_ssh () {
-	>"$TRASH_DIRECTORY/ssh-output"
-}
-
 expect_ssh () {
+	test_when_finished '
+	  (cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
+	' &&
 	{
 		case "$1" in
 		none)
@@ -311,7 +311,6 @@ expect_ssh () {
 }
=20
 test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
-	clear_ssh &&
 	cp -R src "foo:bar" &&
 	git clone "foo:bar" foobar &&
 	expect_ssh none
@@ -323,7 +322,6 @@ counter=3D0
 # $3 path
 test_clone_url () {
 	counter=3D$(($counter + 1))
-	clear_ssh &&
 	test_might_fail git clone "$1" tmp$counter &&
 	expect_ssh "$2" "$3"
 }
