From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Submodule object store
Date: Mon, 26 Mar 2007 15:40:15 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703261530030.14387@qynat.qvtvafvgr.pbz>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost>
 <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de>
 <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
 <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
 <20070326233603.GL22773@admingilde.org> <Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz>
 <20070326235527.GM22773@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzDT-0001V4-DR
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933837AbXC0AHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933843AbXC0AHH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:07:07 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:61467 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933837AbXC0AHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:07:05 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 26 Mar 2007 16:07:05 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 26 Mar 2007 17:06:25 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070326235527.GM22773@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43214>

On Tue, 27 Mar 2007, Martin Waitz wrote:

> hoi :)
>
> On Mon, Mar 26, 2007 at 03:20:34PM -0800, David Lang wrote:
>>> I want to be able to list all objects which are not reachable in the
>>> object store, without traversing all submodules at the same time.
>>> The only way I can think of to achieve this is to have one separate
>>> object store per submodule and then do the traversal per submodule.
>>
>> why do you want to optimize for the relativly rare fsck function rather
>> then the more common read functions (which would benifit from shareing
>> object that are identical between projects)?
>
> Because I don't know how to make it _possible_ for large repositories
> otherwise.  Consider a Linux-distribution which handles each package
> as one submodule.
>
> I don't think that it's too much balanced towards fsck.
> The separated object store also helps reduce the memory requirement for
> large pushs/pulls.
> Sharing objects can be achieved by alternates if you want.

alternates require explicitly setting up the sharing.

useing the same object store makes this work automaticaly (think of all the 
copies of COPYING that would end up being the same as a trivial example)

> If someone comes up with a nice way to handle everything in one big
> object store I would happily use that! :-)

what exactly are the problems with one big object store?

ones that I can think of:

1. when you are doing a fsck you need to walk all the trees and find out the 
list of objects that you know about.

   done as a tree of binary values you can hold a LOT in memory before running 
into swap.

   if it's enough larger then available ram then an option for fsck to use trees 
on disk is an option.

2. when creating a pack you will eventually run into pack-size limits with too 
many objects

   teach the pack creators to make packs that are subsets rather then everything 
(I belive that most of the smarts are there, it just needs the upper control 
logic to tell the existing things what to include)

3. when doing a pull it takes longer to figure out what to pull to get a 
duplicate of _everything_

   add a way to do a 'pull projectlist' that would look at what objects are 
needed by the project(s) requested and only try to pack up those objects

what else is there that I'm not thinking of? so far these look like long-term 
problems as opposed to short-term problems, and all of them have fairly simple 
fixes that can be implemented as they become an issue.

David Lang
