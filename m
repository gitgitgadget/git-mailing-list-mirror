From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Tue, 12 Mar 2013 17:00:56 +0100
Message-ID: <20130312160056.GB4472@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165857.GC1136@sandbox-ub.fritz.box>
 <20130312110003.GD11340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 17:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFRdn-00038m-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 17:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab3CLQBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 12:01:00 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:52560 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702Ab3CLQA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 12:00:59 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UFRdJ-0001tV-DM; Tue, 12 Mar 2013 17:00:57 +0100
Content-Disposition: inline
In-Reply-To: <20130312110003.GD11340@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217969>

On Tue, Mar 12, 2013 at 07:00:03AM -0400, Jeff King wrote:
> On Sun, Mar 10, 2013 at 05:58:57PM +0100, Heiko Voigt wrote:
> 
> > The only location where cf is set in this file is in do_config_from().
> > This function has only one callsite which is config_from_file(). In
> > config_from_file() its ensured that the f member is set to non-zero.
> > [...]
> > -	if (cf && ((f = cf->f) != NULL)) {
> > +	if (cf) {
> 
> I still think we can drop this conditional entirely. The complete call
> graph looks like:
> 
>   git_config_from_file
>     -> git_parse_file
>       -> get_next_char
>       -> get_value
>           -> get_next_char
>           -> parse_value
>               -> get_next_char
>       -> get_base_var
>           -> get_next_char
>           -> get_extended_base_var
>               -> get_next_char
> 
> That is, every path to get_next_char happens while we are in
> git_config_from_file, and that function guarantees that cf = &top, and
> that top.f != NULL.  We do not have to even do any analysis of the
> conditions for each call, because we never change "cf" nor "top.f"
> except when we set them in git_config_from_file.

Ok if you say so I will do that :-). I was thinking about adding a patch
that would remove cf as a global variable and explicitely pass it down
to get_next_char. That makes it more obvious that it actually is != NULL.
Looking at your callgraph I do not think its that much work. What do you
think?

BTW, how did you generate this callgraph? Do you have a nice tool for that?

Cheers Heiko
