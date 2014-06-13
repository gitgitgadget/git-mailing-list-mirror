From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] gpg-interface: provide access to the payload
Date: Fri, 13 Jun 2014 06:34:19 -0400
Message-ID: <20140613103419.GA14066@sigill.intra.peff.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
 <558044a975c940d19370394900bb44bf4fb2387d.1402063796.git.git@drmicha.warpmail.net>
 <20140613075550.GI7908@sigill.intra.peff.net>
 <539AC7FC.8040707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 12:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOoW-0007XD-4H
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbaFMKeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:34:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:43344 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752082AbaFMKeX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 06:34:23 -0400
Received: (qmail 19000 invoked by uid 102); 13 Jun 2014 10:34:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 05:34:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 06:34:19 -0400
Content-Disposition: inline
In-Reply-To: <539AC7FC.8040707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251538>

On Fri, Jun 13, 2014 at 11:44:28AM +0200, Michael J Gruber wrote:

> > Perhaps this is a sign that we need a "signature_check_clear()" helper?
> 
> ... or simply switch to language which has (or can overload) free for an
> object :)

I hear somebody has reimplemented git in pure javascript. ;P

> Do we have prior art for such helpers so that the new one would be
> analogous?

I was thinking of credential_clear, string_list_clear, etc. Literally
just:

  void signature_check_clear(struct signature_check *s)
  {
	free(s->gpg_output);
	free(s->gpg_status);
	free(s->signer);
	free(s->key);
  }

Your first commit fixed a leak on gpg_status.  Did it also need to handle
the "key" field there?

For some structs, we'd also do:

	memset(s, 0, sizeof(*s));

to get us back to a usable, initialized state so the struct can be
reused. However, check_commit_signature doesn't care if the struct is
initialized or not (i.e., there is no initialized state). Doing so does
help detect use-after-free conditions, though.

-Peff
