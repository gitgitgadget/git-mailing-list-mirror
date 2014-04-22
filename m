From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC] Speed up "git status" by caching untracked file info
Date: Tue, 22 Apr 2014 11:56:02 +0200
Message-ID: <53563CB2.5030603@gmail.com>
References: <1397713918-22829-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 11:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcXR2-0003tQ-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 11:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbaDVJ4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2014 05:56:12 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:51510 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233AbaDVJ4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 05:56:06 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so1611948wes.27
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=vg6nCmDT+wkzIh12eD7fyeaK8JaUoHGEJLjA7nRLJkc=;
        b=G861jFnjLQEdCNvVk2nT1LPZP7XChYqmVrbA+6cOa5h5JjczSDKt4SklnlYHL3HsQg
         MZ9Cau79SWJ18OPpo+m5jFU3WBprC/XE2e3pv0X6hEn8WejLRppMgq/ubFEFtRvLiw+v
         XkEe02QZfKUjWaUXE+1oUo1Kc+6gCxYSE4XSSajF4BrfsSq4YCeOW9oUuwAtiXhOY2/6
         r6UWMATaStrXm4N9kwsvHIdsfy6tX6tP/1Y6qP5z0oZcUoKqvLPvP5p3MbCdQlhK6NrF
         P8svxQIGSo7KIy0rVH9HkNFU2t2B7pXkqjf4YyQhhbfZWVsOh4H8RYLp1UrLtl5HSzic
         T7Qw==
X-Received: by 10.194.60.114 with SMTP id g18mr1851950wjr.61.1398160564726;
        Tue, 22 Apr 2014 02:56:04 -0700 (PDT)
Received: from [10.1.116.60] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id f7sm40682009wjy.24.2014.04.22.02.56.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 02:56:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1397713918-22829-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246723>

Am 17.04.2014 07:51, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> This patch serves as a heads up about a feature I'm working on. I hop=
e
> that by posting it early, people could double check if I have made
> some fundamental mistakes that completely ruin the idea. It's about
> speeding up "git status" by caching untracked file info in the index
> _if_ your file system supports it (more below).
>=20
> The whole WIP series is at
>=20
> https://github.com/pclouds/git/commits/untracked-cache
>=20
> I only post the real meat here. I'm aware of a few incomplete details
> in this patch, but nothing fundamentally wrong. So far the numbers ar=
e
> promising.  ls-files is updated to run fill_directory() twice in a
> row and "ls-files -o --directory --no-empty-directory --exclude-stand=
ard"
> (with gcc -O0) gives me:
>=20
>            first run  second (cached) run
> gentoo-x86    500 ms             71.6  ms
> wine          140 ms              9.72 ms
> webkit        125 ms              6.88 ms

IIRC name_hash.c::lazy_init_name_hash took ~100ms on my system, so hope=
fully you did a dummy 'cache_name_exists("anything")' before starting t=
he measurement of the first run?

> linux-2.6     106 ms             16.2  ms
>=20
> Basically untracked time is cut to one tenth in the best case
> scenario. The final numbers would be a bit higher because I haven't
> stored or read the cache from index yet. Real commit message follows.=
=2E
>=20
>=20
> read_directory() plays a bit part in the slowness of "git status"
> because it has to read every directory and check for excluded entries=
,
> which is really expensive. This patch adds an option to cache the
> results so that after the first slow read_directory(), the following
> calls should be cheap and fast.
>=20
> The following inputs are sufficient to determine what files in a
> directory are excluded:
>=20
>  - The list of files and directories of the direction in question
>  - The $GIT_DIR/index
>  - The content of $GIT_DIR/info/exclude
>  - The content of core.excludesfile
>  - The content (or the lack) of .gitignore of all parent directories
>    from $GIT_WORK_TREE
>=20

The dir_struct.flags also play a big role in evaluation of read_directo=
ry.

E.g. it seems untracked files are not properly recorded if the cache is=
 filled with '--ignored' option:

> @@ -1360,15 +1603,18 @@ static enum path_treatment read_directory_rec=
ursive(struct dir_struct *dir,
>  			break;
> =20
>  		case path_untracked:
> -			if (!(dir->flags & DIR_SHOW_IGNORED))
> -				dir_add_name(dir, path.buf, path.len);
> +			if (dir->flags & DIR_SHOW_IGNORED)
> +				break;
> +			dir_add_name(dir, path.buf, path.len);
> +			if (cdir.fdir)
> +				add_untracked(untracked, path.buf + baselen);
>  			break;

Similarly, the '--directory' option controls early returns from the dir=
ectory scan (via read_directory_recursive's check_only argument), so yo=
u won't be able to get a full untracked files listing if the cache was =
recorded with '--directory'. Additionally, '--directory' aggregates the=
 state at the topmost untracked directory, so that directory's cached s=
tate depends on all sub-directories as well...

I wonder if it makes sense to separate cache recording logic from read_=
directory_recursive and friends, which are mainly concerned with flags =
processing.

> If we can cheaply validate all those inputs for a certain directory,
> we are sure that the current code will always produce the same
> results, so we can cache and reuse those results.
>=20
> This is not a silver bullet approach. When you compile a C file, for
> example, the old .o file is removed and a new one with the same name
> created, effectively invalidating the containing directory's
> cache. But at least with a large enough work tree, there could be man=
y
> directories you never touch. The cache could help there.
>=20
> The first input can be checked using directory mtime. In many
> filesystems, directory mtime is updated when direct files/dirs are
> added or removed (*). If you do not use such a file system, this
> feature is not for you.
>=20
> The second one can be hooked from read-cache.c. Whenever a file (or a
> submodule) is added or removed from a directory, we invalidate that
> directory. This will be done in a later patch.
>=20
> The remaining inputs are easy, their SHA-1 could be used to verify
> their contents. We do need to read .gitignore files and digest
> them. But they are usually few and small, so the overhead should not
> be much.
>=20
> At the implementation level, the whole directory structure is saved,
> each directory corresponds to one struct untracked_dir.

With the usual options (e.g. standard 'git status'), untracked director=
ies are mostly skipped, so the cache would mostly store tracked directo=
ries. Naming it 'struct untracked_dir' is a bit confusing, IMO.

> Each directory
> holds SHA-1 of the .gitignore underneath (or null if it does not
> exist) and the list of untracked "files" and subdirs that need to
> recurse into if all is well. Untracked subdirectories are saved in th=
e
> file queue and are the reason of quoting "files" in the previous
> sentence.
>=20
> On the first run, no untracked_dir is valid, the default code path is
> run. prep_exclude() is updated to record SHA-1 of .gitignore along th=
e
> way. read_directory_recursive() is updated to record untracked files.
>=20
> On subsequent runs, read_directory_recursive() reads stat info of the
> directory in question and verifies if files/dirs have been added or
> removed. With the help of prep_exclude() to verify .gitignore chain,
> it may decide "all is well" and enable the fast path in
> treat_path(). read_directory_recursive() is still called for
> subdirectories even in fast path, because a directory mtime does not
> cover all subdirs recursively.
>=20
> So if all is really well, read_directory() becomes a series of
> open(".gitignore"), read(".gitignore"), close(), hash_sha1_file() and
> stat(<dir>) _without_ heavyweight exclude filtering. There should be
> no overhead if this feature is disabled.
>=20

Wouldn't mtime of .gitignore files suffice here (so you don't need to o=
pen and parse them every time)?
