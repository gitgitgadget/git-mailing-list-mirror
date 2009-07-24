From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 14:21:20 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
References: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org>
 <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 23:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSDK-0004cH-Nm
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZGXVVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbZGXVVy
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:21:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39872 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754130AbZGXVVx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 17:21:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6OLLKU1003684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Jul 2009 14:21:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6OLLK6C011311;
	Fri, 24 Jul 2009 14:21:20 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123946>



On Fri, 24 Jul 2009, Linus Torvalds wrote:
> 
> Never mind. I'm seeing even worse behavior on a laptop I just dug up 
> (another 4200 rpm harddisk).
> 
> I'll dig some more.

Yeah, it seems to be the loading overhead. I'm seeing a 'time git branch' 
take 1.2s in the cold-cache case, in a directory that isn't even a git 
directory.

And 80% of it comes before we even get to 'main()'. Shared library 
loading, SELinux crud etc. A lot of it seems to be 'libfreebl3' and 
'libselinux', which is some crazy sh*t.

It seems to be all from 'curl' support.

That seems _really_ sad. Lookie here:

   [torvalds@nehalem git]$ ldd git
	linux-vdso.so.1 =>  (0x00007fff61da7000)
	libcurl.so.4 => /usr/lib64/libcurl.so.4 (0x00007f2f1a498000)
	libz.so.1 => /lib64/libz.so.1 (0x0000003cdb800000)
	libcrypto.so.8 => /usr/lib64/libcrypto.so.8 (0x0000003ba7a00000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003cdb400000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003cda800000)
	libidn.so.11 => /lib64/libidn.so.11 (0x0000003ceaa00000)
	libssh2.so.1 => /usr/lib64/libssh2.so.1 (0x0000003ba8e00000)
	libldap-2.4.so.2 => /usr/lib64/libldap-2.4.so.2 (0x00007f2f1a250000)
	librt.so.1 => /lib64/librt.so.1 (0x0000003cdbc00000)
	libgssapi_krb5.so.2 => /usr/lib64/libgssapi_krb5.so.2 (0x0000003ce6e00000)
	libkrb5.so.3 => /usr/lib64/libkrb5.so.3 (0x0000003ce7e00000)
	libk5crypto.so.3 => /usr/lib64/libk5crypto.so.3 (0x0000003ce7200000)
	libcom_err.so.2 => /lib64/libcom_err.so.2 (0x0000003ce6a00000)
	libssl3.so => /lib64/libssl3.so (0x0000003490200000)
	libsmime3.so => /lib64/libsmime3.so (0x000000348fe00000)
	libnss3.so => /lib64/libnss3.so (0x000000348f600000)
	libplds4.so => /lib64/libplds4.so (0x0000003cbc800000)
	libplc4.so => /lib64/libplc4.so (0x0000003cbdc00000)
	libnspr4.so => /lib64/libnspr4.so (0x0000003cbd800000)
	libdl.so.2 => /lib64/libdl.so.2 (0x0000003cdb000000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003cda400000)
	libssl.so.8 => /usr/lib64/libssl.so.8 (0x0000003ba7e00000)
	liblber-2.4.so.2 => /usr/lib64/liblber-2.4.so.2 (0x0000003ceee00000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x0000003ce5600000)
	libsasl2.so.2 => /usr/lib64/libsasl2.so.2 (0x00007f2f1a030000)
	libkrb5support.so.0 => /usr/lib64/libkrb5support.so.0 (0x0000003ce7a00000)
	libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x0000003ce7600000)
	libnssutil3.so => /lib64/libnssutil3.so (0x000000348fa00000)
	libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007f2f19df8000)
	libselinux.so.1 => /lib64/libselinux.so.1 (0x0000003cdc400000)
	libfreebl3.so => /lib64/libfreebl3.so (0x00007f2f19b99000)
   [torvalds@nehalem git]$ make -j16 NO_CURL=1
   [torvalds@nehalem git]$ ldd git
	linux-vdso.so.1 =>  (0x00007fff2f960000)
	libz.so.1 => /lib64/libz.so.1 (0x0000003cdb800000)
	libcrypto.so.8 => /usr/lib64/libcrypto.so.8 (0x0000003ba7a00000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003cdb400000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003cda800000)
	libdl.so.2 => /lib64/libdl.so.2 (0x0000003cdb000000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003cda400000)

What a huge difference!

And the NO_CURL version really does load a lot faster in cold-cache. We're 
not talking small differences:

 - compiled with NO_CURL, five runs of "echo 3 > /proc/sys/vm/drop_caches" 
   followed by "time git branch":

	real	0m0.654s
	real	0m0.562s
	real	0m0.519s
	real	0m0.534s
	real	0m0.734s

   Total number of system calls: 194

 - compiled with curl, same thing:

	real	0m1.503s
	real	0m1.455s
	real	0m1.267s
	real	0m1.819s
	real	0m0.985s

   Total number of system calls: 407!

ie we're talking a _huge_ hit in startup times for that curl support. 
That's really really sad - especially considering how all the curl support 
is for very random occasional stuff. I never use it myself, for example, 
since I don't use http at all. And even for people who do, they only need 
it for non-local operations.

I wonder if there is some way to only load the crazy curl stuff when we 
actually want open a http: connection.

			Linus
