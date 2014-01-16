From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Thu, 16 Jan 2014 08:08:33 -0500
Message-ID: <20140116130833.GA15613@padd.com>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me>
 <20140114001820.GA12058@padd.com>
 <20140114232432.GA31465@padd.com>
 <843E4B24-5EDD-4451-8849-425160576A99@iwi.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Damien =?iso-8859-1?Q?G=E9rard?= <damien@iwi.me>
X-From: git-owner@vger.kernel.org Thu Jan 16 14:08:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3mgd-0007Xw-JV
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 14:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbaAPNIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 08:08:39 -0500
Received: from honk.padd.com ([74.3.171.149]:51311 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbaAPNIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 08:08:39 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id F3E4C70C6;
	Thu, 16 Jan 2014 05:08:37 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D305120082; Thu, 16 Jan 2014 08:08:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <843E4B24-5EDD-4451-8849-425160576A99@iwi.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240512>

damien@iwi.me wrote on Wed, 15 Jan 2014 09:56 +0100:
> p4 fstat  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h@59702 
> ... depotFile //depot/openssl/0.9.8j/openssl/include/openssl/bn.h
> ... headAction edit
> ... headType symlink
> ... headTime 1237906419
> ... headRev 2
> ... headChange 59702
> ... headModTime 1231329423
> 
> p4 print -q //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 | od -c
> 0000000
> 
> p4 print  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#1        
> //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#1 - add change 59574 (text)
>  p4 print  //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2
> //depot/openssl/0.9.8j/openssl/include/openssl/bn.h#2 - edit change 59702 (symlink)

That's interesting.  When I do the equivalent "p4 print" commands
it shows something like this.

arf-git-test$ p4 fstat //depot/bn.h
... depotFile //depot/bn.h
... clientFile /dev/shm/trash directory.t9802-git-p4-filetype/cli/bn.h
... isMapped 
... headAction edit
... headType symlink
... headTime 1389876870
... headRev 2
... headChange 8
... headModTime 1389876870
... haveRev 2

arf-git-test$ p4 print //depot/bn.h#1
//depot/bn.h#1 - add change 7 (text)
file-text

arf-git-test$ p4 print //depot/bn.h#2
//depot/bn.h#2 - edit change 8 (symlink)
/elsewhere/bn.h

I don't know how you manage to get a symlink with an empty
destination like that.

I'll work on a way to hack around this failure.  In the mean time,
if you're game, it might be fun to see what p4 does with such a
repository.  You could make a client for just that little subdir,
check out at 59702 and see what is there:

mkdir testmess
cd testmess
cat <<EOF | p4 client -i
Client: testmess
Description: testmess
Root: $(pwd)
View: //depot/openssl/0.9.8j/openssl/include/openssl/... //testmess/...
EOF

then take a look at how p4 represents the "empty" symlink
in the filesystem:

p4 sync @59702
ls -la bn.h

		-- Pete
