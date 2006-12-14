X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Geert Bosch <bosch@adacore.com>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 14:05:27 -0500
Message-ID: <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581685D.1070407@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 19:39:45 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1847 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 14:39:37 EST
In-Reply-To: <4581685D.1070407@op5.se>
X-Mailer: Apple Mail (2.752.2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34386>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuwQf-0003iN-As for gcvg-git@gmane.org; Thu, 14 Dec
 2006 20:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750837AbWLNTji (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 14:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWLNTji
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 14:39:38 -0500
Received: from nile.gnat.com ([205.232.38.5]:41896 "EHLO nile.gnat.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750837AbWLNTjh
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 14:39:37 -0500
Received: from localhost (localhost [127.0.0.1]) by filtered-nile.gnat.com
 (Postfix) with ESMTP id 4EFDE48CDE5; Thu, 14 Dec 2006 14:08:50 -0500 (EST)
Received: from nile.gnat.com ([127.0.0.1]) by localhost (nile.gnat.com
 [127.0.0.1]) (amavisd-new, port 10024) with LMTP id 29399-01-3; Thu, 14 Dec
 2006 14:08:50 -0500 (EST)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124]) by
 nile.gnat.com (Postfix) with ESMTP id 21C2448CBFF; Thu, 14 Dec 2006 14:08:50
 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org


On Dec 14, 2006, at 10:06, Andreas Ericsson wrote:

> It wouldn't work for this particular case though. In our  
> distribution repository we have ~300 bzip2 compressed tarballs with  
> an average size of 3MiB. 240 of those are between 2.5 and 4 MiB, so  
> they don't drastically differ, but neither do they delta well.
>
> One option would be to add some sort of config option to skip  
> attempting deltas of files with a certain suffix. That way we could  
> just tell it to ignore *.gz,*.tgz,*.bz2 and everything would work  
> just as it does today, but a lot faster.

Such special magic based on filenames is always a bad idea. Tomorrow  
somebody
comes with .zip files (oh, and of course .ZIP), then it's .jpg's other
compressed content. In the end git will be doing lots of magic and  
still perform
badly on unknown compressed content.

There is a very simple way of detecting compressed files: just look  
at the
size of the compressed blob and compare against the size of the  
expanded blob.
If the compressed blob has a non-trivial size which is close to the  
expanded
size, assume the file is not interesting as source or target for deltas.

Example:
    if (compressed_size > expanded_size / 4 * 3 + 1024) {
      /* don't try to deltify if blob doesn't compress well */
      return ...;
    }

