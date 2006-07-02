From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Sun, 2 Jul 2006 10:51:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607021043550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607011657460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ihdupr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 10:51:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwxgG-0005vl-8l
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 10:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWGBIvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 04:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWGBIvj
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 04:51:39 -0400
Received: from mail.gmx.de ([213.165.64.21]:47776 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751365AbWGBIvi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 04:51:38 -0400
Received: (qmail invoked by alias); 02 Jul 2006 08:51:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 02 Jul 2006 10:51:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ihdupr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23096>

Hi,

On Sat, 1 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > True, I missed that one. But it is just a call to 
> > cache_tree_free(active_cache_tree); in discard_cache(), right?
> 
> On the codepath to write out the new index file, calling 
> cache_free_tree(&active_cache_tree) before write_cache() is all that 
> should be needed.  When "active_cache_tree == NULL", write_cache() would 
> write out an index file without the cached tree information.
> 
> Currently not many things take advantage of cached tree information to 
> optimize its operation.  But I'd like to change that.  For example, tree 
> merges by read-tree should be able to take advantage of the fact that a 
> cached tree read from the index and three trees being read all match for 
> a subdirectory and do the merge of the directory without descending into 
> it.

Together with my argument, that a library function should make life easier 
for you, not harder, you are making a fine point that the _clean() version 
of get_merge_bases() should clean the active_cache_tree, too.

Besides, is it not better to clean up now-bogus memory anyway?

> >>  - index_timestamp is left as the old value in this patch when
> >>    you switch cache using read_cache_from() directly.  I have a
> >>    suspicion you may be bitten by "Racy Git" problem, especially
> >>    because the operations are supposed to happen quickly thanks
> >>    to the effort of you two ;-) increasing the risks that the
> >>    file timestamp of the working tree file and the cached entry
> >>    match.
> >
> > Yes. Again, just one line to discard_cache(), right?
> >
> > 	index_file_timestamp = 0;
> 
> This one I am not sure.  Read the comment in ce_match_stat() and
> see the problematic sequence of events that this variable tries
> to help resolve applies to your use.

Okay. After reading the comment, I am quite certain we can just set the 
index_file_timestamp to 0.

Either we start with an empty cache; In that case it is obviously correct 
to set the timestamp to 0.

Or, after we discard the cache, we have to read a new cache before working 
on it. Now, reading the cache means calling read_cache() (or 
read_cache_from()), and -- alas -- line number 12 in the body of that 
function sets the timestamp to 0 _anyway_, to be reset to the correct 
value later.

So, I still think that these two lines should be in the cleanup part of 
get_merge_bases().

BTW personally, I prefer the one-function approach, i.e. a flag which says 
if it is okay not to clean up.

Ciao,
Dscho
