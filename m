From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 11/16] Read cache-tree in index-v5
Date: Fri, 3 Aug 2012 14:41:13 +0200
Message-ID: <20120803124113.GB3226@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <1343905326-23790-12-git-send-email-t.gummerer@gmail.com>
 <87haskbcmi.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:41:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxHBy-0000yQ-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab2HCMlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 08:41:18 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61917 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab2HCMlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 08:41:17 -0400
Received: by wgbdr13 with SMTP id dr13so615812wgb.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GX2D0LSHOzoNz3IgLzNJva0SJJb5igsCJjRhMAm7dRU=;
        b=E1qR9/BOa+tZW6au59drNPImHRMStnetqk448Bv8Hcw5dsK2xNsbpiEuU1udykNFyu
         T1VB2/19Mh6L27MgPvAdzSRnpAMIFtsdv5PVoQfGt6yksZJ6YV0YMOyLWTWnI+rT0uHO
         ibauJ/8plS9pphd23XIzDHoea+ooB/Moln2FRVA9j9dEOjZi5nVlwcUQxxOnR89NP8kL
         Bw/6D4oKDoQUbUO56VBowuDE5gV5nGBNECIoJatNi6GaCKOvcZ8I7ZtTVfdRvPPVtPxu
         1pCzJW7uhGWGxFcHwEpUPle4GX4spjGl5wzP6mAH/3aLXX2pec4VLsUCH9J46yxHV3dj
         YJMw==
Received: by 10.180.105.6 with SMTP id gi6mr4150765wib.4.1343997676162;
        Fri, 03 Aug 2012 05:41:16 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id l5sm25630859wix.5.2012.08.03.05.41.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 05:41:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87haskbcmi.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202834>

On 08/03, Thomas Rast wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Since the cache-tree data is saved as part of the directory data,
> > we have already read it, when we want to read the cache-tree. The
> > cache-tree then only has to be converted from the directory data.
> 
> I think the first sentence is wrong.  You have already read it at the
> very beginning of reading the index format, when you parsed the
> directory records, haven't you?

Yes, that's what I wanted to say, I'll rephrase this.

> > The cache-tree isn't lexically sorted, but after the pathlen at
> > each level, therefore the directories have to be reordered with
> > respect to the ondisk layout.
> 
> I'm not a native speaker either, but I think this does't parse well.
> Maybe
> 
>   The cache-tree data is arranged in a tree, with the children sorted by
>   pathlen at each node.  So we have to rebuild this format from the
>   on-disk directory list.

Thanks, that sounds better.

> > +	for (i = 0; i < subtree_nr; i++) {
> > +		struct cache_tree *sub;
> > +		struct cache_tree_sub *subtree;
> > +		char *buf, *name;
> > +
> > +		name = "";
> > +		buf = strtok(down[i].de->pathname, "/");
> 
> man 3 strtok says
> 
>    Be cautious when using these functions.  If you do use them, note
>    that:
> 
>    * These functions modify their first argument.
> 
>    * These functions cannot be used on constant strings.
> 
>    * The identity of the delimiting character is lost.
> 
>    * The strtok() function uses a static buffer while parsing, so it's
>      not thread safe.  Use strtok_r() if this matters to you.
> 
> I don't think the last point will be a problem, but what about modifying
> the argument?

Hrm the function is only called at the end of read_index_v5, after
which we don't need the directory entries anymore. If we want to use
the directory entries for a new in-memory format later however, we
should probably change it. Maybe a comment for the cache_tree_convert_v5
function would be enough?
