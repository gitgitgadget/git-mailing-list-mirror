From: Jeff King <peff@peff.net>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 17:35:29 -0400
Message-ID: <20140424213529.GB7815@sigill.intra.peff.net>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
 <87lhuvb9kr.fsf@fencepost.gnu.org>
 <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
 <87tx9ia5zq.fsf@fencepost.gnu.org>
 <xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, d9ba@mailtor.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 23:35:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRIu-0000VH-PL
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 23:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbaDXVfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 17:35:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:37825 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751203AbaDXVfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 17:35:31 -0400
Received: (qmail 10350 invoked by uid 102); 24 Apr 2014 21:35:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Apr 2014 16:35:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Apr 2014 17:35:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247010>

On Thu, Apr 24, 2014 at 12:29:21PM -0700, Junio C Hamano wrote:

> David Kastrup <dak@gnu.org> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Traditionally, because the tool grew in a context of being used in a
> >> project whose participants are at least not malicious, always having
> >> to be on the lookout for fear of middle-of-line tabs hiding bad
> >> contents near the right edges of lines has never been an issue.
> >
> > My beef is not with "hiding bad contents" but with "hiding contents".
> > It makes the output useless for seeing what is actually happening as
> > soon as the option starts having an effect.
> 
> My suspicion is that one of the reasons why S was chosen to be in
> the default was to mildly discourage people from busting the usual
> line-length limit, but I am not Linus ;-)

I would think it's the opposite. Long lines look _horrible_ without
"-S", as they get wrapped at awkward points. Using "-S" means that long
lines don't bug you, unless you really want to scroll over and see the
content.

I really think the right solution here is to teach less to make it more
obvious that there is something worth scrolling over to. Here's a very
rough patch for less, if you want to see what I'm thinking of.

diff --git a/input.c b/input.c
index b211323..01aa411 100755
--- a/input.c
+++ b/input.c
@@ -178,6 +178,7 @@ get_forw_line:
 			 */
 			if (chopline || hshift > 0)
 			{
+				set_chopped_marker(ch_tell()-1);
 				do
 				{
 					if (ABORT_SIGS())
diff --git a/line.c b/line.c
index 1eb3914..b3358a0 100755
--- a/line.c
+++ b/line.c
@@ -1080,6 +1080,20 @@ set_status_col(c)
 	attr[0] = AT_NORMAL|AT_HILITE;
 }
 
+	public void
+set_chopped_marker(pos)
+	    POSITION pos;
+{
+	/*
+	 * Roll back output by one character; probably
+	 * we need to actually walk curr back further
+	 * for multibyte characters?
+	 */
+	column--;
+	curr--;
+	store_char('>', AT_NORMAL|AT_HILITE, NULL, pos);
+}
+
 /*
  * Get a character from the current line.
  * Return the character as the function return value,

-Peff
