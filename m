From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv5 1/2] http.c: implement the GIT_TRACE_CURL environment
 variable
Date: Mon, 2 May 2016 15:25:54 -0400
Message-ID: <20160502192554.GA13492@sigill.intra.peff.net>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
 <20160502142813.50868-2-gitter.spiros@gmail.com>
 <xmqq60uwthfh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	tboegi@web.de, ramsay@ramsayjones.plus.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:26:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJTz-0006Wi-L0
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbcEBTZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 15:25:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:60522 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754938AbcEBTZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:25:57 -0400
Received: (qmail 11796 invoked by uid 102); 2 May 2016 19:25:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 15:25:56 -0400
Received: (qmail 17949 invoked by uid 107); 2 May 2016 19:26:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 15:26:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2016 15:25:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60uwthfh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293273>

On Mon, May 02, 2016 at 11:59:14AM -0700, Junio C Hamano wrote:

> > +int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
> > +{
> > +	const char *text;
> > +	(void)handle;		/* prevent compiler unused parameter warning if checked */
> > +	(void)userp;		/* prevent compiler unused parameter warning if checked */
> 
> I really do not want to see these casts.  Unused parameters are
> perfectly normal in a codebase with callback functions, no?  I do
> not think these are the first occurrences of unused parameters in
> our codebase, and I do not think we have such cast to void to them.
> Why add this ugliness only to here?

Yeah, it is pointless to use -Wunused-parameter in our code base, as it
turns up over 1200 hits (though some are repeats from include files).
Most are callbacks, but some also look like compat functions. But
clearly it's going to be a false positive any time the interface to the
function is dictated by something other than the function body.

I generally don't mind quieting false positive warnings if we think it
might provide an opportunity for cleanup (i.e., parameters that really
_can_ go away). But I don't think gcc provides a great way to do it.

You can mark individual parameters as unused, like:

diff --git a/git-compat-util.h b/git-compat-util.h
index ba51cfd..71b4f7b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -331,7 +331,7 @@ extern char *gitdirname(char *);
 #endif
 
 #ifndef has_dos_drive_prefix
-static inline int git_has_dos_drive_prefix(const char *path)
+static inline int git_has_dos_drive_prefix(const char *path __attribute__((unused)))
 {
 	return 0;
 }
@@ -339,7 +339,7 @@ static inline int git_has_dos_drive_prefix(const char *path)
 #endif
 
 #ifndef skip_dos_drive_prefix
-static inline int git_skip_dos_drive_prefix(char **path)
+static inline int git_skip_dos_drive_prefix(char **path __attribute__((unused)))
 {
 	return 0;
 }

That's not too bad in a single-argument function, but for callbacks it
can get pretty tedious:

diff --git a/wt-status.c b/wt-status.c
index 1ea2ebe..7f00981 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1300,8 +1300,11 @@ struct grab_1st_switch_cbdata {
 	unsigned char nsha1[20];
 };
 
-static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
-			   const char *email, unsigned long timestamp, int tz,
+static int grab_1st_switch(unsigned char *osha1 __attribute__((unused)),
+			   unsigned char *nsha1,
+			   const char *email __attribute__((unused)),
+			   unsigned long timestamp __attribute__((unused)),
+			   int tz __attribute__((unused)),
 			   const char *message, void *cb_data)
 {
 	struct grab_1st_switch_cbdata *cb = cb_data;

It would be much nicer if we had some way of declaring the whole
_function_ as having an interface dictated elsewhere. Then it becomes a
single attribute per callback function, and actually tells the human
reader something useful: not "I happen to not need these variables right
now", but "my interface is specified elsewhere and not up for debate".

But AFAIK, there's no such attribute.

-Peff
