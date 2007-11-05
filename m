From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Mon, 5 Nov 2007 23:53:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711052348390.4362@racer.site>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
 <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
 <472F7B2F.4050608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:54:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBlk-00055j-QN
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbXKEXx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754750AbXKEXx5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:53:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:43206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754741AbXKEXx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:53:56 -0500
Received: (qmail invoked by alias); 05 Nov 2007 23:53:54 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 06 Nov 2007 00:53:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cqEc/mb2cgPYS7d3vFdPZbabFdMJo2jGN6zqAG8
	9XG1Eb2WEG5hFu
X-X-Sender: gene099@racer.site
In-Reply-To: <472F7B2F.4050608@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63594>

Hi,

On Mon, 5 Nov 2007, Ren? Scharfe wrote:

> Junio C Hamano schrieb:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> >> Unfortunately, we cannot reuse the result of that function, which
> >> would be cleaner: there are more users than just git log.  Most
> >> notably, git-archive with "$Format:...$" substitution.
> > 
> > That makes sense.
> > 
> > 
> >> diff --git a/pretty.c b/pretty.c
> >> index 490cede..241e91c 100644
> >> --- a/pretty.c
> >> +++ b/pretty.c
> >> @@ -393,6 +393,7 @@ void format_commit_message(const struct commit *commit,
> >>  	int i;
> >>  	enum { HEADER, SUBJECT, BODY } state;
> >>  	const char *msg = commit->buffer;
> >> +	char *active = interp_find_active(format, table, ARRAY_SIZE(table));
> >> ...
> >> +	if (active[IHASH])
> >> +		interp_set_entry(table, IHASH,
> >> +				sha1_to_hex(commit->object.sha1));
> >> +	if (active[IHASH_ABBREV])
> >> +		interp_set_entry(table, IHASH_ABBREV,
> >>  			find_unique_abbrev(commit->object.sha1,
> >>  				DEFAULT_ABBREV));
> > 
> > Instead of allocating a separate array and freeing at the end,
> > wouldn't it make more sense to have a bitfield that records what
> > is used by the format string inside the array elements?
> 
> How about (ab)using the value field?  Let interp_find_active() mark
> unneeded entries with NULL, and the rest with some cookie.  All table
> entries with non-NULL values need to be initialized.  interp_set_entry()
> needs to be aware of this cookie, as it mustn't free() it.  The cookie
> could be the address of a static char* in interpolate.c.

Yeah, something like this on top of my earlier patch (and obviously the 
corresponding change from "if (active[IHASH])" to
"if (table[IHASH].value)"):

---

 interpolate.c |   10 ++++------
 interpolate.h |    2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/interpolate.c b/interpolate.c
index 80eeb36..05a22e1 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -5,13 +5,14 @@
 #include "git-compat-util.h"
 #include "interpolate.h"
 
+static const char *empty_value = "";
 
 void interp_set_entry(struct interp *table, int slot, const char *value)
 {
 	char *oldval = table[slot].value;
 	char *newval = NULL;
 
-	if (oldval)
+	if (oldval && oldval != empty_value)
 		free(oldval);
 
 	if (value)
@@ -103,10 +104,9 @@ unsigned long interpolate(char *result, unsigned long reslen,
 	return newlen;
 }
 
-char *interp_find_active(const char *orig,
+void interp_find_active(const char *orig,
 		const struct interp *interps, int ninterps)
 {
-	char *result = xcalloc(1, ninterps);
 	char c;
 	int i;
 
@@ -115,10 +115,8 @@ char *interp_find_active(const char *orig,
 			/* Try to match an interpolation string. */
 			for (i = 0; i < ninterps; i++)
 				if (!prefixcmp(orig, interps[i].name + 1)) {
-					result[i] = 1;
+					interps[i].value = empty_value;
 					orig += strlen(interps[i].name + 1);
 					break;
 				}
-
-	return result;
 }
diff --git a/interpolate.h b/interpolate.h
index 2d197c5..19b7ebe 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -22,7 +22,7 @@ extern void interp_clear_table(struct interp *table, int ninterps);
 extern unsigned long interpolate(char *result, unsigned long reslen,
 				 const char *orig,
 				 const struct interp *interps, int ninterps);
-extern char *interp_find_active(const char *orig,
+extern void interp_find_active(const char *orig,
 				const struct interp *interps, int ninterps);
 
 #endif /* INTERPOLATE_H */


Hmm?

Ciao,
Dscho
