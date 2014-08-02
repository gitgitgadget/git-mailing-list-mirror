From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: Bug report about symlinks
Date: Sat, 02 Aug 2014 16:10:21 +0200
Message-ID: <53DCF14D.8040705@web.de>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de> <xmqqppgkw55g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nikolay Avdeev <avdeev@math.vsu.ru>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 16:11:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDa1Z-0006A8-M4
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 16:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbaHBOLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2014 10:11:00 -0400
Received: from mout.web.de ([212.227.17.12]:63587 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070AbaHBOK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 10:10:59 -0400
Received: from [192.168.178.27] ([79.250.190.177]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M5fwS-1WFy9g3NEm-00xXzy; Sat, 02 Aug 2014 16:10:48
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqppgkw55g.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:mQBB3AEWOvwoXwJrJDuMi6cEPBChrR6UtwzJKf+4SZiT5uDBfKJ
 19DuEBFmxU3pECIponTIAMv12Xuya8pnaCF54xjD7+SUFfoYMRRztDowytKvH55CCIK3ilL
 vbEhLkn1df0ucZa7lPeFsrnIoxOnTybsJhHvmQo3z21MrCYIrmx2fMgLlSoHkPI8Wqfw9lp
 Djr2J5OGw5c2KkV7L94UQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254700>

Am 01.08.2014 um 18:23 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> # Create test repo with two directories with two files each.
>> $ git init
>> Initialized empty Git repository in /tmp/.git/
>> $ mkdir a b
>> $ echo x >a/equal
>> $ echo x >b/equal
>> $ echo y >a/different
>> $ echo z >b/different
>> $ git add a b
>> $ git commit -minitial
>> [master (root-commit) 6d36895] initial
>>   4 files changed, 4 insertions(+)
>>   create mode 100644 a/different
>>   create mode 100644 a/equal
>>   create mode 100644 b/different
>>   create mode 100644 b/equal
>>
>> # Replace one directory with a symlink to the other.
>> $ rm -rf b
>> $ ln -s a b
>>
>> # First git status call.
>> $ git status
>> On branch master
>> Changes not staged for commit:
>>    (use "git add/rm <file>..." to update what will be committed)
>>    (use "git checkout -- <file>..." to discard changes in working di=
rectory)
>>
>>          deleted:    b/different
>>
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>>
>>          b
>>
>> no changes added to commit (use "git add" and/or "git commit -a")
>> ...
>>
>> It could be debated if the first git status call should also report
>> b/equal as deleted.
>=20
> Hmph.
>=20
> I wonder if "could be" is an understatement.  The difference of
> reporting between b/equal and b/different may indicate that somebody
> is mistakenly comparing the index with these paths, without first
> checking each path with has_symlink_leading_path(), or something,
> no?

How about the patch below?  Before it checks if an index entry exists
in the work tree, it checks if its path includes a symlink.  After
the patch, git status reports b/equal as deleted, too.  The test
suite still passes.

And do we need to use the threaded_ variant of the function here?


diff --git a/read-cache.c b/read-cache.c
index 5d3c8bd..6f0057f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1064,6 +1064,14 @@ static struct cache_entry *refresh_cache_ent(str=
uct index_state *istate,
 		return ce;
 	}
=20
+	if (has_symlink_leading_path(ce->name, ce_namelen(ce))) {
+		if (ignore_missing)
+			return ce;
+		if (err)
+			*err =3D ENOENT;
+		return NULL;
+	}
+
 	if (lstat(ce->name, &st) < 0) {
 		if (ignore_missing && errno =3D=3D ENOENT)
 			return ce;
