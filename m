From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add status.relativePaths config variable
Date: Sat, 8 Dec 2007 02:55:38 -0500
Message-ID: <20071208075538.GA4812@coredump.intra.peff.net>
References: <20071207165703.GA8889@sigill.intra.peff.net> <Pine.LNX.4.64.0712071853500.27959@racer.site> <4759996B.2000300@gmail.com> <20071207204937.GA20111@coredump.intra.peff.net> <20071207212607.GA11504@coredump.intra.peff.net> <7vejdxy70p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 08:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0uXa-0004Fq-6l
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 08:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbXLHHzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 02:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXLHHzm
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 02:55:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2779 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbXLHHzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 02:55:41 -0500
Received: (qmail 17283 invoked by uid 111); 8 Dec 2007 07:55:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Dec 2007 02:55:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 02:55:39 -0500
Content-Disposition: inline
In-Reply-To: <7vejdxy70p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67522>

On Fri, Dec 07, 2007 at 11:34:14PM -0800, Junio C Hamano wrote:

> I like the general idea (and suspect we might want to make it default to
> false to retain the original behaviour, but I'd refrain from suggesting
> it, to keep the user experience stable during the upcoming -rc period).
> 
> We'd need an update to git-status documentation to mention the variable.

Patch is below; please squash it into the original.

It seems kind of silly to manually write the "Configuration" section for
git-status, though. It would be nice if our config.txt could be
annotated to mention which commands use which config variables, and
git-*.txt could automagically include the right sections.

> > -	wt_status_prepare(&s);
> > -	s.prefix = prefix;
> > +	wt_status_prepare(&s, prefix);
> 
> I have been wondering ever since receiving this patch if this is a good
> interface change.  Was there a problem if instead:
> 
> 	- The implementation of wt_status_prepare(&s) stays as before;
> 
> 	- run_status(), after calling wt_status_prepare(&s), notices the
>           configuration variable, and sets s.prefix conditionally;

That would work fine. My reasoning was: the point of wt_status_prepare
is to initialize the wt_status object. I thought the "whether to use
relative paths based on config" logic should be something that _every_
preparer uses. OTOH, when I wrote it, I never expected that anyone _but_
run_status would call it (I must confess to not really investigating why
git-revert needed it; looks like it is to find a dirty index or working
tree, which is a little silly, since as a side effect we will do a find
on all untracked files).

I am fine with either; your call. Documentation patch is below.

---
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index b0cb6bc..645dc85 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -42,7 +42,8 @@ template comments, and all the output lines are prefixed with '#'.
 
 The paths mentioned in the output, unlike many other git commands, are
 made relative to the current directory, if you are working in a
-subdirectory (this is on purpose, to help cutting and pasting).
+subdirectory (this is on purpose, to help cutting and pasting). See
+the status.relativePaths config option below.
 
 
 CONFIGURATION
@@ -53,6 +54,10 @@ mean the same thing and the latter is kept for backward
 compatibility) and `color.status.<slot>` configuration variables
 to colorize its output.
 
+If the config variable `status.relativePaths` is set to false, then all
+paths shown are relative to the repository root, not to the current
+directory.
+
 See Also
 --------
 gitlink:gitignore[5]
