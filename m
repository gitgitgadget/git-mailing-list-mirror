From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 08:53:37 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703270735550.15345@qynat.qvtvafvgr.pbz>
References: <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de>
 <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
 <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
 <20070326233603.GL22773@admingilde.org> <Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz>
 <20070326235527.GM22773@admingilde.org> <Pine.LNX.4.63.0703261530030.14387@qynat.qvtvafvgr.pbz>
 <20070327152507.GO22773@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWFLc-0004m9-H4
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 19:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933999AbXC0RUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 13:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934012AbXC0RUh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 13:20:37 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:34714 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933999AbXC0RUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 13:20:35 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 27 Mar 2007 09:20:35 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 27 Mar 2007 10:19:58 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070327152507.GO22773@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43287>

On Tue, 27 Mar 2007, Martin Waitz wrote:

> On Mon, Mar 26, 2007 at 03:40:15PM -0800, David Lang wrote:
>> useing the same object store makes this work automaticaly (think of all the
>> copies of COPYING that would end up being the same as a trivial example)
>
> Yes, but I guess not much more than COPYING, INSTALL, some trivial
> Makefiles and empty files will be shared between subprojects.
> Except when you have the same subproject in your tree multiple times,
> of course.

although, if you end up packing multiple projects togeather you may end up 
finding more things that diff well against each other (although it will slow 
down the packing with more objects.

> Yet this sharing is exactly why I started to do it that way, until Linus
> stopped me.

I missed that one.

>>> If someone comes up with a nice way to handle everything in one big
>>> object store I would happily use that! :-)
>>
>> what exactly are the problems with one big object store?
>
> I think we really have to discuss this separation on several layers:
> traversal, pack-files, and object database.
>
> For the traversal the point of separating it into a per-module traversal
> is that only one module has to be loaded into RAM at a time.
> This effects all operations which do a (potentially) recursive traversal:
> push, pull, fsck, prune, repack.
> However a separated traversal will no longer be garanteed to only list
> an object once, so this has to be handled in some way.

an object can already appear more then once in pack files.

> Pack files should have better access patterns if they are per-module.
> Most of the time you are only interested in one individual module and
> locality is important here.
>
> Separating the entire object database is a way to improve unreachability
> analysis, as it now can be done per module.
> The other two separations are easier to implement with a separated
> object database, but that's not too strong an argument.

if modules are really as seperate as you make them out to be then what you want 
isn't multiple modules inside one overall project (top level .git) you want 
multiple projects and a way to link them togeather.

>
> So if we can come up with a nice way to do unreachability analysis we
> can indeed go on with the shared object database and tackle the
> remaining scalability issues as they arise.  Those could then be added
> later without changing the on-disk format.
>
>> ones that I can think of:
>>
>> 1. when you are doing a fsck you need to walk all the trees and find out
>> the list of objects that you know about.
>>
>>   done as a tree of binary values you can hold a LOT in memory before
>>   running into swap.
>
> Could you explain the algorithm you are thinking about in more detail?

as I understand it the need is to efficiantly create a list of all the objects 
that are reachable (so that we can then go through the objects and remove them 
if they aren't on the list).

you need these sorted to make it easy to find if something is in the list, and 
with millions of entries you don't it to be a flat list (inserting new values 
becomes very inefficiant) so the classic answer is to do a tree structure. you 
can either do a tree with the object ID's in all the nodes, or you can do one 
where only the leaf nodes hold the object ID's and the other nodes just hold 
pointers (which would then allow you to spill the leaf nodes to disk more 
efficiantly as they wouldn't need to be accessed when inserting unless the node 
itself needed to be changed. looking them up is being done more or less in alpha 
order for loose objects (and could be made to be so for objects in packs) so any 
file I/O for lookups would be close to sequential

this sort of memory useage wouldn't be acceptable for something that happens 
frequently, but a fsck/prune is relativly infrequent and can be run off-hours.

>>   if it's enough larger then available ram then an option for fsck to use
>>   trees on disk is an option.
>
> This could simplify some things.
> There could be an on-disk index of all known objects, so that the sha1
> sums do not have to loaded into RAM all at once.

you wouldn't want to trust this for a fsck/prune

David Lang
