From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Spam: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 17:55:25 -0500
Message-ID: <470D585D.1030808@nrlssc.navy.mil>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>	 <20071010213925.GB2963@fieldses.org> <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 00:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfkT2-0000CV-RX
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 00:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbXJJWzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756573AbXJJWzn
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 18:55:43 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46407 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558AbXJJWzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 18:55:43 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9AMtQ88004763;
	Wed, 10 Oct 2007 17:55:26 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Oct 2007 17:55:25 -0500
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
X-OriginalArrivalTime: 10 Oct 2007 22:55:25.0927 (UTC) FILETIME=[A5769F70:01C80B90]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes-1.511700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ2MDA4LTE1MDU2Ny03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNzcwMS03MDA4ODctNzAxNDU1LTcwNjI0OS03?=
	=?us-ascii?B?MTE5NTMtNzA0OTI3LTcwNDQzMC03MDY3MzctNzAxMTYzLTEwNjQy?=
	=?us-ascii?B?MC03MDM3MTItNzAyNzI2LTcwMDczMy03MDE5MTQtNzAxNTc2LTcw?=
	=?us-ascii?B?NDQyNS03MDY0NTQtNzAyNzYyLTcwNDMzMi03MDA5OTQtNzExODYz?=
	=?us-ascii?B?LTcwMjM1OC03MDI2MDktNzAzNzg4LTcwMjkwMC0xODgwMTktMTQ4?=
	=?us-ascii?B?MDM5LTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60562>

Lars Hjemli wrote:
> On 10/10/07, J. Bruce Fields <bfields@fieldses.org> wrote:
>> On Wed, Oct 10, 2007 at 06:30:02PM -0300, Han-Wen Nienhuys wrote:
>>> could it be that GC does not handle cyclic alternates correctly?
>> Does it handle alternates at all?  If you run git-gc on a repository
>> which other repositories get objects from, then my impression was that
>> bad things happen.
>>
> 
> AFAIK 'git gc' is safe, while 'git gc --prune' will remove loose
> (unreferenced) objects.

No, this is not the case, unless something has changed very recently
in git-gc or git-repack. Even git-gc with no arguments is unsafe if
the repository being gc'ed is listed in another's alternates.

git-gc calls repack with -a and -d. which causes a new pack to be
created which only contains the objects required by the local repository.
The other packs are then deleted. Objects contained in those packs and
required by a "sharing" repository (one using the alternates mechanism)
will be deleted if the local repository no longer references them.

Maybe git-gc should make use of repack's new -A option by default and
only use -a (and not -A) when --prune is specified...

-brandon
