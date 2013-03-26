From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cat-file: Fix an gcc -Wuninitialized warning
Date: Tue, 26 Mar 2013 15:35:39 -0400
Message-ID: <20130326193539.GB28244@sigill.intra.peff.net>
References: <5151F4EB.80909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:36:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZfI-00061R-19
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab3CZTfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:35:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40586 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023Ab3CZTfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:35:43 -0400
Received: (qmail 6815 invoked by uid 107); 26 Mar 2013 19:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 15:37:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 15:35:39 -0400
Content-Disposition: inline
In-Reply-To: <5151F4EB.80909@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219193>

On Tue, Mar 26, 2013 at 07:20:11PM +0000, Ramsay Jones wrote:

> After commit cbfd5e1c ("drop some obsolete "x = x" compiler warning
> hacks", 21-03-2013) removed a gcc specific hack, older versions of
> gcc now issue an "'contents' might be used uninitialized" warning.
> In order to suppress the warning, we simply initialize the variable
> to NULL in it's declaration.

I'm OK with this, if it's the direction we want to go. But I thought the
discussion kind of ended as "we do not care about these warnings on
ancient versions of gcc; those people should use -Wno-error=uninitialized".

What version of gcc are you using? If it is the most recent thing
reasonably available on msysgit, then I am more sympathetic. But if it's
just an antique version of gcc, I am less so.

> An alternative solution may look like this (note: *untested*):
> [...]
> However, this would add an additional call to sha1_object_info()

Yeah, I don't think that is worth it.

> the "--batch" code path, with potential performance consequences
> (again untested). Also, if you are paranoid, I guess you should
> check that the (type,size) returned by sha1_object_info() was the
> same as that returned by read_sha1_file(). ;-)

I note that we do not actually check that contents != NULL after calling
read_sha1_file, either (nor that sha1_object_info does not return an
error). I suspect cat-file could segfault under the right conditions.

-Peff
