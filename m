X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: can I remove or move a tag in a remote repository?
Date: Wed, 29 Nov 2006 11:47:55 +0000
Message-ID: <456D736B.3040707@shadowen.org>
References: <87wt5rffbm.fsf@rho.meyering.net>	<7virgz1bz7.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0611291040590.30004@wbgn013.biozentrum.uni-wuerzburg.de> <87u00imsin.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 11:48:18 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <87u00imsin.fsf@rho.meyering.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32636>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpNv0-0003Ql-8B for gcvg-git@gmane.org; Wed, 29 Nov
 2006 12:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966223AbWK2Lr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 06:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966284AbWK2Lr7
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 06:47:59 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3088 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S966223AbWK2Lr7
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 06:47:59 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GpNu9-0006g6-Of; Wed, 29 Nov 2006 11:47:09 +0000
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

Jim Meyering wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Tue, 28 Nov 2006, Junio C Hamano wrote:
> ...
>>> I think this is due to overeager receive.denyNonFastForwards
>>> configuration setting at the repository you are pushing into.
> 
> Junio, thank you for following up on this!
> 
>>> I _think_ what receive-pack does in this case is totally wrong.
>>> It should either:
>>>
>>>  (1) deny overwriting existing tags -- tags are meant to be
>>>      immutable so it should not allow them to be "updated"
>>>      regardless of fast-forwardness, or
>>>
>>>  (2) allow overwriting things under refs/tags/ without any
>>>      fast-forward checking.  After all, a tag could point at a
>>>      tree or a blob, and there is no fast-forwardness among
>>>      trees.
>>>
>>> The client side check in "git fetch" takes the latter viewpoint,
>>> and I think we should be consistent with it.
> 
>>> Johannes, what do you think?  Does the following patch look sane
>>> to you?
>> It does if you agree that (2) is correct.
>>
>> But I don't agree. cvs-head really should be a head IMHO, not a tag,
>> because cvs-head really tracks a branch.
>>
>> I also think that git-fetch silently updating tags is wrong. Rather, it
>> should warn that the tags are different. But I've been wrong before.
> 
> AFAIK, no one wants git-fetch to update tags _silently_.
> I expected it give a diagnostic and fail by default -- and it already
> does that.  Pushing moved tags is serious business.  I was hoping to be
> able to use --force to override that fail-safe.
> 
> My goal is to maintain a symbolic reference "cvs-head" that points
> to the newest git trunk node that's been mirrored to a CVS repository.
> Without even considering any other option, I chose to use a lightweight
> tag for that purpose, since I have a conceptual view that it's a label I
> can move from one referent to another.  It strikes me as counter-intuitive
> to use a temporary git "branch" that way.  Would that even work, removing
> it and recreating it all the time?  Hmm.. or maybe you mean to create the
> branch once and then to merge from the trunk repeatedly.  That seems
> like unnecessary work, when all I want is a movable label.

Well remember that all heads are simply references into the DAG, they
are all labels.  'heads' you are allowed to move and change, commit to
etc, but they are still just name -> sha1 mechanisms.

If the merge is a ff then there is no work.  You could always use
'reset' instead to move the branch to the right place in the DAG.

> 
> I admit that I like the idea of release tags being immutable, but even
> there, it's happened that I've made-but-not-published a release, then
> realized that it wasn't quite complete.  I was glad to be able to go
> back and re-tag after making corrections.
> 
> I wouldn't mind having a way to specify that a pushed tag is *not*
> immutable, with the default being it is immutable.

