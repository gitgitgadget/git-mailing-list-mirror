From: Chris Hoogendyk <hoogendyk@bio.umass.edu>
Subject: building git on Solaris
Date: Tue, 07 Sep 2010 17:02:35 -0400
Message-ID: <4C86A86B.1030107@bio.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 07 23:34:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot5oO-0007Wu-48
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 23:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab0IGVeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 17:34:24 -0400
Received: from marlin.bio.umass.edu ([128.119.55.19]:54311 "EHLO
	marlin.bio.umass.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab0IGVeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 17:34:23 -0400
X-Greylist: delayed 1905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2010 17:34:23 EDT
Received: from peredhil.bio.umass.edu (peredhil.bio.umass.edu [128.119.54.86])
	(authenticated bits=0)
	by marlin.bio.umass.edu (8.14.4/8.14.4) with ESMTP id o87L2ZtC016730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Sep 2010 17:02:37 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (marlin.bio.umass.edu [128.119.55.19]); Tue, 07 Sep 2010 17:02:37 -0400 (EDT)
X-Scanned-By: MIMEDefang 2.68 on 128.119.55.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155744>

Building git 1.7.1 on Solaris 9 using gcc and gnu tools.

My build environment includes:

    CC=3Dgcc
    CFLAGS=3D'-L/usr/local/lib -R/usr/local/lib'
    CPPFLAGS=3D-I/usr/local/include
    LDFLAGS=3D'-L/usr/local/lib -R/usr/local/lib'
    LD_INCLUDE_PATH=3D/usr/include:/usr/local/include
    LD_LIBRARY_PATH=3D/usr/local/lib:/usr/lib:/usr/sfw/lib
   =20
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/ucb:/usr/=
ccs/bin
    PWD=3D/usr/local/src/git/git-1.7.1
    SHELL=3D/bin/ksh

If I ask `which make`, I get /usr/local/bin/make. If I say, `make=20
--version`, I get "GNU Make 3.80".

If I ask `which perl`, I get /usr/local/bin/perl. If I say, `perl=20
--version`, I get "This is perl, v5.8.6 built for=20
sun4-solaris-thread-multi".

I'm building with

     # make configure
     # ./configure --prefix=3D/usr/local
     # make all doc
     # make install install-doc install-html

It seems to work fine (though way sparse in what it has to say), until=20
it hits here (from the `make all doc`):

            :
            :
        GEN git-submodule
        GEN git-web--browse
        SUBDIR perl
    make: Warning: Ignoring DistributedMake -o option
    Usage : make [ -f makefile ][ -K statefile ]... [ -d ][ -dd ][ -D ]=
[=20
-DD ]
                 [ -e ][ -i ][ -k ][ -n ][ -p ][ -P ][ -q ][ -r ][ -s ]=
[=20
-S ][ -t ]
                 [ -u ][ -w ][ -V ][ target... ][ macro=3Dvalue... ][=20
"macro +=3Dvalue"... ]
    make: Fatal error: Unknown option `-C'
    make: *** [perl/perl.mak] Error 1


I couldn't figure out where that was coming from (Can I turn on a bit=20
more verbosity during the build?) until I tried to do a `make clean` an=
d=20
got a little more detail, where it ended up with `make -C Documentation=
/=20
clean` followed by the same set of errors.

When I simply enter `make -C Documentation/ clean` from the command=20
line, it works.

Poking around, I eventually found that /usr/ccs/bin/make will emit thos=
e=20
errors, whereas /usr/local/bin/make does not. However, /usr/ccs/bin/mak=
e=20
should never be called. That is last in my PATH, whereas=20
/usr/local/bin/make is first in my PATH.

So, something fishy is going on with the environment. But, those path=20
precedences are everywhere in my system. If I `su - nobody`, for=20
example, I get /usr/local/bin first in the PATH. I also did a `find .=20
-type f | xargs grep ccs` from within /usr/local/src/git/git-1.7.1, and=
=20
the only things I found were in the config.log where it was noting=20
/usr/ccs/bin/ar, /usr/ccs/bin/as and /usr/ccs/bin/ld, which, I believe,=
=20
are correct.

Does anyone have any guidance or clues as to where I should look from=20
here? Or how to fix this?

TIA


---------------------

NOTE: I also had to do the following:

    # diff configure configure.orig
    7810c7810
    <   for opt in -pthreads -lpthreads; do
    ---
    >   for opt in -pthread -lpthread; do
    #

to get rid of errors like this:

               :
               :
        CC xdiff/xpatience.o
        AR xdiff/lib.a
        LINK git-fast-import
    gcc: unrecognized option `-pthread'
        CC imap-send.o
        LINK git-imap-send
    gcc: unrecognized option `-pthread'
        CC shell.o
        LINK git-shell
   gcc: unrecognized option `-pthread'
        CC show-index.o
        LINK git-show-index
    gcc: unrecognized option `-pthread'
               :
               :

---------------------


--=20
---------------

Chris Hoogendyk

-
   O__  ---- Systems Administrator
  c/ /'_ --- Biology & Geology Departments
 (*) \(*) -- 140 Morrill Science Center
~~~~~~~~~~ - University of Massachusetts, Amherst=20

<hoogendyk@bio.umass.edu>

---------------=20

Erd=F6s 4
