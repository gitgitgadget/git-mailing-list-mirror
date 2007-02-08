From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 8 Feb 2007 20:46:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082040390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
 <Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <eqfu36$lb3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-958258419-1170963649=:22628"
Cc: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFEG-0006uD-Kj
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423279AbXBHTqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423283AbXBHTqp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:46:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:50541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423279AbXBHTqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:46:44 -0500
Received: (qmail invoked by alias); 08 Feb 2007 19:46:43 -0000
X-Provags-ID: V01U2FsdGVkX1+dZ1kingqdhy9VtHsqmRIOUVexvL8BYfdbf0tRgt
	4kTQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eqfu36$lb3$1@sea.gmane.org>
Content-ID: <Pine.LNX.4.63.0702082040530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39079>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-958258419-1170963649=:22628
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.63.0702082040531.22628@wbgn013.biozentrum.uni-wuerzburg.de>

Hi,

[Cc'ing the mailing list, not the newsgroup]

On Thu, 8 Feb 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Thu, 8 Feb 2007, Santi Béjar wrote:
> > 
> >>  when a reflog entry do not have a reflog message the refs@{num} syntax 
> >> gives a different result than with 'git log -g'. Actually 'git log -g' 
> >> just skips this ref.
> > 
> > I could be that some older git version produces empty messages. But I'd 
> > regard the empty messages to be the problem. Or is the current Git version 
> > still producing such entries?
> 
> StGIT used to produce no reflog messages; I don't know if this has 
> improved. But you can have old reflog entries with empty messages; git 
> log -g should deal with them IMHO.

I just tried. An empty string is not enough. The tab before the message 
has to be lacking, too.

Here's a small patch, if you have to have it.

---

 refs.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 7e07fc4..ba5bd2d 100644
--- a/refs.c
+++ b/refs.c
@@ -1189,12 +1189,14 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 		    !message || message[0] != ' ' ||
 		    (message[1] != '+' && message[1] != '-') ||
 		    !isdigit(message[2]) || !isdigit(message[3]) ||
-		    !isdigit(message[4]) || !isdigit(message[5]) ||
-		    message[6] != '\t')
+		    !isdigit(message[4]) || !isdigit(message[5]))
 			continue; /* corrupt? */
 		email_end[1] = '\0';
 		tz = strtol(message + 1, NULL, 10);
-		message += 7;
+		if (message[6] != '\t')
+			message += 6;
+		else
+			message += 7;
 		ret = fn(osha1, nsha1, buf+82, timestamp, tz, message, cb_data);
 		if (ret)
 			break;
---1148973799-958258419-1170963649=:22628--
