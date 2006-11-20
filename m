X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 02:48:13 -0800
Message-ID: <7virha4cnm.fsf@assigned-by-dhcp.cox.net>
References: <200611201157.23680.litvinov2004@gmail.com>
	<200611200951.05529.andyparkins@gmail.com>
	<7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
	<200611201022.10656.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 10:48:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611201022.10656.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 20 Nov 2006 11:22:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31899>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm6hI-000369-2y for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753104AbWKTKsP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbWKTKsP
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:48:15 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10394 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1753104AbWKTKsO
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:48:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120104814.TPIK21630.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 05:48:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oynl1V0021kojtg0000000; Mon, 20 Nov 2006
 05:47:45 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Monday 2006 November 20 10:07, Junio C Hamano wrote:
>
>> The real issue here is because the b/a on the command line
>> applies on the input-side, and does not act as the output
>> filter.  This comes from _very_ early design decision and if you
>> dig the list archive you will see Linus and I arguing about
>> diffcore-pathspec (which later died off).
>
> I don't think so; even without the b/a on the command line,
> git does not find copies made in this way...

I wrote the code and you contradict me ;-)?

Trust me, I know this area reasonably well, to the point that
sometimes I wonder if there is a sane and cheap way to change
the meaning of the pathspec to be an output filter and then
quickly say "Nah" to myself.

If you say

	git diff --find-copies-harder HEAD^..HEAD -- fileB

in your example, it would give you the creation of fileB, not
copy.

There are a few things we need to be careful about rename/copy.

 - Typically too small files are not treated as copies unless
   they are identical copies (does not apply to this case,
   luckily).

 - Renames are only picked up from files that were lost in the
   same change (i.e. "mv fileA fileB" creates fileB and loses
   fileA; fileB is checked if it is similar to fileA in the
   original).

 - Copies are only picked up from files that were changed in the
   same change (i.e. splitting major part of original file and
   moving it to somewhere else, while leaving a skelton in the
   original file).  "harder" is needed if the copy original was
   untouched, as you found out.

The last one is a compromise between performance and thoroughness,
and the "harder" is one knob to tweak its behaviour.

In the kernel archive, 

	git show -C ad2f931d

tells us that:

 - drivers/i2c/chips/Kconfig lost major part of it and only
   skeletal part of the original remains in it;

 - major part of it went to drivers/hwmon/Kconfig;

The story is similar to the Makefile next door.
