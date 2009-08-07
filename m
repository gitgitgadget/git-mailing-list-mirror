From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Problem running 'make install' as root when on mounted fs
Date: Fri, 7 Aug 2009 11:08:24 +0100
Message-ID: <8F9F4A8A-9515-4A7D-90EE-4BD3DA3F7A2B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 12:08:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZMNO-0007td-7R
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 12:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944AbZHGKI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 06:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbZHGKI3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 06:08:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:19506 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZHGKI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 06:08:28 -0400
Received: by ey-out-2122.google.com with SMTP id 9so493169eyd.37
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=65K7dwaD80KbS5mLXsts1XonxtXQBDd8aM7wxUsza2I=;
        b=gBIRjgh05Y3WgcVDKphP6wGVE4eoHym5cLh9DoDhvvUGwRi0Vj7Z+PZDDeG1o1H9pD
         fTrtswcJCrodWDZtB83O/sPNpyRSfP/mltWIUxXYzBVI6mCMmdV+wUmplbmDCowzH4AZ
         Oh1ZLC5UdnM7W2SbzmzrXVLL+EkaVBh8sMBxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=KdiKZZq9oAxcCIUXMJABKwdW19kGdUaUrLKKBXcd3B12D7ommnatA2lSO04gSTpUDI
         ofX0qaQ9fiAREx7t8LKEQ0IWanZNE1GtBpA5PSd6PEp+xMJso2hljjvAK8D0x0O2LGUy
         YpJxnjNiFjkfs0GTrEQD58Kz6THB8NBiGP1lk=
Received: by 10.210.62.12 with SMTP id k12mr1194196eba.19.1249639708119;
        Fri, 07 Aug 2009 03:08:28 -0700 (PDT)
Received: from bigmac.int.bandlem.com (gateway.bandlem.com [217.155.97.59])
        by mx.google.com with ESMTPS id 5sm2412907eyf.18.2009.08.07.03.08.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 03:08:26 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125189>

I just tried building and installing Git on Mac OSX. My home directory  
is NFS mounted, to which I have write (but root doesn't).

When I do make, everything compiles OK
When I do sudo make install, I get '/bin/sh: GIT-BUILD-OPTIONS:  
permission denied'

It seems that make install is re-running the GIT-BUILD-OPTIONS target,  
and that tries to write to the current directory. In my case, on an  
NFS mounted home, root doesn't have write permissions to the local dir  
and so the install step fails.

I could build on a local partition (e.g. /tmp) but I'd prefer to have  
the code on my local drive so that I can do a git update and other  
such changes subsequently. I was able to get it to work by removing  
the echo>> from the GIT-BUILD-OPTIONS step after having built the code  
the first time.

The problem basically seems to be:

install: all
all:: ... GIT-BUILD-OPTIONS

I think it would be possible to restrict the GIT-BUILD-OPTIONS to be  
generated during a build phase, so restructuring the Makefile like:

install: build
all:: build GIT-BUILD-OPTIONS
build: ...

would then mean the install phase wouldn't have to touch the GIT-BUILD- 
OPTIONS step.

Does that sound reasonable? I'm happy to test it out and submit a  
patch if people agree (and/or have opinions on what the inner target  
'build' should be called)

Alex
