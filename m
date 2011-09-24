From: Jeff King <peff@peff.net>
Subject: Re: Fwd: permission to re-license strbuf subsystem as LGPL
Date: Sat, 24 Sep 2011 02:05:40 -0400
Message-ID: <20110924060540.GA13974@sigill.intra.peff.net>
References: <CA+sFfMeRDQiqGhO9Y=k3tEnzdXjMx59huFE_fx6Y14cJxj1J=Q@mail.gmail.com>
 <CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
 <m3mxdvqj31.fsf@localhost.localdomain>
 <CA+sFfMdt-95rfaZmiYAHx02Ukjt_WN-kLJr410AzZfGHYkSv5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 08:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7LN1-00069c-D4
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 08:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab1IXGFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 02:05:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42126
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab1IXGFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 02:05:44 -0400
Received: (qmail 25403 invoked by uid 107); 24 Sep 2011 06:10:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Sep 2011 02:10:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Sep 2011 02:05:40 -0400
Content-Disposition: inline
In-Reply-To: <CA+sFfMdt-95rfaZmiYAHx02Ukjt_WN-kLJr410AzZfGHYkSv5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182020>

On Fri, Sep 23, 2011 at 05:50:27PM -0500, Brandon Casey wrote:

> Hmm, I forgot about bstring.  I think strbuf is a little smaller in
> scope than bstring, perhaps less ambitious.  Less abstraction, and
> less protection too.  With strbuf, you never forget that you're
> dealing with C char arrays.  The data structures are pretty similar,
> but I don't think strbuf will ever have a function like
> 
>    bconcat(bstring1, bstring2)
> 
> instead, you'd just do
> 
>    strbuf_add(strbuf1, strbuf2.buf, strbuf2.len)

I think it's spelled:

  strbuf_addbuf(strbuf1, strbuf2);

in the current code.

> The benefit, of course, of a bconcat function is that either bstring1
> or bstring2 can be NULL (like if a previous bstring2 = bfromcstr()
> initialization failed).  This allows you to perform a sequence of
> bstring operations and only check errors at the end.

There is no error checking with strbufs at all. The only thing that can
fail is malloc, and in that case, we always die().

It wouldn't be too hard to make it return errors (or set a global error
flag), and have any failed mallocs just leave the strbuf unchanged.
Because strbufs are always in a consistent state, it would be safe to
do:

  global_strbuf_error_flag = 0;
  strbuf_addbuf(strbuf1, strbuf2);
  strbuf_addbuf(strbuf3, strbuf1);
  strbuf_addbuf(strbuf3, strbuf4);
  if (global_strbuf_error_flag)
    ...

The contents of the strbufs would be indeterminant, but you would never
have violated any memory constraints.

-Peff
