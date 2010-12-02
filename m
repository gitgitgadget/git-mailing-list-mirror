From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 2 Dec 2010 14:05:54 -0500
Message-ID: <20101202190553.GB20225@sigill.intra.peff.net>
References: <AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
 <87sjygspgy.fsf@picasso.cante.net>
 <buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
 <87bp54s770.fsf@picasso.cante.net>
 <87mxoos4a8.fsf@catnip.gol.com>
 <20101202132053.GF6537@picasso.cante.net>
 <m262vcqdb9.fsf@igel.home>
 <7veia0rrew.fsf@alter.siamese.dyndns.org>
 <20101202184617.GA20225@sigill.intra.peff.net>
 <7vvd3cqa44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	jari <jari.aalto@cante.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:06:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POETh-0001mb-Fu
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699Ab0LBTFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:05:55 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41631 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755427Ab0LBTFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:05:54 -0500
Received: (qmail 15296 invoked by uid 111); 2 Dec 2010 19:05:54 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 02 Dec 2010 19:05:54 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Dec 2010 14:05:54 -0500
Content-Disposition: inline
In-Reply-To: <7vvd3cqa44.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162733>

On Thu, Dec 02, 2010 at 10:54:03AM -0800, Junio C Hamano wrote:

> > but I am not sure the results are always more readable. I think "foo^"
> > is perhaps nicer than "foo~1". But in more complex examples, I kind of
> > think the ~1 is easier to read. E.g.:
> >
> >   # old
> >   $ git name-rev 9904fadf
> >   9904fadf tags/v1.7.3-rc2~1^2~1
> >
> >   # new
> >   $ git name-rev 9904fadf
> >   9904fadf tags/v1.7.3-rc2~1^2^
> 
> Curious.  Why does the "first take the first parent of rc2" is left as-is,
> while "then lastly take its parent" does get shortened?

Because my patch is crappy and I didn't spend more than 30 seconds
testing it? :)

It needs a similar change elsewhere, so the full patch should be:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c946a82..03d7bce 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -64,9 +64,15 @@ copy_data:
 
 			if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
 				len -= 2;
-			if (generation > 0)
-				sprintf(new_name, "%.*s~%d^%d", len, tip_name,
+			if (generation > 0) {
+				int w = sprintf(new_name, "%.*s", len, tip_name);
+				if (generation == 1)
+					sprintf(new_name + w, "^^%d",
+						parent_number);
+				else
+					sprintf(new_name + w, "~%d^%d",
 						generation, parent_number);
+			}
 			else
 				sprintf(new_name, "%.*s^%d", len, tip_name,
 						parent_number);
@@ -142,8 +148,12 @@ static const char *get_rev_name(const struct object *o)
 		int len = strlen(n->tip_name);
 		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
 			len -= 2;
-		snprintf(buffer, sizeof(buffer), "%.*s~%d", len, n->tip_name,
-				n->generation);
+		if (n->generation == 1)
+			snprintf(buffer, sizeof(buffer), "%.*s^", len,
+				 n->tip_name);
+		else
+			snprintf(buffer, sizeof(buffer), "%.*s~%d", len,
+				 n->tip_name, n->generation);
 
 		return buffer;
 	}

However, IMHO that looks even worse:

  $ git name-rev 9904fadf
  9904fadf tags/v1.7.3-rc2^^2^

-Peff
