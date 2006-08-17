From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] introduce inline is_same_sha1
Date: Wed, 16 Aug 2006 20:51:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608162029540.14684@chino.corp.google.com>
References: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
 <7vveos17ym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 05:52:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDYvw-000476-TD
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 05:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWHQDwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 23:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWHQDwX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 23:52:23 -0400
Received: from smtp-out.google.com ([216.239.45.12]:38995 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751267AbWHQDwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 23:52:23 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7H3qAWq008411;
	Wed, 16 Aug 2006 20:52:15 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=WjJN5PSigGqEByOXX8j17VqecdwsTcyZeWvtch+8DQicHvyS4dq8GEFJx+D1l9Vz8
	qURiKz+72OQXmtqP4OnxQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7H3q0qV014349;
	Wed, 16 Aug 2006 20:52:00 -0700
Received: by localhost (Postfix, from userid 24081)
	id 3F22887D71; Wed, 16 Aug 2006 20:51:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id E082487D70;
	Wed, 16 Aug 2006 20:51:58 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveos17ym.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25546>

On Wed, 16 Aug 2006, Junio C Hamano wrote:

> I would have expected the inline function to be:
> 
> 	int cmp_object_name(const void *, const void *)
> 
> No need for "unsigned char *" that way [*1*].  
> 
> I do not know what your ultimate goal with this patch is, but I
> like the fact that we do not have to hardcode "20" everywhere.
> With a yet-to-be-written companion patch to make the "20" into a
> symbolic constant OBJECT_NAME_LENGTH, we could someday have a
> flag day to use a hash different from SHA-1 with an updated
> 'git-convert-objects' ;-).
> 

The reason it is not
	int cmp_object_name(const void *, const void *)

ties into the ultimate goal.  As you said, 20 is hardcoded everywhere in 
the code as the length sha1's name.  Since my own development tree uses 
two different hashes configurable at runtime, I decided to create a single 
static inline that would deal with name comparisons.  I submitted a 
similar change to your tree because, like you, I envisioned that someday 
you may have several different hashes that require different comparison 
lengths.  The easy solution is using strcmp in the inline but then you're 
required to cast based on signness and sometimes you want to truncate the 
comparison to n bytes anyway depending on your hash of choice.  If you 
want to open your project to the possibility of implementing other 
hashes, my patch is a step in that direction.

> I would have liked if the function were to give the comparison
> results similar to standard comparison functions such as memcmp
> and strcmp.  I do not know off-hand if we order by the object
> names, and we might only be interested in equality tests, but
> still...
> 

Remember, this is an inline function.  The only reason for writing it 
would be to isolate the number 20 to this particular function (those that 
require comparisons were untouched, as I previously stated, so it still 
exists there as well), otherwise it's useless.  If you're going to allow a 
configurable hash function, then you'll need to isolate the n-bytes 
somewhere if you don't want to pass HASH_NAME_LENGTH around everywhere.

git does sort on sha1 name, specifically with qsort in pack-objects using 
sha1_sort (which isn't an inline, but should be).

(It would be helpful if you were to specifically request changes to a 
patch or explicitly state whether or not you queued to apply it, I can 
never tell).

		David
