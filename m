From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv3 1/8] Introduce commit notes
Date: Thu, 30 Jul 2009 03:14:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907300313440.8306@pacific.mpi-cbg.de>
References: <1248834326-31488-1-git-send-email-johan@herland.net> <81b0412b0907290152w27c1b5b5l9efbd6980d4f904e@mail.gmail.com> <alpine.DEB.1.00.0907291839350.7626@intel-tinevez-2-302> <200907300250.03485.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	gitster@pobox.com, trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 30 03:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWKEQ-0005ce-61
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 03:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbZG3BOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 21:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756062AbZG3BOr
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 21:14:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:52454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754875AbZG3BOq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 21:14:46 -0400
Received: (qmail invoked by alias); 30 Jul 2009 01:14:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 30 Jul 2009 03:14:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FlvBUaFuF4qfWC3sQSTThD5iPNn9wdWKS/G/EIH
	BtovzjlCofIY1s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200907300250.03485.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124434>

Hi,

On Thu, 30 Jul 2009, Johan Herland wrote:

> On Wednesday 29 July 2009, Johannes Schindelin wrote:
> > On Wed, 29 Jul 2009, Alex Riesen wrote:
> > > On Wed, Jul 29, 2009 at 04:25, Johan Herland<johan@herland.net> wrote:
> > > > @@ -963,5 +964,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const
> > > > struct commit *commit, +
> > > > +       if (fmt != CMIT_FMT_ONELINE)
> > > > +               get_commit_notes(commit, sb, encoding);
> > > > +
> > >
> > > Someday we will need a way to switch off the display of notes
> > > without resolving to oneline format.
> > > Is there a notes specifier for the printf-like log message formatting
> > > (--pretty=format: or --format) planned, BTW?
> >
> > That would probably be something like "GIT_NOTES_REF=nyanyanya git log"?
> 
> Yes, that works, although I suspect some users will prefer a command-line
> argument instead.
> 
> Nonetheless, I think it makes sense to add a notes specifier to be used in 
> --pretty/--format.
> 
> I'll try to remember to look into this later, but I'll be grateful if 
> someone gets to it before me.

Probably you will not want to show the "\nNotes:" prefix, and also not 
indent the string, but that is something you could make conditional upon a 
flag to get_commit_notes().  But this should get you started:

-- snipsnap --
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..5fb10b3 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,7 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%N': commit notes
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index fee6789..7349697 100644
--- a/pretty.c
+++ b/pretty.c
@@ -690,6 +690,10 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'd':
 		format_decoration(sb, commit);
 		return 1;
+	case 'N':
+		get_commit_notes(commit, sb, git_log_output_encoding ?
+				git_log_output_encoding : git_commit_encoding);
+		return 1;
 	}
 
 	/* For the rest we have to parse the commit header. */
