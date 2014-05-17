From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Sat, 17 May 2014 01:59:11 -0700
Message-ID: <20140517085911.GA18862@hudson.localdomain>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
 <20140516081445.GA21468@sigill.intra.peff.net>
 <20140517072548.GA18239@hudson.localdomain>
 <20140517074224.GA16697@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 17 10:59:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlaSm-0002b4-LU
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 10:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910AbaEQI7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 04:59:18 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43361 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbaEQI7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 04:59:16 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so3617589pbb.31
        for <git@vger.kernel.org>; Sat, 17 May 2014 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=d4jLRBEmhG+gjTWQm2PZsQoSnEqCREpTj6K0wrCB+EI=;
        b=jILrfnIZdKsb5vCP1/F1jPcZgzk+8nNjhEoke6QGqYOpIdIwI1LW1cpGPAlV7H5kfu
         hBR7yzaS3PjDfZkRgMyaBPwwI5n0rVNTJ372IMOzTIUqauTqePuF8nSS1Lc+4hTCWpFm
         LLchhJLWrhfm3sqvs5ZxhdgFCtLAcWdZgJV2IEpN3/QSPx/YjH4PTHlBWBno8YNDiaFY
         h3qhL3+SWS+oGYsiLLhJbVfEBAt56jEJw0X3tcvOTegdSjV2ni+7gvnmhNh0RdiujfhE
         tSa02fYitlC7BCmTiH/L8tkRnCjDJtOqxUxqb1xvk02VZEIKRaOIWoT8l1dIByt7Kr7n
         ZD7A==
X-Received: by 10.66.157.200 with SMTP id wo8mr27167467pab.92.1400317156251;
        Sat, 17 May 2014 01:59:16 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id vf9sm18735448pbc.94.2014.05.17.01.59.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 May 2014 01:59:14 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 17 May 2014 01:59:11 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140517074224.GA16697@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249461>

On Sat, May 17, 2014 at 03:42:24AM -0400, Jeff King wrote:
> On Sat, May 17, 2014 at 12:25:48AM -0700, Jeremiah Mahler wrote:
> 
> > > We have routines for reading directly into a strbuf, which eliminates
> > > the need for this 1024-byte limit. We even have a wrapper that can make
> > > this much shorter:
> > > 
> > >   struct strbuf buf = STRBUF_INIT;
> > > 
> > >   strbuf_read_file(&buf, arg, 128);
> > >   *signature = strbuf_detach(&buf, NULL);
> > > 
> > 
> > Yes, that is much cleaner.
> > The memory returned by strbuf_detach() will have to be freed as well.
> 
> In cases like this, we often let the memory leak. It's in a global that
> stays valid through the whole program, so we just let the program's exit
> clean it up.
> 

It bugs me but I see your point.
It works just fine in this situation.

> > Having --signature-file override --signature seems simpler to implement.
> > The signature variable has a default value which complicates
> > determining whether it was set or not.
> 
> Yeah, the default value complicates it. I think you can handle that just
> by moving the default to the main logic, like:
> 
>   static const char *signature;
>   static const char *signature_file;
> 
>   ...
> 
>   if (signature) {
> 	if (signature_file)
> 		die("you cannot specify both a signature and a signature-file");
> 	/* otherwise, we already have the value */
>   } else if (signature_file) {
> 	struct strbuf buf = STRBUF_INIT;
> 	strbuf_read(&buf, signature_file, 128);
> 	signature = strbuf_detach(&buf);
>   } else
> 	signature = git_version_string;
> 

Before, --no-signature would clear the &signature.
With this code it sees it as not being set and assigns
the default version string.

> and as a bonus, that keeps all of the logic together in one (fairly
> readable) chain.
> 
> -Peff

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
