From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 7 Oct 2007 10:41:26 -0500
Message-ID: <20071007154126.GD5642@mediacenter.austin.rr.com>
References: <1191719841666-git-send-email-shawn.bohrer@gmail.com> <alpine.LFD.0.999.0710061827010.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, frank@lichtenheld.de, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 17:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYFA-0004aW-E7
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 17:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXJGPkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 11:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbXJGPkZ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 11:40:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:62852 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXJGPkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 11:40:24 -0400
Received: by wr-out-0506.google.com with SMTP id 36so519135wra
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=Wfym/V4vlsUFx3IZjBWaXgWM18YxF08xX7XRnIiT1Hk=;
        b=b1Fji6PCK9enl4MDzlTzZAODvcPmSoYDMa1Xofd/lujE37kfFxvTt64hRP7LoxyjuW1ugCo77NBmvop2ztQHo9hn+wD9/NVMr3DTAsEKp6bbY2P/p5DOzXBulKm5GmKKdX+B9beyObp5lo0Sa2DDuSdJRXOhdz83A6XQzoMUA9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lyIz3+6lxteiPO1Z93tAwdosIPrlY+uNjGcCMpITkZwkiwkx7IQPX84TsDRzEuxj80bhDmqHFVVnm8tCPsJWhl+Ymth4odbwWTuaaH2Ri92vkBf54HH6gODRifZZNT9ye3ksHlT2/I6frwsxZ1+A9D3L5k2oDL1oMkR0G9myvx0=
Received: by 10.150.153.19 with SMTP id a19mr747059ybe.1191771622203;
        Sun, 07 Oct 2007 08:40:22 -0700 (PDT)
Received: from mediacenter.austin.rr.com ( [70.112.123.114])
        by mx.google.com with ESMTPS id 61sm6405022wry.2007.10.07.08.40.19
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Oct 2007 08:40:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710061827010.23684@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60185>

Thanks for the input.

On Sat, Oct 06, 2007 at 06:31:36PM -0700, Linus Torvalds wrote:
> This looks better, but I think you'd be even better off actually using the 
> "read_directory()" interface directly, instead of exec'ing off "git 
> ls-files" and parsing the line output.

Perhaps, I'll take a look at how git-ls-files does it and see if I can
do that directly.  Since I'm new to git (and C) it will probably take me
a while to re-implement though.

> I also would still worry a bit about 'chdir(x)' and 'chdir("..")', because 
> quite frankly, they are *not* mirrors of each other (think symlinks, but 
> also error behaviour due to directories that might be non-executable). 
> Now, admittedly, if a directory isn't executable, I can imagine other git 
> things having problems (anybody want to test?), but that whole pattern is 
> just very fragile and not very reliable.

Yes it does seem fragile, but 'chdir("-")' doesn't work in C and I
couldn't find any equivalents.  I actually did think about symlinks, and
my code does do the right thing since I test if it is a directory before
doing the 'chdir(x)'. Symlinks are therefore treated as normal files and
removed.

I did not think about non-executable directories, and you are correct
that my code will fail to remove a directory if it is non-executable. I
also tested a git-ls-files with non-executable directories, and it will
fail to show you any files that are more than one level deep for
example:

|-- docs
|   |-- contributing
|   |   `-- patches.txt
|   `-- manual.txt

If docs is non-executable it will only return 'docs/manual.txt'

--
Shawn
