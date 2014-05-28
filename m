From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 20:32:16 +0700
Message-ID: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 28 15:32:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpdyO-0003CJ-7G
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 15:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbaE1Ncs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 09:32:48 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:43228 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbaE1Ncr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 09:32:47 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so17512650qgd.18
        for <git@vger.kernel.org>; Wed, 28 May 2014 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NVIHuRm3M1K0A6dbEnaODBQV4Ai00c9HaKUMz6Efclo=;
        b=fVkgKHgwsp4TSBowe57Zb6BQ5Py3ZoNFuPPqYOcpNLIMfac9qw3gC9NdsrmV9oCkXi
         LHPEK7hvbwQ/ooYukaFPlhbX2cp2OPe8/0dNHQbmHf/XkHBbZYOi6P3e+koVFrjXDVy8
         /4ycsRmejESJ25m9NDyHeBS8MY4USvLFbN7HM1Ksy8re1uI2YfhRrETK7nWLh4So7KF+
         i22cpoVXHkPl3OvHK3Uh0cPkDVr3ipVz3hZyxNRq9La5k8u/i9rPgzCi3P12LQHu7Hdg
         BJ3CKEMgYrD7g+mFpk2howjWXqA2NwLppdJp9FSdFzVXb0ONYsg9uYiEOHAx4x9d72ug
         mJyg==
X-Received: by 10.224.160.202 with SMTP id o10mr38511239qax.8.1401283966627;
 Wed, 28 May 2014 06:32:46 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 28 May 2014 06:32:16 -0700 (PDT)
In-Reply-To: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250280>

On Tue, May 27, 2014 at 11:47 PM, Dale R. Worley <worley@alum.mit.edu> =
wrote:
> I've discovered a problem using Git.  It's not clear to me what the
> "correct" behavior should be, but it seems to me that Git is failing
> in an undesirable way.
>
> The problem arises when trying to handle a very large file.  For
> example:
>
>     $ git --version
>     git version 1.8.3.1
>     $ mkdir $$
>     $ cd $$
>     $ git init
>     Initialized empty Git repository in /common/not-replicated/worley=
/temp/5627/.git/
>     $ truncate --size=3D20G big_file
>     $ ls -l
>     total 0
>     -rw-rw-r--. 1 worley worley 21474836480 May 27 11:59 big_file
>     $ time git add big_file
>
>     real        4m48.752s
>     user        4m31.295s
>     sys 0m16.747s
>     $
>
> At this point, either 'git fsck' or 'git commit' fails:
>
>     $ git fsck --full --strict
>     notice: HEAD points to an unborn branch (master)
>     Checking object directories: 100% (256/256), done.
>     fatal: Out of memory, malloc failed (tried to allocate 2147483648=
1 bytes)

Back trace for this one

#3  0x000000000055cf39 in xmalloc (size=3D21474836481) at wrapper.c:49
#4  0x000000000055cffd in xmallocz (size=3D21474836480) at wrapper.c:73
#5  0x0000000000537858 in unpack_compressed_entry (p=3D0x858ac0,
w_curs=3D0x7fffffffc0f8, curpos=3D18, size=3D21474836480) at
sha1_file.c:1924
#6  0x0000000000538364 in unpack_entry (p=3D0x858ac0, obj_offset=3D12,
final_type=3D0x7fffffffc1e4, final_size=3D0x7fffffffc1d8) at
sha1_file.c:2206
#7  0x00000000004fb0a2 in verify_packfile (p=3D0x858ac0,
w_curs=3D0x7fffffffc320, fn=3D0x43f5f2 <fsck_obj_buffer>,
progress=3D0x858a90, base_count=3D0) at pack-check.c:119
#8  0x00000000004fb3f4 in verify_pack (p=3D0x858ac0, fn=3D0x43f5f2
<fsck_obj_buffer>, progress=3D0x858a90, base_count=3D0) at
pack-check.c:177
#9  0x00000000004401d7 in cmd_fsck (argc=3D0, argv=3D0x7fffffffd650,
prefix=3D0x0) at builtin/fsck.c:677

Not easy to fix. I started working on converting fsck to use
index-pack code for pack verification. index-pack supports large files
well, so in the end it might fix this (as well as speeding up fsck).
But that work has stalled for a long time.

>
>     $ git commit -m Test.
>     [master (root-commit) 3df3655] Test.
>     fatal: Out of memory, malloc failed (tried to allocate 2147483648=
1 bytes)

And back trace

#11 0x00000000004b9da0 in read_sha1_file (sha1=3D0x8558a0
"\256/s\324\370\304\344\212\304I\v\342\334MS\002\352\214\061\222",
type=3D0x7fffffffc6c4, size=3D0x8558d0) at cache.h:820
#12 0x00000000004c1b98 in diff_populate_filespec (s=3D0x8558a0,
size_only=3D0) at diff.c:2749
#13 0x00000000004c0110 in diff_filespec_is_binary (one=3D0x8558a0) at d=
iff.c:2188
#14 0x00000000004c0f0b in builtin_diffstat (name_a=3D0x858530
"big_file", name_b=3D0x0, one=3D0x8584e0, two=3D0x8558a0,
diffstat=3D0x7fffffffc8a0, o=3D0x7fffffffce88, p=3D0x855910) at diff.c:=
2435
#15 0x00000000004c2fd4 in run_diffstat (p=3D0x855910, o=3D0x7fffffffce8=
8,
diffstat=3D0x7fffffffc8a0) at diff.c:3168
#16 0x00000000004c603a in diff_flush_stat (p=3D0x855910,
o=3D0x7fffffffce88, diffstat=3D0x7fffffffc8a0) at diff.c:4081
#17 0x00000000004c70e4 in diff_flush (options=3D0x7fffffffce88) at diff=
=2Ec:4520
#18 0x00000000004e5d59 in log_tree_diff_flush (opt=3D0x7fffffffcaf0) at
log-tree.c:715
#19 0x00000000004e5e5a in log_tree_diff (opt=3D0x7fffffffcaf0,
commit=3D0x8585b0, log=3D0x7fffffffc9a0) at log-tree.c:747
#20 0x00000000004e60b1 in log_tree_commit (opt=3D0x7fffffffcaf0,
commit=3D0x8585b0) at log-tree.c:810
#21 0x000000000042c45c in print_summary (prefix=3D0x0,
sha1=3D0x7fffffffd300 ".&G=C8=91\360\243\202\351&!\035\312q\374\345\314=
LL)",
initial_commit=3D1) at builtin/commit.c:1426
#22 0x000000000042d213 in cmd_commit (argc=3D0, argv=3D0x7fffffffd650,
prefix=3D0x0) at builtin/commit.c:1750

If we could have an option in read_sha1_file to read max to <n> bytes
(enough for binary detection purpose), it would fix this. Another
option is declare all files larger than core.bigfilethreshold binary.
Easier in both senses of implementation cost and looseness.

> Even doing a 'git reset' does not put the repository in a state where
> 'git fsck' will complete:
>
>     $ git reset
>     $ git fsck --full --strict
>     notice: HEAD points to an unborn branch (master)
>     Checking object directories: 100% (256/256), done.
>     fatal: Out of memory, malloc failed (tried to allocate 2147483648=
1 bytes)

I don't know how many commands are hit by this. If you have time and
gdb, please put a break point in die_builtin() function and send
backtraces for those that fail. You could speed up the process by
creating a smaller file and set the environment variable
GIT_ALLOC_LIMIT (in kilobytes) to a number lower than that size. If
git attempts to allocate a block larger than that limit it'll die.
--=20
Duy
