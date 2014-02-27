From: Jeff King <peff@peff.net>
Subject: Re: Cygwin + git log = no pager!
Date: Thu, 27 Feb 2014 01:21:07 -0500
Message-ID: <20140227062107.GA21000@sigill.intra.peff.net>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
 <53085434.4060106@gmail.com>
 <CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
 <530AFAFD.2060504@gmail.com>
 <20140224090618.GB10698@sigill.intra.peff.net>
 <CAHd499BDBgaAZFkoc=S9i9hG=NifAmqhaW86fqgkzjShZd07ww@mail.gmail.com>
 <20140226092610.GB32537@sigill.intra.peff.net>
 <CAHd499Co9Amdf_gWnY81dkRa2uDTH0fVM8HSb99VHhrb1AAKhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 07:21:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIuLN-00065D-6I
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 07:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaB0GVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 01:21:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:57819 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750742AbaB0GVK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 01:21:10 -0500
Received: (qmail 3493 invoked by uid 102); 27 Feb 2014 06:21:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 00:21:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 01:21:07 -0500
Content-Disposition: inline
In-Reply-To: <CAHd499Co9Amdf_gWnY81dkRa2uDTH0fVM8HSb99VHhrb1AAKhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242785>

On Wed, Feb 26, 2014 at 09:54:39AM -0600, Robert Dailey wrote:

> > That _should_ turn on the pager, but I think it does not due to a bug
> > with setup_pager and aliases. Something like the patch below would make
> > it work (but if you are having to use "-p" manually, there is something
> > to fix in your cygwin environment, which does not think you are on a
> > terminal).
> 
> I have tried `git -p log` and `git log` and neither use the pager.

I thought Git's behavior was a bug, but it seems to be the intended
effect that "-p" is just "cancel --no-pager" and not "turn on the pager,
even if stdout is not a tty".

So the patch I sent is not something we would want to apply, but it
might help debugging your situation (if my hunch is right that isatty()
is returning false, then "git -p log" would work with it). Or perhaps a
simpler way to check that is just:

diff --git a/pager.c b/pager.c
index 0cc75a8..6d870ac 100644
--- a/pager.c
+++ b/pager.c
@@ -41,8 +41,10 @@ const char *git_pager(int stdout_is_tty)
 {
 	const char *pager;
 
-	if (!stdout_is_tty)
+	if (!stdout_is_tty) {
+		warning("disabling pager, stdout is not a tty");
 		return NULL;
+	}
 
 	pager = getenv("GIT_PAGER");
 	if (!pager) {

> Should I apply the provided patch to the Git for Windows master
> branch? Also I'm not sure if there is a convenient way to apply a
> patch via email, so should I copy & paste it to a file & then apply
> the file?

The usual way is to save the patch to an mbox, then use "git am" to
apply it. Most Unix-y mail clients have mbox support, but I suspect many
Windows ones do not.

-Peff
