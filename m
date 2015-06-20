From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of
 pack-objects.c
Date: Sat, 20 Jun 2015 17:51:39 +0100
Message-ID: <20150620165138.GA27488@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434705059-2793-3-git-send-email-charles@hashpling.org>
 <xmqq7fqza8bo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 18:51:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6Lzf-0001b8-Be
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbbFTQvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 12:51:44 -0400
Received: from avasout06.plus.net ([212.159.14.18]:59125 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbbFTQvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 12:51:42 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id igrf1q0022iA9hg01grggV; Sat, 20 Jun 2015 17:51:40 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=foEhHwMf c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=VgUCJR4wDJE6rHXwwUkA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z6LzX-0007dD-1K; Sat, 20 Jun 2015 17:51:39 +0100
Content-Disposition: inline
In-Reply-To: <xmqq7fqza8bo.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272234>

On Fri, Jun 19, 2015 at 10:58:51AM -0700, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> Please place it immediately after INTEGER, as they are conceptually
> siblings---group similar things together.

Sorry, this is a bad habit from working on projects where changing the
value of existing enum identifiers cause bad things.

> This used to be:
> 
> > -		die(_("unable to parse value '%s' for option %s"),
> > -		    arg, opt->long_name);
> 
> but opterror() talks about which option, so there is no information
> loss by losing "for option %s" from here.  That means there is only
> one difference for pack-objects:
> 
>     $ git pack-objects --max-pack-size=1T
>     fatal: unable to parse value '1T' for option max-pack-size
>     $ ./git pack-objects --max-pack-size=1T
>     error: option `max-pack-size' expects a numerical value
>     usage: git pack-objects --stdout [options...
>     ... 30 more lines omitted ...
> 
> Eh, make that two:
> 
>  * We no longer say what value we did not like.  The user presumably
>    knows what he typed, so this is only a minor loss.
> 
>  * We used to stop without giving "usage", as the error message was
>    specific enough.  We now spew descriptions on other options
>    unrelated to the specific error the user may want to concentrate
>    on.  Perhaps this is a minor regression.
> 
> I wonder if "expects a numerical value" is the best way to say this.

I was aware that I was changing the error reporting for max-pack-size
and window-memory but thought that by going with the existing behaviour
of OPT_INTEGER I'd be going with a more established pattern.

These observations also seem to apply to OPT_INTEGER handling. Would
this be something that we'd want to fix too?

Currently git package-objects --depth=5.5 prints:

    error: option `depth' expects a numerical value
    usage: git pack-objects --stdout [options...
    [... many more lines omitted ...]

Obviously, changing this to skip the full usage report would affect many
existing commands.

Also, I preserved the PARSE_OPT_NONEG flag for OPT_ULONG but would this
ever not make sense for an OPT_INTEGER option?
