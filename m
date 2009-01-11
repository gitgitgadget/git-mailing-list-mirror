From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] refactor the --color-words to make it more
 hackable
Date: Mon, 12 Jan 2009 00:02:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112351050.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <200901112253.27165.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 12 00:02:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM9KK-0000in-D4
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZAKXBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZAKXBQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:01:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:43141 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751494AbZAKXBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:01:15 -0500
Received: (qmail invoked by alias); 11 Jan 2009 23:01:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 12 Jan 2009 00:01:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jgpBKLG7j7o8fcPzV+5jJEqdaVl5hGHlEkeYy9D
	XFNaKEHOBP+mL6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901112253.27165.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105248>

Hi,

On Sun, 11 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 
> > But at least _I_ think it is easy to follow, and it actually makes the code
> > more readable/hackable.  Correct me if I'm wrong.
> 
> It indeed seems a sane approach.

Thanks.

>  However, the final result segfaults and/or prints garbage (on 
> apparently every commit except very small changes) when using the regex 
> '\S+', which IMHO should give exactly the same result as not using a 
> regex at all.

No, it should not.  The correct regex is '^\S+'.

As it happens, your regex matches _anything_ + non-whitespace.  
Unfortunately, this includes a newline which utterly confuses the diff, 
and therefore the code that tries to get the true offsets.

Consequently, it crashes.

> Plain --color-words is not affected.

Of course, I did not change anything outside the code path of 
--color-words.

Ciao,
Dscho

-- snipsnap --
[PATCH] color-words: \n must not be a part of the word.

Allowing \n as part of a word is a pilot error, but that is not a 
reason for the code to crash.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 diff.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index d6bba72..676eb79 100644
--- a/diff.c
+++ b/diff.c
@@ -381,8 +381,10 @@ static int find_word_boundary(mmfile_t *buffer, int i, regex_t *word_regex)
 
 	if (word_regex) {
 		regmatch_t match[1];
-		if (!regexec(word_regex, buffer->ptr + i, 1, match, 0))
-			i += match[0].rm_eo;
+		if (!regexec(word_regex, buffer->ptr + i, 1, match, 0)) {
+			char *p = memchr(buffer->ptr + i, '\n', match[0].rm_eo);
+			i = p ? p - buffer->ptr : match[0].rm_eo + i;
+		}
 	}
 	else
 		while (i < buffer->size && !isspace(buffer->ptr[i]))
