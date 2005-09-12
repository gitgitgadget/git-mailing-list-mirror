From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 19:59:49 -0400
Organization: Network Appliance, Inc.
Message-ID: <43261675.10905@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <7vaciiawrm.fsf@assigned-by-dhcp.cox.net>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050908010904090603020307"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 02:01:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEyDq-0007nR-1E
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 02:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVIMAAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 20:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVIMAAA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 20:00:00 -0400
Received: from citi.umich.edu ([141.211.133.111]:36423 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932372AbVILX76 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 19:59:58 -0400
Received: from [10.58.52.181] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id AC0CD1BACD;
	Mon, 12 Sep 2005 19:59:57 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaciiawrm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8455>

This is a multi-part message in MIME format.
--------------050908010904090603020307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> I have a couple of comments on the API, though.
> 
> * Doesn't function to be applied usually want to have its own
>   data when passed to walk, maybe something like this?
> 
>   typedef int (*cache_iterator_fn_t) (struct cache_cursor *cc,
> 			 struct cache_entry *ce, void *udata);
>   static inline int walk_cache(cache_iterator_fn_t func, void *udata)
>   {
>           struct cache_cursor cc;
> 
>           init_cc(&cc);
>           while (!cache_eof(&cc)) {
>                   int status = func(&cc, cc_to_ce(&cc), udata);
>                   if (status < 0)
>                           return status;
>           }
>           return 0;
>   }
> 
>   This was a question I had when I read [PATCH 01/22] before
>   reading the rest of the patches, but the actual conversion
>   does not seem to find much need for it.  A new global variable
>   pathspec is introduced to pass information the API is unable
>   to pass to diff_one() in diff-index.c, which may be a sign
>   that an extra "user data" parameter might help.  Your call.

heh.  well, i had something like this earlier, but i know linus doesn't 
like void *, and it was really kind of ugly.  and as you observed, it's 
used so rarely.  so i just decided to drop it.

> * It may make sense to give another param to describe which
>   cache the caller is talking about so that we can later have
>   more than one cache at the same time:
> 
>   struct cache {
>       struct cache_entry **cache_array;
>       unsigned int nr;
>       unsigned int alloc;
>       unsigned int cache_changed;
>   };
>   struct cache active_cache;
> 
>   and use it like this:
> 
>   static inline struct cache_entry *cc_to_ce(struct cache_cursor *cc,
>                                              struct cache *cache)
>   {
>           return cache->cache_array[cc->pos];
>   }
> 
>   We could argue that this should be left for later rounds.  On
>   the other hand, we will be changing all the cc_* function call
>   sites during that round, which is by definition the places you
>   are touching in this round anyway.

actually this is simple to add now.  i'll give it a shot (and fix up 
write_cache to use it).

btw, with daniel's changes i don't see where we're using 
active_cache_changed any more.

--------------050908010904090603020307
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------050908010904090603020307--
