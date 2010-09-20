From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 18:20:05 -0500
Message-ID: <4F4U1inRKcW4HHV1z2hCXRdyS9lEqRBQYwV2RNDETBIkkT7YIO_qHQ@cipher.nrlssc.navy.mil>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil> <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com> <CWxE18Hq1ro8utv-_dFm1ZaVIKpCDTv-TbEB4u_l84GvbeJh1vKing@cipher.nrlssc.navy.mil> <5FA82BA4-AE76-44F5-9635-36E199E97B00@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 01:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxpej-0001cr-V9
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 01:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398Ab0ITXUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 19:20:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33463 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab0ITXUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 19:20:08 -0400
Received: by mail.nrlssc.navy.mil id o8KNK6Bv010180; Mon, 20 Sep 2010 18:20:06 -0500
In-Reply-To: <5FA82BA4-AE76-44F5-9635-36E199E97B00@kellerfarm.com>
X-OriginalArrivalTime: 20 Sep 2010 23:20:06.0764 (UTC) FILETIME=[5C976AC0:01CB591A]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156679>

On 09/20/2010 05:53 PM, Andrew Keller wrote:
> On Sep 20, 2010, at 3:12 PM, Brandon Casey wrote:
>>  You could try
>> deleting the config.mak.autogen file that configure creates, and just run
>> make by itself.  Based on what you've describe, it would look something
>> like this:
>>
>>   cd <path-to-git-src>
>>   rm config.mak.autogen
>>   cat >config.mak <<EOF
>> CC=/usr/local/bin/gcc
>> PREFIX=/usr/users/students/ak4390/.local
>> PYTHON_PATH=/usr/local/bin/python
>> TCL_PATH=/usr/local/bin/tclsh8.4
>> NO_PERL_MAKEMAKER=1
>> EOF
>>   make
>>
>> Then add 'install' to the make command line when you are ready.
>>
>> Notice, I placed all of the make settings in a file named config.mak.  This
>> file is imported by the main Makefile automatically and is intended to be
>> used like this for user settings.  If you really need to disable pthreads,
>> then you can add NO_PTHREADS=1.  Check out the comments at the top of the
>> Makefile for a list of all variables that can be set.
> 
> Compiling as described above appears to go down in flames:
> 
> $ make
> /bin/sh: curl-config: not found

At this point, the above is just a warning that curl-config is not
in your path.  If curl is not installed on your system, you need
to set NO_CURL=1.

>     CC fast-import.o
> In file included from builtin.h:4,
>                  from fast-import.c:147:
> git-compat-util.h:140:25: openssl/ssl.h: No such file or directory
> git-compat-util.h:141:25: openssl/err.h: No such file or directory
<snip other related warnings>

Fixed by setting NO_OPENSSL=1.

> And, this is the same source tree that just worked a minute ago, when
> I used configure/make/make install.  I then copied the entire source
> folder, with the modified config.mak file, to my laptop running Snow Leopard,
> modified the variables in the config.mak file to match the system, and it
> compiled and installed just fine.  So, this server seems to have a problem
> with not running the configure script first.

git's configure script is a little different from the configure
scripts in other projects.  All configure does in git is set variables
that are used by the Makefile.  Using its rules, it tries to figure out
what the best setting is for each variable.  Any of these variables can
be set manually in the user's config.mak file.  Apparently, additional
variables need to be modified from their default to handle your system.
Once you determine the set of variables that need to be set, they most
likely will not need to be changed when compiling future versions of
git.

The above two variables (NO_CURL, NO_OPENSSL) will likely fix the errors
that you reported, but I don't guarantee that more errors will not be
produced and will require additional settings.  All of the variables
are described in the comments at the top of the Makefile.  It's an
iterative process.  You could also use the config.mak.autogen as the
baseline for you config.mak file.

-Brandon
