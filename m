From: david@lang.hm
Subject: Re: metastore
Date: Mon, 17 Sep 2007 10:17:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709171011160.1558@asgard.lang.hm>
References: <Pine.LNX.4.64.0709151507310.28586@racer.site>
 <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161054380.5298@iabervon.org> <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
 <Pine.LNX.4.64.0709161715090.5298@iabervon.org> <Pine.LNX.4.64.0709161507130.24221@asgard.lang.hm>
 <20070917133000.GD16773@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:18:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXKFF-00072y-Nh
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 19:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbXIQRSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 13:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXIQRSr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 13:18:47 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:50033
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbXIQRSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 13:18:46 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8HHHkel028972;
	Mon, 17 Sep 2007 10:17:46 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070917133000.GD16773@lapse.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58464>

On Mon, 17 Sep 2007, martin f krafft wrote:

> also sprach david@lang.hm <david@lang.hm> [2007.09.17.0037 +0200]:
>>> While we're at it, you probably don't even want to write the
>>> permission file to the live filesystem. It's just one more thing
>>> that could leak information, and changes to the permissions of
>>> files that you record by committing the live filesystem would
>>> presumably be done by changing the permissions of files in the
>>> filesystem, not by changing the text file.
>>
>> the permissions and ACL's can be queried directly from the
>> filesystem, so I don't see any security problems with writing the
>> permission file to the filesystem.
>>
>> changing the permissions would be done by changing the files
>> themselves (when you are running as root on a filesystem that
>> supports the changes, otherwise it would need to fall back to
>> writing the file and getting the changes there, but that should be
>> able to be a local config option)
>>
>> I don't like the idea of having a file that doesn't appear on the
>> local filesystem at any point, it just makes troubleshooting too
>> hard.
>
> Reading over your thoughts, I get this uneasy feeling about such
> a permissions file, because it stores redundant information, and
> redundant information has a tendency to get out of sync. If we
> cannot attach attributes to objects in the git database, then
> I understand the need for such a metastore. But I don't think it
> should be checked out and visible, or maybe we should think of it
> not in terms of a file anyway, but a metastore. Or how do you want
> to resolve the situation when a user might edit the file, changing
> a mode from 644 to 640, while in the filesystem, it was changed by
> other means to 600.

each local repository would need to be configured to either recreate the 
permissions file at checkin time or to use the permission file and ignore 
the actual permissions on the file.

while I agree that it would be ideal to store this data inside git, I'm 
more interested in getting a functional implementation, and given the 
reluctance of the git core team to allow any changes to support this 
use-case anything that can be done to minimize the changes needed to 
support this use-case is a good thing.

> .gitattributes is a different story since it stores git-specificy
> attributes, which are present nowhere else in the checkout.
>
> I still maintain it would be best if git allowed extra data to be
> attached to object nodes. When you start thinking about
> cherry-picking or even simple merges, I think that makes most sense.
> And we don't need conflict markers, we could employ an iterative
> merge process as e.g. git-rebase uses:
>
>  "a conflict has been found in the file mode of ...
>   ... 2750 vs. 2755 ...
>   please set the file mode as it should be and do git-merge
>   --continue. Or git-merge --abort. ..."

and there's nothing to prevent the checkin hook from running such a 
comparison if you want it to.

>>> (Of course, you could check out the same commits as ordinary source, with
>>> developer-owned 644 files and a 644 "permissions" file, and there you'd
>>> have the permissions file appear in the work tree, and you could edit it
>>> and check it in in a totally mundane way.)
>>
>> right, and the same thing if the filesystem doesn't support something in the
>> permission file.
>
> I'd much rather see something like `git-attr chmod 644
> file-in-index` to make this change, rather than a file, which
> introduces the potential for syntax errors.

first make this useable, then if it starts getting used widely (which 
would not at all surprise me, many distros are looking for good options 
for doing this sort of thing, I wouldn't be surprised to see several of 
them start useing git if it did the job well) things can be moved from 
external scripts and storage to internal capabilities as appropriate.

David Lang
