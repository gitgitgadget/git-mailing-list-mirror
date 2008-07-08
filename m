From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: uninstalling Git
Date: Tue, 08 Jul 2008 06:57:20 +0200
Message-ID: <4872F3B0.6050406@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG5Ha-0001Wu-AI
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYGHE5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbYGHE5d
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:57:33 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:59460 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751236AbYGHE5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:57:32 -0400
Received: (qmail 21058 invoked from network); 8 Jul 2008 04:57:29 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 8 Jul 2008 04:57:29 -0000
Received: (qmail 23309 invoked from network); 8 Jul 2008 04:57:21 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 8 Jul 2008 04:57:21 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

There are two situations where I'm missing a way to uninstall Git:

- accidental install with prefix=/usr instead of prefix=/usr/local which 
I usually choose
- removing cruft from older gits, like tools and their man/info pages 
which don't exist anymore in newer Git releases

I wonder why there's no "uninstall" make target. Ok, maybe some people 
would argue that installing and uninstalling software through make has 
never been the best way, but usually I don't have problems with software 
providing "make uninstall", and I'm left with no solution for the above 
once I choose to use "make install" for Git.

[
Well, there's the "checkinstall" tool, but for some reason using 
checkinstall (version 1.6.1(-7) from Debian lenny) leads to some strange 
problems:

at first I always got (with a fresh tree):

...
if test -r /usr/share/info/dir; then \
      install-info --info-dir=/usr/share/info git.info ;\
      install-info --info-dir=/usr/share/info gitman.info ;\
    else \
      echo "No directory found in /usr/share/info" >&2 ; \
    fi

No `START-INFO-DIR-ENTRY' and no `This file documents'.
install-info(git.info): unable to determine description for `dir' entry 
- giving up

No `START-INFO-DIR-ENTRY' and no `This file documents'.
install-info(gitman.info): unable to determine description for `dir' 
entry - giving up
make[1]: *** [install-info] Error 1
make[1]: Leaving directory `/usr/src/GIT/T/git.1/Documentation'
make: *** [install-info] Error 2


and now I'm consistently getting (each time with a fresh tree):

asciidoc -b docbook -d book user-manual.txt
FAILED: unexpected error:
------------------------------------------------------------
Traceback (most recent call last):
  File "/usr/bin/asciidoc", line 4014, in asciidoc
    config.load_all(CONF_DIR)
  File "/usr/bin/asciidoc", line 3637, in load_all
    for f in os.listdir(filters):
OSError: [Errno 2] No such file or directory: '/etc/asciidoc/filters'
...


and now, again with a fresh tree but without -j2:

# checkinstall make prefix=/usr install install-doc install-info
...
asciidoc -b docbook -d manpage -f asciidoc.conf \
         -agit_version=1.5.6.GIT -o git-add.xml+ git-add.txt
FAILED: unexpected error:
------------------------------------------------------------
Traceback (most recent call last):
  File "/usr/bin/asciidoc", line 4014, in asciidoc
    config.load_all(CONF_DIR)
  File "/usr/bin/asciidoc", line 3637, in load_all
    for f in os.listdir(filters):
OSError: [Errno 2] No such file or directory: '/etc/asciidoc/filters'
------------------------------------------------------------
make[1]: *** [git-add.xml] Error 1
make[1]: Leaving directory `/usr/src/GIT/T/git.1/Documentation'
make: *** [install-doc] Error 2

****  Installation failed. Aborting package creation.

Cleaning up...OK

Bye.


where /etc/asciidoc/filters clearly is a non-empty directory. It seems 
to behave non-deterministically. So my guess is that checkinstall is 
using LD_PRELOAD tricks or some such and just doesn't work for the task 
here, at least not without fixing something.
]

So,
- is there any (good?) reason there is no uninstall target? Should I 
look into creating one?
- do you have better or working alternative suggestions?

Actually I'd be happy if there are more elegant solutions than make 
uninstall, since there is the race/hen-and-egg problem of having to run 
"make uninstall" from the tree before checking out the new version, and 
checking out the new version of course needs git, meaning the "right" 
approach would be to keep the working dir of the last install for the 
purpose of uninstallation until after having built the new version. 
Maybe it's enough to just keep the toplevel Makefile, but that would be 
making assumptions. Maybe I should talk with the Debian people about how 
to build debs easily for such purposes (and not using the standard 
Debian packages -- I'd really like to just have an own single package 
without any applied patches etc.)?

Thanks,
Christian.
