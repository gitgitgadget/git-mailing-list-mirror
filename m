From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: FW: Windows. Git, and Dedupe
Date: Tue, 19 Mar 2013 22:08:13 +0100
Message-ID: <5148D3BD.4040608@lsrfire.ath.cx>
References: <02803146dc74414191fab53b0de33fa1@BLUPR03MB019.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Josh Rowe <Joshua.Rowe@microsoft.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 22:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI3m4-0008S6-65
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 22:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933923Ab3CSVIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 17:08:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:49669 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab3CSVIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 17:08:20 -0400
Received: from [192.168.2.105] (p4FFD8DD5.dip.t-dialin.net [79.253.141.213])
	by india601.server4you.de (Postfix) with ESMTPSA id 0ACD217E;
	Tue, 19 Mar 2013 22:08:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <02803146dc74414191fab53b0de33fa1@BLUPR03MB019.namprd03.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218556>

Am 18.03.2013 22:20, schrieb Josh Rowe:
> On Windows with an NTFS volume with Deduplication enabled, Git
> believes that deduplicated files are symlinks.  It then fails to be
> able to do anything with the file.  This can be repro-ed by creating
> an NTFS volume with dedup, creating some duplicate files, verifying
> that a few files are deduped, and trying to add and commit the files
> via git.

Both Single Instance Storage[1] and Data Deduplication[2] (introduced
with Windows Server 2012) seem to be server-only features.  How about
keeping regular git repositories with checked-out files on client
disks and use the server only for bare repositories (without working
tree)?

When I tried to add a symbolic link created with mklink on Windows 8,
the mingw version of git refused because readlink(2) is not
supported.  This seems to be sufficient to reproduce the issue.

I couldn't test the Cygwin version, though, because http://cygwin.com
doesn't respond at the moment.

But a working readlink(2) wouldn't help anyway, I guess.  I imagine
that the reparse points used for deduplication point into a magic
block store which performs garbage collection of content that is no
longer referenced -- which probably means that a recreated "symlink"
may point to blocks that have been deleted in the meantime.

Perhaps you need a way to ask git to always follow symlinks instead
of trying to store their target specification.

Ren=C3=A9


[1] http://technet.microsoft.com/en-us/library/dd573308%28v=3Dws.10%29.=
aspx
[2] http://msdn.microsoft.com/en-us/library/windows/desktop/hh769303%28=
v=3Dvs.85%29.aspx
