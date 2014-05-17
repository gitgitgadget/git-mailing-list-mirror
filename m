From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Sat, 17 May 2014 03:42:24 -0400
Message-ID: <20140517074224.GA16697@sigill.intra.peff.net>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
 <20140516081445.GA21468@sigill.intra.peff.net>
 <20140517072548.GA18239@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 09:45:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlZIj-0001Sg-Hm
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 09:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111AbaEQHm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 03:42:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:53705 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756985AbaEQHm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 03:42:26 -0400
Received: (qmail 12797 invoked by uid 102); 17 May 2014 07:42:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 02:42:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 03:42:24 -0400
Content-Disposition: inline
In-Reply-To: <20140517072548.GA18239@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249459>

On Sat, May 17, 2014 at 12:25:48AM -0700, Jeremiah Mahler wrote:

> > We have routines for reading directly into a strbuf, which eliminates
> > the need for this 1024-byte limit. We even have a wrapper that can make
> > this much shorter:
> > 
> >   struct strbuf buf = STRBUF_INIT;
> > 
> >   strbuf_read_file(&buf, arg, 128);
> >   *signature = strbuf_detach(&buf, NULL);
> > 
> 
> Yes, that is much cleaner.
> The memory returned by strbuf_detach() will have to be freed as well.

In cases like this, we often let the memory leak. It's in a global that
stays valid through the whole program, so we just let the program's exit
clean it up.

> Having --signature-file override --signature seems simpler to implement.
> The signature variable has a default value which complicates
> determining whether it was set or not.

Yeah, the default value complicates it. I think you can handle that just
by moving the default to the main logic, like:

  static const char *signature;
  static const char *signature_file;

  ...

  if (signature) {
	if (signature_file)
		die("you cannot specify both a signature and a signature-file");
	/* otherwise, we already have the value */
  } else if (signature_file) {
	struct strbuf buf = STRBUF_INIT;
	strbuf_read(&buf, signature_file, 128);
	signature = strbuf_detach(&buf);
  } else
	signature = git_version_string;

and as a bonus, that keeps all of the logic together in one (fairly
readable) chain.

-Peff
