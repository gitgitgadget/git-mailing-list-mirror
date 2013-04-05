From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Fri, 5 Apr 2013 01:43:28 -0400
Message-ID: <20130405054328.GA12705@sigill.intra.peff.net>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
 <1365091293-23758-1-git-send-email-jkoleszar@google.com>
 <7v6202jjhx.fsf@alter.siamese.dyndns.org>
 <CAAvHm8NyJ3nRZPygy+grMw5BLhLe8eWfEBNfK1tkC8Y34jRynA@mail.gmail.com>
 <20130405023516.GA32290@leaf>
 <20130405025655.GA25970@sigill.intra.peff.net>
 <7vobdtee12.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	John Koleszar <jkoleszar@google.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNzRg-0004du-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338Ab3DEFng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 01:43:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56839 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572Ab3DEFnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 01:43:35 -0400
Received: (qmail 11126 invoked by uid 107); 5 Apr 2013 05:45:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 01:45:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 01:43:28 -0400
Content-Disposition: inline
In-Reply-To: <7vobdtee12.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220147>

On Thu, Apr 04, 2013 at 10:34:49PM -0700, Junio C Hamano wrote:

> > +static void get_head(char *arg)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	head_ref_namespaced(show_text_ref, &buf);
> > +	send_strbuf("text/plain", &buf);
> > +	strbuf_release(&buf);
> > +}
> 
> You identified the right place to patch, but I think we need a bit
> more than this.
> 
> The show_text_ref() function gives "SHA-1 <TAB> refname". It is
> likely that the dumb client will ignore the trailing part of that
> output, but let's avoid a hack that we would not want see other
> implementations imitate.

Oh, right. I was thinking too much about normal clients which see HEAD
in the ref advertisement; of course the dumb client is expecting to see
the actual HEAD file.

> One advantage dumb clients has over smart ones is that they can read
> HEAD that is a textual symref from a dumb server and learn which
> branch is the default one (remote.c::guess_remote_head()) without
> guessing.  I think this function should:
> 
>  - Turn "HEAD" into a namespaced equivalent;
> 
>  - Run resolve_ref() on the result of the above;
> 
>  - Is it a symbolic ref?
> 
>    . If it is, then format "ref: <target>\n" into a strbuf and send
>      it (make sure <target> is without the namespace prefix);
> 
>    . Otherwise, HEAD is detached. Prepare "%s\n" % sha1_to_hex(sha1),
>      and send it.

Yes, that sounds right; it is basically just reconstructing a HEAD
file. What do the HEADs inside namespaces look like? Do they refer to
full global refs, or do they refer to refs within the namespace?

If the latter, we could just send the HEAD file directly. But I suspect
it is the former, so that they can function when non-namespaced commands
are used.

-Peff
