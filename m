From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix signal handler
Date: Wed, 10 Feb 2010 09:14:06 -0800
Message-ID: <20100210171406.GE2747@spearce.org>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfGGR-0006ji-LP
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab0BJRWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 12:22:01 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:34152 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0BJRWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:22:00 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2010 12:22:00 EST
Received: by yxe38 with SMTP id 38so225950yxe.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 09:22:00 -0800 (PST)
Received: by 10.101.139.34 with SMTP id r34mr673389ann.29.1265822049164;
        Wed, 10 Feb 2010 09:14:09 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm517583yxe.54.2010.02.10.09.14.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 09:14:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B72E81B.3020900@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139522>

Markus Elfring <Markus.Elfring@web.de> wrote:
> How do Git software developers think about the appended update suggestion?
> Would you like to integrate such adjustments into your source code
> repository?

Finally, a concrete patch we can comment on!
 
> Subject: [PATCH] Fix a signal handler
> 
> A global flag can only be set by a signal handler in a portable way if it has got the data type "sig_atomic_t". The previously used assignment of a function pointer in the function "early_output" was moved to another variable in the function "setup_early_output".
> The involved software design details were also mentioned on the mailing list.

Please line wrap your commit messages at ~70 characters per line.
This improves readability when reading the messages with tools like
`git log` and `gitk` where the lines aren't reflowed.

Please read Documentation/SubmittingPatches and add a Signed-off-by
line if you agree to the Developer's Certificate of Origin.


> +	early_output_function = &log_show_early;
...
> -volatile show_early_output_fn_t show_early_output;
> +sig_atomic_t show_early_output = 0;
> +show_early_output_fn_t early_output_function = NULL;
...
> +		if (show_early_output) {
> +			(*early_output_function)(revs, newlist);
> +			show_early_output = 0;
> +		}

The function pointer isn't necessary.  AFAIK its only called in
this one call site.  So you can make a direct reference to the
log_show_early function.

-- 
Shawn.
