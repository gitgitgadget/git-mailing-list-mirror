From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] archive.c: add support for --submodules[=(all|checkedout)]
Date: Fri, 06 May 2011 20:39:17 +0200
Message-ID: <4DC44055.8020905@web.de>
References: <8638611E-BE0A-41CE-A406-96A0A143FFAE@deepdarc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Robert Quattlebaum <darco@deepdarc.com>
X-From: git-owner@vger.kernel.org Fri May 06 20:39:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIPw3-0004VS-5w
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 20:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509Ab1EFSjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 14:39:25 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33040 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932468Ab1EFSjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 14:39:24 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 774F418E2018B;
	Fri,  6 May 2011 20:39:22 +0200 (CEST)
Received: from [93.246.59.164] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QIPvu-0001je-00; Fri, 06 May 2011 20:39:22 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <8638611E-BE0A-41CE-A406-96A0A143FFAE@deepdarc.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/WKwgF2vi3fF5cJFkOtzdjngryBqcujbMqGmdV
	mUyON8yyQpaWEiZMZ+2gXZtmveDSQg80c1n1euS8k/R+iYyOEd
	D+Q8SpOZJq7dum1VqzJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172997>

Am 05.05.2011 19:00, schrieb Robert Quattlebaum:
> Anybody know what ever happened to this change? It still applies
> fairly cleanly, and appears to work. I sent an email to Lars, but
> I haven't heard back from him. What additional work needs to be
> done on this?

Thanks for bringing that up, I haven't been aware of this patch!
As some other git commands did learn to recurse into submodules
in recent years this is a worthwhile addition (and an item on my
to-do list too ;-).

Just a few comments:

*) I'd vote for renaming this option to "=97recurse-submodules" as
   most other commands that learned to recurse into submodules use
   that option name. (For some commands "--submodule[s]" has an
   obvious meaning, for others "--recursive" does, so we prefer to
   use "=97recurse-submodules" for consistency)

*) I'm not sure it still makes sense to add an add_alt_odb()
   function to sha1_file.c as submodule.c has add_submodule_odb()
   which seems to do basically the same thing (although I'm not
   familiar enough with the alternate odb code to confirm that
   after glancing over it).

*) The test should be renamed to t5002 as "t5001-archive-attr.sh"
   has been added in the meantime.

Apart from that the patch looks good to me.

