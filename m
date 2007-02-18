From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] builtin-update-index.c (add_file_to_cache): Don't leak a cache entry.
Date: Sun, 18 Feb 2007 10:10:21 +0100
Message-ID: <87bqjrvnk2.fsf@rho.meyering.net>
References: <87mz3e327y.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0702160858190.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 18 10:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIi46-00047j-6c
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 10:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbXBRJKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 04:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbXBRJKY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 04:10:24 -0500
Received: from mx.meyering.net ([82.230.74.64]:60458 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161195AbXBRJKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 04:10:23 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id C18AF1245; Sun, 18 Feb 2007 10:10:21 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0702160858190.20368@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 16 Feb 2007 09:00:34 -0800 (PST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40067>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 16 Feb 2007, Jim Meyering wrote:
>>
>> -	if (index_path(ce->sha1, path, &st, !info_only))
>> +	if (index_path(ce->sha1, path, &st, !info_only)) {
>> +		free(ce);
>>  		return -1;
>> +	}
>
> Well, the only user of this does:
>
> 	if (add_file_to_cache(p))
> 		die("Unable to process file %s", path);
>
> so the leak is very shortlived ;)

True... for now, and probably for ever after, but what if?  However,
the goal in plugging a leak like this is not to avoid wasting memory,
but rather to avoid spending time investigating it, again and again.
It's analogous to making your code compile warning-free.  When a new
warning/leak pops up, it's easy to spot (in case it really does matter),
not obscured by lots of older ones.

There are other ways to mark a leak as ignorable, but this method works
across all leak-detecting tools.

If you'd prefer to avoid the cost of a technically-unnecessary free,
give it a different name, so it can be a no-op most of the time, and
"free" only when compiled in leak-checking mode.
