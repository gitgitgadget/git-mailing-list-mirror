From: Steffen Prohaska <prohaska@zib.de>
Subject: How to update index stat info without reading file content?
Date: Thu, 11 Sep 2014 21:04:08 +0200
Message-ID: <99C877A8-8145-4D8E-BE83-0F8A1FC16214@zib.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:04:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS9fJ-0000ot-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbaIKTER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Sep 2014 15:04:17 -0400
Received: from mailer.zib.de ([130.73.108.11]:36885 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbaIKTEQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 15:04:16 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s8BJ4FwI003805
	for <git@vger.kernel.org>; Thu, 11 Sep 2014 21:04:15 +0200 (CEST)
Received: from [192.168.1.200] (ip5f5bd2cf.dynamic.kabel-deutschland.de [95.91.210.207] (may be forged))
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s8BJ4DJf027261
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 11 Sep 2014 21:04:14 +0200 (CEST)
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 5411F22F.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5411F22F.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 5411F22F.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256862>

Hi,

Is there a way to update the stat information recorded in the index wit=
hout reading the file content from disk?

Starting from a clean working copy with a committed `file`, I'd like=20

    touch file
    git <magic-command> file

to bring the index into essentially the same state as

    touch file
    git status

but without reading the content of `file`.  (I'd be willing to wait a b=
it between touch and the magic command, to avoid any racy-git-related c=
ode paths.)

`git-update-index --assume-unchanged` is related.  But it requires comp=
letely manual handling of changes, because git will not look at marked =
files until told otherwise with `--no-assume-unchanged`.  I'd like to t=
ell git only that the current file content is known to be up-to-date.  =
Any future changes should be handled as usual.

In the documentation, `git add --refresh file` sounds a bit like what I=
'm looking for.  The documentation of `--refresh` states: "Don=92t add =
the file(s), but only refresh their stat() information in the index."  =
But it doesn't do what I want.

I looked a bit into `read-cache.c`.  The comment above `refresh_cache_e=
nt()` sounds promising:

     "refresh" does not calculate a new sha1 file or bring the
     cache up-to-date for mode/content changes. But what it
     _does_ do is to "re-match" the stat information of a file
     with the cache, so that you can refresh the cache for a
     file that hasn't been changed but where the stat entry is
     out of date.

But it isn't obvious to me whether what I'm looking for is available.  =
All code paths that eventually reach `fill_stat_cache_info()` seem to g=
o through `ce_compare_data()` and therefore `index_fd()`, which reads t=
he data from disk.

	Steffen