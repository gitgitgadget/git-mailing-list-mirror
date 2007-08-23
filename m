From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 11:41:34 -0700
Message-ID: <7vhcmqt7oh.fsf@gitster.siamese.dyndns.org>
References: <46CD94AB.7070709@trolltech.com>
	<alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:42:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOHd6-00066G-Qw
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 20:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764707AbXHWSl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764672AbXHWSl5
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 14:41:57 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760824AbXHWSl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 14:41:56 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F0E24126B02;
	Thu, 23 Aug 2007 14:42:12 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 23 Aug 2007 10:18:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56513>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 23 Aug 2007, Marius Storm-Olsen wrote:
>> 
>> I have an issue with git-rebase failing on a repository using
>>     core.autocrlf=true
>> 
>> I've tracked it down to git-am failing with core.autocrlf=true and passing
>> with core.autocrlf=false. I've tried digging deeper into the code, but for
>> some reason ce_match_stat_basic() (read-cache.c:~187) reports the size of the
>> file in the index to be 0 (when core.autocrlf=true), which is why git-am bails
>> out on the patch. (ce->ce_size == 0, while st->st_size == the correct size on
>> disk)
>
> Very interesting.
> ...
> 	trace: built-in: git 'apply' '--allow-binary-replacement' '--index' '.dotest/patch'
> 	trace: built-in: git 'diff' '--quiet'
> 	trace: built-in: git 'diff' '--quiet'
> 	trace: built-in: git 'write-tree'
> 	trace: built-in: git 'diff' '--quiet'
>
> ie everything was fine after the "apply" phase, but the index and the 
> working tree went out-of-kilter after "git write-tree".
>
> The reason? "git write-tree" doesn't read the config file, so it never 
> even reads the "core.autocrlf=true" variable. As a result, it seems to 
> screw up the index matching when it does the cache_tree_fully_valid() 
> (which will fail due to "git apply --index" having invalidated the tree 
> SHA1's) followed by cache_tree_update().
>
>> Can anyone please enlighten me on why this may happen?
>
> This patch should fix it. 
>
> Junio - it fixes the test for me, but quite frankly, I don't see why 
> write-tree would *ever* change any non-tree index entries. But it does. I 
> think there's another bug somewhere, or I'm missing something.

As you said, there is something else going on.  write-tree is
about reading the index entries and writing them out as a set of
trees, and at that point it should not even matter if you have
garbage in the work tree or if you do not even have a work tree.
All the crlf conversions have been done when the object hit the
index, so its reading or not reading core.autocrlf should not
change its behaviour.
