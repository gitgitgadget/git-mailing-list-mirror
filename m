From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 20:17:42 +0400
Message-ID: <20080416161742.GC3133@dpotapov.dyndns.org>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com> <4805FD7C.5000206@viscovery.net> <20080416142551.GB3133@dpotapov.dyndns.org> <48061388.6090705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:37:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmALN-0003Bi-5m
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 18:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762361AbYDPQRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 12:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761990AbYDPQRt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 12:17:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:36364 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761977AbYDPQRs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 12:17:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so959385ugc.16
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=2Itck1L6LwnNEgUgLRH9BFbVCSobxOzw86qTqgBwNbk=;
        b=a4No99VE3qFdA+PmOvVxM0MjRsgP1dY0QmikoD60soalCeta+XADmP34c6lEoPmfinaTG7JhtKWUlbfGBv2JYmSxM59oHleQxmA/FVBFDZQSQj8WNTHkNPJo7CWcWJs0k1oJ+YE7K5t/QWulfXy+b92GEb5GnYaHZzY7bbon14w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=mYvsS4ulSjjIrH98RtgtBevRlguxjFhUzkcrfrxGt6ldlGJHhNyJNE5HKdcI1BlO1FfggsrqB0bx1dBSi9Hoshj20BbSqdkfXcDj6XggkkbuRTpWI/rOOqtDGcWh+YYJAGLO6R0tJcRRosh1V3e4klz7uD7r1M3rI+5Qj+B0dPE=
Received: by 10.78.137.14 with SMTP id k14mr319214hud.103.1208362666217;
        Wed, 16 Apr 2008 09:17:46 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id d25sm13870439nfh.33.2008.04.16.09.17.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 09:17:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48061388.6090705@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79716>

On Wed, Apr 16, 2008 at 04:56:08PM +0200, Johannes Sixt wrote:
> 
> No. The reason why git clone'd repositories have problems is that
> git-upload-pack sends a pack that does not contain the hidden objects; but
> since the cloned repository doesn't have the info/grafts, it tries to look
> up the hidden, now missing, objects, and fails.

In my experiment, there was no problem with hidden commits and objects
as long as they presented in the original repository. Maybe, it is
because I cloned it as locally using:

   git clone PATH-TO-ORIG-REPO PATH-TO-DEST-REPO

Maybe things would be as you say if I used git://

> 
> Actually, no. The trouble is that *all* tools obey grafts. Hence,
> git-repack -f -d -a will remove the hidden objects. But a subsequent fsck
> won't notice, because it *also* obeys the grafts. git prune will remove
> hidden objects only as long as they are loose; if they are already packed,
> then only a repack -f will remove them.

I use git 1.5.5 and I have a script that creates are repo with a hidden
commit and then it cleans the reflog cleaned (as it would be happen after
expiration of gc.reflogExpire). Then I run 'git-repack -f -d -a' and the
hidden commit still presents, but when I run 'git prune' then the hidden
object disappear. You can try it for yourself. Here is the script, I used:

===
#!/bin/sh

set -e

mkdir t5
cd t5
git init

echo 1 > foo
git add foo
git commit -m 'add foo'
R1=$(git rev-parse HEAD)

echo 2 >> foo
git commit -m 'edit foo' -a
R2=$(git rev-parse HEAD)

echo 3 >> foo
git commit -m 'edit foo again' -a
R3=$(git rev-parse HEAD)

set -x
git log
echo "$R3 $R1" > .git/info/grafts
git log
git-fsck --unreachable
: > .git/logs/HEAD
: > .git/logs/refs/heads/master
git-fsck --unreachable
git gc
git-fsck --unreachable


git-repack -f -d -a
git-fsck --unreachable

git prune
git-fsck --unreachable
===

Dmitry
