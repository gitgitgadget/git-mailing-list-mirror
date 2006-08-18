From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] make sha1_sort inline
Date: Fri, 18 Aug 2006 09:56:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608180947240.29405@chino.corp.google.com>
References: <Pine.LNX.4.63.0608172229070.25827@chino.corp.google.com>
 <7vsljud2fs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 18:57:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7eS-0001NV-F8
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWHRQ4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWHRQ4h
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:56:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60119 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751423AbWHRQ4g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 12:56:36 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7IGu6Uu016801;
	Fri, 18 Aug 2006 09:56:06 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=mPWHFOjUkhkr71szLgre1TBedO3+mcl6jI0bQFaTmwQHDEf57SCPovCZguidMPK3f
	lWPGbR2Oqa92JN7aqSxGw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7IGu1mT000503;
	Fri, 18 Aug 2006 09:56:01 -0700
Received: by localhost (Postfix, from userid 24081)
	id 49C4287D71; Fri, 18 Aug 2006 09:56:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 0733587D70;
	Fri, 18 Aug 2006 09:56:01 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsljud2fs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25679>

On Thu, 17 Aug 2006, Junio C Hamano wrote:

> The only use of this function is to got its address taken of,
> and then the variable that has its address (current_sort) is
> used by sort_comparator() function, whose address is given to
> the library routine qsort(3).
> 
> Does it still make sense to declare it inline?
> 
> 

No.

Well, maybe just "not yet."  The idea is to isolate the sort functions for 
hashes since we may add support for additional ones in the future (re: my 
thread on md5).  Then all these functions would probably be abstracted to 
a single file and labeled as static with a single global function:

	static int hash_sort(const struct object_entry,
			     const struct object_entry);

which would call the static inline function that corresponds to the hash 
in use for that database.  This can't simply be #ifdef's since the choice 
of hash would not be compile-time, it would be run-time depending on what 
flags are sent during init-db.

And instead of:
	struct object_entry {
		unsigned char sha1[20];
		...
	}

it becomes:
	struct object_entry {
		union hash_name {
			unsigned char sha1[20];
			...
		}
		...
	}

So in that case, the static inline of the sort does have its advantage as 
opposed to two function calls on any hash_sort.  But I agree in the 
meantime while additional hashes are still be considered that this would 
not be an advantageous addition to the code.

(At least you get an idea of what I'm thinking about hashes)

		David
