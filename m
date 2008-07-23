From: Jan Engelhardt <jengelh@medozas.de>
Subject: Not so happy about build system
Date: Wed, 23 Jul 2008 11:33:56 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807222036230.23410@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 11:34:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLakN-0003OT-Cr
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 11:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbYGWJd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 05:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbYGWJd6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 05:33:58 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:36476 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbYGWJd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 05:33:57 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 4AEE918043864; Wed, 23 Jul 2008 11:33:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 437891CF30E94
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 11:33:56 +0200 (CEST)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89617>

Hi,


I just tried git 1.5.6.4 on a Solaris 10 box. Building mostly went 
smooth, but a few unhappy edges turned up:

~/git-1.5.6.4>gmake MAKE=gmake
    LINK git-daemon
ld: fatal: library -lcurl: not found
ld: fatal: library -lcrypto: not found
ld: fatal: File processing errors. No output written to git-daemon
collect2: ld returned 1 exit status
gmake: *** [git-daemon] Error 1

Of course curl is available, it's just somewhere else. And that is where 
the fun begins that comes with plain Makefiles.

	"What's the variable I ought to set?"

Yes, usually it is LDFLAGS, and this is also true for git. But not 
everyone necessarily adheres to that, and looking through the Makefile 
is not fun. That also reminds me of CFLAGS, which about every Makefile 
write happily sets to

	CFLAGS = -g -O2 -Wall -Wmy-fancy-flags

which would give no way to keep -Wmy-fancy-flags while also overriding 
it. Autotools solved this whereby a developer puts -Wmy-fancy-flags that 
shall always be present into AM_CFLAGS instead and only puts the really 
freely choosable flags into CFLAGS. Of course I could list all the 
developers flags that are needed/wanted (-Wmy-fancy-flags) like

	make CFLAGS="-Wdevelopers-fancy-flags -O3 -g0"

but one would have to look them up first and and etc.
Ok, enough Makefile ramblings, as there seems to be a configure script 
lurking. What's the Makefile good for then if configure will create it 
anyway?

Trying my luck with configure, I call

	./configure --prefix=$HOME/rt --with-openssl=/opt/csw 
	--with-curl=/opt/csw

but what I get is that it obviously did not find neither openssl nor 
curl, though they do exist in /opt/csw/include and /opt/csw/lib:

	checking for SHA1_Init in -lcrypto... no
	checking for SHA1_Init in -lssl... no
	checking for curl_global_init in -lcurl... no
	checking for XML_ParserCreate in -lexpat... no

(someone please fix that)

	./configure --prefix=$HOME/rt --with-openssl=/opt/csw 
	--with-curl=/opt/csw CFLAGS="-O2 -I/opt/csw/include -L/opt/csw/lib 
	-R/opt/csw/lib"
# using /usr/ccs/bin/ld, not GNU ld

That finally made it succeed in finding SHA1_Init. Then however,

	~/git-1.5.6.4>make
	make: Fatal error in reader: Makefile, line 158: Unexpected end 
	of line seen

So configure did not create a POSIX-compatible Makefile. Ok, 
I had gmake, so the story is successfully done here :)
