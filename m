From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 12:00:34 +0000
Message-ID: <200703021200.35069.andyparkins@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <CF579EA9-04AB-4B39-809F-650E611A8D6B@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN6S7-0007wl-GO
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423050AbXCBMBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423054AbXCBMBW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:01:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:53007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423048AbXCBMBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:01:21 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1257595nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 04:01:20 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:x-uid:x-length:message-id:content-type:content-transfer-encoding;
        b=UU1SyPUAkA6V2dlhDKz1P+ysWlPxK1FYu24vi7tOyA+psmY4oIqq3PYdxd6WID7fgY4veIctNsZIl5A67zTRncB0tZCkm0x0tdFWJXt2i5ypqFihUcnG4ZeJa1C/2QBFoIXabYSwyVU6pLL3SWMEXxfF+ExqPSUUP2IN8Nv5Oe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:x-uid:x-length:message-id:content-type:content-transfer-encoding;
        b=KxIhjucRaUEOBEWjZOPHRcx3nH2ekIcG9qeRFBjrfVnuzEUq/YP8uH55ZJroR022bANjzJp428O+u5jEcTVPwx/sdLwNBHrARiBbZdthdSOAScogwytoqjSywxvMzWHeY1Py6ODEUHKQlJWY0CrEQvQfS48Zy66yaDdlvErlfiI=
Received: by 10.48.202.11 with SMTP id z11mr7618812nff.1172836880463;
        Fri, 02 Mar 2007 04:01:20 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm6230723iky.2007.03.02.04.01.17;
        Fri, 02 Mar 2007 04:01:18 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <CF579EA9-04AB-4B39-809F-650E611A8D6B@silverinsanity.com>
Content-Disposition: inline
X-UID: 278
X-Length: 4541
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41199>

On Thursday 2007, March 01, Brian Gernhardt wrote:

> [attribute "image/png"]
>     path = *.png
>     show = "open %path%"
> [attribute "text/plain"]
>     path = *.c
>     checkout = eol_to_local

The problem is that this flips the relationship.  What you want to do is 
assign attributes to paths.  This is assigning paths to attributes.  
What about this:

  doc/*.txt = text/plain AND documentation

In your system that would make

[attribute text/plain]
  path = doc/*.txt
  show = "open %path%"
[attribute documentation]
  path = doc/*.txt
  show = "open %path"

i.e. you've got two sections to maintain instead of one.  That's why I 
suggested:

[attributes "doc/*.txt"]
  attributes = text/plain
  attributes = documentation

I'm not really advocating that exact syntax, but I do think it's got to 
be like having a database like this:

  paths -> path-attribute-join <- attributes
  attributes -> handlers

Your method does
  path -> attribute
  attribute -> handlers

There would therefore be excessive repetition or impossible-to-specify 
connections.


> Both of these lists look right at first glance, although I think I
> prefer something simple like "show" to "prettyfilter".  And we might
> want a "reject" or "none" for merges...  Attempting to merge a bitmap
> is madness, so the system should just output a <file>-
> <head>.<extension> or similar.

I have no major concerns about any of the syntax really.  The important thing 
is that we are clear and consistent (as always).


> > + - Change of .gitattributes without change of files.
> > +   What happens when .gitattributes changes, but the files that
> > would be
> > +   affected by that change do not?  Those files really should be
> > checked
> > +   out again, to apply any new outfilter settings.
>
> Actually, shouldn't the files also be run through the infilter to
> check for changes caused by that, too?

I don't think so.  The effect of the infilter will never be seen in the 
working tree, because it's applied on git-add.  The previous content with the 
old attributes are already in the repository.  However, it could be that we 
would have to force those files to be marked dirty in the index (this is 
already sounding bad), to force the application of the infilter on next 
checkin.  Perhaps that's what you meant, and I'm being slow.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
