From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 02/18] revert: change many die() calls into "return
 error()" calls
Date: Fri, 26 Nov 2010 00:05:43 -0600
Message-ID: <20101126060543.GC18751@burratino>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
 <20101125212050.5188.21758.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 26 07:06:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrRq-0001mk-NJ
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 07:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab0KZGFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 01:05:50 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61693 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZGFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 01:05:50 -0500
Received: by yxt3 with SMTP id 3so280868yxt.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 22:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BlcOQwnKcfwMQ5j+HDnlWS9O1OTdY26AfeF3FcMI13s=;
        b=wI+hQsonINur/8Q0TbvzCFrBbqaRGsx686yfytYfybP9mkWXkZDCrndv4CPLHyIoS1
         ELrfIlvv/68/BWlPXv8WEoi9AJaf1xg2Hxjr4yI/NjIl/v599z9eqBv7qvb9Nr35pwj7
         AqNkssU9jISfGZmO8HTypNucM9CG0TTn+j+tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qgS/HAANX6YMlqrxQrOTzRGDeDp/cXIoxHDOkLIh2YYY/AU9qbWZai7WHdzNbXsgyX
         /hFHWYpRYuS8j818zDWf6FsCidF8sYaxNVqX+01+X1n0PTVyf9cPEx8AjQOHkH2Ar73O
         rUPOTVNVAGwmDA7vENfEVCUBxqx4EhhT+lQfI=
Received: by 10.150.230.7 with SMTP id c7mr4349421ybh.446.1290751549010;
        Thu, 25 Nov 2010 22:05:49 -0800 (PST)
Received: from burratino ([68.255.101.216])
        by mx.google.com with ESMTPS id x53sm1029415yhc.31.2010.11.25.22.05.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 22:05:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101125212050.5188.21758.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162203>

Christian Couder wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -280,16 +280,18 @@ static struct tree *empty_tree(void)
>  	return tree;
>  }
>  
> -static NORETURN void die_dirty_index(const char *me)
> +static int error_dirty_index(const char *me)

In general sounds to me like a good thing to do.  But for your use
case (writing out TODO and DONE files when cherry-pick fails),
wouldn't a set_die_routine() also work?

I am tempted to suggest a series in the following order:

 1. set die routine with the desired behavior
 2. change die() calls to return error() so the nice stack unwinding
    takes place automatically (this should help with other libification
    work, anyway)

then maybe:

 3. add an assert(0) to die routine (perhaps protected by a compile-time
    option) so missing die() calls can be noticed
 4. remove the die routine once it is clear all problematic die calls
    have been eliminated.

... but wait: would all such die calls ever be eliminated?  xmalloc,
xmkstemp, and similar functions are perhaps too convenient to avoid.
So it might be simpler to stick to (1) and treat (2) as a separate
topic.
