From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-add has gone lstat() mad
Date: Fri, 30 Mar 2007 21:20:22 +0100
Message-ID: <200703302120.23713.andyparkins@gmail.com>
References: <200703302055.13619.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 22:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXNd3-0000BE-BK
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 22:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbXC3UXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 16:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbXC3UXS
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 16:23:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:9125 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbXC3UXR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 16:23:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so927570uga
        for <git@vger.kernel.org>; Fri, 30 Mar 2007 13:23:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HnmfsStZ11ImQ8nJMYfOYlU59ErATu5h69paFM0wjx5cuKvalhxJLnTH3Nat89LMHFgBQp53WQEHqItfLbW70GYBPAp68TMZT36qCrx36UfhXgjxxqPavfflCdBj2QpTaJ0MkGZzFnt9LudwkpR60mmug4NrUA5Hyvn2wbrr2RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eqd3qrWbOokw2w/Lqfa7NVOnO420uCMFGSz7AsH6ySWNWLzg1S5uQppd5HqSTTI/ogKbhZSIazPnfN7HKq6cjplgpnuCQVxndqkomCeBCEZjDC2g1OejLUOAPwRK57OvhGBl9CxelBQiH8RHC6M758QIz8jIK2CDaFaAymXZ3JQ=
Received: by 10.66.237.9 with SMTP id k9mr2212817ugh.1175286194635;
        Fri, 30 Mar 2007 13:23:14 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm3670513ugd.2007.03.30.13.23.13;
        Fri, 30 Mar 2007 13:23:14 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200703302055.13619.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday 2007, March 30, Andy Parkins wrote:

> At this point the CPU pegs at 100% systime.  An strace shows that git
> is calling lstat64() on every file in my home directory.  I killed
> git before it scanned everything I've ever done.

Okay.  I've tracked down the culprit function, but I have no idea what 
the fix is.

builtin-add.c:fill_directory() calls
dir.c:read_directory() which calls
dir.c:read_directory_recursive()

I can't see why git feels that it has to recurse the entire subtree.  It 
seems to be something to do with the gitignore stuff.  Surely there is 
no need to use a recursive search when no directories are being added?

If git-add were given

 file1
 dir1/file2
 dir2/dir3/file3

Then only the directories "."; "dir1/"; "dir2"; and "dir2/dir3" need 
checking for .gitignore files; and in none of those cases does the 
search need to be recursive.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
