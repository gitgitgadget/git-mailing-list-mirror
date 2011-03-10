From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Thu, 10 Mar 2011 09:08:29 +0100
Message-ID: <4D7886FD.60109@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net> <7vtyfc7ymk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 09:12:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxayd-0003Rf-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 09:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab1CJIMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 03:12:01 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38946 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810Ab1CJIMA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 03:12:00 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5DFBC208B9;
	Thu, 10 Mar 2011 03:11:59 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 10 Mar 2011 03:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5zFNABZvu7PnUBvT3XOHUj0elWc=; b=DK48ejH+6Tzksss5YtjqGWHLZBeU+Al6NppAC3R7IAKdugEjeNdMQ5ERBv64axpmIY5O+4Ia30Qqtjd/y6pOpwpDNZh6zMsqEABZFa2ZU5RIVLDAtGmQvpHQ+18xTPczdLZES+9j35Ft1w8tivxNy+zbFteJEylRACcFEC/kAxM=
X-Sasl-enc: oQjENL8rJjExWBXZ2O3UcPOR82TeA+VK+H9IvfysU1BZ 1299744719
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D779D40B224;
	Thu, 10 Mar 2011 03:11:58 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7vtyfc7ymk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168796>

Junio C Hamano venit, vidit, dixit 09.03.2011 22:49:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This is a replacement for mg/rev-list-one-side-only in pu.
>> The --left/right-only related commits (1-4/9) are unchanged.
> 
> I like the general idea of marking the equivalent ones instead of outright
> discarding the commits in the cherry_pick_list() function.
> 
> It might be a good idea to record the correspondence between equivalent
> commits in some way; the current topic does not need that information in
> order to produce its output, so that is something other people can build
> on top of this topic in the future.

Yes, I often want to look up the commit on pu which a patch resulted in.
But usually looking it up by commit subject works better than by
patch-id (because of occasional minor edits).

In general it might be nice to have maybe --patch-ids similar to
--parents, or a --patch=<commit> limitting option. (I don't think
outputting equivalent commits along with all commits is viable.)

> There is only one minor point that nagged me while reading this series.
> 
> Conceptually revs->cherry_mark ought to be a subset of revs->cherry_pick
> and the code shouldn't have to do something like this:
> 
> 	if (revs->cherry_pick || revs->cherry_mark)
>         	cherry_pick_list();
> 
> Instead, the code should arrange that revs->cherry_pick is always set
> when revs->cherry_mark is set before the calling application enters the
> loop to call get_revision().
> 
> But that would make the command line parsing more cumbersome (you would
> either waste one bit so that you can tell if you saw --cherry-pick on the
> command line, or keep the version of parser in this series as-is, and add
> postprocessing code to flip revs->cherry_pick on when revs->cherry_mark
> was given in prepare_revision_walk()), and I understand that is why you
> did it that way?

Yes, I think so :) Another reason is that even cherry_pick_list() needs
to know which object flag it should set. So we could

- leave the parser as is
- set cherry_pick when cherry_mark is set
- if (revs->cherry_pick) cherry_pick_list();
- leave cherry_pick_list() as is

Would that be better? I didn't do that because it changes the meaning of
cherry_pick (it can mean two things then). It would introduce the
assumption "pick is set when mark is" instead of "at most one is set"
which is as good or bad. (The current series does cherry_mark when both
are set by a different caller, and the above would do neither when only
cherry_mark is set.)

I think I also didn't do it because "marking" does not do any "picking",
so with the above "cherry_pick" would really be "cherry_process".

But I'm open to changing this, of course (maybe along with renaming
revs->cherry_pick).

Any thoughts on the actual marks ('+' vs. ' ' vs. '*')?

I also feel like we could use a space between the mark and the sha1
(like git cherry does) to ease copy and paste but that is an orthogonal
issue applying to all marks (<>-^+=).

Michael
