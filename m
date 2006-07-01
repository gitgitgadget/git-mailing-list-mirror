From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Sat, 01 Jul 2006 11:51:44 -0700
Message-ID: <7v64ihdupr.fsf@assigned-by-dhcp.cox.net>
References: <20060630002756.GD22618@steel.home>
	<Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607011657460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 20:51:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwkZK-0003Se-Co
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWGASvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 14:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWGASvq
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 14:51:46 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64425 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751913AbWGASvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 14:51:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701185145.ZHRU6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Jul 2006 14:51:45 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607011657460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 1 Jul 2006 17:06:14 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23057>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> True, I missed that one. But it is just a call to 
> cache_tree_free(active_cache_tree); in discard_cache(), right?

On the codepath to write out the new index file, calling
cache_free_tree(&active_cache_tree) before write_cache() is all
that should be needed.  When "active_cache_tree == NULL",
write_cache() would write out an index file without the cached
tree information.

Currently not many things take advantage of cached tree
information to optimize its operation.  But I'd like to change
that.  For example, tree merges by read-tree should be able to
take advantage of the fact that a cached tree read from the
index and three trees being read all match for a subdirectory
and do the merge of the directory without descending into it.

>>  - index_timestamp is left as the old value in this patch when
>>    you switch cache using read_cache_from() directly.  I have a
>>    suspicion you may be bitten by "Racy Git" problem, especially
>>    because the operations are supposed to happen quickly thanks
>>    to the effort of you two ;-) increasing the risks that the
>>    file timestamp of the working tree file and the cached entry
>>    match.
>
> Yes. Again, just one line to discard_cache(), right?
>
> 	index_file_timestamp = 0;

This one I am not sure.  Read the comment in ce_match_stat() and
see the problematic sequence of events that this variable tries
to help resolve applies to your use.
