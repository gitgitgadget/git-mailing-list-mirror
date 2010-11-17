From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] log.decorate: accept 0/1 bool values
Date: Wed, 17 Nov 2010 14:52:59 -0500
Message-ID: <20101117195259.GA13008@sigill.intra.peff.net>
References: <20101117170045.GA4108@sigill.intra.peff.net>
 <7v4obfg2td.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 20:53:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIo45-0003Ew-G4
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 20:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935385Ab0KQTxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 14:53:04 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935247Ab0KQTxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 14:53:03 -0500
Received: (qmail 8132 invoked by uid 111); 17 Nov 2010 19:53:01 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 17 Nov 2010 19:53:01 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Nov 2010 14:52:59 -0500
Content-Disposition: inline
In-Reply-To: <7v4obfg2td.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161631>

On Wed, Nov 17, 2010 at 11:36:30AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We cannot simply add 0/1 support to git_config_maybe_bool.
> > That would confuse git_config_bool_or_int, which may want to
> > distinguish the integer values "0" and "1" from bools.
> 
> ... e.g. number one spelled as "1" do mean one not true in contexts like
> status.submodulesummary, where "true" means "unlimited" and "1" means
> "limit to one".  It surely is necessary to avoid breakage there.

Makes sense. I didn't even bother checking, as the fact that we export
it as "git config --bool-or-int" was enough for me that we need to keep
the behavior the same.

> A caller that uses git_config_maybe_bool() expects to see 0/1 when the
> input looks like a boolean, and your patch looks like the right thing to
> do.

It's possible we could have another type of caller, but I suspect they
would want git_config_bool_or_int instead. The exception would be one who
wants a bool, an int, _or_ an arbitrary string. If somebody writes such
a thing, they are free to expose the new git_config_maybe_bool_text.

> The repertoire of parsers that involve elements that are possibly boolean
> are now:
> 
>  - git_config_bool(): takes "0/false/no/..." or "$n/true/yes/..." (where
>    any non-zero number $n is taken as true [*1*]), or more traditional
> 
>    [section]
>        var
> 
>    without any equal sign, which means true.  Errors out if the input is
>    not a boolean.
> 
>  - git_config_maybe_bool(): similar, and returns -1 (not a bool), 0
>    (false) and 1 (true).  "0" is false, "1" is true.  But all other
>    numbers are not boolean;

Yeah, I did notice that. Technically it is a regression in my 2/2, in
that "pager.foo = 2" used to mean "use the pager for foo" and now means
"use a pager called 2". But I am willing to write that off as insanity,
especially since we never documented that behavior (and in fact we
explicitly document the allowable values as yes/no, 0/1, true/false, and
on/off).

I don't think it is worth closing the hole for no reason on other config
options, but I am certainly fine with breaking it in the case of
pager.*.

> Perhaps we would want to add Documentation/technical/api-config.txt
> someday?   Hint, hint....

I'll put it on my todo, right after refactoring the awful mess of the
config code itself. :)

-Peff
