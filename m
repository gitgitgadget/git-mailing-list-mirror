From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git gc expanding packed data?
Date: Tue, 11 Aug 2009 11:17:14 +0100
Message-ID: <3ace41890908110317k6e6ada07jc39ea446f9fa246e@mail.gmail.com>
References: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
	 <alpine.LFD.2.00.0908042203380.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maqk9-0004ns-9R
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZHKMmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbZHKMmT
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:42:19 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56185 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbZHKMmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:42:15 -0400
Received: by ewy10 with SMTP id 10so3737240ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f7YMXGrDjH9z5oBJqyTn+bONemlf77yBmBgTL5qm8rA=;
        b=DAWmKvymbF2d2Qh5lZlMBqTHLHYzJY8MehgoKCoEyo4L/5uEdHMEYHMRX862Nm0kN/
         eHoAisy1vAr4gtSMrNtibNPz6/68hZo/WfadASIMXPQAbyYxRbUOwq69GER1slnf0y34
         o0wemXYVQe3h2tvzEjHcvYqLPddI00XXb19O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I2n3PEMmD3B/Dn8lFizoIKuaEgpLm9B13RL3lBayLJ1zTSJmjDrWJPQvoAlGxNVsef
         4fTdEFCaLmJW6yQEj2B4xE8GcZliRhvccThimYR3JWtjb7ozSNsgRkp8NBsfk9TzaKDO
         9XOjqrAmkns/o4v0PjAXs2ffrYMULKcihNcrM=
Received: by 10.216.10.149 with SMTP id 21mr1232721wev.56.1249985834967; Tue, 
	11 Aug 2009 03:17:14 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908042203380.16073@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125541>

On Wed, Aug 5, 2009 at 11:39 PM, Nicolas Pitre<nico@cam.org> wrote:
> On Tue, 4 Aug 2009, Hin-Tak Leung wrote:
>
>> I cloned gcc's git about a week ago to work on some problems I have
>> with gcc on minor platforms, just plain 'git clone
>> git://gcc.gnu.org/git/gcc.git gcc' .and ran gcc fetch about daily, and
>> 'git rebase origin' from time to time. I don't have local changes,
>> just following and monitoring what's going on in gcc. So after a week,
>> I thought I'd do a git gc . Then it goes very bizarre.
>>
>> Before I start 'git gc', .The whole of .git was about 700MB and
>> git/objects/pack was a bit under 600MB, with a few other directories
>> under .git/objects at 10's of K's and a few 30000-40000K's, and the
>> checkout was, well, the size of gcc source code. But after I started
>> git gc, the message stays in the 'counting objects' at about 900,000
>> for a long time, while a lot of directories under .git/objects/ gets a
>> bit large, and .git blows up to at least 7GB with a lot of small files
>> under .git/objects/*/, before seeing as I will run out of disk space,
>> I kill the whole lot and ran git clone again, since I don't have any
>> local change and there is nothing to lose.
>>
>> I am running git version 1.6.2.5 (fedora 11). Is there any reason why
>> 'git gc' does that?
>
> There is probably a reason, although a bad one for sure.
>
> Well... OK.
>
> It appears that the git installation serving clone requests for
> git://gcc.gnu.org/git/gcc.git generates lots of unreferenced objects. I
> just cloned it and the pack I was sent contains 1383356 objects (can be
> determined with 'git show-index < .git/objects/pack/*.idx | wc -l').
> However, there are only 978501 actually referenced objects in that
> cloned repository ( 'git rev-list --all --objects | wc -l').  That makes
> for 404855 useless objects in the cloned repository.
>
> Now git has a safety mechanism to _not_ delete unreferenced objects
> right away when running 'git gc'.  By default unreferenced objects are
> kept around for a period of 2 weeks.  This is to make it easy for you to
> recover accidentally deleted branches or commits, or to avoid a race
> where a just-created object in the process of being but not yet
> referenced could be deleted by a 'git gc' process running in parallel.
>
> So to give that grace period to packed but unreferenced objects, the
> repack process pushes those unreferenced objects out of the pack into
> their loose form so they can be aged and eventually pruned.  Objects
> becoming unreferenced are usually not that many though.  Having 404855
> unreferenced objects is quite a lot, and being sent those objects in the
> first place via a clone is stupid and a complete waste of network
> bandwidth.
>
> Anyone has an idea of the git version running on gcc.gnu.org?  It is
> certainly buggy and needs fixing.
>
> Anyway... To solve your problem, you simply need to run 'git gc' with
> the --prune=now argument to disable that grace period and get rid of
> those unreferenced objects right away (safe only if no other git
> activities are taking place at the same time which should be easy to
> ensure on a workstation).  The resulting .git/objects directory size
> will shrink to about 441 MB.  If the gcc.gnu.org git server was doing
> its job properly, the size of the clone transfer would also be
> significantly smaller, meaning around 414 MB instead of the current 600+
> MB.
>
> And BTW, using 'git gc --aggressive' with a later git version (or
> 'git repack -a -f -d --window=250 --depth=250') gives me a .git/objects
> directory size of 310 MB, meaning that the actual repository with all
> the trunk history is _smaller_ than the actual source checkout.  If that
> repository was properly repacked on the server, the clone data transfer
> would be 283 MB.  This is less than half the current clone transfer
> size.
>
>
> Nicolas
>

'git gc --prune=now' does work, but 'git gc --prune=now --aggressive'
(before) and 'git gc --aggressive' (after) both create very large
(>2GB; I stopped it) packs from the ~400MB-600MB packed objects. I
noted that you specifically wrote 'with a later git version' -
presumably there is a some sort of a known and fixed issue there? Just
curious.

I guess --aggressive doesn't always save space...

Hin-Tak
