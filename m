From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git fast-export: add --no-data option
Date: Mon, 27 Jul 2009 20:49:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907272042450.6883@intel-tinevez-2-302>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>  <7vfxcku13i.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907251942390.8306@pacific.mpi-cbg.de> <7f9d599f0907270548k15c51a01j1fedba20c66b66f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-319961799-1248720597=:6883"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVVH7-0007PU-DX
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbZG0SuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbZG0SuF
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:50:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:49143 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753725AbZG0SuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:50:04 -0400
Received: (qmail invoked by alias); 27 Jul 2009 18:50:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 27 Jul 2009 20:50:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7MLgmtoT7EAp4CkTHTXiFJ7gDNA4XcKWQf7Is4/
	ctzO+lT8Isn7Y5
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7f9d599f0907270548k15c51a01j1fedba20c66b66f6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124183>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-319961799-1248720597=:6883
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 27 Jul 2009, Geoffrey Irving wrote:

> On Sat, Jul 25, 2009 at 1:44 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> > On Sat, 25 Jul 2009, Junio C Hamano wrote:
> >
> >> Geoffrey Irving <irving@naml.us> writes:
> >>
> >> > @@ -504,6 +508,8 @@ int cmd_fast_export(int argc, const char **argv,
> >> > const char *prefix)
> >> >                          "Import marks from this file"),
> >> >             OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
> >> >                          "Fake a tagger when tags lack one"),
> >> > +           OPT_BOOLEAN(0, "no-data", &no_data,
> >> > +                        "Skip output of blob data"),
> >>
> >> Shouldn't this be --[no-]data option that defaults to true? 
> >>  Otherwise you would accept --no-no-data that looks silly.
> >
> > Maybe
> >
> >                OPT_NEGBIT(0, "data", &no_data,
> >                             "Skip output of blob data", 1),
> >
> > Hmm?
> 
> Not quite.  That produces
> 
> usage: git fast-export [rev-list-opts]
> 
>     --progress <n>        show progress after <n> objects
>     --signed-tags <mode>  select handling of signed tags
>     --export-marks <FILE>
>                           Dump marks to this file
>     --import-marks <FILE>
>                           Import marks from this file
>     --fake-missing-tagger
>                           Fake a tagger when tags lack one
>     --data                Skip output of blob data
> 
> I don't see similar uses of OPT_NEGBIT, so maybe the necessary option
> case hasn't been written yet (or I'm missing something obvious)?

There is an ugly solution:

		{ OPTION_NEGBIT, 0, "no-data", &no_data, NULL, NULL,
			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0 },
		{ OPTION_BIT, 0, "no-data", NULL, NULL,
			"Skip output of blob data",
			PARSE_OPT_NOARG, NULL, 1 },

and there is a more elegant solution:

[PATCH] parse-opt: optionally show "--no-" option string

It is usually better to have positive options, to avoid confusing double
negations.  However, sometimes it is desirable to show the negative option
in the help.

Introduce the flag PARSE_OPT_NEGHELP to do that.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 parse-options.c |    6 ++++--
 parse-options.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 68accef..a64a4d6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -511,7 +511,7 @@ static int usage_with_options_internal(const char * const *usagestr,
 			continue;
 
 		pos = fprintf(stderr, "    ");
-		if (opts->short_name) {
+		if (opts->short_name && !(opts->flags & PARSE_OPT_NEGHELP)) {
 			if (opts->flags & PARSE_OPT_NODASH)
 				pos += fprintf(stderr, "%c", opts->short_name);
 			else
@@ -520,7 +520,9 @@ static int usage_with_options_internal(const char * const *usagestr,
 		if (opts->long_name && opts->short_name)
 			pos += fprintf(stderr, ", ");
 		if (opts->long_name)
-			pos += fprintf(stderr, "--%s", opts->long_name);
+			pos += fprintf(stderr, "--%s%s",
+				(opts->flags & PARSE_OPT_NEGHELP) ?  "no-" : "",
+				opts->long_name);
 		if (opts->type == OPTION_NUMBER)
 			pos += fprintf(stderr, "-NUM");
 
diff --git a/parse-options.h b/parse-options.h
index 4b62361..8f0035a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -36,6 +36,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
+	PARSE_OPT_NEGHELP = 128,
 };
 
 struct option;
--8323329-319961799-1248720597=:6883--
