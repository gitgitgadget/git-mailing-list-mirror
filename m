From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Porting to old zlib (deflateBound) & old mktemp (e.g., Red Hat Linux
 9)
Date: Thu, 21 Apr 2005 19:27:57 -0400
Message-ID: <426836FD.8070708@dwheeler.com>
References: <4267E0A4.40506@austin.ibm.com> <20050421102552.544c70fd.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jschopp@austin.ibm.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 01:23:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOl1J-0005GO-It
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVDUX2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 19:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDUX2H
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 19:28:07 -0400
Received: from cujo.runbox.com ([193.71.199.138]:9112 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261682AbVDUX2B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 19:28:01 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DOl5Q-0000go-4N; Fri, 22 Apr 2005 01:27:56 +0200
Received: from [129.246.254.211] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DOl5P-00068S-Pr; Fri, 22 Apr 2005 01:27:56 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <20050421102552.544c70fd.rddunlap@osdl.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Apr 2005 12:19:32 -0500 Joel Schopp wrote:

>| I downloaded git-pasky 0.6.2.  I cannot compile it because my zlib 
>| version is 1.1.4 and git-pasky relies on function deflateBound() which 
>| wasn't introduced until zlib version 1.2.x  Is there a patch out there 
>| to work around this and maybe conditionally compile based on the zlib 
>| version?
>  
>
Here's a quick (read: nasty, dreadful) hack to port git
to older systems like Red Hat Linux 9 which have old versions
of zlib & mktemp. Someone who actually spent two seconds
on this can no doubt give you a better solution, but it "worked for me".

Edit sha1_file.c, and change the line:
 size = deflateBound(&stream, len);
to
 size = len + 1024; /* 1024=emergency extra space */
The "deflateBound" call just finds out the maximum amount of allocation 
space.
The documentation says that "deflateBound() may return a
conservative value that may be larger than /sourceLen/" in certain cases,
which worried me. So to be safe I just added a big pile of excess space 
to "len";
I suspect that "size = len" is sufficient but I didn't investigate it.

If you're trying to get this to work on Red Hat Linux 9, you'll
have another problem too: old versions of "mktemp"
don't support the "-t" option. Other old distributions will
have the same problem.  To find these cases, do:
 grep "mktemp.*-t" *
and edit all the files to remove the "-t" option from mktemp.
That's the bare minimum to make it work; a much
cleaner solution would to specify the tempdir, e.g.,:
 mktemp ${TMPDIR:-/tmp/}gitci.XXXXX
or even more portably, write the shell code to set TMPDIR to "/tmp"
locally if it's not set, then use $TMPDIR everywhere.

Not a good final solution, but enough to get started in the interim.
In long term, this should be made more portable, but it's
only ~2 weeks old after all.  Some people are trying to fly this plane
to transport a buffalo herd, while others are working to attach the 
wings :-).

--- David A. Wheeler

