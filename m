From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: Folder and files are deleted by git stash -u
Date: Thu, 05 Feb 2015 11:15:41 -0800
Message-ID: <xmqqvbjgkw4i.fsf@gitster.dls.corp.google.com>
References: <CADEaiE8zSptYy9GTi4ZZ2bZptbretW6kDM4srmrSqaYeavfFhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Tobias Preuss <tobias.preuss@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJRu1-0005oT-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbBETPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:15:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752561AbbBETPo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:15:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BDEE355D3;
	Thu,  5 Feb 2015 14:15:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=00+4WvBvYy3w9+XOzhEPYhC/WnQ=; b=OoGMFH
	GYJ89sWr6sI9sl8UEN4cjbfVGfeDHENOgojEIEKiItGRi7/D5GdeVYiZYbwmXXyg
	BuLEoDwAQsjSfDPkg4FItzAqNGilCmomDDiFBrwTr/I50b3NnXFp1p5D3NpDWAsn
	zcIkIvITxcSbeLkpp29TVlS+14DgVHfBZUlgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sQsr1hY7KPSam0PUnk33jlr1Jo3LOrrA
	Xq1Y524czU9tIa0GNNxCPVoDs1Rj4p4X0eKMgAzx6UsATgi6A5gxexZZB39qgAX2
	Vi341UxJR6s0PiNOIuCLlVWyW/2L5MHTA4GhW3Soomvl8uDqyc2SsmRMKtHfRlHB
	Od/MULweoJA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D512355D2;
	Thu,  5 Feb 2015 14:15:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB659355CF;
	Thu,  5 Feb 2015 14:15:42 -0500 (EST)
In-Reply-To: <CADEaiE8zSptYy9GTi4ZZ2bZptbretW6kDM4srmrSqaYeavfFhg@mail.gmail.com>
	(Tobias Preuss's message of "Thu, 5 Feb 2015 10:56:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60F575C6-AD6B-11E4-BC35-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263385>

Tobias Preuss <tobias.preuss@googlemail.com> writes:

> I noticed some bizarre behaviour when using: git stash -u.
> It deletes folders which contain files configured to be ignored.

The files you mark as ignored are expendable and this is not limited
to "stash".

    $ git init
    Initialized empty Git repository in /var/tmp/x/ignore/.git/
    $ echo \*.o >.gitignore
    $ git add .gitignore
    $ git commit -m void
    [master (root-commit) 457b70e] void
     1 file changed, 1 insertion(+)
     create mode 100644 .gitignore
    $ echo a regular file >a
    $ git add a
    $ git commit -m "a regular file"
    [master df839f0] a regular file
     1 file changed, 1 insertion(+)
     create mode 100644 a

We have two regular files, .gitignore and a, on 'master' branch.

    $ git checkout -b side HEAD^
    Switched to a new branch 'side'
    $ mkdir a
    $ >a/file.c
    $ >a/file.o
    $ git add .
    $ git commit -m 'a/file.c'
    [side 3199d63] a/file.c
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 a/file.c

We have two regular files, .gitignore and a/file.c, on 'side' branch,
which is checked out.  The object files that would be created by
compiling source files are set to be ignored by .gitignore rule.

Here is what should happen when you go to 'master':

    $ git checkout master
    Switched to branch 'master'
    $ /bin/ls -AF
    a  .git/  .gitignore

That is, a/file.c that is safely stored in 'side' branch is removed,
a/file.o that is expendable is deleted, and the empty directory 'a'
now can be replaced with the regular file 'a' the 'master' branch
wants to have.
