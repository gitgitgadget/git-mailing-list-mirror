From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 =?UTF-8?Q?loose=3F?=
Date: Mon, 11 Jun 2012 23:41:56 +0200
Message-ID: <97844573ed775a758d75eec5508b6c85@ulrik.uio.no>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch> <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <0450a24b1f53420f36a3d864c50536cb@ulrik.uio.no>
 <20120611211414.GA32061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	<git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?Q?Ngu?= =?UTF-8?Q?y=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:42:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCND-0006Gj-VB
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab2FKVmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:42:03 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:48051 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab2FKVmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:42:01 -0400
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SeCN3-0003ET-T0; Mon, 11 Jun 2012 23:41:57 +0200
Received: from w3prod-wm01.uio.no ([129.240.4.214] helo=webmail.uio.no)
	by mail-mx2.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SeCN3-0005MT-ER; Mon, 11 Jun 2012 23:41:57 +0200
Received: from cA3A345C1.dhcp.bluecom.no ([193.69.163.163])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Mon, 11 Jun 2012 23:41:56 +0200
In-Reply-To: <20120611211414.GA32061@sigill.intra.peff.net>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 6 msgs/h 1 sum rcpts/h 8 sum msgs/h 1 total rcpts 2469 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, FSL_RCVD_USER=0.001,T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 8CD7D1D02376A1DDBEC3A8F03FBE71143E3DFBDC
X-UiO-SPAM-Test: remote_host: 129.240.4.214 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 84 total 2417498 max/h 663 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199737>

 On Mon, 11 Jun 2012 17:14:14 -0400, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 11, 2012 at 10:44:39PM +0200, Hallvard Breien Furuseth 
> wrote:
>
>> >OK, so that 4.5 is at least a respectable percentage of the total
>> >repo
>> >size. I suspect it may be worse for small repos in that sense, 
>> (...)
>>
>> 'git gc' gave a 3100% increase with my example:
>>
>>     $ git clone --bare --branch linux-overhaul-20010122 \
>>         git://git.savannah.gnu.org/config.git
>>     $ cd config.git/
>>     $ git tag -d `git tag`; git branch -D master
>>     $ du -s objects
>>     624     objects
>>     $ git gc
>>     $ du -s objects
>>     19840   objects
>>
>> Basically: Clone/fetch a repo, keep a small part of it, drop the
>> rest, and gc.  Gc explodes all the objects you no longer want.
>
> I would argue that this is not a very interesting case in the first
> place, since the right thing to do is use "clone --single-branch"[1] 
> to
> void transferring all of those objects in the first place.

 Yeah, I just wanted a simple way to fetch a lot and drop most of
 it, since that's what triggers the problem.  A simple use case
 would be where you did a lot of work between cloing and pruning
 most refs.  I described some actual use cases below the command.

> But there are plenty of variant cases, where you are not just 
> deleting
> all of the refs, but rather doing some manipulation of the branches,
> diffing them to make sure it is safe to drop some bits, running
> filter-branch, etc. And it would be nice to make those cases more
> efficient.

-- 
 Hallvard
