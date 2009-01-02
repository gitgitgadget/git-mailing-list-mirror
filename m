From: david@lang.hm
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 15:01:20 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901021459480.21567@asgard.lang.hm>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> <20090102212655.GA24082@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIs4S-00083y-Hx
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779AbZABV7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758759AbZABV7F
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:59:05 -0500
Received: from mail.lang.hm ([64.81.33.126]:46138 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758114AbZABV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:59:03 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n02Lwwlv022953;
	Fri, 2 Jan 2009 13:58:58 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090102212655.GA24082@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104423>

On Fri, 2 Jan 2009, Jeff King wrote:

> The tricky thing here is what is "this line"? Using the line number
> isn't right, since it will change based on other content coming in and
> out of the file. You can keep drilling down by reblaming parent commits,
> but remember that each time you do that you are manually looking at the
> content and saying "Oh, this is the line I am still interested in." So I
> a script would have to correlate the old version and new version of the
> line and realize how to follow the "interesting" thing.
>
> In your case, I think you want to see any commit in Makefile which
> changed a line with SUBLEVEL in it. Which is maybe easiest done as:
>
>  git log -z -p Makefile |
>    perl -0ne 'print if /\n[+-]SUBLEVEL/' |
>    tr '\0' '\n'
>
> and is pretty fast. But obviously we're leveraging some content-specific
> knowledge about what's in the Makefile.

Ok, I hacked togeather a quick bash script to try this

#!/bin/bash
line=`git blame -L /$1/,+1 -M $2`
COMMIT=`echo $line |cut -f 1 -d " "`
foundline=`echo $line |cut -f 6 -d " "|sed s/")"//`
echo "$foundline $COMMIT"
echo "$line"
while [ "$COMMIT" != "" ] ;do
echo "git blame -L $foundline,+1 -M $2 $COMMIT^"
line=`git blame -L $foundline,+1 -M $2 $COMMIT^`
COMMIT=`echo $line |cut -f 1 -d " "`
foundline=`echo $line |cut -f 6 -d " "|sed s/")"//`
echo "$line"
done


the problem that this has is that line 3 of $COMMIT may not be line 3 of 
$COMMIT^, and if they aren't it ends up hunting down the wrong data

either that or I am not understanding the output of git blame properly 
(also very possible)

David Lang
