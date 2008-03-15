From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix recent 'unpack_trees()'-related changes breaking 'git
 stash'
Date: Fri, 14 Mar 2008 21:40:02 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803142133160.3557@woody.linux-foundation.org>
References: <20080315014133.GB32265@neumann> <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: SZEDER G?bor <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 05:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaOCz-0005wg-4f
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 05:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbYCOEkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 00:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbYCOEkq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 00:40:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37018 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750824AbYCOEkq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2008 00:40:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2F4f1cr011573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 21:41:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2F4e2Qn001711;
	Fri, 14 Mar 2008 21:40:03 -0700
In-Reply-To: <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.31 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77305>



On Fri, 14 Mar 2008, Linus Torvalds wrote:
> 
> The trivial fix is to just copy the index timestamp from the source index 
> into the result index. But we only do this if we *have* a source index, of 
> course, and if we will even bother to use the result.

Actually, that second part of the test is just unnecessarily clever, and 
it's just asking for trouble.

Even if we never use the "result" for anything in the end, it's probably a 
good idea to have its timestamp match the source timestamp just in case 
somebody wants to do the "is_racy_timestamp()" on the result while it's 
being generated (and before it is thrown away).

In particular, it would not be necessarily wrong to use ie_match_stat() on 
the result index in a callback.

So it might be better to make that thing be just

>  	memset(&o->result, 0, sizeof(o->result));
> +	if (o->src_index)
> +		o->result.timestamp = o->src_index->timestamp;
>  	o->merge_size = len;

instead of checking both src_index *and* dst_index. The source index is 
all that matters anyway. Even if 'o->result' isn't used in the end, who 
cares? We can still give it the right timestamp.

And no, this really isn't likely to matter, but let's pick the simpler 
version if it doesn't matter.

		Linus
