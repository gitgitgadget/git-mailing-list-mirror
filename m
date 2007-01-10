From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Tue, 09 Jan 2007 16:36:56 -0800
Message-ID: <7vtzyzhg47.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vodp7iwzu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701100108460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RSe-0002jK-Od
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbXAJAg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXAJAg6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:36:58 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40584 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589AbXAJAg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:36:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110003657.ELRC19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 19:36:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9Cc61W00d1kojtg0000000; Tue, 09 Jan 2007 19:36:07 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701100108460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 10 Jan 2007 01:22:44 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36444>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is still at what cache_name_pos(cp, namelen) pointed to, or NULL if 
> the entry does not exist (e.g. there is no cache entry, or all cache 
> entries are lexicographically smaller).
>
>> For example, would this work?
>> 
>> 	$ echo >t- && git add t-
>>         $ git show :t
>> 	$ git show :t/
>
> I think so: The code explicitely checks for a trailing '/'. (See second 
> last line of the hunk you quoted.)

The comment was not about the trailing / version, but the one without.
Have you tried them?  

>> > +			struct cache_tree *tree =
>> > +				cache_tree_find(active_cache_tree, cp);
>> > +			if (!cache_tree_fully_valid(tree)) {
>> > +				ret = cache_tree_update(active_cache_tree,
>> > +						active_cache, active_nr, 0, 0);
>> > +				if (ret < 0)
>> > +					return ret;
>> 
>> This gracefully errs out when the index is unmerged but fails to
>> pretend the index knows about trees, if the unmerged part of
>> index is outside the directory the user specified.
>
> That is correct. But in that case, we cannot sanely ask the question "what 
> would the tree object look like if we committed right now?"

But that is not the question you are asking.  "git-ls-files t/"
does work even though you still have cache.h unmerged in the
index.

> But then it turned out that I even use it before committing, like when I 
> ask "what files would be in my next revision?" It is not a question 
> arising daily, but sometimes it is interesting to see _before_ committing 
> them. (Note that I am not only interested in the _modified_ files.)

So it really is about being able to say show while you mean ls-files.

I am not opposed to that goal at all.  I think it makes it
easier to type.  But I think using cache-tree is a wrong
approach.
