From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Wed, 7 Jan 2009 10:55:56 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngm92hr.72d.sitaramc@sitaramc.homelinux.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
 <20090106080300.GA10079@coredump.intra.peff.net>
 <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net>
 <200901070027.21721.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 11:57:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKW6T-0007bh-Jq
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 11:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbZAGK4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 05:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbZAGK4P
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 05:56:15 -0500
Received: from main.gmane.org ([80.91.229.2]:33547 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbZAGK4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 05:56:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKW4z-0004PL-9I
	for git@vger.kernel.org; Wed, 07 Jan 2009 10:56:05 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 10:56:05 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 10:56:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104784>

On 2009-01-07, Boyd Stephen Smith Jr. <bss@iguanasuicide.net> wrote:
> On Tuesday 06 January 2009, Sitaram Chamarty <sitaramc@gmail.com> wrote=20

>>    chmod g+ws .git
>>
>>Now set the group to something (I use "gitpushers" ;-)
>>
>>    chgrp -R gitpushers .git

> ISTR this breaking here when someone on the team had a umask like 077 and=20
> was using file:// or ssh:// to push.  I tended up "fixing" things with a=20
> cronjob, (which is a bit of a hack) IIRC.

That doesn't sound right.  "git help init" says:
 - 0xxx: 0xxx is an octal number and each file will have mode 0xxx
 - 0xxx will override users umask(2) value, and thus, users
   with a safe umask (0077) can use this option
 - 0660 is equivalent to group.

So when you say "group", you're saying "0660", and when you
say "0660", you're overriding users umask value.

I sorta-kinda tested it (some output of the "find|xargs ls"
is snipped for brevity):

    $ mkdir umt;cd umt
    $ umask         
    0022                                 
    $ git init --shared=group
    Initialized empty shared Git repository in /home/sitaram/t/umt/.git/
    (reverse-i-search)`find': sfind f|ack .git|map -x du -sk |sort -n
    $ find . -type d|xargs ls -ald     
    drwxr-xr-x 3 sitaram sitaram 4096 2009-01-07 15:59 .             
    drwxrwsr-x 7 sitaram sitaram 4096 2009-01-07 15:59 ./.git        

    $ dummy_commit                   
    Created initial commit afb2645: file-30824 at Wed Jan  7 15:59:23 IST 2009
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file-30824
    $ find . -type d|xargs ls -ald
    drwxr-xr-x 3 sitaram sitaram 4096 2009-01-07 15:59 .
    drwxrwsr-x 9 sitaram sitaram 4096 2009-01-07 15:59 ./.git
    drwxrwsr-x 2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/a7
    drwxrwsr-x 2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/af
    drwxrwsr-x 2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/ca

    $ umask 077
    $ jeeves dummy_commit
    Created commit 232f157: file-3025 at Wed Jan  7 15:59:36 IST 2009
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file-3025
    $ find . -type d|xargs ls -ald
    drwxr-xr-x  3 sitaram sitaram 4096 2009-01-07 15:59 .
    drwxrwsr-x  9 sitaram sitaram 4096 2009-01-07 15:59 ./.git
    drwxrws---  2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/23
    drwxrwsr-x  2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/a7
    drwxrws---  2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/a8
    drwxrwsr-x  2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/af
    drwxrws---  2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/c7
    drwxrwsr-x  2 sitaram sitaram 4096 2009-01-07 15:59 ./.git/objects/ca
