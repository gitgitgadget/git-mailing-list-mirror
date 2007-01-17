From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 11:44:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701171138371.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701170024.10640.jnareb@gmail.com>
 <Pine.LNX.4.63.0701170948420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701171048.03686.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 11:44:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H78H5-0007OS-Sa
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 11:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXAQKoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 05:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXAQKoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 05:44:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:41724 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932231AbXAQKoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 05:44:08 -0500
Received: (qmail invoked by alias); 17 Jan 2007 10:44:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 17 Jan 2007 11:44:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701171048.03686.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36993>

Hi,

On Wed, 17 Jan 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > 
> > On Wed, 17 Jan 2007, Jakub Narebski wrote:
> > 
> >> Dnia wtorek 16. stycznia 2007 23:56, Johannes Schindelin napisa?:
> 
> >>> So, how about a "git repo-config --dump" which outputs a stream of NUL 
> >>> separated keys and values? This should be really easy to "parse", and 
> >>> there are no ambiguities: No key or value can contain a NUL.
> >> 
> >> Good idea, although "\n" would work as well as NUL.
> > 
> > No it would not:
> > 
> > 	[someSection]
> > 		thisKey = has\na\nvalue\with\nseveral\nnewlines
> 
> $ fatal: bad config file line <nn> in <config>

Yeah, sorry. But you got the point.

> The same with quoted:
> 
>  	[someSection]
>  		qthisKey = "has\na\nvalue\with\nseveral\nnewlines"
> 
> There is no escaping besides escaping " and escape character
> i.e. escaping \ in git config. Se "\n" would work as well as NUL.
> (It is said explicitely that subsection names cannot contain "\n").

So you want "git-repo-config --dump" to output something which has to be 
scanned for escaping sequences?

If you call

	$ git repo-config -l

you will _no longer_ see "\n"s, but rather newlines.

I don't know why you insist on newlines, when a NUL makes perfect sense: 
Take everything until the next NUL. This is the key. Then take everything 
until the next NUL. This is the value. Repeat until EOF.

> >> The only problem is with "key without value" case, i.e. something like
> >> 
> >>   [section]
> >>   	noval
> >> 
> >> which shows as
> >> 
> >>   section.noval
> > 
> > but is equivalent to
> > 
> > 	[section]
> > 		noval = true
> > 
> > Since it is by definition a boolean value.
> 
> But only for "git repo-config --bool --get section.noval" output.
> Semantically equivalent to "true".
> 
> But without --bool it returns like it was "".

Yes, it returns "", but this is _wrong_. A single "[section] noval" _only_ 
makes sense as a boolean. The information lies in its _presence_, which is 
as good as saying "true".

Ciao,
Dscho
