From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Thu, 31 May 2007 02:17:30 +0200
Message-ID: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
References: <1180385483418-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 31 02:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtYMG-0002BS-6h
	for gcvg-git@gmane.org; Thu, 31 May 2007 02:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbXEaARd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 20:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbXEaARc
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 20:17:32 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:40853 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbXEaARc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 20:17:32 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1700500nzf
        for <git@vger.kernel.org>; Wed, 30 May 2007 17:17:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M8tHcGstUJ2AV+/KFquuxbHI8q20RgFPaFKVMg0QvPEr3tWCQ+peBRKz346S1hUE6uBih3aYibE5BxklAEtTVLGEOPUJp2vir3QRksNEYHFB4BwjdweMr37ADqnXYKmentXl6Omqyjaxd5k6fkZtrqziIC5yWrmZJv134uxlW8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n2sGqr1S/MSmy58HX/Xax34X3SJeaHZACzAz5xjU8GFJTQqJp1IjVfTHH3LOTTQggFkvahMZm2sCDdhTa3xku9coZZClIPKLsOrMLGfqGbv/sxPrjEqrqOWSe/S5p1kvgfurCdWa+jqsPX0zhVknscLjmgY/D4NtysFk7+Wq1PQ=
Received: by 10.114.111.1 with SMTP id j1mr12154wac.1180570650210;
        Wed, 30 May 2007 17:17:30 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 30 May 2007 17:17:30 -0700 (PDT)
In-Reply-To: <1180385483418-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48790>

On 5/28/07, Lars Hjemli <hjemli@gmail.com> wrote:
> This changes git-submodule in a few ways:

Please don't apply the "Let .git/config specify the url for
submodules" patch, I'm having second thoughts ;-)

Your design outline in
http://article.gmane.org/gmane.comp.version-control.git/48287 is
obviously superior, and I'd like to take a stab at it with something
like this:

1. 'git-submodule init' saves submodule name and suggested url from
.gitmodules into .git/config (submodule.$name.url)

2. 'git-submodule update' keeps the work tree updated for submodules
with five separate (and optional) operations:
  a) git-clone --bare $url .git/submodules/$name.git
  b) git-clone -l -s .git/submodules/$name.git $path
  c) cd .git/submodules/$name.git && git-fetch
  d) cd $path && git-fetch
  e) cd $path && git-checkout $sha1

3) 'git-submodule push' runs something like 'cd $path && git push
origin $branch', where $branch is found in .gitmodules
(path.$path.branch).

A remaining issue is how to detect if step 2b is necessary if a
submodule is already checked out at the submodule path, but I guess
remote.origin.url in the checked out submodule would be the thing to
peek into.

Also, step 2c/2d should obviously only be performed if the requested
sha1 isn't available, which should be trivial to detect with
'git-cat-file -e'.

Could this turn out to be an acceptable solution?

--
larsh
