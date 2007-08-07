From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Mon, 06 Aug 2007 23:24:46 -0400
Message-ID: <46B7E5FE.7050006@tromer.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org> <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net> <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org> <7v643vj316.fsf@assigned-by-dhcp.cox.net> <46B4A350.9060806@tromer.org> <20070805144632.GB999MdfPADPa@greensroom.kotnet.org> <46B76B8C.9050905@tromer.org> <20070806190344.GF999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Tue Aug 07 05:25:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIFhg-0004aa-IP
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 05:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbXHGDZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 23:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933264AbXHGDZt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 23:25:49 -0400
Received: from forum2.org ([198.65.45.153]:1059 "EHLO forum2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933334AbXHGDZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 23:25:48 -0400
X-F2-Envelope-From: git2eran@tromer.org
X-F2-Envelope-To: git@vger.kernel.org
Received: from moby.tromer.org (c-66-30-26-80.hsd1.ma.comcast.net [66.30.26.80])
	(authenticated bits=0)
	by forum2.org (8.13.6.20060614/8.13.6) with ESMTP id l773P1AD007779;
	Tue, 7 Aug 2007 03:25:01 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20070719 Fedora/2.0.0.5-1.fc7 Thunderbird/2.0.0.5 Mnenhy/0.7.5.0
In-Reply-To: <20070806190344.GF999MdfPADPa@greensroom.kotnet.org>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55212>

On 2007-08-06 15:03, Sven Verdoolaege wrote:
> I don't see the difference.  If you forgot you changed something
> (be it a submodule or a file) you will commit something you
> didn't plan to commit.
...
>     bash-3.00$ git checkout master && echo "test" > b && git commit -a -m 'change b'
>     M       c
>     Switched to branch "master"
>     Created commit 657c5b1: change b
>      2 files changed, 2 insertions(+), 0 deletions(-)

Yes, you're right. (When I tried this, checkout complained about the
dirty working tree because a *merge* was needed.)

So let's try to explicitly reset the index and work tree:

$ git reset --hard master
$ vi foo
$ git commit -a -m 'fixed typos'

Oops, still a corrupt commit.


>>>> Another approach is for pull, checkout etc. to automatically update the
>>>> submodule' head ref, but no more.
>>> Then everything, including "git submodule update", would assume
>>> that the submodule is up-to-date.
>> With that approach, "git submodule update" would fetch the submodule's
>> head commit (which could be missing), and then check it against the
>> submodule's index (and maybe its work tree).
> And how is anyone supposed to figure out what HEAD the submodule's
> index and working tree correspond to?

What HEAD corresponds to any other dirty index or dirty working tree?
It's irrelevant and may not exist. You just have some random dirty state.

If it's the yet-to-exist submodule merging you're worried about, the
submodule's old head can be saved in ORIG_HEAD or some such during the
supermodule checkout.


> I can only hope that "git submodule update" would never blindly assume
> that the submodule is clean and so the user would have to manually
> sync the HEAD and the working tree.

Why would it assume that? In this approach, and ignoring submodule
merging for now, "git submodule update" should mean roughly "cd
submodule && git fetch HEAD && git reset --hard HEAD". After all, this
is really the only way to end up with the prescribed commit sha1.

I agree that for safety it makes sense to warn or abort if the index
doesn't match ORIG_HEAD (saved by the supermodule checkout) or if the
index doesn't match the work tree.

  Eran
