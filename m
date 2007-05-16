From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 16 May 2007 07:15:07 -0400
Message-ID: <20070516111506.GC30256@coredump.intra.peff.net>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org> <20070515042200.GA10884@coredump.intra.peff.net> <20070515045044.GB2805@fieldses.org> <20070515050808.GA11745@coredump.intra.peff.net> <20070515082407.GA9096@diana.vm.bytemark.co.uk> <7v3b1ylb48.fsf@assigned-by-dhcp.cox.net> <20070515095756.GB18942@coredump.intra.peff.net> <7vlkfqj5fm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 13:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoHTU-0001Z1-AT
	for gcvg-git@gmane.org; Wed, 16 May 2007 13:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270AbXEPLPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 07:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756349AbXEPLPL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 07:15:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1284 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756270AbXEPLPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 07:15:09 -0400
Received: (qmail 14113 invoked from network); 16 May 2007 11:15:09 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 May 2007 11:15:09 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2007 07:15:07 -0400
Content-Disposition: inline
In-Reply-To: <7vlkfqj5fm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47433>

On Tue, May 15, 2007 at 11:41:01AM -0700, Junio C Hamano wrote:

> I do not want to break projects whose members consistently use a
> single non UTF-8 encoding, and I've been hoping that in such a
> use case they should not have to set any of these encoding
> configuration.  So in that sense I would be somewhat reluctant
> to agree with the last one.  But I am getting a feeling that it
> is a losing battle.

I think that is a good goal, but I think we have already failed, as
git-format-patch generates content-type headers with charset=utf-8
(unless the encoding variables are set up). This code was added last
year around this time (cdd406e38).

It looks like this is squelched in the presence of format.headers
configuration. However, that still means they have to do _something_ to
get it to work right (and I note that the fact that format.headers
squelches MIME headers doesn't seem to be documented anywhere...)

> I think it is a reasonable compromise to do it the way you
> outlined.  Doing it at patch generation time would fix the
> ambiguity issues during the step 2, so it might turn out to be
> necessary to add the encoding header to format-patch output
> after all, but send-email needs to be able to handle messages
> that do not have the header anyway, so probably the first step
> is to do so in send-email.

As I noted in my other email, it actually _is_ there already. So the
MIME-Version fix just keeps the status quo, and we've been doing it this
way for a year.

Is it still worth making these guesses in send-email?

> > Also Junio, it looks like commit 7cbcf4d5 moved parsing of the
> > --encoding parameter into setup_revisions, but it's still being checked
> > for in cmd_log_init. Can you confirm that the latter is now superfluous
> > and can be removed?
> Thanks for noticing, and I think you are right.  The code parses
> the same input and sets the same global variable the same way.

Well, I wouldn't have noticed it if you hadn't written git-log -S. :) In
case you haven't fixed it yet, here it is in patch form:

-- >8 --
cmd_log_init: remove parsing of --encoding command line parameter

This was moved to the setup_revisions parsing in 7cbcf4d5, so it was
never being triggered.

Signed-off-by: Jeff King <peff@peff.net>
---
diff --git a/builtin-log.c b/builtin-log.c
index 3744712..cebb958 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -60,13 +60,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		rev->always_show_header = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (!prefixcmp(arg, "--encoding=")) {
-			arg += 11;
-			if (strcmp(arg, "none"))
-				git_log_output_encoding = xstrdup(arg);
-			else
-				git_log_output_encoding = "";
-		} else if (!strcmp(arg, "--decorate")) {
+		if (!strcmp(arg, "--decorate")) {
 			if (!decorate)
 				for_each_ref(add_ref_decoration, NULL);
 			decorate = 1;
