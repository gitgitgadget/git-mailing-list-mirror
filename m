From: josh@joshtriplett.org
Subject: Re: [PATCHv4 3/4] Support ref namespaces for remote repositories
 via upload-pack and receive-pack
Date: Thu, 2 Jun 2011 17:06:12 -0700
Message-ID: <20110603000612.GB30975@cloud>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-3-git-send-email-jamey@minilop.net>
 <7v8vtjdebw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 02:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSI7d-0002V3-Mh
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 02:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab1FCAUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 20:20:10 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58641 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab1FCAUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 20:20:09 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8CF6EA8072;
	Fri,  3 Jun 2011 02:20:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8vtjdebw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174990>

On Thu, Jun 02, 2011 at 04:05:23PM -0700, Junio C Hamano wrote:
> Jamey Sharp <jamey@minilop.net> writes:
> 
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index e1a687a..9bb268a 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -109,6 +109,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
> >  
> >  static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
> >  {
> > +	path = path ? strip_namespace(path) : "capabilities^{}";
> >  	if (sent_capabilities)
> >  		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
> >  	else
> 
> This feels really ugly.
> 
> Logically the stripping of "path" should happen before the caller calls
> this function, as the purpose of this function is "given a token and
> object name, produce one line of 'I have this at here' protocol message,
> which is defined to have the capability list tucked after the first of
> such messages in an exchange". It now is "the token has to be a path in a
> namespace; the only exception is when the token is NULL, in which case we
> always send 'capabilities^{}'".
> 
> It also is a very selfish solution for an immediate issue(*) that does not
> give much considertation for people who may want to add new things in the
> future, as the _only_ possible special case is to send in NULL.
> 
> The immediate issue you wanted to solve, I think, is that it is not
> convenient to strip in the caller as this is a callback. Still, I think it
> should be easy to do something like...
> 
> 	static int show_ref_message(const char *path,
>         				 const unsigned char *sha1)
> 	{
> 		... original show_ref() implementation comes here ...
> 	}
> 
>         static int show_ref_cb(const char *path,
> 			        const unsigned char *sha1,
>                                 int flag, void *cb_data)
> 	{
> 		return show_ref_message(strip_namespace(path), sha1);
>         }
>         
> and give the latter as the callback to for_each_ref_in_namespace().
> 
> And the call to run "capabilities^{}" when there is no ref can call
> show_ref_message() directly.

Fair enough.  We'd thought of NULL as a fairly logical representation
for a null ref sent as a dummy ref just to send capabilities, but we can
easily rework the functions so that show_ref has the semantic you
suggest and expects an un-namespaced ref, since show_ref doesn't need
the original namespaced ref.  We'll do this in the next version of the
patch series.

- Josh Triplett
