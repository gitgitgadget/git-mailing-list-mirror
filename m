From: Jeff King <peff@peff.net>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 1 Mar 2013 19:41:20 -0500
Message-ID: <20130302004120.GB14936@sigill.intra.peff.net>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
 <20130301233548.GA13422@sigill.intra.peff.net>
 <7v1ubyek9n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 01:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBaWK-0004QQ-JG
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 01:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab3CBAlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 19:41:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39672 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab3CBAlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 19:41:22 -0500
Received: (qmail 5680 invoked by uid 107); 2 Mar 2013 00:42:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 19:42:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 19:41:20 -0500
Content-Disposition: inline
In-Reply-To: <7v1ubyek9n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217314>

On Fri, Mar 01, 2013 at 04:08:04PM -0800, Junio C Hamano wrote:

> > +static int maildir_filename_cmp(const char *a, const char *b)
> > +{
> > +	while (1) {
> 
> It is somewhat funny that we do not need to check !*a or !*b in this
> loop.  As long as readdir() does not return duplicates, we won't be
> comparing the same strings with this function, and we won't read
> past '\0' at the end of both a and b at the same time.

Ugh, thanks for catching. I had structured this differently at first
with a while(1), and then after refactoring it forgot to update the loop
condition. Even if it is fine without duplicates, we should not rely on
that not to cause an infinite loop (in case the function is ever used
again). But moreover, you can trigger the problem even now, since we
would parse "foo_0123" and "foo_123" as equivalent, and hit the NUL.

I think this needs squashed in:

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 772c668..1ddbff4 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -132,7 +132,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
 
 static int maildir_filename_cmp(const char *a, const char *b)
 {
-	while (1) {
+	while (*a && *b) {
 		if (isdigit(*a) && isdigit(*b)) {
 			long int na, nb;
 			na = strtol(a, (char **)&a, 10);
@@ -148,6 +148,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
 			b++;
 		}
 	}
+	return *a - *b;
 }
 
 static int split_maildir(const char *maildir, const char *dir,

-Peff
