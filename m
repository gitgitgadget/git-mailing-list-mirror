From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] revision.c: Correctly dereference interesting_cache
Date: Fri, 19 Jun 2015 14:00:24 -0700
Message-ID: <20150619210023.GA4865@google.com>
References: <1434740483-31730-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:00:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63P3-0004m4-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbbFSVAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 17:00:39 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33428 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518AbbFSVAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 17:00:33 -0400
Received: by igbqq3 with SMTP id qq3so25172789igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ixrws/F7Zjkjf1gwPO6kN+g8+uN02qEDPbIrvioHELo=;
        b=nar6mEB1JnVrxlgwC1igs/wf7VhFiA+k2JJG9PKgGBxgHfdV7xrwRGPxWq55LIUUbI
         Ar6FdsCL98vDgBHXbDpyjlw07CQNenO8xup9AByJ1eQ/mzHHXKsRKukcYsn6S+DqpQr7
         lhMJfD6tzA42qQ6/A2IjIP+vXiPWow2SdFfyOOqH/pOxJbUY9mKK1j9brvOmxTdkum/P
         NEMXk58YVS+rS/upSFLUIh5KnTkzpbS91wRUhmDnJBOC0AbWhjEXKOi0QtWMd/s6c5jw
         jX3TErZKj9zD9v+vxiXKt7RA5c6Po/XRVZlYEQk0hbxOlR/9epgiJjPC1I1lxBkzBnDI
         MaAQ==
X-Received: by 10.43.10.194 with SMTP id pb2mr14356769icb.31.1434747632271;
        Fri, 19 Jun 2015 14:00:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:7111:f201:e4f4:2844])
        by mx.google.com with ESMTPSA id pg7sm2437612igb.6.2015.06.19.14.00.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 14:00:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434740483-31730-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272206>

Hi,

Stefan Beller wrote:

> This was introduced at b6e8a3b5 (2015-04-17, limit_list: avoid
> quadratic behavior from still_interesting), which
> also introduced the check a few lines before, which already dereferences
> `interesting_cache`. So at this point `interesting_cache` is guaranteed to
> be not NULL.

The above is the rationale for the coverity warning, but it does not
explain why this change is safe.

>                The code is called referencing the address of a local
> variable, so `interesting_cache` can actually never be NULL and trigger a
> segmentation fault by dereferencing it a few lines before this.

I'm having trouble parsing this sentence.  Do you mean that limit_list()
only calls still_interesting() (and thus, indirectly,
everybody_uninteresting()), with the second parameter equal to the
address of the local interesting_cache variable, so it can never be
NULL?

That makes sense, but I had to look at the code and reread the above
sentence a few times before I understood.

Do you know what this code is trying to check for?  What does it mean
for *interesting_cache to be NULL?

Should there be

	if (!interesting_cache)
		die("BUG: &interesting_cache == NULL");

checks at the top of still_interesting and everybody_uninteresting to
futureproof this?

What does the *interesting_cache variable represent, anyway?

This code seems to be underdocumented.

Thanks and hope that helps,
Jonathan
