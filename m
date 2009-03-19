From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for
 doing  custom path transformations
Date: Thu, 19 Mar 2009 01:15:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903190107001.10279@pacific.mpi-cbg.de>
References: <49B7DFA1.4030409@viscovery.net> <1236852820-12980-1-git-send-email-johan@johansorensen.com> <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de> <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com> <7vvdqcd1zh.fsf@gitster.siamese.dyndns.org>
 <9e0f31700903140739g26be7981lb0fa411cdd8029e6@mail.gmail.com> <7vprgkarq5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1179107049-1237421728=:10279"
Cc: =?ISO-8859-15?Q?Johan_S=F8rensen?= <johan@johansorensen.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 01:15:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk5ug-0006MW-4i
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 01:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbZCSANg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 20:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZCSANg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 20:13:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:52586 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752272AbZCSANf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 20:13:35 -0400
Received: (qmail invoked by alias); 19 Mar 2009 00:13:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 19 Mar 2009 01:13:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BdD4s+/zBXJJinAs++1I7vhLSWKrwmSeQ1E7YJa
	vFgDvpiluBrLG4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vprgkarq5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113708>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1179107049-1237421728=:10279
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Mar 2009, Junio C Hamano wrote:

> Johan Sørensen <johan@johansorensen.com> writes:
> 
> >> Do you run git-daemon from inetd, or standalone, by the way?
> >
> > Standalone.
> >
> >> I am wondering how well it would scale if you spawn an external 
> >>"filter path" script every time you get a request.
> >
> > A quick test of 250 consecutive requests with ls-remote to localhost
> > (all without the --verbose flag), slowest run:
> > - Baseline (no --filter-path agument): 3.39s
> >
> > $ cat filter.c
> > #import "stdio.h"
> > int main (int argc, char const *argv[]) {
> > 	printf("%s", "/existing.git\0");
> > 	return 0;
> > }
> > - 3.84s
> >
> > $ cat filter.rb
> > #!/usr/bin/ruby
> > print "/existing.git\0"
> > - 4.76s
> >
> > So, obviously highly dependent on how long it takes the script to 
> > launch and how much work it does. And yes, neither of the above really 
> > does anything :) nor takes any increased cpu load into account
> >
> > Another approach is to keep the external script running and feed it on 
> > stdin, but that would involve a bit more micro-management of the 
> > external process. I will revisit that idea if I find out that's 
> > needed.
> 
> I actually was hoping (especially we have Dscho on Cc: list) that somebody
> like you would start suggesting a "plug in" approach to load .so files,
> which would lead to a easy-to-port dso support with the help from msysgit
> folks we can use later in other parts of the system (e.g. customizable
> filters used for diff textconv, clean/smudge, etc.)

I do not like that at all.  Dynamic libraries -- especially on Windows -- 
are a major hassle.

However, I cannot think of anything Johan might want to do that would not 
be possible using a bunch of regular expressions together with 
substitions.

FWIW I have experimental code in my personal tree that sports 
strbuf_regsub(), a function to replace matches of a regular expression 
(possibly with groups) by a given string (which may contain \0 .. \9, 
being replaced with the respective group's contents).

Ciao,
Dscho

--8323328-1179107049-1237421728=:10279--
