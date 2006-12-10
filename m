X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 12:38:42 +0100
Message-ID: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 11:38:51 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kQ1ut+JOw2iZGmnQeCXyvHeKohZKDxVx+h6LwwcId2fSSfpEmYtNS9GM6Jhq6kiF2gYUHnyxCcWLzfhInqfiATOZwCU7OsKX3S1D56S0G3G5n7qTBdQwTa9im/fwHoawwy7pqk2YbcwSsy+PQ8v32hwTQ25eoip0+Mv0iz/PQyU=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33876>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtN16-0006Rb-Ic for gcvg-git@gmane.org; Sun, 10 Dec
 2006 12:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758161AbWLJLio (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 06:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758303AbWLJLio
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 06:38:44 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:20106 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758292AbWLJLin (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 06:38:43 -0500
Received: by py-out-1112.google.com with SMTP id a29so723497pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 03:38:43 -0800 (PST)
Received: by 10.35.77.1 with SMTP id e1mr1467338pyl.1165750723020; Sun, 10
 Dec 2006 03:38:43 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 10 Dec 2006 03:38:42 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I have done some tests about reading git-rev-list output with
different IPC facilities:

- Native Qt QProcess socket based IPC

- pipe based: popen() and fread()

- redirecting git-rev-list to a file (under tmpfs) and 'block reading'
back the file: read() under Qt QFile class. The file, always in
memory, is deleted at the end of loading.


I have tested with different block sizes and different CPU speed on
linux and git trees.

The averaged results on linux tree (about 30MB of data) and CPU set at
1.2GHz are:

- QProcess 6734ms

- pipe and fread() with 64KB blocks 4832ms (38% faster then QProcess)

- temporary file and read() with 64KB blocks 4321ms (10% faster then pipe)


I have not enough knowledge to understand why temporary file is faster
then pipe. My guess is, after reading some docs around, fread() uses a
C standard I/O buffer, while read() is unbuffered.

To make git-rev-list writing a temporary file I create and run a
script more or less like:

git rev-list --header --boundary --parents --topo-order HEAD  >
/tmp/qgit_135902672.txt

There is also some additional kludge to get git-rev-list pid, so to
use in case of a cancel request arrives while loading.


So my request is if it is possible to make git-rev-list write
_directly_ to a file, without shell redirection, I would ask if it is
possible:

- Add a -o, --output option to git-rev-list to specify output file
instead of stdout

- Use an unbuffered binary block write to be as fastest as possible

- Do *not* flush ever the file, it's only a waste under this scenario.


This will let me to avoid the shell launching crap and probably gain
also some more speed.

I understand this could be not exactly a top priority feature for git
people, but I would really like to get the best possible interface
with the plumbing git and the -o options is also a very common one.

Thanks
Marco

P.S: On another thread I explained why I see problematic linking
directly against libgit.a
I rewrite here for completeness:

> I've looked again to Shawn idea (and code) of linking qgit
> against libgit.a but I found these two difficult points:
>
> - traverse_commit_list(&revs, show_commit, show_object) is blocking,
> i.e. the GUI will stop responding for few seconds while traversing the
> list. This is easily and transparently solved by the OS scheduler if
> an external process is used for git-rev-list. To solve this in qgit I
> have two ways: 1) call QEventLoop() once in a while from inside
> show_commit()/ show_object() to process pending events  2) Use a
> separate thread (QThread class). The first idea is not nice, the
> second opens a whole a new set of problems and it's a big amount of
> not trivial new code to add.
>
> -  traverse_commit_list() having an internal state it's not
> re-entrant. git-rev-list it's used to load main view data but also
> file history in another tab, and the two calls _could_ be ran
> concurrently. With external process I simply run two instances of
> DataLoader class and consequently two external git-rev-list processes,
> but If I link against libgit.a that would be a big problem.
