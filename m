From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match
 directory "foo"
Date: Thu, 31 Jan 2008 11:38:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801311128190.23907@racer.site>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com> <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com> <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org> <47A06EF9.60704@users.sourceforge.net>
 <7vprvjgi9v.fsf@gitster.siamese.dyndns.org> <47A1733E.9040103@users.sourceforge.net> <7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org> <7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org> <20080131094124.GA25546@coredump.intra.peff.net> <7vfxwecmfe.fsf@gitster.siamese.dyndns.org>
 <20080131104256.GF25546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 12:40:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKXlv-00021h-Tx
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 12:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbYAaLj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 06:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbYAaLj1
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 06:39:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:37717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753984AbYAaLj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 06:39:26 -0500
Received: (qmail invoked by alias); 31 Jan 2008 11:39:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 31 Jan 2008 12:39:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X18VgO1PXp6dcnSiIhMFt5ljK6FBmNLgZJYgzUi
	Qo/8DFJd9eSBXQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20080131104256.GF25546@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72128>

Hi,

On Thu, 31 Jan 2008, Jeff King wrote:

> On Thu, Jan 31, 2008 at 02:35:33AM -0800, Junio C Hamano wrote:
> 
> > Without "foo/", you do not have to pay the price, so I think that is a 
> > sane optimization, but at the same time it would make it worse if 
> > "foo/" is actually used.  excluded_1() is called for the same pathname 
> > from a loop to check for a match and you would end up running lstat(2) 
> > three times (once each for EXC_CMDL, EXC_DIRS and EXC_FILE).
> > 
> > But maybe people who want "foo/" deserve it.  I dunno.
> 
> Ah, I didn't look at it that closely.
> 
> To do the laziness right, I think you would need to pass a pointer to 
> the dtype around, and just fill it in the first time it is needed.

Just to add my two eurocents: I think the patch is complicated enough that 
we could go the other way round: while parsing the ignore entries, we can 
plainly state that entries with a trailing slash are ignored:

-- snipsnap --
[PATCH] Warn if an ignore/exclude entry ends in a slash

Git does not like ignore entries ending in a slash; they will be ignored.
So just be honest and warn the user about it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 dir.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 1b9cc7a..c3e9a0d 100644
--- a/dir.c
+++ b/dir.c
@@ -135,6 +135,11 @@ void add_exclude(const char *string, const char *base,
 	}
 	x->pattern = string;
 	x->patternlen = strlen(string);
+	if (x->patternlen && x->pattern[x->patternlen - 1] == '/') {
+		warning("Ignoring ignore entry because of trailing slash: %s",
+			string);
+		return;
+	}
 	x->base = base;
 	x->baselen = baselen;
 	x->flags = 0;
