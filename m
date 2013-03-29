From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 13:44:55 -0400
Message-ID: <20130329174455.GA13268@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
 <20130329120539.GA20711@sigill.intra.peff.net>
 <20130329130230.GA25861@lanh>
 <7vli96p34f.fsf@alter.siamese.dyndns.org>
 <20130329170459.GB3552@sigill.intra.peff.net>
 <7vzjxmnm7e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULdMk-0007Hv-HA
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab3C2Ro6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:44:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48468 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755476Ab3C2Ro5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:44:57 -0400
Received: (qmail 7614 invoked by uid 107); 29 Mar 2013 17:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 13:46:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 13:44:55 -0400
Content-Disposition: inline
In-Reply-To: <7vzjxmnm7e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219516>

On Fri, Mar 29, 2013 at 10:35:17AM -0700, Junio C Hamano wrote:

> This may be just the matter of naming.
> 
> It smelled wrong to me only because the "fnmatch" in the helper
> fnmatch_icase_mem() told me that it should forever use fnmatch
> semantics.  After reading its (only) two callsites, they are both
> "the caller has transformed the inputs to this lowest level pathname
> vs pattern matching function in order to reduce the cost of
> matching, and now it is time to exercise the matcher".  The only
> thing they care about is that they are calling "the lowest level
> pathname vs pattern matching function."
> 
> If we pronounce "fnmatch_icase_mem()" as "match_path_with_pattern()"
> or something in the original series, the problem may go away ;-)

Yes, since there are only the two new added callers, if they both want
to switch to wildmatch, then it is fine for the helper function to
switch. The danger is if some other caller wants to start using it; I
added it with the name I did figuring that other spots might want to use
it eventually. But if all of fnmatch is going to go away in favor of
wildmatch eventually, then that helper is not all that useful (or it
would be even more useful as "wildmatch_mem" or similar).

> Does any caller pass FNM_* bits to a callchain that reach the new *_mem()
> function?

The series only adds two callers, and they provide constant flags;
match_basename passes no flags, and should be OK. match_pathname uses
FNM_PATHNAME, and would need to be converted to use WM_PATHNAME as part
of the conflict resolution.

-Peff
