From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] Teach git diff about Objective-C syntax
Date: Tue, 30 Sep 2008 19:52:11 -0500
Message-ID: <mJtumbyBuR0sRaFjwb6O5_D_ps0fVfz6APTAAjYMixV0MvzP8nEZRw@cipher.nrlssc.navy.mil>
References: <57518fd10809171630v97485aalcc5089f96082c0fc@mail.gmail.com> <1222818394-11547-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Wed Oct 01 03:00:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkq4O-0008H0-TZ
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 03:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYJAAxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 20:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYJAAxj
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 20:53:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49446 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYJAAxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 20:53:38 -0400
Received: by mail.nrlssc.navy.mil id m910qCZr008563; Tue, 30 Sep 2008 19:52:12 -0500
In-Reply-To: <1222818394-11547-1-git-send-email-jon.delStrother@bestbefore.tv>
X-OriginalArrivalTime: 01 Oct 2008 00:52:12.0046 (UTC) FILETIME=[F07E8AE0:01C9235F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97178>

Jonathan del Strother wrote:
> Add support for recognition of Objective-C class & instance methods, C functions, and class implementation/interfaces.
> 
> Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
> ---
> This version is much the same, but rebuilt on top of 1883a0d3b to use the extended regexp stuff, and it doesn't attempt to tidy up other patterns.
> 
> I've been trying to make the objc-method matching line a bit more specific - I think I'm running into a bug (or more likely a misunderstanding) in the matching process.
> Every pattern there uses either .*$ or [^;]*$ to match up to the end of a line.  But in trying to come up with a whitelist of characters to match up to the end of a line, I couldn't do it : there seems to be an invisible character at the end of the line that I can't match.
> That is, a line containing just "FUNCNAME" (terminated by a newline) will be matched by the pattern "^(FUNCNAME.$)" but not "^(FUNCNAME$)".
> Why is this?

I think it is the newline which git is not removing from the string passed to regexec.

See: http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html#tag_09_02

   "...In the regular expression processing described in IEEE Std 1003.1-2001,
    the <newline> is regarded as an ordinary character and both a period and a
    non-matching list can match one."

   "...Those utilities (like grep) that do not allow <newline>s to match are
    responsible for eliminating any <newline> from strings before matching against
    the RE."


Possibly something like:

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 8bab82e..f471c7c 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -191,7 +191,7 @@ struct ff_regs {
 static long ff_regexp(const char *line, long len,
		char *buffer, long buffer_size, void *priv)
 {
-	char *line_buffer = xstrndup(line, len); /* make NUL terminated */
+	char *line_buffer = xstrndup(line, len-1); /* make NUL terminated */
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
 	int i;
