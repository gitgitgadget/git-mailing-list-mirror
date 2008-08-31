From: David Greaves <david@dgreaves.com>
Subject: [Regression] Re: setlocalversion wasn't producing git labels for
 bisect
Date: Sun, 31 Aug 2008 11:15:01 +0100
Message-ID: <48BA6F25.8040102@dgreaves.com>
References: <48B9A2C7.3080001@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki"
X-From: git-owner@vger.kernel.org Sun Aug 31 12:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZjyo-0006sl-BO
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 12:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbYHaKPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 06:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYHaKPH
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 06:15:07 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:56339 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859AbYHaKPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 06:15:05 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 70585DEC8D;
	Sun, 31 Aug 2008 11:15:06 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id TGGX98RM9KnR; Sun, 31 Aug 2008 09:32:41 +0100 (BST)
Received: from elm.dgreaves.com (78-32-229-233.no-dns-yet.enta.net [78.32.229.233])
	by mail.ukfsn.org (Postfix) with ESMTP id 14814DEC74;
	Sun, 31 Aug 2008 11:15:06 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by elm.dgreaves.com with esmtp (Exim 4.62)
	(envelope-from <david@dgreaves.com>)
	id 1KZjxW-0007J1-Ew; Sun, 31 Aug 2008 11:15:02 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48B9A2C7.3080001@dgreaves.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94472>

David Greaves wrote:

> Trying to do a bisect with git version 1.5.6.3 didn't work with the setlocalversion script
>
> Running
>   git name-rev --tags HEAD
> gives the output
>   HEAD tags/v2.6.27-rc4~44^2
>
> This isn't matched by setlocalversion regexp so it makes it harder to make deb-pkg/install/grub/reboot/remove
>
> Of course if this patch is accepted it is going to make life complicated when bisecting around it.
> Maybe git should behave as the man page suggests and have the ^X before the ~nnn? (maybe it has been fixed already)
>   http://www.kernel.org/pub/software/scm/git/docs/v1.5.6.5/git-name-rev.html
> shows an example:
>   33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99^0~940
OK, I apologise if I'm being dim.
I use git to get source for all my kernels on all my various machines. Rather than have them all pull from kernel.org I have a local mirror setup that also merges in the stable branches so I can get any tag without hitting the WAN.

When I do

cd /usr/src/linux-git/

git reset --hard v2.6.27-rc5

git bisect start

git bisect bad v2.6.27-rc4

git bisect good v2.6.27-rc3
zcat /proc/config.gz > .config

make oldconfig

make include/config/kernel.release

$ cat include/config/kernel.release
2.6.27-rc3

I think this should be a -git<nnnnn>

OK I have just done a fresh clone and tried it on that - it's nothing to do with my merged setup. I've also asked on irc and someone else had the problem too.

So now I think setlocalversion should be (at least)
+    if git name-rev --tags HEAD | grep -E '^HEAD[[:space:]]+(.*[0-9^~]*|undefined)$' > /dev/null; then

I'm cc'ing the git group since I suspect this is to do with branches or rebases or something arcane and it would be good to get the regexp right.
The git-rev-parse manpage talks about many other formats but it's not easy to see which are valid input and which are possible output.
I also wondered about using git rev-parse in the script but I'm not sure.
 [ -z `git tag -l \`git name-rev --name-only --tags HEAD\`` ]
sprang to mind but I'm still getting ^0 on the end of name-rev in 1.5.6.3 and of course older git versions won't work.


In any case I think bisecting using localversion is broken around this point... I'll get on it manually for the actual bug I've got :)

David
