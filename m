From: Jeff King <peff@peff.net>
Subject: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sat, 4 Feb 2012 13:26:11 -0500
Message-ID: <20120204182611.GA31091@sigill.intra.peff.net>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino>
 <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 19:26:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtkJb-0000tq-Li
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 19:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab2BDS0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 13:26:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57693
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169Ab2BDS0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 13:26:17 -0500
Received: (qmail 11093 invoked by uid 107); 4 Feb 2012 18:33:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 13:33:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 13:26:11 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189891>

On Sat, Feb 04, 2012 at 05:46:05PM +0200, Felipe Contreras wrote:

> In any case, the one to blame for the header corruption is git:
> [...]
> f2bb9f88 (<spearce@spearce.org>> 2006-11-27 03:41:01 -0500 952)
> 
> Notice the mail is wrong.

Ugh. The fault lies in this code:

  $ sed -n 1405,1414p builtin/blame.c 
          if (map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
                  /* Add a trailing '>' to email, since map_user returns plain emails
                     Note: It already has '<', since we replace from mail+1 */
                  mailpos = memchr(mail, '\0', mail_len);
                  if (mailpos && mailpos-mail < mail_len - 1) {
                          *mailpos = '>';
                          *(mailpos+1) = '\0';
                  }
          }
  }

But that comment is wrong. If there's no email mapping needed, map_user
will leave the "mail" buffer intact, in which case it will have the
trailing ">" (because we feed the address with enclosing angle
brackets).  So while map_user tries to accept either "foo@example.com\0"
and "foo@example.com>", it is up to the contents of the mailmap whether
you get back something with the closing angle bracket or not. Which is a
pretty error-prone interface.

You can fix it with this:

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a67c20..9b886fa 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1406,7 +1406,8 @@ static void get_ac_line(const char *inbuf, const char *what,
 		/* Add a trailing '>' to email, since map_user returns plain emails
 		   Note: It already has '<', since we replace from mail+1 */
 		mailpos = memchr(mail, '\0', mail_len);
-		if (mailpos && mailpos-mail < mail_len - 1) {
+		if (mailpos && mailpos-mail < mail_len - 1 &&
+		    mailpos > mail && *(mailpos-1) != '>') {
 			*mailpos = '>';
 			*(mailpos+1) = '\0';
 		}

but it feels like the fix should go into map_user.  I tried a few things,
like "git log -1 --format=%aE", and couldn't find other code paths with
this problem. So presumably they are all feeding email addresses without
the closing ">" (so one option is to just say "map_user needs to get
NUL-terminated strings).

-Peff
