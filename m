From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: MSVC build broken (on cygwin)
Date: Sat, 03 Oct 2009 20:36:28 +0100
Message-ID: <4AC7A7BC.5070608@ramsay1.demon.co.uk>
References: <4AC4E2C2.6030509@ramsay1.demon.co.uk> <4AC5B4AE.5070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 22:15:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuB0h-0001sL-OC
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 22:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102AbZJCUKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 16:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757032AbZJCUKF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 16:10:05 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:58498 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757012AbZJCUKE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Oct 2009 16:10:04 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1MuAuu-0002EV-pV; Sat, 03 Oct 2009 20:09:22 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AC5B4AE.5070307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129500>

Marius Storm-Olsen wrote:
> ...
> Clone the git://repo.or.cz/msvcgit.git, and run the 
> setup_32bit_env.cmd script in there, and you should have everything 
> you need to both compile and link Git with MSVC.
> 

Hmm, I'm trying to avoid YASORD (Yet Another Set Of Redundant
Dependencies ;-)  On my laptop, I currently have 4 zlib installations,
5 openssl installations, 3 iconv's ...

As I said earlier (see below), I'm not so interested in getting the
msvc build to work for me, rather than understand why it works for you,
since it should not work!

Having said that, I *may* try to get it working on my cygwin
installation. However, I'm much more likely to make some changes to
the build/Makefile to allow the dependent libraries to be installed
in different locations :) There is nothing wrong with my zlib at
C:\zlib.

>> Anyway, the point is *not* to get the msvc build to work for me; rather
>> it is to understand why the build *works* for you. ;-)
> 
> First of all, thanks for the thorough report! :)

You're welcome.

> Second, I just recompiled, and it magically works for me. Why is a 
> good question, since I also think it shouldn't at this point. The

Oh, you *really* don't want "magic" to be the answer... :P

> So, obviously, some magic in there is making it work for me. I have a 
> hard time locating the magic in question though. :-/

Which shell are you using? MSYS-bash?
Which make are you using? MSYS-GNU?
Which Perl are you using? ActiveState? MSYS?

I'm using cygwin 1.5.22, along with the cygwin versions of
bash 3.2, GNU make 3.81, perl 5.8.7

I noticed that the clink.pl script was not returning the correct exit
code to the Makefile, which is why I ended up snipping 940 lines of
output from the earlier #error demonstration; the Makefile does not
notice when the compile exits with an error.

In order to fix this issue for me, I made the following change:

-- >8 --
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 0ffd59f..3e4e501 100644
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -45,4 +45,18 @@ if ($is_linking) {
 	push(@args, @cflags);
 }
 #printf("**** @args\n");
-exit system(@args);
+
+system(@args);
+
+if ($? == -1) {
+	print "clink.pl: failed to execute: $!\n";
+	exit 1;
+}
+elsif ($? & 127) {
+	printf "clink.pl: child died with signal %d%s\n",
+		($? & 127), ($? & 128) ? ', coredump.' : '.';
+	exit 1;
+}
+
+exit $? >> 8;
+
-- >8 --

See "perldoc -f system" for more explanation of the above. This is
how it works on unix and unix-alike systems, so this may not work
too well on (say) ActiveState Perl; Dunno. Also, according to this
documentation, the form of the call to system() should result in a
call to an exec function, rather than using a shell; this may or
may not be true on other platforms.

Having fixed that problem, I modified clink.pl again so that it
would run args.exe rather than cl.exe; this allowed me to see,
using: make -> perl -> "system()" -> args.exe, just what will be
passed to the compiler.

Just in case you can't guess, create args.exe from:

    $ cat -n args.c
         1	#include <stdio.h>
         2	
         3	int main(int argc, char *argv[])
         4	{
         5		int i;
         6	
         7		for (i=0; i< argc; i++) {
         8			printf("argv[%d] = '%s'\n", i, argv[i]);
         9		}
        10		exit(1);
        11	}
        12	
    $ 

and put it somewhere in your path (~/bin for me).

    $ make MSVC=1
    GIT_VERSION = 1.6.5.rc1.38.gb4f27.dirty
        * new build flags or prefix
        CC fast-import.o
    argv[0] = 'args'
    argv[1] = '-Fofast-import.o'
    argv[2] = '-c'
    argv[3] = '-nologo'
    argv[4] = 'fast-import.c'
    argv[5] = '-I.'
    argv[6] = '-I../zlib'
    argv[7] = '-Icompat/vcbuild'
    argv[8] = '-Icompat/vcbuild/include'
    argv[9] = '-DWIN32-D_CONSOLE'
    [...snipped...]
    argv[56] = '-Icompat/regex'
    make: *** [fast-import.o] Error 1

Perhaps you could try a similar exercise?

Hmm, do you have any funny environment variables set which msvc is
picking up? 
Oh, what about the CL variable?

> That being said, does adding the space between the defines fix the 
> MSVC compilation using Cygwin's GNU Make? It's none-the-less a correct 
> patch, so you get an ack from me. Thanks!
> 
> Acked-by: Marius Storm-Olsen <mstormo@gmail.com>
> 

Thanks!

ATB,
Ramsay Jones
