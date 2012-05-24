From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] vcs-svn: fix cppcheck warning
Date: Thu, 24 May 2012 09:20:58 -0500
Message-ID: <20120524142058.GA3732@burratino>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
 <1337868259-45626-6-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu May 24 16:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYuy-0005Ms-PF
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab2EXOV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:21:28 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61148 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab2EXOV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:21:27 -0400
Received: by weyu7 with SMTP id u7so5400526wey.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AWPU0asINnKXovF6gKnOvelyNY+bcgKYokXUUgD4N4M=;
        b=Jps8frrFjVonQ+iqRE2TqkZYjddbutAejIVYrWMLeQ30vBy4e7l+QWlln7ltac29M7
         k/923zlWinafsojZpYA7aH/6Tvl2sQu86FzbOb1NnC0xTslFt6jfWf0voFPRfemS7yn9
         i0pSkRIRKRPAi+CNnvlk0EBoOILrEoTS9ast42/CUiigYw+AMPTGz3Y+TGceVO11hABd
         FwAkQqeOID6BS8L7lruz44RPWQOerFAMesHeByYg3I4NgGu7CRIWNb2xMStaajiIfxrI
         K76gJnPVLiLmd19udWnlvjQYjXdcs1hhVf0Nm/sNy4CfgXac1oAvp0eF1Vod4XUuO+gN
         otTA==
Received: by 10.50.219.162 with SMTP id pp2mr16898963igc.40.1337869266933;
        Thu, 24 May 2012 07:21:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k4sm3125922igq.16.2012.05.24.07.21.04
        (version=SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:21:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337868259-45626-6-git-send-email-davidbarr@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198384>

Hi,

First, thanks much for this series!  I especially like patch #4.

David Barr wrote:

> [vcs-svn/fast_export.c:211]: (warning) Using sizeof with a numeric constant
> as function argument might not be what you intended.
[...]
> -		assert(!signed_add_overflows(preimage.max_off, 1));
> +		assert(!signed_add_overflows(preimage.max_off, (off_t) 1));

I think this is due to a typo in the compat-util.h compatibility layer
you are using.  In git.git there is

	#define signed_add_overflows(a, b) \
	    ((b) > maximum_signed_value_of_type(a) - (a))

so the sizeof() operator is applied to preimage.max_off and all is well.
By contrast, in svn-dump-fast-export.git it says

	#define signed_add_overflows(a, b) \
		((a) > maximum_signed_value_of_type(b) - (b))

Though the comment describing signed_add_overflows() does say that "a"
and "b" should have the same type, I like being able to ask if
signed_add_overflows(n, 1) in a non-fussy way that does not introduce
subtle bugs when the type of "n" changes, so I'd prefer not to take
this patch.

Hope that helps,
Jonathan
