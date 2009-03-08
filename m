From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: t9500-gitweb-standalone-no-errors.sh.prb 4 errors
Date: Sat, 7 Mar 2009 18:29:38 -0700
Message-ID: <alpine.LNX.2.00.0903071814050.20607@suse104.zenez.com>
References: <alpine.LNX.2.00.0903071645370.20607@suse104.zenez.com> <m3ab7wizz5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:31:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7rB-0002rB-KB
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbZCHB3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbZCHB3l
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:29:41 -0500
Received: from suse104.zenez.com ([198.60.105.164]:34519 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbZCHB3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:29:41 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id E54B76C08B2; Sat,  7 Mar 2009 18:29:38 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id D4ED4938188;
	Sat,  7 Mar 2009 18:29:38 -0700 (MST)
In-Reply-To: <m3ab7wizz5.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112608>

On Sat, 7 Mar 2009, Jakub Narebski wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>> Test fails for SCO OpenServer 6.0 MP4 with 1.6.2
>>
>> Below is the set -x output of the tests.
>
> Could you run it without -x, but with --debug (as option to test
> itself) instead?  Because what matters here not on which command the
> test failed (we know it is on gitweb_run), but what error message
> gitweb returned.

Yes,

> Also the problem might with in Perl modules gitweb uses (CGI, Encode,
> ...), and with Perl version used, although it is less likely...

It is a perl problem...

* FAIL 18: .git blob (file)
         gitweb_run "p=.git;a=blob;f=file"
[Sun Mar  8 01:11:44 2009] gitweb.perl: -T and -B not implemented on 
filehandles at /tmp/git-1.6.2/t/../gitweb/gitweb.perl line 2853.
* FAIL 19: .git blob_plain (file)
         gitweb_run "p=.git;a=blob_plain;f=file"
[Sun Mar  8 01:11:44 2009] gitweb.perl: -T and -B not implemented on 
filehandles at /tmp/git-1.6.2/t/../gitweb/gitweb.perl line 2853.
* FAIL 62: path_info: project/branch:file
         gitweb_run "" "/.git/master:file"
[Sun Mar  8 01:12:15 2009] gitweb.perl: -T and -B not implemented on 
filehandles at /tmp/git-1.6.2/t/../gitweb/gitweb.perl line 2853.
* FAIL 66: path_info: project/branch:/file
         gitweb_run "" "/.git/master:/file"
[Sun Mar  8 01:12:17 2009] gitweb.perl: -T and -B not implemented on 
filehandles at /tmp/git-1.6.2/t/../gitweb/gitweb.perl line 2853.

I am not really sure what to do about it.  I contacted SCO on a 
different problem with the same type of filehandle problem and they told 
me they have not implemented any thing is the OS that could do this test.

This is what I traced it to...

This is what Tim Rice and I received from SCO...

  Re: __fpending()

Tim Rice wrote:
> It looks like it needs __fpending, __fpurge, & __freading.
> But as mentioned before, we can use funflush for __fpurge.

And for __freading() you could use

#define __freading(p) ((p)->__flag & _IOREAD)

or if we were to have had it in <stdio.h>, it'd look
more like the following (for C) for various reasons:

#define __freading(p) ((void)sizeof(__filbuf(p)), ((FILE *)(p))->__flag &
_IOREAD)

> I strongly suspect these missing APIs are responsible for the
For C++, it's be an inline routine checking the flag.

> I strongly suspect these missing APIs are responsible for the
> problem I found with Perl too. See "uw714 MP4 perl" and "osr600 
MP4 perl" thread.

This hadn't been raised as a possibility as far as I've
read in that thread -- did I miss something?  Does this
mean you've built your own perl for uw7 and found that
you needed one or more of these __f...() routines?

And Boyd Gerber wrote:
Ah yes, we're doing
#if defined(__USLC__)
   return (fp->__flag & _IOREAD) != 0;
#else
   return (fp->_flag & _IOREAD) != 0;
#endif

Would you consider this test case.
......
cat > tst.pl << 'EOF'
open (FH, $ARGV[0]) || die ("Can't open $ARGV[0] -- $!\n");
print "Text\n" if (-T FH);
print "Binary\n" if (-B FH);
close (FH);
EOF
......

On OpenServer 5 if you run "perl tst.pl tst.pl" it will say
Text

On UnixWare 7.1.4 MP4 and OpenSever 6.0 MP4 if you run "perl tst.pl 
tst.pl" it will say -T and -B not implemented on filehandles at tst.pl 
line 2.

While googling I found according to a post by Randal Schwartz that this 
means perl doesn't know enough about stdio on that platform.

Looking at /opt/lib/perl5/5.8.8/i386-unixware-thread-multi/Config_heavy.pl
we see things like stdio_base='((fp)->_base)' but then we have
d_stdiobase='undef' so it is not used.

And this wouldn't work but probably isn't used because of
d_stdiobase='undef'
stdio_bufsiz='((fp)->_cnt + (fp)->_ptr - (fp)->_base)'

If we had  __fbufsiz() it might be
stdio_bufsiz='__fbufsiz(fp)'

As the test program shows, there is something missing in UnixWare's
and OpenServer 6 perl's implementation.

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
