From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: file permissions in Git repo
Date: Fri, 17 Jan 2014 19:08:39 +0100
Message-ID: <52D971A7.1040104@web.de>
References: <1389916737.92225.YahooMailNeo@web124906.mail.ne1.yahoo.com> <20140117022623.GC12444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: SH <saajey@yahoo.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 19:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4DqY-0001L6-LW
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 19:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbaAQSIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 13:08:43 -0500
Received: from mout.web.de ([212.227.17.12]:53671 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbaAQSIl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 13:08:41 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M2qsI-1VF9OY0d4o-00sdUz for <git@vger.kernel.org>;
 Fri, 17 Jan 2014 19:08:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117022623.GC12444@sigill.intra.peff.net>
X-Provags-ID: V03:K0:XoO43Elq48n3RUoIgIouyCBSZqffOVK/L1qxRB1Wn5fLdj5VUsK
 07gufeAm8L9i/9WsvGRB7L0MxvLwpl5eaGUgyUhPP83i7JRx9bcpAGPX9yTGl12zSYwkwUo
 CH8iqM4aBH9oIaoI+7z1TRpgObnrorZRcZ5hC0F1+RtFAkfBYm1SdVrTC0ZkaIIW3uE91Tf
 4781nYbCRTEs6n/82NfGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240602>

On 01/17/2014 03:26 AM, Jeff King wrote:
> On Thu, Jan 16, 2014 at 03:58:57PM -0800, SH wrote:
>
>> We have a repository which holds lots of shell and perl scripts. We add the
>> files to repository (from windows client) with executable permissions (using
>> cygwin) but when we pull that repository on another machine (windows or linux),
>> files dont have executable permission. Can you please provide a solutions for
>> this?
>
> Git does not preserve file permissions _except_ for the executable bit.
> So this should be working.
>
> However, I suspect that `core.fileMode` is set to `false` in your
> repository, which causes git to ignore the executable bit. When a
> repository is initialized, we check whether the filesystem simply
> creates everything with the executable bit. If so, we turn off
> core.fileMode for the repository (since otherwise every file would have
> it set).
>
> -Peff
Cygwin has been a little bit special (and mingw still is).
Until this commit:
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jul 24 19:22:49 2013 -0700

    Merge branch 'ml/cygwin-updates'

    The tip one does _not_ revert c869753e (Force core.filemode to
    false on Cygwin., 2006-12-30) on purpose, so that people can
    still retain the old behaviour if they wanted to.

    * ml/cygwin-updates:
      cygwin: stop forcing core.filemode=false
      Cygwin 1.7 supports mmap
      Cygwin 1.7 has thread-safe pread
      Cygwin 1.7 needs compat/regex
the repositories created by cygwin had always core.filemode=false.

You can easily check your configuration by running
git config -l
on the cygwin machine, as Peff suggested.

The next step is to check how the files had been recored in git, using
git ls-files -s | less
on any machine.

If I do this on git.git, we find lines like this, where
100755 means an executable file,
100644 means non-executable file.

100755 9c3f4131b8586408acd81d1e60912b51688575ed 0 
Documentation/technical/api-index.sh
100644 dd894043ae8b04269b3aa2108f96cb935217181d 0 
Documentation/technical/api-lockfile.txt


The 3rd step is to check how file are shown in cygwin, run
ls -l
(Do they have the executable bit set ?)

Side note:
And I think the way the auto-probing of the file system works is
like this:
When a git repo is initialized, the .git/config file is created.
After that, we try to toggle the executable bit, and if lstat reports
it as toggled, we set core.filemode=true.
(See builtin/init-db.c, search for core.filemode)

I tested to create a repo on a network share exported by SAMBA.
The Server was configured so that all new created files had the
executable bit set by default.
Git detected that the executable bit could be switched off,
and configured core.filemode=true
Nice.

/Torsten
