From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 =?UTF-8?Q?loose=3F?=
Date: Mon, 11 Jun 2012 22:44:39 +0200
Message-ID: <0450a24b1f53420f36a3d864c50536cb@ulrik.uio.no>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch> <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	<git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBhs-0004kM-3U
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab2FKU7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:59:20 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:40579 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab2FKU7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:59:19 -0400
X-Greylist: delayed 871 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2012 16:59:19 EDT
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SeBTe-0005pe-FQ; Mon, 11 Jun 2012 22:44:42 +0200
Received: from w3prod-wm02.uio.no ([129.240.4.215] helo=webmail.uio.no)
	by mail-mx1.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SeBTe-0008PH-20; Mon, 11 Jun 2012 22:44:42 +0200
Received: from cA3A345C1.dhcp.bluecom.no ([193.69.163.163])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Mon, 11 Jun 2012 22:44:39 +0200
In-Reply-To: <20120611183414.GD20134@sigill.intra.peff.net>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 5 msgs/h 1 sum rcpts/h 5 sum msgs/h 1 total rcpts 2463 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, FSL_RCVD_USER=0.001,T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: B7D348A6CA726FEF9A0D2CA755E2031B1DF77F6C
X-UiO-SPAM-Test: remote_host: 129.240.4.215 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 110 total 2418873 max/h 641 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199728>

 On Mon, 11 Jun 2012 14:34:14 -0400, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 11, 2012 at 01:27:32PM -0400, Ted Ts'o wrote:
>> So depending on how you would want to do the comparison, probably 
>> the
>> fairest thing to say is that I had a total "good" packs totally 
>> about
>> 16 megs, and the loose cruft objects was an additional 4.5 
>> megabytes.
>
> OK, so that 4.5 is at least a respectable percentage of the total 
> repo
> size. I suspect it may be worse for small repos in that sense, (...)

 'git gc' gave a 3100% increase with my example:

     $ git clone --bare --branch linux-overhaul-20010122 \
         git://git.savannah.gnu.org/config.git
     $ cd config.git/
     $ git tag -d `git tag`; git branch -D master
     $ du -s objects
     624     objects
     $ git gc
     $ du -s objects
     19840   objects

 Basically: Clone/fetch a repo, keep a small part of it, drop the
 rest, and gc.  Gc explodes all the objects you no longer want.

 This hits you hard if your small project tracks a big one, and
 later ceases doing so.  Maybe your project is to convert a small
 part of the remote into a library, or you're just tracking a few
 files from the remote - e.g. from the GNU Config repo.

 Not something one does every day, but it does happen.
 Tweaks to expiration time etc do not help here.

 Hallvard