> I've got this patch rebased to a more recent commit, in case anyone
> is interested:
>=20
> <https://github.com/darconeous/git/tree/archive-submodule-support>
>=20
> On Jan 24, 2009, at 4:52 PM, Lars Hjemli wrote:
>=20
>> The --submodules option uses the enhanced read_tree_recursive() to
>> enable inclusion of submodules in the generated archive.
>>
>> When invoked with `--submodules=3Dall` all gitlink entries will be
>> traversed, and when invoked with --submodules=3Dcheckedout (the defa=
ult
>> option) only gitlink entries with a git repo (i.e. checked out sub-
>> modules) will be traversed.
>>
>> When a gitlink has been selected for traversal, it is required that =
all
>> objects necessary to perform this traversal are available in either =
the
>> primary odb or through an alternate odb. To this end, git archive wi=
ll
>> insert the object database of the selected gitlink (when checked out=
)
>> as an alternate odb, using the new function add_alt_odb(). And since
>> alternates now can be added after parsing of objects/info/alternates=
,
>> the error message in link_alt_odb_entry() has been updated to not
>> mention this file.
>>
>> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
>> ---
>> Documentation/git-archive.txt |    5 ++
>> archive.c                     |   81 +++++++++++++++++++++++++-
>> archive.h                     |    4 +
>> cache.h                       |    1 +
>> sha1_file.c                   |   11 +++-
>> t/t5001-archive-submodules.sh |  129 +++++++++++++++++++++++++++++++=
++++++++++
>> 6 files changed, 228 insertions(+), 3 deletions(-)
>> create mode 100755 t/t5001-archive-submodules.sh
>>
>> diff --git a/Documentation/git-archive.txt b/Documentation/git-archi=
ve.txt
>> index 9c750e2..6afffb9 100644
>> --- a/Documentation/git-archive.txt
>> +++ b/Documentation/git-archive.txt
>> @@ -58,6 +58,11 @@ OPTIONS
>> --worktree-attributes::
>> 	Look for attributes in .gitattributes in working directory too.
>>
>> +--submodules[=3D<spec>]::
>> +	Include the content of submodules in the archive. The specificatio=
n
>> +	of which submodules to include can be either 'checkedout' (default=
)
>> +	or 'all'.
>> +
>> <extra>::
>> 	This can be any options that the archiver backend understands.
>> 	See next section.
>> diff --git a/archive.c b/archive.c
>> index 1944ed4..6f0f690 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -5,6 +5,7 @@
>> #include "archive.h"
>> #include "parse-options.h"
>> #include "unpack-trees.h"
>> +#include "refs.h"
>>
>> static char const * const archive_usage[] =3D {
>> 	"git archive [options] <tree-ish> [<path>...]",
>> @@ -95,6 +96,70 @@ static void setup_archive_check(struct git_attr_c=
heck *check)
>> 	check[1].attr =3D attr_export_subst;
>> }
>>
>> +static int include_repository(const char *path)
>> +{
>> +	struct stat st;
>> +	const char *tmp;
>> +
>> +	/* Return early if the path does not exist since it is OK to not
>> +	 * checkout submodules.
>> +	 */
>> +	if (stat(path, &st) && errno =3D=3D ENOENT)
>> +		return 1;
>> +
>> +	tmp =3D read_gitfile_gently(path);
>> +	if (tmp) {
>> +		path =3D tmp;
>> +		if (stat(path, &st))
>> +			die("Unable to stat submodule gitdir %s: %s (%d)",
>> +			    path, strerror(errno), errno);
>> +	}
>> +
>> +	if (!S_ISDIR(st.st_mode))
>> +		die("Submodule gitdir %s is not a directory", path);
>> +
>> +	if (add_alt_odb(mkpath("%s/objects", path)))
>> +		die("submodule odb %s could not be added as an alternate",
>> +		    path);
>> +
>> +	return 0;
>> +}
>> +
>> +static int check_gitlink(struct archiver_args *args, const unsigned=
 char *sha1,
>> +			 const char *path)
>> +{
>> +	switch (args->submodules) {
>> +	case 0:
>> +		return 0;
>> +
>> +	case SUBMODULES_ALL:
>> +		/* When all submodules are requested, we try to add any
>> +		 * checked out submodules as alternate odbs. But we don't
>> +		 * really care whether any particular submodule is checked
>> +		 * out or not, we are going to try to traverse it anyways.
>> +		 */
>> +		include_repository(mkpath("%s.git", path));
>> +		return READ_TREE_RECURSIVE;
>> +
>> +	case SUBMODULES_CHECKEDOUT:
>> +		/* If a repo is checked out at the gitlink path, we want to
>> +		 * traverse into the submodule. But we ignore the current
>> +		 * HEAD of the checked out submodule and always uses the SHA1
>> +		 * recorded in the gitlink entry since we want the content
>> +		 * of the archive to match the content of the <tree-ish>
>> +		 * specified on the command line.
>> +		 */
>> +		if (!include_repository(mkpath("%s.git", path)))
>> +			return READ_TREE_RECURSIVE;
>> +		else
>> +			return 0;
>> +
>> +	default:
>> +		die("archive.c: invalid value for args->submodules: %d",
>> +		    args->submodules);
>> +	}
>> +}
>> +
>> struct archiver_context {
>> 	struct archiver_args *args;
>> 	write_archive_entry_fn_t write_entry;
>> @@ -137,7 +202,8 @@ static int write_archive_entry(const unsigned ch=
ar *sha1, const char *base,
>> 		err =3D write_entry(args, sha1, path.buf, path.len, mode, NULL, 0)=
;
>> 		if (err)
>> 			return err;
>> -		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>> +		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE :
>> +			check_gitlink(args, sha1, path.buf));
>> 	}
>>
>> 	buffer =3D sha1_file_to_archive(path_without_prefix, sha1, mode,
>> @@ -300,6 +366,7 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>> 	const char *remote =3D NULL;
>> 	const char *exec =3D NULL;
>> 	const char *output =3D NULL;
>> +	const char *submodules =3D NULL;
>> 	int compression_level =3D -1;
>> 	int verbose =3D 0;
>> 	int i;
>> @@ -315,6 +382,9 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>> 		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
>> 			"read .gitattributes in working directory"),
>> 		OPT__VERBOSE(&verbose, "report archived files on stderr"),
>> +		{OPTION_STRING, 0, "submodules", &submodules, "kind",
>> +			"include submodule content in the archive",
>> +			PARSE_OPT_OPTARG, NULL, (intptr_t)"checkedout"},
>> 		OPT__COMPR('0', &compression_level, "store only", 0),
>> 		OPT__COMPR('1', &compression_level, "compress faster", 1),
>> 		OPT__COMPR_HIDDEN('2', &compression_level, 2),
>> @@ -370,6 +440,15 @@ static int parse_archive_args(int argc, const c=
har **argv,
>> 					format, compression_level);
>> 		}
>> 	}
>> +
>> +	if (!submodules)
>> +		args->submodules =3D 0;
>> +	else if (!strcmp(submodules, "checkedout"))
>> +		args->submodules =3D SUBMODULES_CHECKEDOUT;
>> +	else if (!strcmp(submodules, "all"))
>> +		args->submodules =3D SUBMODULES_ALL;
>> +	else
>> +		die("Invalid submodule kind: %s", submodules);
>> 	args->verbose =3D verbose;
>> 	args->base =3D base;
>> 	args->baselen =3D strlen(base);
>> diff --git a/archive.h b/archive.h
>> index 038ac35..ef4d081 100644
>> --- a/archive.h
>> +++ b/archive.h
>> @@ -12,8 +12,12 @@ struct archiver_args {
>> 	unsigned int verbose : 1;
>> 	unsigned int worktree_attributes : 1;
>> 	int compression_level;
>> +	int submodules;
>> };
>>
>> +#define SUBMODULES_CHECKEDOUT 1
>> +#define SUBMODULES_ALL 2
>> +
>> typedef int (*write_archive_fn_t)(struct archiver_args *);
>>
>> typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, =
const unsigned char *sha1, const char *path, size_t pathlen, unsigned i=
nt mode, void *buffer, unsigned long size);
>> diff --git a/cache.h b/cache.h
>> index 28899b7..cb80992 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -893,6 +893,7 @@ extern struct alternate_object_database {
>> 	char base[FLEX_ARRAY]; /* more */
>> } *alt_odb_list;
>> extern void prepare_alt_odb(void);
>> +extern int add_alt_odb(const char *path);
>> extern void add_to_alternates_file(const char *reference);
>> typedef int alt_odb_fn(struct alternate_object_database *, void *);
>> extern void foreach_alt_odb(alt_odb_fn, void*);
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 889fe71..203f98b 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -276,8 +276,7 @@ static int link_alt_odb_entry(const char * entry=
, int len, const char * relative
>>
>> 	/* Detect cases where alternate disappeared */
>> 	if (!is_directory(ent->base)) {
>> -		error("object directory %s does not exist; "
>> -		      "check .git/objects/info/alternates.",
>> +		error("Alternate object directory %s does not exist",
>> 		      ent->base);
>> 		free(ent);
>> 		return -1;
>> @@ -2715,3 +2714,11 @@ void assert_sha1_type(const unsigned char *sh=
a1, enum object_type expect)
>> 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
>> 		    typename(expect));
>> }
>> +
>> +int add_alt_odb(const char *path)
>> +{
>> +	int err =3D link_alt_odb_entry(path, strlen(path), NULL, 0);
>> +	if (!err)
>> +		prepare_packed_git_one((char *)path, 0);
>> +	return err;
>> +}
>> diff --git a/t/t5001-archive-submodules.sh b/t/t5001-archive-submodu=
les.sh
>> new file mode 100755
>> index 0000000..14383b3
>> --- /dev/null
>> +++ b/t/t5001-archive-submodules.sh
>> @@ -0,0 +1,129 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'git archive can include submodule content'
>> +
>> +. ./test-lib.sh
>> +
>> +add_file()
>> +{
>> +	git add $1 &&
>> +	git commit -m "added $1"
>> +}
>> +
>> +add_submodule()
>> +{
>> +	mkdir $1 && (
>> +		cd $1 &&
>> +		git init &&
>> +		echo "File $2" >$2 &&
>> +		add_file $2
>> +	) &&
>> +	add_file $1
>> +}
>> +
>> +test_expect_success 'by default, submodules are not included' '
>> +	echo "File 1" >1 &&
>> +	add_file 1 &&
>> +	add_submodule 2 3 &&
>> +	add_submodule 4 5 &&
>> +	cat <<EOF >expected &&
>> +1
>> +2/
>> +4/
>> +EOF
>> +	git archive HEAD >normal.tar &&
>> +	tar -tf normal.tar >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'with --submodules, checked out submodules are =
 included' '
>> +	cat <<EOF >expected &&
>> +1
>> +2/
>> +2/3
>> +4/
>> +4/5
>> +EOF
>> +	git archive --submodules HEAD >full.tar &&
>> +	tar -tf full.tar >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'with --submodules=3Dall, all submodules are in=
cluded' '
>> +	git archive --submodules=3Dall HEAD >all.tar &&
>> +	tar -tf all.tar >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'submodules in submodules are supported' '
>> +	(cd 4 && add_submodule 6 7) &&
>> +	add_file 4 &&
>> +	cat <<EOF >expected &&
>> +1
>> +2/
>> +2/3
>> +4/
>> +4/5
>> +4/6/
>> +4/6/7
>> +EOF
>> +	git archive --submodules HEAD >recursive.tar &&
>> +	tar -tf recursive.tar >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'packed submodules are supported' '
>> +	msg=3D$(cd 2 && git repack -ad && git count-objects) &&
>> +	test "$msg" =3D "0 objects, 0 kilobytes" &&
>> +	git archive --submodules HEAD >packed.tar &&
>> +	tar -tf packed.tar >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'missing submodule packs triggers an error' '
>> +	mv 2/.git/objects/pack .git/packdir2 &&
>> +	test_must_fail git archive --submodules HEAD
>> +'
>> +
>> +test_expect_success '--submodules skips non-checked out submodules'=
 '
>> +	cat <<EOF >expected &&
>> +1
>> +2/
>> +4/
>> +4/5
>> +4/6/
>> +4/6/7
>> +EOF
>> +	rm -rf 2/.git &&
>> +	git archive --submodules HEAD >partial.tar &&
>> +	tar -tf partial.tar >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success '--submodules=3Dall fails if gitlinked objects =
are missing' '
>> +	test_must_fail git archive --submodules=3Dall HEAD
>> +'
>> +
>> +test_expect_success \
>> +	'--submodules=3Dall does not require submodules to be checked out'=
 '
>> +	cat <<EOF >expected &&
>> +1
>> +2/
>> +2/3
>> +4/
>> +4/5
>> +4/6/
>> +4/6/7
>> +EOF
>> +	mv .git/packdir2/* .git/objects/pack/ &&
>> +	git archive --submodules=3Dall HEAD >all2.tar &&
>> +	tar -tf all2.tar >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'missing objects in a submodule triggers an err=
or' '
>> +	find 4/.git/objects -type f | xargs rm &&
>> +	test_must_fail git archive --submodules HEAD
>> +'
>> +
>> +test_done
>> --=20
>> 1.7.4.1
>>
>=20
> __________________
> Robert Quattlebaum
> Jabber: darco@deepdarc.com
> eMail:  darco@deepdarc.com
> www:    http://www.deepdarc.com/
