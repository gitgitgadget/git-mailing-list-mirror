From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Wed, 09 Feb 2011 02:24:45 +0100
Message-ID: <201102090224.45397.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102080915.27484.johan@herland.net>
 <7vzkq6p1ap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 02:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmynn-0006KP-1V
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 02:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab1BIBYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 20:24:50 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62423 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755918Ab1BIBYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 20:24:49 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGB00B95T9B9Z80@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Feb 2011 02:24:47 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2EFA51EF03D1_D51ECDFB	for <git@vger.kernel.org>; Wed,
 09 Feb 2011 01:24:47 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id DB3571EF0397_D51ECDDF	for <git@vger.kernel.org>; Wed,
 09 Feb 2011 01:24:45 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGB00ANNT99F000@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Feb 2011 02:24:45 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7vzkq6p1ap.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166384>

On Wednesday 09 February 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Ah, yes, I should have been more specific:
> >     remote.origin.fetch = ~refs/tags/*:refs/tags/*
> 
> Hmmm, I was in the vicinity of builtin/fetch.c:find_non_local_tags()
> today, and I had to wonder what the implementation of this would look
> like....

AFAIK, find_non_local_tags() is called to produce a list of refs to be auto-
followed. Currently it produces this list by traversing the remote refs, and 
selecting refs that follow all of these criteria:

A. Ref name starts with "refs/tags"

B. Ref refers (after peeling) to an object that is either already locally 
available, or is already on the list of objects to be fetched.

C. Ref name does not already exist locally.


Now, here's roughly how I would change it to implement the "~from:to"-style 
refspecs:

0. Change its name from find_non_local_tags() to find_auto_follow_refs().

1. At the top, enumerate the auto-following refspecs 
("~refs/tags/*:refs/tags/*" in this case)

2. When traversing the remote refs, instead of criteria A above, we want to 
check if ref->name matches the remote side of any of the auto-following 
refspecs enumerated in step #1. Skip past all non-matches.

3. Criteria B stays unchanged.

4. When checking criteria C, we want to check against the _local_ side of 
the matched auto-following refspec.


AFAICS, that's pretty much what should be needed. There are some other 
things to consider as well, but IMHO none of those seem like show stoppers:

For example, there may be command-line options for making auto-following 
refspecs explicit (i.e. corresponding to --tags; basically disables the "~" 
in the refspec), or disabling auto-following (i.e. corresponding to --no-
tags; basically disregards refspecs with "~").

Another slight complication is refspecs with _both_ "~" and "+" (i.e. both 
auto-following and --force behavior), which may be resolved by disregarding 
criteria C for those refspecs.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
