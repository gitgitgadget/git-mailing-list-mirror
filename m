From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: a bug when execute "git status" in git version 1.7.7.431.g89633
Date: Sun, 23 Oct 2011 16:28:00 +0200
Message-ID: <4EA42470.1070501@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Oct 23 16:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHz4p-0000tE-NT
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 16:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab1JWO2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 10:28:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:60081 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573Ab1JWO2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 10:28:08 -0400
Received: from [192.168.2.104] (p4FFD9D8D.dip.t-dialin.net [79.253.157.141])
	by india601.server4you.de (Postfix) with ESMTPSA id 6E00A2F8061;
	Sun, 23 Oct 2011 16:28:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4EA415BD.1040109@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184140>

Am 23.10.2011 15:25, schrieb Ren=C3=A9 Scharfe:
> Am 23.10.2011 10:35, schrieb John Hsing:
>> ok,when i finish compiling git 1.7.7.431.g89633=EF=BC=8CI use it to =
check
>> Cyanogenod=EF=BC=88an Android mod source=EF=BC=89 by =E2=80=9Cgit st=
atus=E2=80=9D=EF=BC=8Cit happend this
>> error=EF=BC=81but when i reuse git v1.7.7=EF=BC=8Cit is OK=EF=BC=81s=
o i think it is a bug in
>> git 1.7.7.431.g89633=EF=BC=81My OS is Ubuntu Linux 10.10=EF=BC=8Csor=
ry for my bad
>> english=EF=BC=81 If you want to reproduce this error,please excute "=
git status"
>> in https://github.com/CyanogenMod/android_packages_apps_DSPManager.g=
it
>> repo!
>=20
> I can reproduce the malloc crash on Ubuntu 11.10 with these simple st=
eps:
>=20
> 	$ a=3Dandroid_packages_apps_DSPManager
> 	$ git-v1.7.7 clone https://github.com/CyanogenMod/$a.git
> 	Cloning into android_packages_apps_DSPManager...
> 	remote: Counting objects: 902, done.
> 	remote: Compressing objects: 100% (412/412), done.
> 	remote: Total 902 (delta 367), reused 838 (delta 324)
> 	Receiving objects: 100% (902/902), 136.78 KiB | 264 KiB/s, done.
> 	Resolving deltas: 100% (367/367), done.
> 	$ cd $a
>=20
> 	$ git-v1.7.7 status
> 	# On branch gingerbread
> 	nothing to commit (working directory clean)
>=20
> 	$ git-master status
> 	git: malloc.c:3096: sYSMALLOc: Assertion `(old_top =3D=3D (((mbinptr=
) (((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (struct=
 malloc_chunk, fd)))) && old_size =3D=3D 0) || ((unsigned long) (old_si=
ze) >=3D (unsigned long)((((__builtin_offsetof (struct malloc_chunk, fd=
_nextsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t))) - =
1))) && ((old_top)->size & 0x1) && ((unsigned long)old_end & pagemask) =
=3D=3D 0)' failed.
> 	Aborted

And valgrind reports the following errors (git was compiled with -O0 an=
d
-g) for master, but not for 1.7.7 nor master plus my ugly patch:

Invalid write of size 1
   at 0x4029DE5: memcpy (mc_replace_strmem.c:635)
   by 0x81159A5: convert_from_disk (read-cache.c:1247)
   by 0x8115BE4: read_index_from (read-cache.c:1326)
   by 0x81157D7: read_index (read-cache.c:1202)
   by 0x813A802: gitmodules_config (submodule.c:105)
   by 0x806857E: cmd_status (commit.c:1209)
   by 0x804B7F8: run_builtin (git.c:308)
   by 0x804B956: handle_internal_command (git.c:466)
   by 0x804BA4E: run_argv (git.c:512)
   by 0x804BBC0: main (git.c:585)
 Address 0x41f2d5e is 2 bytes after a block of size 6,356 alloc'd
   at 0x4028876: malloc (vg_replace_malloc.c:236)
   by 0x814C070: xmalloc (wrapper.c:35)
   by 0x8115B8E: read_index_from (read-cache.c:1315)
   by 0x81157D7: read_index (read-cache.c:1202)
   by 0x813A802: gitmodules_config (submodule.c:105)
   by 0x806857E: cmd_status (commit.c:1209)
   by 0x804B7F8: run_builtin (git.c:308)
   by 0x804B956: handle_internal_command (git.c:466)
   by 0x804BA4E: run_argv (git.c:512)
   by 0x804BBC0: main (git.c:585)

Syscall param lstat64(file_name) points to unaddressable byte(s)
   at 0x4131D32: __lxstat64@@GLIBC_2.2 (lxstat64.c:48)
   by 0x81154DE: refresh_index (read-cache.c:1133)
   by 0x8068687: cmd_status (commit.c:1226)
   by 0x804B7F8: run_builtin (git.c:308)
   by 0x804B956: handle_internal_command (git.c:466)
   by 0x804BA4E: run_argv (git.c:512)
   by 0x804BBC0: main (git.c:585)
 Address 0x41f2d5c is 0 bytes after a block of size 6,356 alloc'd
   at 0x4028876: malloc (vg_replace_malloc.c:236)
   by 0x814C070: xmalloc (wrapper.c:35)
   by 0x8115B8E: read_index_from (read-cache.c:1315)
   by 0x81157D7: read_index (read-cache.c:1202)
   by 0x813A802: gitmodules_config (submodule.c:105)
   by 0x806857E: cmd_status (commit.c:1209)
   by 0x804B7F8: run_builtin (git.c:308)
   by 0x804B956: handle_internal_command (git.c:466)
   by 0x804BA4E: run_argv (git.c:512)
   by 0x804BBC0: main (git.c:585)

Invalid read of size 1
   at 0x402A682: bcmp (mc_replace_strmem.c:679)
   by 0x8113D12: df_name_compare (read-cache.c:387)
   by 0x81478F9: do_compare_entry (unpack-trees.c:499)
   by 0x814791B: compare_entry (unpack-trees.c:504)
   by 0x8148086: unpack_callback (unpack-trees.c:747)
   by 0x8145EA5: traverse_trees (tree-walk.c:407)
   by 0x81477EB: traverse_trees_recursive (unpack-trees.c:460)
   by 0x814823D: unpack_callback (unpack-trees.c:809)
   by 0x8145EA5: traverse_trees (tree-walk.c:407)
   by 0x81477EB: traverse_trees_recursive (unpack-trees.c:460)
   by 0x814823D: unpack_callback (unpack-trees.c:809)
   by 0x8145EA5: traverse_trees (tree-walk.c:407)
 Address 0x41f2d5c is 0 bytes after a block of size 6,356 alloc'd
   at 0x4028876: malloc (vg_replace_malloc.c:236)
   by 0x814C070: xmalloc (wrapper.c:35)
   by 0x8115B8E: read_index_from (read-cache.c:1315)
   by 0x81157D7: read_index (read-cache.c:1202)
   by 0x813A802: gitmodules_config (submodule.c:105)
   by 0x806857E: cmd_status (commit.c:1209)
   by 0x804B7F8: run_builtin (git.c:308)
   by 0x804B956: handle_internal_command (git.c:466)
   by 0x804BA4E: run_argv (git.c:512)
   by 0x804BBC0: main (git.c:585)

Invalid read of size 1
   at 0x8100E0E: hash_name (name-hash.c:28)
   by 0x8100F3D: hash_index_entry (name-hash.c:78)
   by 0x8100FD3: lazy_init_name_hash (name-hash.c:96)
   by 0x8101197: index_name_exists (name-hash.c:159)
   by 0x80EADA9: dir_add_name (dir.c:596)
   by 0x80EB8CD: read_directory_recursive (dir.c:994)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EBCED: read_directory (dir.c:1101)
 Address 0x41f2d5c is 0 bytes after a block of size 6,356 alloc'd
   at 0x4028876: malloc (vg_replace_malloc.c:236)
   by 0x814C070: xmalloc (wrapper.c:35)
   by 0x8115B8E: read_index_from (read-cache.c:1315)
   by 0x81157D7: read_index (read-cache.c:1202)
   by 0x813A802: gitmodules_config (submodule.c:105)
   by 0x806857E: cmd_status (commit.c:1209)
   by 0x804B7F8: run_builtin (git.c:308)
   by 0x804B956: handle_internal_command (git.c:466)
   by 0x804BA4E: run_argv (git.c:512)
   by 0x804BBC0: main (git.c:585)

Invalid read of size 1
   at 0x402A687: bcmp (mc_replace_strmem.c:679)
   by 0x8113DF4: cache_name_compare (read-cache.c:413)
   by 0x81010F8: same_name (name-hash.c:134)
   by 0x81011E0: index_name_exists (name-hash.c:164)
   by 0x80EADA9: dir_add_name (dir.c:596)
   by 0x80EB8CD: read_directory_recursive (dir.c:994)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
   by 0x80EB895: read_directory_recursive (dir.c:983)
 Address 0x41f2d5c is 0 bytes after a block of size 6,356 alloc'd
   at 0x4028876: malloc (vg_replace_malloc.c:236)
   by 0x814C070: xmalloc (wrapper.c:35)
   by 0x8115B8E: read_index_from (read-cache.c:1315)
   by 0x81157D7: read_index (read-cache.c:1202)
   by 0x813A802: gitmodules_config (submodule.c:105)
   by 0x806857E: cmd_status (commit.c:1209)
   by 0x804B7F8: run_builtin (git.c:308)
   by 0x804B956: handle_internal_command (git.c:466)
   by 0x804BA4E: run_argv (git.c:512)
   by 0x804BBC0: main (git.c:585)
