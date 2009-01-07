From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Wed, 7 Jan 2009 09:26:10 +0100
Message-ID: <c09652430901070026m6ca0ec98ndc7483aac8dfde89@mail.gmail.com>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 09:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKTlI-0003DX-2d
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 09:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbZAGI0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 03:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZAGI0N
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 03:26:13 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:53269 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZAGI0M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 03:26:12 -0500
Received: by bwz14 with SMTP id 14so25143312bwz.13
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 00:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=a7o3jS/gTy837kZEmVL0kB1p//opNGCMQiVo1mM40hM=;
        b=mwI9JR2UaQFtLUgJKaC/n14lTlJ4kIjvrt4CNyIzR/S9sFpCHQG6UCvxogkyaRupvr
         CMy0qAOCd7tvIzEKwFXaXrjfQt/uOJW6duJl8SDdtn+M+dUBVfylQdqSfv7metTE2239
         8Mjn0HY0P5fHdxnA4T9d9Q2llG36zcqFqSQ0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=DuyVbqZNLrVzIZCfxQDXB39MNw7y2LbJDOv3fB/j4BjQxE7dDrnxLlKYhhSW8zY8Rg
         SCl3Z4QFMwAQXPPG6tPuc08joSz1DTrC/DYi4fvG9LKxk2H6FxKjgYY3u4IYOO9pQ4J+
         2xQ305UvWMRiAf85y3bz70iNIwnFH8BCU20wc=
Received: by 10.223.107.9 with SMTP id z9mr16198310fao.1.1231316770110;
        Wed, 07 Jan 2009 00:26:10 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Wed, 7 Jan 2009 00:26:10 -0800 (PST)
In-Reply-To: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 7429ae594293c063
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104774>

Here is a summary of the solution I used. I'm a beginner in git
and just summarizing what others told me and what I did. Use at
your own risk!

1. Remove anything you know should be removed, e.g.:

git filter-branch --tree-filter 'find . -regex ".*toolchain\..*" -exec
rm -f {} \;' HEAD

2. Expire the log:

git reflog expire --all

3. Delete stuff from .git that should be manually "verified" to be
correct. I don't actually
know how to "verify" that at this point... Use backups Luke!

rm -rf .git/refs/original
# delete lines w/"refs/original" from .git/packed-refs
vi .git/packed-refs
# for good measure...
git reflog expire --all
git gc

4. Your repository is still huge. By creating a new repository and pull=
ing from
this one, the garbage will stay in the old one...

mkdir newrep
cd newrep
git init
git pull file:///oldrep

5. Check size of .git. If it is still too big, try figuring out which
files that are big by looking at the packs(.git/objects/pack/xxx):

$ git verify-pack -v $PACK | grep -v "^chain " | sort -n -k 4

and then for the last few lines do a

$ git rev-list --all --objects | grep $SHA1

6. Go back to #1 until done.

Your repository should now be of reasonable size...

I've found some great scripts for converting from svn/cvs, but really
the above procedure
is necessary to run when converting nasty old repositories...

--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
