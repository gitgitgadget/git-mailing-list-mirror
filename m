From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to   significantly
 speed up packing/walking
Date: Thu, 06 Aug 2009 16:58:48 +0200
Message-ID: <4A7AEFA8.5010001@drmicha.warpmail.net>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nick Edelen <sirnot@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 16:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4R4-0000Nd-GJ
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 16:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbZHFO7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 10:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbZHFO7H
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 10:59:07 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50588 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807AbZHFO7G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 10:59:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4E905243B;
	Thu,  6 Aug 2009 10:59:05 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 06 Aug 2009 10:59:05 -0400
X-Sasl-enc: nkBByFEm7fiIVsA+QKHQK8NgkOazyKinCme41cfFk8Rv 1249570744
Received: from localhost.localdomain (vpn-137-097.rz.uni-augsburg.de [137.250.137.97])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2A55315EC2;
	Thu,  6 Aug 2009 10:59:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125077>

Johannes Schindelin venit, vidit, dixit 06.08.2009 16:48:
> Hi,
> 
> On Thu, 6 Aug 2009, Nick Edelen wrote:
> 
>> SUGGESTED FOR 'PU':
>>
>> Traversing objects is currently very costly, as every commit and tree must be 
>> loaded and parsed.  Much time and energy could be saved by caching metadata and 
>> topological info in an efficient, easily accessible manner.  Furthermore, this 
>> could improve git's interfacing potential, by providing a condensed summary of 
>> a repository's commit tree.
>>
>> This is a series to implement such a revision caching mechanism, aptly named 
>> rev-cache.  The series will provide:
>>  - a core API to manipulate and traverse caches
>>  - an integration into the internal revision walker
>>  - a porcelain front-end providing access to users and (shell) applications
>>  - a series of tests to verify/demonstrate correctness
>>  - documentation of the API, porcelain and core concepts
>>
>> In cold starts rev-cache has sped up packing and walking by a factor of 4, and 
>> over twice that on warm starts.  Some times on slax for the linux repository:
>>
>> rev-list --all --objects >/dev/null
>>  default
>>    cold    1:13
>>    warm    0:43
>>  rev-cache'd
>>    cold    0:19
>>    warm    0:02
>>
>> pack-objects --revs --all --stdout >/dev/null
>>  default
>>    cold    2:44
>>    warm    1:21
>>  rev-cache'd
>>    cold    0:44
>>    warm    0:10
> 
> Nice!
> 
>> The mechanism is minimally intrusive: most of the changes take place in 
>> seperate files, and only a handful of git's existing functions are 
>> modified.
> 
> Sorry, I forgot the details, could you quickly remind me why these caches 
> are not in the pack index files?
> 
>>  Documentation/rev-cache.txt           |   51 +
>>  Documentation/technical/rev-cache.txt |  336 ++++++
>>  Makefile                              |    2 +
>>  blob.c                                |    1 +
>>  blob.h                                |    1 +
>>  builtin-rev-cache.c                   |  284 +++++
>>  builtin.h                             |    1 +
>>  commit.c                              |    3 +
>>  commit.h                              |    2 +
>>  git.c                                 |    1 +
>>  list-objects.c                        |   49 +-
>>  rev-cache.c                           | 1832 +++++++++++++++++++++++++++++++++
>>  revision.c                            |   89 ++-
>>  revision.h                            |   46 +-
>>  t/t6015-rev-cache-list.sh             |  228 ++++
>>  t/t6015-sha1-dump-diff.py             |   36 +
> 
> Hmpf.
> 
> We got rid of the last Python script in Git a long time ago, but now two 
> different patch series try to sneak that dependency (at least for testing) 
> back in.
> 
> That's all the worse because we cannot use Python in msysGit, and Windows 
> should be a platform benefitting dramatically from your work.

In fact, the test the script performs could be easily rephrased with
"sort", "uniq" and "comm".
OTOH: If the walker is supposed to return the exact same orderd list of
commits you can just use test_cmp.

Michael
