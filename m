From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find the next tag on a given branch
Date: Thu, 09 Sep 2010 18:12:28 +0200
Message-ID: <4C89076C.2040308@gmail.com>
References: <20100909052841.GA16722@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Sep 09 18:12:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otjjv-0006EW-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 18:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab0IIQMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 12:12:35 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38777 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0IIQMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 12:12:34 -0400
Received: by ewy23 with SMTP id 23so989016ewy.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=1aTdPcEOIGh+cnVqIcDIHwlgFDjJ36BqlmcIgnpQ6Kc=;
        b=dw3cj6sISM4GYzQzQBONrzjk6hOKEyH744tWfUvn5/rAWiQbOCnG7uJDOF+ucP+LA7
         yK79ReSF5pq/4e992Zsqz7GutEs94mUw4Bkoblnng5Kbuhnip82RUTDD8V5nUXYjz7Hz
         /MlNn+A4sgARHN93Lk7OC/Zfn52m7A9O6Z+Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=ix+Bv9fGnAuuQVLtWVumBjQX6P5U+KZVfbz6frld2UocW0AybVDsHlARpv/IPqzC1t
         YAgdRczdEeKjyH45L+2/VpnqaBXIqs6i3uC1SMIo2xpumKbQwia+gzoMH3EoXnEr5w5b
         8ACfT9IhplDCsti/7kwEfC5+6HMg2DsvKcfeU=
Received: by 10.213.101.13 with SMTP id a13mr99575ebo.44.1284048752873;
        Thu, 09 Sep 2010 09:12:32 -0700 (PDT)
Received: from [172.19.43.221] (ip-94-42-26-180.multimo.pl [94.42.26.180])
        by mx.google.com with ESMTPS id z55sm2236566eeh.9.2010.09.09.09.12.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 09:12:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <20100909052841.GA16722@fishbowl.rw.madduck.net>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155864>

On 09/09/10 07:28, martin f krafft wrote:
> I want to find the next tag (the tag following a commit), but
> require that it lie on a given branch. Alternatively, a filter

> The way Debian packages are (mostly) maintained in Git is that
> there are at least an upstream and a Debian branch (usually
> "master"). master branched off upstream, and upstream is merged into
> master at regular intervals. Whenever a Debian release is made, the
> corresponding branch is tagged.
> 
> If I run
> 
>   git describe --contains mycommitish
> 
> it prints the next tag, which is usually upstream's tag, which is
> not quite what I want (it's usually enough for me to figure it out,
> but this is Git and so I should be able to do even better! ;\) )
> 
> I would like to have it continue the search until it reaches the
> master branch. For instance, a command like
> 
>   git describe --contains mycommit --on-branch master

It's not that simple, as 'mycommit', once merged, /is/ technically part
of master.

If 'upstream' contains just imports, ie has no merges whatsoever, like
eg git://git.debian.org/collab-maint/batmand.git, you could use something
like this: 

$ git rev-list --ancestry-path --merges mycommit..master | xargs -n1 git describe --contains

(this doesn't catch the very first initial import (and release tag),
 but that case isn't very interesting anyway)


With a more complicated history, with many merges, you'd have to
do something more like

1) git rev-list --ancestry-path --merges mycommit..master
2) filter out all the merge ids from this list that are reachable from
   'upstream'
3) git describe --contains 

Easily scriptable, but i don't see a way to express the 2nd step
in pure git-speak right now. [1] Is there a way?

Or you could just extend 'git describe --contains' to take another
optional ref, check if the object pointed to by the tag that it finds
is reachable from that ref, and skip this tag if yes.
Then you could do `git describe --contains mycommit --skip upstream`. ;)

artur

[1] iff i got it right. Consider history such as:
               
         ...-> c
                \    
upstream -> C -> m -> c ----> ... ---> c ---> upstream
                       \                \
master   -------------> M -> m -> ... -> m -> master
                            /
         ... ------------> c

Asking for a released 'C' must result in 'M'. 
(Merging 'master' into 'upstream' must not happen, obviously)
