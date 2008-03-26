From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 0/7] Case-insensitive filesystem support, take 1
Date: Wed, 26 Mar 2008 05:46:09 +0300
Message-ID: <20080326024609.GL25381@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <20080325081409.GI25381@dpotapov.dyndns.org> <alpine.LFD.1.00.0803251347400.2775@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 03:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeLfG-0005ox-An
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 03:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbYCZCqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 22:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbYCZCqR
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 22:46:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:10081 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbYCZCqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 22:46:16 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3797982fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 19:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=UG//ollpExW5hLfu1UChKgjpv+kSs0FniNo+APwZib4=;
        b=PotnB4DIec//m78vMd7kEU5C7RQisvz3KHpVliRPsJW6xyWyaRytm0EljkvHyEZoAe9be00i/hvnqO2XpMbU0Of1aRLSUmEkC0fxLr2lJ8uqjCaQz5KprR2wol8bsf+Dqq7Cjs7wEUaTaXXUVMd/SEUCQ9eI8/ZkWLEgqfwUYSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rVVx0rmz3X4CLdV7xOeo5clCXS7iCuuRkAhnULqT2ljvYV4rXmJLdwiBXA/9rKq5qEoWc+jrhlV6xhsjZ93wgpt1glgo7h489Cuy5M2irLgk4hEfXxsQCN+Ow5Tj3W/27p5AgmLbPxaX2dWkvbLrnXfrxKWt43wLXC2RjI8+cSA=
Received: by 10.82.186.19 with SMTP id j19mr23079297buf.2.1206499574456;
        Tue, 25 Mar 2008 19:46:14 -0700 (PDT)
Received: from localhost ( [85.141.237.241])
        by mx.google.com with ESMTPS id e10sm11355150muf.10.2008.03.25.19.46.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Mar 2008 19:46:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803251347400.2775@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78245>

On Tue, Mar 25, 2008 at 02:04:58PM -0700, Linus Torvalds wrote:
> 
> IOW, all my case-insensitivity checking was very much designed to be about 
> the working tree, not about git internal representations. Put another way, 
> they should really only affect code that does "lstat()" to check whether 
> a file exists or code that does "open()" to open/create a file.

Of course, case-insensitivity is about the working tree only. But when
I merge another branch to the current one, git normally checks that it
is not going to overwrite existing files in the *work tree* and refuses
to do the merge if some files may be overwritten.

So if I work on a case-insensitive filesystem and have a file in a different
case and core.ignorecase=false, then the merge fails as expected!

But core.ignorecase=true, which is supposed to do a better job for case-
insensitive filesystems, actually causes the problem here.

Here is my test script:

====
mkdir git-test
cd git-test
git init
git config core.ignorecase true
echo foo > foo
git add foo
git commit -m 'initial commit'

git checkout -b other

echo file > file
git add file
git commit -m 'add file'

git checkout master
echo File > File
git add File
git commit -m 'add File'

# I expect merge to fail here... and it does fail if core.ignorecase
# is set to false, but with core.ignorecase = true, git will overwrite
# 'File'.
# git config core.ignorecase false
git merge other
===

Dmitry
