From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: git status reads too many files
Date: Mon, 21 Mar 2011 13:40:21 +0100
Message-ID: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 13:40:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ePO-0003DO-Iv
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 13:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab1CUMkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 08:40:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62301 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab1CUMkX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 08:40:23 -0400
Received: by bwz15 with SMTP id 15so4970453bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=UKUAO1BTOhGrh3s+7kFyUQufpDib0EiJ5DbKmGJoP9Q=;
        b=R++iQfx3z9GxnsnxgW5ZBT5ksGyosGtlbqpqTUwdBDuvIdp9qu3DOQIBzfcg4ZpBJj
         uzfvMKTHCNtLG6kq3iTeJObo1W5+xFdGZ0qSi44g9iQ6n7vViRIoxz0OAyx4yXC5yFD/
         v3HWeSxsbiKFZ920HqeDPdC9Xqo5+ImtICFEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=boo3aMivL02HXgArezmP9cj5HaQqJ1ogsSVp3frMYs3y8NVc8noWzT//bbu6NIr5DM
         XRU9asdvDl5L23NGTfL2hht5zmIbIvgDOYRIbQK+rAYL9liUHxAVU9b88Z2cEKA9ZoeG
         eYC69uYKEQrxqpWnH9c/+QxH89+iNK5tjdZTY=
Received: by 10.204.126.148 with SMTP id c20mr3619833bks.87.1300711221860;
 Mon, 21 Mar 2011 05:40:21 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Mon, 21 Mar 2011 05:40:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169592>

After a git checkout, git status has a tendency to read all the files
that were updated during the checkout. In git.git for example:

$ git checkout -b here v1.7.4
Switched to a new branch 'here'
$ git checkout -b there v1.7.4.1
Switched to a new branch 'there'
$ strace -o /tmp/trace1 git status
# On branch there
nothing to commit (working directory clean)
$ grep ^open /tmp/trace1 | wc -l
414
$ git diff --name-only here..there | tail -1
wrapper.c
$ grep -A2 wrapper.c /tmp/trace1
lstat("wrapper.c", {st_mode=S_IFREG|0644, st_size=7617, ...}) = 0
open("wrapper.c", O_RDONLY)             = 3
read(3, "/*\n * Various trivial helper wra"..., 7617) = 7617
close(3)                                = 0
$

This persistent across multiple runs of git status:

$ strace -o /tmp/trace2 git status
# On branch there
nothing to commit (working directory clean)
$ grep ^open /tmp/trace2 | wc -l
414
$

...until the index is touched:

$ touch .git/index
$ strace -o /tmp/trace3 git status
# On branch there
nothing to commit (working directory clean)
$ grep ^open /tmp/trace3 | wc -l
362
$

This happening at least with 1.7.0.4 and 1.7.4.1.343.ga91df (master as
of now)...

Further scrutiny reveals that when this happens, the index and the
newly updated files in the working tree have identical modification
times, so I guess git status is reading all files which are not older
than the index...

Discussing this with Mr. Schindelin last week, my first thought was
that checkout should ensure that the index is newer than any of the
files in the working tree but Johannes seems to think that instead,
the first git status run should touch the index, thus preventing the
next run from reading the files again.

I'm not familiar enough with the semantics of the index to say which
way is correct or intended, but surely the current behaviour is not
desirable.

Bug?

-- 
/Lasse
