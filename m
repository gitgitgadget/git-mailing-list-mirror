From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 19:26:38 +0700
Message-ID: <CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
 <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
 <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
 <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com> <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 13:27:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYD49-0007Fk-RL
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 13:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbbCRM1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 08:27:12 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34987 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbbCRM1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 08:27:09 -0400
Received: by ieclw3 with SMTP id lw3so36357121iec.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SxQTxu3OCWXRDXH3e44Nc1nil30q+naPqn1ajXbxdSE=;
        b=Zmb4AnZyRvajAyPm7xSCum6ZO+ewXYYWLL9gVKIKQ89Vj8LqON+TD5464FJltbTWwP
         wz57xzYL1eziVX3VuvFed8YlEnPjWI0eABUocSphWc1kKrgJY3sfyFjXDNvGFij38AP1
         Vj4iJVP07Kr49WR9CwjCuSrQmv756zjsSwk7nkqSZD/CLWwLq0e/QFrg6MQ3ZWXSwYaL
         u9wcyY+4nvxsXQQ5z9YzYg7Q/uw1MMqJhx+79x2wpKUSpwB6W6EFqjTMx1/xLBR/URPn
         OFCEyc1xWos/zigzhvCX4fBfWCT5hK8SQZiNA4WihGvzcZYqs+q5SNgEXoNqhqjANqI/
         TugQ==
X-Received: by 10.42.82.199 with SMTP id e7mr87811809icl.18.1426681628696;
 Wed, 18 Mar 2015 05:27:08 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 05:26:38 -0700 (PDT)
In-Reply-To: <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265723>

On Wed, Mar 18, 2015 at 7:03 PM, Graham Hay <grahamrhay@gmail.com> wrote:
> Are there any commands that I can use to show exactly what it is trying to push?

It's a bit more than a command. If you push when GIT_TRACE is set to
2, you'll see it executes "git pack-objects" command with all its
arguments. This command expects some input from stdin. If you can
capture that, you can run it by yourself to create the exact pack that
is transferred over network. Run that pack through "git index-pack
--verify-stat" will show you SHA-1 of all sent objects.

It's quite a lot of work :) I created this script named "git" and put
it in $PATH to capture input for pack-objects. You'll need to update
"/path/to/real/git" to point to the real binary then you'll get
/tmp/stdin

-- 8< --
#!/bin/sh

if [ "$1" = pack-objects ]; then
exec tee /tmp/stdin | /path/to/real/git "$@"
else
exec /path/to/real/git "$@"
fi
-- 8< --

The remaining steps may be this (may need tweaking)

git pack-objects '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress' < /tmp/stdin | git index-pack
--fix-thin --stdin
pack    708538afeda8eb331858680e227f7713228ce782 <-- new pack
git verify-pack --verbose
.git/objects/pack/pack-708538afeda8eb331858680e227f7713228ce782.pack
d75631bd83ebdf03d4b0d925ff6734380f801fc6 commit 567 377 12
dd44100a7cdad113b23d31876e469b74fbe21e1b tree   15069 10492 389
8f4bbccea759d7a47616e29bd55b3f205b3615c2 tree   3869 2831 10881
3db0460935bc843a2a70a0e087222eec61a0ff0d blob   12379 3529 13712

Here we can see this push of mine sends four objects, 1 commit, 2
trees and 1 blob.
-- 
Duy
