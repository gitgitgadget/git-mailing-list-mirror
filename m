From: Jeff King <peff@peff.net>
Subject: Re: hooks scripts and noexec partition
Date: Wed, 15 Jan 2014 04:16:09 -0500
Message-ID: <20140115091609.GC14335@sigill.intra.peff.net>
References: <CAJ1PRS=96aSp3GE+wj=zHX=JGfZbjUeiUuiDDvfJNuRhrbK_Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "krzf83@gmail.com " <krzf83@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 10:16:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3MaD-0003d4-0f
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 10:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbaAOJQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 04:16:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:60966 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbaAOJQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 04:16:11 -0500
Received: (qmail 11372 invoked by uid 102); 15 Jan 2014 09:16:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 03:16:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 04:16:09 -0500
Content-Disposition: inline
In-Reply-To: <CAJ1PRS=96aSp3GE+wj=zHX=JGfZbjUeiUuiDDvfJNuRhrbK_Yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240446>

On Tue, Jan 14, 2014 at 04:41:03PM +0100, krzf83@gmail.com  wrote:

> git can't execute hooks no partitions mounted with noexec - even if
> those are just scripts with shebang line

Right. Git does not know that they are shell (or other) scripts; they
could be anything, and the advertised interface is that git will run
exec on them (and it is explicitly OK for them to exist but not be
executable, and git takes this as a sign that they are inactive).

> and they actualy work by
> hooks/./post-comit (because I use small patch on kernel that allows
> running scripts that way on noexec partition)

If you are suggesting that git always execute them as "hooks/./$hook",
that might make sense if such behavior is widespread. But it sounds like
you are running a custom kernel patch to get around the noexec setting.
Here is the custom git patch to match it. :)

diff --git a/run-command.c b/run-command.c
index 3914d9c..ae84e87 100644
--- a/run-command.c
+++ b/run-command.c
@@ -753,7 +753,7 @@ int finish_async(struct async *async)
 
 char *find_hook(const char *name)
 {
-	char *path = git_path("hooks/%s", name);
+	char *path = git_path("hooks/./%s", name);
 	if (access(path, X_OK) < 0)
 		path = NULL;
 

-Peff
