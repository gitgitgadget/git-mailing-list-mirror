From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Sun, 12 Aug 2007 09:49:32 -0400
Message-ID: <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Aug 12 15:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKDp6-0004lh-B8
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 15:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763921AbXHLNtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759068AbXHLNtg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 09:49:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:34362 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXHLNtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 09:49:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1525919wah
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 06:49:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kHN0cwo36bYSAUIne8Q7UA5T82XAoqOr3jTPe73JZuaZofdyLvD6qS3NjYIZV6AH2/E61J3QoocwoD9XHJ1QZ4bheTjCafsiIRoEtKrWQZ+61TOwHz+nMZyofu3hIfYgw2rF/thP+NgtwJ6YZp9mvp5cd41k89unLQa5DJ69Czw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VQbXfjvi7lwYSXdGv1m2dK6TFih4b2QJE9NWfMfvk6zx548L2cf0iLA5ahl4O5fp0wI5rD68uWk+VJdl003pGZSsPV1mRyYy0r7jPMIfGbsli+T5aeDCexqERhPlV8dDUfmU1XxlT1NEFT4jrJCg5DMV+fHPSyM2DMjOtyOURBI=
Received: by 10.115.93.16 with SMTP id v16mr476413wal.1186926572388;
        Sun, 12 Aug 2007 06:49:32 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sun, 12 Aug 2007 06:49:32 -0700 (PDT)
In-Reply-To: <20070812103338.GA7763@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55684>

On 8/12/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> On Sat, Aug 11, 2007 at 05:12:24PM -0400, Jon Smirl wrote:
> > If anyone is bored and looking for something to do, making the delta
> > code in git repack multithreaded would help. Yesterday I did a big
> > repack that took 20 minutes and it only used one of my four cores. It
> > was compute bound the entire time.
>
> First, how much time is used by the write and how much by the deltify
> phase?

95% in deltify

>
> If the writing phase uses too much time and you have enough free
> memory, you can try to raise the config variable pack.deltacachelimit
> (default 1000). It will save an additional delta operation for all
> object, whose delta is smaller than pack.deltacachelimit by caching
> the delta.

I have 4GB RAM and fast RAID 10 disk, writing happens very quickly.
Pretty much everything is in RAM.

> Have you considered the impact on memory usage, if there are large
> blobs in the repository?

The process size maxed at 650MB. I'm in 64b mode so there is no
virtual memory limit.

On 32b there's windowing code for accessing the packfile since we can
run out of address space, does this code get turned off for 64b?

>
> While repacking, git keeps $window_size (default: 10) objects unpacked
> in memory. For all (except one), it additionally stores the delta
> index, which has about the same size as the object.
>
> So the worst case memory usage is "sizeof(biggest object)*(2*$window_size - 1)".
> If you have blobs >=100 MB, you need some GB of memory.
>
> Partitioning the problem is not trivial:
>
> * To get not worse packing resultes, we must first sort all objects by
>   type, path, size. Then we can split split the list (for each task
>   one part), which we can deltify individually.
>
>   The problems are:
>
>   - We need more memory, as each tasks keeps its own window of
>     $window_size objects (+ delta indexes) in memory.
>
>   - The list must be split in parts, which require the same amount of
>     time. This is difficult, as it depends on the size of the objects as
>     well as how they are stored (delta chain length).
>
> * On the other hand, we could run all try_delta operations for one object
>   parallel. This way, we would need not very much more memory, but
>   require more synchronization (and more complex code).

This solution was my first thought too. Use the main thread to get
everything needed for the object into RAM, then multi-thread the
compute bound, in-memory delta search operation. Shared CPU caches
might make this very fast.

-- 
Jon Smirl
jonsmirl@gmail.com
