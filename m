From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] make config --add behave correctly for empty and NULL
 values
Date: Tue, 19 Aug 2014 01:17:32 -0400
Message-ID: <20140819051732.GA13765@peff.net>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
 <xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 07:17:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJbnf-00071q-T2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 07:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbaHSFRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 01:17:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:54662 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751624AbaHSFRf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 01:17:35 -0400
Received: (qmail 12571 invoked by uid 102); 19 Aug 2014 05:17:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 00:17:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 01:17:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255441>

On Mon, Aug 18, 2014 at 11:18:52AM -0700, Junio C Hamano wrote:

> Are we sure that "a^", which cannot be true for any string, will not
> be caught by anybody's regcomp() as an error?  I know regcomp()
> accepts the expression and regexec() fails to match with GNU libc,
> but that is not the whole of the world.

We do support negation (ourselves) in the regexp, so "!$foo" would work,
where "$foo" is some regexp that always matches. But that may be digging
ourselves the opposite hole, trying to find a pattern that reliably
matches everything.

> To be honest, I'd rather see this done "right", by giving an option
> to the caller to tell the function not to call regcomp/regexec in
> matches().

Yeah, that was my first thought, too on seeing the patch. I even worked
up an example before reading your message, but:

>  * Define a global exported via cache.h and defined in config.c
> 
> 	extern const char CONFIG_SET_MULTIVAR_NO_REPLACE[];
> 
>    and pass it from this calling site, instead of an arbitrary
>    literal string e.g. "a^"
> 
>  * Add a bit to the "store" struct, e.g. "unsigned value_never_matches:1";
> 
>  * In git_config_set_multivar_in_file() implementation, check for
>    this constant address and set store.value_never_matches to true;
> 
>  * in matches(), check this bit and always return "No, this existing
>    value do not match" when it is set.

I just used

  #define CONFIG_REGEX_NONE ((void *)1)

as my magic sentinel value, both for the string and compiled regex
versions. Adding a bit to the store struct is a lot less disgusting and
error-prone. So I won't share mine here. :)

-Peff
