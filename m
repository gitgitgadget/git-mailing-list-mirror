From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Creating empty commits with --intent-to-add
Date: Sun, 5 Jun 2016 21:02:07 +0200
Message-ID: <fefa95d8-f1ef-5007-ad99-a26b01471243@virtuell-zuhause.de>
References: <fdf86f73-0885-7191-2932-f10feba0bdfc@virtuell-zuhause.de>
 <CACsJy8A8-RgpYxYsJBaLrMia7D3DfQPr4cxASNsaLyCnmgm3ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 21:02:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9dJP-0006cC-TK
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 21:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbcFETCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 15:02:12 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:35833 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169AbcFETCL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 15:02:11 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1b9dJI-0005ab-N4; Sun, 05 Jun 2016 21:02:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <CACsJy8A8-RgpYxYsJBaLrMia7D3DfQPr4cxASNsaLyCnmgm3ZQ@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465153331;4a4d7cd2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296478>

Am 05.06.2016 um 05:15 schrieb Duy Nguyen:
> On Sun, Jun 5, 2016 at 12:54 AM, Thomas Braun
> <thomas.braun@virtuell-zuhause.de> wrote:
>> Hi,
>>
>> the following procedure
>>
>> mkdir test
>> cd test
>> git init
>> echo 1 >file
>> git add --intent-to-add file
>> git commit -m "blurb"
>>
>> results in a commit. I would have expected that git commit complains,
>> as I have not pased the --allow-empty option.
>>
>> Is that intended behaviour?
> 
> It's a bug. I'll get to it very soon.

Thanks for looking into that!

Encouraged by your statement I've done some bisecting via

#!/bin/sh

git=../git/git
( make -j10 git >/dev/null || exit 125 ) &&
cd .. &&
rm -rf test &&
mkdir test &&
cd test &&
$git init &&
echo 1>file &&
$git add --intent-to-add file  &&
$git commit -m "blurb"  &&
exit 1

exit 0

and found 3f6d56de (commit: ignore intent-to-add entries instead of refusing, 2012-02-07)
as first "bad" commit.

This commit states

#################
commit: ignore intent-to-add entries instead of refusing

Originally, "git add -N" was introduced to help users from forgetting to
add new files to the index before they ran "git commit -a".  As an attempt
to help them further so that they do not forget to say "-a", "git commit"
to commit the index as-is was taught to error out, reminding the user that
they may have forgotten to add the final contents of the paths before
running the command.

This turned out to be a false "safety" that is useless.  If the user made
changes to already tracked paths and paths added with "git add -N", and
then ran "git add" to register the final contents of the paths added with
"git add -N", "git commit" will happily create a commit out of the index,
without including the local changes made to the already tracked paths. It
was not a useful "safety" measure to prevent "forgetful" mistakes from
happening.

It turns out that this behaviour is not just a useless false "safety", but
actively hurts use cases of "git add -N" that were discovered later and
have become popular, namely, to tell Git to be aware of these paths added
by "git add -N", so that commands like "git status" and "git diff" would
include them in their output, even though the user is not interested in
including them in the next commit they are going to make.

Fix this ancient UI mistake, and instead make a commit from the index
ignoring the paths added by "git add -N" without adding real contents.
#################
