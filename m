From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 3/4] git-commit: Refactor creation of log message.
Date: Mon, 04 Feb 2008 18:14:19 +0100
Message-ID: <47A747EB.9020909@gnu.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org> <14fc1ba3f94a773ab2e5b8cdf0c230962f32180d.1200933409.git.bonzini@gnu.org> <alpine.LSU.1.00.0802041646461.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:15:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM4uN-0001wW-14
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbYBDRO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYBDRO1
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:14:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:51436 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbYBDRO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:14:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2014815fga.17
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 09:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=rSB0+HTOZG89UYbrQuXRenn1uzIDJS2LQuz9hBgXzmI=;
        b=KEwuHYSLPQmzBn47atN6p/fWE4bvdfKn4+bwosFGDyuZXKiMo/N44dF18o0bG/LGJOWFXjSqFcGfQz6vlAwVDJ41emeuv6jumGC4TtsrcfT15JP+ydIpMmGBFMPQ+7h0rkxcwMblPrecdJ0SZdPUWySCc1rXMe322zdx+efWMtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=jAj6X3J05XIZYlLAIMFsRhzpUtGU7lsVQjCruh8NsmI/1vz74EcUUUYXvvpQirM2oRnJe9pdTPamUh6u61ysYz2o/SdSDXq3XJjxfa4O7A9AJTWUqF3Mo+nIGexYtyefSdkwBaIxs6GVNkxOiWrwqezgDT1fhW8x/jem7feFiig=
Received: by 10.86.87.5 with SMTP id k5mr6810722fgb.51.1202145263392;
        Mon, 04 Feb 2008 09:14:23 -0800 (PST)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id l12sm18566712fgb.8.2008.02.04.09.14.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Feb 2008 09:14:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0802041646461.7372@racer.site>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72526>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 21 Jan 2008, Paolo Bonzini wrote:
> 
>> This means that: 1) the commit may be aborted after editing the message
>> if there is a problem writing out the tree object (slight disadvantage);
> 
> I consider this more than a slight disadvantage.  I regularly take ages 
> coming up with a good commit message, because I think that the overall 
> time balance is better with me spending more time on the message, but 
> every reader spending less time to guess what I meant.
> 
> So I would be quite annoyed to edit a message, only to find out that for 
> whatever reason the commit was not successful.

Just to make it clearer, the piece of code that would have to fail, for 
the behavior to change, is this:

         discard_cache();
         read_cache_from(index_file);
         if (!active_cache_tree)
                 active_cache_tree = cache_tree();
         if (cache_tree_update(active_cache_tree,
                               active_cache, active_nr, 0, 0) < 0) {
                 rollback_index_files();
                 die("Error building trees");
         }

There are a couple of failure modes hidden in update_one (in cache-tree.c):

         sub = find_subtree(it, path + baselen, entlen, 0);
         if (!sub)
                 die("cache-tree.c: '%.*s' in '%s' not found",
                     entlen, path + baselen, path);

         ...

         if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
                 return error("invalid object %s", sha1_to_hex(sha1));

but I don't really understand how they could happen.  If you do, I 
appreciate being taught.  :-)

Also note that some problems writing the tree object (I cannot think of 
anything but running out of diskspace -- permission errors could be 
caught creating the index and logmessage too) could also happen writing 
the commit object.  I don't think in practice the disadvantage I 
mentioned can happen.

> Are you _sure_ you need 3/4 for 4/4?

Probably no, but it makes it much easier to avoid duplicated code (all 
the cases are already enumerated in prepare_log_message).  I tried it 
first and did not finish because the code was really really ugly.

Thanks for the review.

Paolo
