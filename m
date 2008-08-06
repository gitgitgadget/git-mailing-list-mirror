From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] perl/Makefile: handle paths with spaces in the NO_PERL_MAKEMAKER
 section
Date: Wed, 06 Aug 2008 14:31:49 -0500
Message-ID: <lh6XIUcjpbjj8G8Ot7RQFlDitUn1njsc350QhnNmQkcgxlfluBPGZw@cipher.nrlssc.navy.mil>
References: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil> <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil> <7v8wvbuit7.fsf@gitster.siamese.dyndns.org> <klGWkbWGpsUHZpuNwl9WvZs5UGGfYVAngWbiM3eippaejrXLNyLpRA@cipher.nrlssc.navy.mil> <7v7iaurwe4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 21:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQol5-0005oT-A2
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 21:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761595AbYHFTcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761587AbYHFTcP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 15:32:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58466 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761579AbYHFTcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 15:32:12 -0400
Received: by mail.nrlssc.navy.mil id m76JVoWT007928; Wed, 6 Aug 2008 14:31:52 -0500
In-Reply-To: <7v7iaurwe4.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Aug 2008 19:31:50.0062 (UTC) FILETIME=[12944CE0:01C8F7FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91533>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Junio C Hamano wrote:
>>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>>
>>>> Use double quotes to protect against paths which may contain spaces.
>>>> ...
>>>> +	echo '	mkdir -p "$(instdir_SQ)"' >> $@
>>> Is this sufficient?  We seem to apply double-sq when writing shell
>>> scriptlet in GIT-BUILD-OPTIONS from the main Makefile, and I suspect you
>>> would need to do something similar.
>> It seems to be sufficient. The double quotes survived into my perl.mak file
>> and the two perl modules were installed correctly when I supplied a prefix
>> with spaces. Is there something else to be concerned about?
> 
> I think the generic way GIT-BUILD-OPTIONS writing is done covers cases
> where the installation directory has funnies other than whitespace, e.g. 
> double quotes.  Is your 'echo "$(instdir_SQ)"' sufficient?


DOUBLE QUOTE ISSUE:

I added a double quote to my prefix, and the build fails at compiling config.c
line 589. The failure is caused by the macro ETC_GITCONFIG which is set in the
Makefile and contains the prefix string, which contains the single double quote.
This of course causes a syntax error. So it looks like the cleansing done to
ETC_GITCONFIG doesn't handle this.

Doing this allows me to compile:

    ETC_GITCONFIG_SQ = $(subst ",\",$(subst ','\'',$(ETC_GITCONFIG)))

The patch at the end of this email applies the same treatment to the other
variables I needed to get git to compile. If this is the correct fix, then
the other variables used as macros in git source files would need to be
hunted down... at least SHA1_HEADER_SQ, but maybe others?


SPACE ISSUE:

Also, the installation of the perl modules fails when I have a space in the
path and NO_PERL_MAKEMAKER is _not_ set. IOW the perl makemaker install fails
for me when there is a space in the path. This has nothing to do with the
double quote I was talking about above, I think it would fail with double quote
too.

The line assigning PREFIX in my perl.mak looks like:

    PREFIX = /home/casey/opt/test spaces/

Shouldn't that argument have quotes around it?

The errors look like:

make -C perl prefix='/home/casey/opt/test spaces/' DESTDIR='' install
make[1]: Entering directory `/home/casey/scratch/git/master/perl'
make[2]: Entering directory `/home/casey/scratch/git/master/perl'
Installing /home/casey/opt/test/private-Error.3pm
Installing /home/casey/opt/test/Git.3pm
Writing /home/casey/opt/test
Can't open file /home/casey/opt/test: Is a directory at /usr/lib/perl5/5.8.5/ExtUtils/Install.pm line 209
make[2]: *** [pure_site_install] Error 255
make[2]: Leaving directory `/home/casey/scratch/git/master/perl'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/casey/scratch/git/master/perl'
make: *** [install] Error 2

private-Error.3pm and Git.3pm showed up in /home/casey/opt/test/


There are problems here with spaces, single quotes, and double quotes.
I'll follow up in another email.

MakeMaker version 6.17 (Revision: 1.133)
perl v5.8.5

-brandon


diff --git a/Makefile b/Makefile
index 0d373f7..affc288 100644
--- a/Makefile
+++ b/Makefile
@@ -1031,15 +1031,15 @@ endif
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
-ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
+ETC_GITCONFIG_SQ = $(subst ",\",$(subst ','\'',$(ETC_GITCONFIG)))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
-mandir_SQ = $(subst ','\'',$(mandir))
-infodir_SQ = $(subst ','\'',$(infodir))
-gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
-template_dir_SQ = $(subst ','\'',$(template_dir))
-htmldir_SQ = $(subst ','\'',$(htmldir))
+mandir_SQ = $(subst ",\",$(subst ','\'',$(mandir)))
+infodir_SQ = $(subst ",\",$(subst ','\'',$(infodir)))
+gitexecdir_SQ = $(subst ",\",$(subst ','\'',$(gitexecdir)))
+template_dir_SQ = $(subst ",\",$(subst ','\'',$(template_dir)))
+htmldir_SQ = $(subst ",\",$(subst ','\'',$(htmldir)))
 prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
