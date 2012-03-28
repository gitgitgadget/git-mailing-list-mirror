From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 13:04:04 -0500
Message-ID: <20120328180404.GA9052@burratino>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:04:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxEj-0005bE-5X
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758425Ab2C1SEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:04:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39495 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758389Ab2C1SEN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:04:13 -0400
Received: by iagz16 with SMTP id z16so1785967iag.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+MvFLNSQjU6P/iZE0Sl0yEMreBxp1xR864zrNzhaXhE=;
        b=FbaBJUeYaU8nmjVPtQMaagQaVhFFjeaxq0VpQ2q6y2tups/Pt5OacQDJUw73iNayu1
         Zibd+7TLV39HJONKwy7dI75Qfz5ZQCVDPp+X8KILoXsdPTisG/JjhanHFg4HEdzz5pM9
         IO0RPrB6VDh1tkcBiID7CB5o/6CE+Bwy90fiPUo3vaPOTx7L+RMABrxYpqKvCNAGY7ef
         vz+OHxDsAD11OMaTyZD+dZjAwaKxdJMX6ZRDGiAS2b5m4f19lHYXLhE5XsTxMR+vvZ8F
         3FY5dPCd3Z7ZL6j5OSwLNhh7Io9o0eZUJPbItf4zth7mx2PH0bZrihbzwuP9DXPlhoSw
         ecSw==
Received: by 10.50.36.193 with SMTP id s1mr53576igj.45.1332957852919;
        Wed, 28 Mar 2012 11:04:12 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id md6sm3665294igc.0.2012.03.28.11.04.10
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 11:04:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120328174841.GA27876@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194153>

Jeff King wrote:
> On Wed, Mar 28, 2012 at 10:42:26AM -0700, Junio C Hamano wrote:

>> I am leaning to think that it would be the least surprising if we treat as
>> if /bin/ls does not even exist if /bin is not searchable.  If /bin/ls is
>> unreadable or unexecutable but /bin is searchable, then we _know_ it
>> exists, and we follow the usual exec*p() rule to ignore it
[...]
> That sounds sensible to me. I think it involves writing our own
> execvp, though, right?

If I understood Junio correctly, then checking for ENOENT and EACCES
should be enough.

Example: when I try

 :; mkdir $HOME/cannotread
 :; chmod -x $HOME/cannotread
 :; echo nonsense >$HOME/bin/cat
 :; chmod -x $HOME/bin/cat
 :; PATH=$HOME/cannotread:$HOME/bin/cat:/usr/local/bin:/usr/bin:/bin
 :; cat /etc/fstab

the shell uses /bin/cat without complaint.
