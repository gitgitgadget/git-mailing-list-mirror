From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] git-gc --auto: run "repack -A -d -l" as necessary.
Date: Mon, 17 Sep 2007 12:54:02 -0700
Message-ID: <7vlkb5yso5.fsf@gitster.siamese.dyndns.org>
References: <11900186941912-git-send-email-gitster@pobox.com>
	<1190018716666-git-send-email-gitster@pobox.com>
	<Pine.LNX.4.64.0709171044170.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXMfq-0005U3-G7
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbXIQTyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 15:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756209AbXIQTyI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:54:08 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42075 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045AbXIQTyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 15:54:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917195404.PUVF6851.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 17 Sep 2007 15:54:04 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id pXu21X00M1gtr5g0000000; Mon, 17 Sep 2007 15:54:02 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58475>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/builtin-gc.c b/builtin-gc.c
>> index 34ce35b..a82f6be 100644
>> --- a/builtin-gc.c
>> +++ b/builtin-gc.c
>> @@ -78,6 +83,9 @@ static int too_many_loose_objects(void)
>>  	int num_loose = 0;
>>  	int needed = 0;
>>  
>> +	if (gc_auto_threshold <= 0)
>> +		return 0;
>> +
>
> Heh, patch 6/8 explicitely moved this check out of the function.

Back in 6/8 there was only one toggle to disable auto gc
and it made sense to have it there.  Now the two switches act
together, so that you can say "Don't count my loose objects, but
do check the number of packs" if you wanted to.

>> +		if (!p->pack_local)
>> +			continue;
>> +		suffix = p->pack_name + strlen(p->pack_name) - 5;
>
> I suspect that you need something like
>
> 		int len;
> 		len = strlen(p->pack_name);
> 		if (len < 5)
> 			continue;
>
> before this.

While your additional check would not hurt, I actually think it
is the other way around; the code is already overly cautious.
If it is linked to packed_git list, the file should have already
been checked for having the suffix ".pack".

>> +	/*
>> +	 * If there are too many loose objects, but not too many
>> +	 * packs, we run "repack -d -l".  If there are too many packs,
>> +	 * we run "repack -A -d -l".  Otherwise we tell the caller
>> +	 * there is no need.
>> +	 */
>>  	argv_repack[ac++] = "repack";
>> +	if (too_many_packs())
>> +		argv_repack[ac++] = "-A";
>> +	if (!too_many_loose_objects() && ac == 1)
>> +		return 0;
>
> Why not
>
> 	else if (!too_many_loose_objects())
> 		return 0;
>

Ok.
