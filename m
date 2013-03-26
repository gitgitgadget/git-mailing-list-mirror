From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Tue, 26 Mar 2013 14:55:59 -0400
Message-ID: <20130326185559.GB26462@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 19:56:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZ2v-0002ek-U2
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab3CZS4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:56:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40529 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab3CZS4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:56:04 -0400
Received: (qmail 6298 invoked by uid 107); 26 Mar 2013 18:57:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 14:57:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 14:55:59 -0400
Content-Disposition: inline
In-Reply-To: <1364323171-20299-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219183>

On Tue, Mar 26, 2013 at 11:39:29AM -0700, Junio C Hamano wrote:

> The function takes two counted strings (<basename, basenamelen> and
> <pattern, patternlen>) as parameters, together with prefix (the
> length of the prefix in pattern that is to be matched literally
> without globbing against the basename) and EXC_* flags that tells it
> how to match the pattern against the basename.
> 
> However, it did not pay attention to the length of these counted
> strings.  Update them to do the following:
> 
>  * When the entire pattern is to be matched literally, the pattern
>    matches the basename only when the lengths of them are the same,
>    and they match up to that length.
> 
>  * When the pattern is "*" followed by a string to be matched
>    literally, make sure that the basenamelen is equal or longer than
>    the "literal" part of the pattern, and the tail of the basename
>    string matches that literal part.
> 
>  * Otherwise, make sure we use only the counted part of the strings
>    when calling fnmatch_icase().  Because these counted strings are
>    full strings most of the time, avoid unnecessary allocation.

I think this is OK, with the intention that we would eventually drop the
allocations from your third bullet point in favor of using a
byte-counted version of fnmatch (i.e., nwildmatch). But until then we're
going to see a performance drop.

The pattern is usually going to be NUL-terminated at the length counter,
but every time we feed a directory, it's going to run into this
allocation. And we do it once for _every_ directory against _every_
wildcard gitignore pattern. So I think it is probably going to be
measurable. I guess we can try measuring it on something like WebKit,
which has plenty of both directories and gitattributes.

-Peff
