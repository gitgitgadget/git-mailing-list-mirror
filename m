From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/7] revert: free revs->cmdline.rev
Date: Tue, 22 May 2012 22:01:42 +0200 (CEST)
Message-ID: <20120522.220142.31626389365969573.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
	<20120521145610.1911.46356.chriscool@tuxfamily.org>
	<20120521203941.GB28331@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, artagnon@gmail.com,
	nbowler@elliptictech.com
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 22 22:02:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvHL-0001n2-Di
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303Ab2EVUBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:01:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:60749 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab2EVUBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:01:52 -0400
Received: from localhost (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 78CABA62DA;
	Tue, 22 May 2012 22:01:43 +0200 (CEST)
In-Reply-To: <20120521203941.GB28331@burratino>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198234>

Hi,

From: Jonathan Nieder <jrnieder@gmail.com>
> Hi,
> 
> Christian Couder wrote:
> 
>> add_rev_cmdline() in revision.c is (re)allocating an array of
>> struct rev_cmdline_entry. This patch releases it.
> [...]
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -217,6 +217,8 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>>  	git_config(git_default_config, NULL);
>>  	parse_args(argc, argv, &opts);
>>  	res = sequencer_pick_revisions(&opts);
>> +	if (opts.revs)
>> +		free(opts.revs->cmdline.rev);
>>  	free(opts.revs);
>>  	if (res < 0)
>>  		die(_("revert failed"));
> 
> Quick thoughts:
> 
> This feels like a layering violation.  Avoidable?  Maybe revision.c
> could gain a helper to allow this to be written like so:
> 
> 	free_rev_info(opts.revs);
> 	free(opts.revs);
> 
> Since this is a one-time allocation it is probably worth mentioning in
> the log message that this is a futureproofing/valgrind-cleanliness
> measure and is not actually fixing a leak.

Ok, I will create the free_rev_info() helper and improve the commit
message.

> Micronit: it would feel slightly more comfortable if the free() were
> after the die(), even though the die() should probably be changed to
> exit().  That way someone wanting to add code after the die() that
> continues to assume opts.revs is valid would be able to.
> 
> Of course I'd imagine the largest leak in cherry-pick is the
> deliberately constantly growing object hash table.  It would be very
> interesting to fix that --- do you know how libgit2 handles it?

About the constantly growing hash table, perhaps it should be taken
care of in a try_to_free_routine() used by xmalloc and other such
functions. And no I don't know much about libgit2.

> Thanks much and hope that helps,
> Jonathan

Thanks for your kind review,
Christian.
