From: Adam Heath <doogie@brainfood.com>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 17:35:27 -0500
Message-ID: <49C9602F.2000306@brainfood.com>
References: <49C7FAB3.7080301@brainfood.com> <49C8A102.6090408@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFFT-0002dv-R4
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbZCXWfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 18:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbZCXWff
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:35:35 -0400
Received: from newmail.brainfood.com ([70.103.162.5]:33166 "EHLO
	newmail.brainfood.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZCXWfd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:35:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by newmail.brainfood.com (Postfix) with ESMTP id 01366F89C3;
	Tue, 24 Mar 2009 17:35:32 -0500 (CDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.101
X-Spam-Level: 
X-Spam-Status: No, score=0.101 tagged_above=-10 required=6.6
	tests=[BAYES_50=0.001, RDNS_DYNAMIC=0.1]
Received: from newmail.brainfood.com ([127.0.0.1])
	by localhost (newmail.brainfood.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUbFU5DtNAz9; Tue, 24 Mar 2009 17:35:28 -0500 (CDT)
Received: from [192.168.2.49] (70-103-162-249.brainfood.com [70.103.162.249])
	by newmail.brainfood.com (Postfix) with ESMTP id F2C9BF89C2;
	Tue, 24 Mar 2009 17:35:27 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <49C8A102.6090408@op5.se>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114504>

Andreas Ericsson wrote:
> First of all, I'm going to hint that you would be far better off
> keeping the media files in a separate repository, linked in as a
> submodule in git and with tweaked configuration settings with the
> specific aim of handling huge files.

Already do that.  We have a custom overlay/union-type filesystem, that
makes use of a small base directory, where code resides, then each
sub-website is where the content is.

It's just finding documentation thru google that describes the
workflow we are doing is difficult.

> The basis of such a repository is probably the following config
> settings, since media files very rarely compress enough to be
> worth the effort, and their own compressed formats make them
> very unsuitable delta candidates:
> [pack]
>   # disable delta-based packing
>   depth = 1
>   # disable compression
>   compression = 0
> 
> [gc]
>   # don't auto-pack, ever
>   auto = 0
>   # never automatically consolidate un-.keep'd packs
>   autopacklimit = 0

Thanks for the pointers!

> You will have to manually repack this repository from time to
> time, and it's almost certainly a good idea to mark the
> resulting packs with .keep to avoid copying tons of data.
> When packs are being created, objects can be copied from
> existing packs, and send-pack will make use of that so that what
> goes over the wire will simply be copied from the existing packs.
> 
> YMMV. If you do come up with settings that work fine for huge
> repos made up of mostly media files, please share your findings.

I'll use these as a basis.

>> So, to work around that, I ran git gc.  When done, I discovered that
>> git repacked the *entire* repository.  While not something I care for,
>> I can understand that, and live with it.  It just took *hours* to do so.
>>
> 
> I'm not sure what, if any, magic "git gc" applies before spawning
> "git repack", but running "git repack" directly would almost certainly
> have produced an incremental pack. Perhaps we need to make gc less
> magic.

The repo should only be converted into a single .pack, if the user
explicitily wants it.  Any automatic gc call, or called without args,
should just take any loose objects and pack them up.  But that's my
opinion.

> Not necessarily all that simple (we do not want to touch the ssh
> password if we can possibly avoid it, but the user shouldn't have
> to type it more than once), but certainly doable. Easier would
> probably be to recommend adding the proper SSH config variables,
> as has been stated elsewhere.

ssh-agent, or password-less anonymous ssh(I've got a custom login
script inside authorized_keys on the remote).

> See above. I *think* you can also do this with git-attributes, but
> I'm not sure. However, keeping the large media files in a sub-module
> would nicely solve that problem anyway, and is probably a good idea
> even with git-attributes support for pack delta- and compression
> settings.

The site would *still* be > 25G in size, at the least, and constantly
getting bigger.  This site contains copies of ad videos from their
competitors, plus their own, and is used to market their international
company.

> http://www.thousandparsec.net/~tim/media+git.pdf probably holds all the
> relevant information when it comes to storing large media files with
> git. I have not checked and have no inclination to do so.

http://caca.zoy.org/wiki/git-bigfiles is another one.
