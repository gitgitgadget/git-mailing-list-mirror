From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC] i18n.pathencoding
Date: Mon, 03 Sep 2012 00:59:00 +0200
Message-ID: <5043E4B4.9050801@dewire.com>
References: <201209010811.33994.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 01:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8JGU-00081Y-Sz
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 01:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab2IBXHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Sep 2012 19:07:30 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:39943 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab2IBXH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 19:07:29 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Sep 2012 19:07:29 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id C482B823B2;
	Mon,  3 Sep 2012 00:59:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A0IQ7Il-EFnS; Mon,  3 Sep 2012 00:59:01 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h30n1fls32o828.telia.com [213.65.101.30])
	by zimbra.dewire.com (Postfix) with ESMTPSA id 1B4CE823A9;
	Mon,  3 Sep 2012 00:59:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20120828 Thunderbird/16.0
In-Reply-To: <201209010811.33994.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204679>

Torsten B=C3=B6gershausen skrev 2012-09-01 08.11:> Allow path names to =
be encoded in UTF-8 in the repository
 > and checkout out as e.g. ISO-8859-1 in the working tree.

Ack for attempting this.

Did it myself if 2007, but times weren't ripe then, I guess.

 > +i18n.pathEncoding::
 > +	This option is only used by some implementations of git.
 > +	When "git init" sets core.supportspathencoding to true,
 > +	i18n.pathEncoding can be set to re-encode path names when
 > +	a working tree is checked out.
 > +	Path names may be e.g. encoded in ISO-8859-1 and are stored as
 > +	UTF-8 encoded in the repository.
 > +	When not set, the encoding of path names is the same in working tr=
ee
 > +	and the repository.

"If set, then core.precomposeunicode is ignored on Mac OS X."

 > diff --git a/compat/reencode_pathname.c b/compat/reencode_pathname.c
 > new file mode 100644
 > index 0000000..3bdc776
 > --- /dev/null
 > +++ b/compat/reencode_pathname.c
 > @@ -0,0 +1,441 @@
 > +/*
 > + * Converts pathnames from one encoding into another.
 > + * The pathnames are stored as UTF-8 in the repository,
 > + * and might be checkout out as e.g. ISO-8859-1 in the working tree
 > + *
 > + * On MacOS X decomposed unicode is converted into precomposed unic=
ode.
, ignoring the setting of core.precomposeunicode.

[...]
 > + */
 > +
 > +#define REENCODE_PATHNAME_C
 > +#include "cache.h"
 > +#include "utf8.h"
 > +#include "reencode_pathname.h"
 > +
 > +#if defined(OLD_ICONV) || (defined(__sun__) && !defined(_XPG6))
 > +	typedef const char *iconv_ibp;
 > +#else
 > +	typedef char *iconv_ibp;
 > +#endif
 > +
 > +const static char *repo_path_encoding =3D "UTF-8";
 > +
 > +static iconv_t iconv_open_or_die(const char *tocode, const char *fr=
omcode)
 > +{
 > +	iconv_t my_iconv;
 > +	my_iconv =3D iconv_open(tocode, fromcode);
join these two lines

 > +	if (my_iconv =3D=3D (iconv_t) -1)
 > +		die_errno(_("iconv_open(%s,%s) failed"), tocode, fromcode);
 > +	return my_iconv;
 > +}
 > +
 > +static size_t has_non_ascii(const char *s, size_t maxlen, size_t *s=
trlen_c)
 > +{
 > +	const uint8_t *ptr =3D (const uint8_t *)s;
 > +	size_t strlen_chars =3D 0;
 > +	size_t ret =3D 0;
 > +
 > +	if (!ptr || !*ptr)
 > +		return 0;
 > +
 > +	while (*ptr && maxlen) {
 > +		if (*ptr & 0x80)
 > +			ret++;
 > +		strlen_chars++;
 > +		ptr++;
 > +		maxlen--;
 > +	}
 > +	if (strlen_c)
 > +		*strlen_c =3D strlen_chars;
 > +
 > +	return ret;
 > +}
 > +
 > +#ifdef PRECOMPOSE_UNICODE
 > +void probe_utf8_pathname_composition(char *path, int len)
 > +{
 > +	static const char *auml_nfc =3D "\xc3\xa4";
 > +	static const char *auml_nfd =3D "\x61\xcc\x88";
 > +	int output_fd;
 > +	if (precomposed_unicode !=3D -1)
 > +		return; /* We found it defined in the global config, respect it *=
/
a bland line here would be nice

 > +	strcpy(path + len, auml_nfc);
 > +	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
 > +	if (output_fd >=3D 0) {
 > +		close(output_fd);
 > +		strcpy(path + len, auml_nfd);
 > +		/* Indicate to the user, that we can configure it to true */
 > +		if (!access(path, R_OK))
 > +			git_config_set("core.precomposeunicode", "false");
 > +		/* To be backward compatible, set precomposed_unicode to 0 */
 > +		precomposed_unicode =3D 0;
 > +		strcpy(path + len, auml_nfc);
 > +		if (unlink(path))
 > +			die_errno(_("failed to unlink '%s'"), path);
 > +	}
 > +}
 > +#endif

[...]

 > +struct dirent_psx *renc_pn_readdir(RENC_FN_DIR *renc_pn_dir)
 > +{
 > +	struct dirent *res;
 > +	res =3D readdir(renc_pn_dir->dirp);
 > +	if (res) {
 > +		size_t namelenz =3D strlen(res->d_name) + 1; /* \0 */
 > +		size_t new_len_needed =3D 0;
 > +		int ret_errno =3D errno;
 > +
 > +		renc_pn_dir->dirent_utf8->d_ino	 =3D res->d_ino;
 > +		renc_pn_dir->dirent_utf8->d_type =3D res->d_type;
 > +	do {
 > +		 if (new_len_needed > renc_pn_dir->dirent_utf8->max_name_len) {
indent

[...]

 > diff --git a/environment.c b/environment.c
 > index 85edd7f..ba81575 100644
 > --- a/environment.c
 > +++ b/environment.c
 > @@ -59,6 +59,7 @@ int grafts_replace_parents =3D 1;
 >   int core_apply_sparse_checkout;
 >   int merge_log_config =3D -1;
 >   int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composi=
tion() */
 > +const char *wt_path_encoding =3D NULL;
indent

 >   struct startup_info *startup_info;
 >   unsigned long pack_size_limit_cfg;
 >
 > diff --git a/git-compat-util.h b/git-compat-util.h
 > index 35b095e..877b060 100644
 > --- a/git-compat-util.h
 > +++ b/git-compat-util.h
 > @@ -153,13 +153,21 @@
 >   #endif
 >   #endif
 >
 > -/* used on Mac OS X */
 > -#ifdef PRECOMPOSE_UNICODE
 > -#include "compat/precompose_utf8.h"
 > +#if defined(PATH_ENCODING) || defined(PRECOMPOSE_UNICODE)
 > +#include "compat/reencode_pathname.h"
 >   #else
 > -#define precompose_str(in,i_nfd2nfc)
 > -#define precompose_argv(c,v)
 > -#define probe_utf8_pathname_composition(a,b)
 > +#define reencode_argv(c,v)
 > +#endif
 > +
 > +/* needed for Mac OS X */
 > +#ifndef PRECOMPOSE_UNICODE
 > +#define probe_utf8_pathname_composition(a,b);
 > +#endif
 > +
 > +#ifndef PATH_ENCODING
 > +#define str_worktree2repolen(in, insz) (NULL)
 > +#define str_repo2worktree(in) (NULL)
 > +#define str_worktree2repo(in) (NULL)
 >   #endif
 >
 >   #ifndef NO_LIBGEN_H
 > diff --git a/parse-options.c b/parse-options.c
 > index c1c66bd..5840c18 100644
 > --- a/parse-options.c
 > +++ b/parse-options.c
 > @@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv, c=
onst char *prefix,
 >   		usage_with_options(usagestr, options);
 >   	}
 >
 > -	precompose_argv(argc, argv);
 > +	reencode_argv(argc, argv);
 >   	return parse_options_end(&ctx);
 >   }
 >
 > diff --git a/t/t3911-i18n-filename-8859.sh b/t/t3911-i18n-filename-8=
859.sh
 > new file mode 100755
 > index 0000000..aa2be57
 > --- /dev/null
 > +++ b/t/t3911-i18n-filename-8859.sh
 > @@ -0,0 +1,251 @@
 > +#!/bin/sh
 > +#
 > +# Copyright (c) 2010 Torsten B=C3=B6gershausen
 > +#
 > +
 > +test_description=3D'file system encodings UTF-8 ISO8859-1'
 > +
 > +. ./test-lib.sh
 > +
 > +fname_UTF_8=3D`printf '\303\206\302\242'`
 > +fname_ISO8859_1=3D`printf '\306\242'`
 > +Euro_utf8=3D`printf '\342\202\254'`
 > +supportspathencoding=3D`git config core.supportspathencoding` || :
 > +
 > +
 > +add_file_dir_link() {
 > +	local bname=3D$1
 > +	local fname=3D$2
 > +	test_expect_success "add file $fname.f $bname" '
 > +		git checkout master &&
 > +		git checkout -b add_f_$bname &&
 > +		>$fname.f &&
 > +		git add $fname.f &&
 > +		git commit -m "add fname"
 > +	'
 > +
 > +	test_expect_success "add dir $fname.d $bname" '
 > +		git checkout master &&
 > +		git checkout -b add_d_$bname &&
 > +		mkdir $fname.d &&
 > +		touch $fname.d/$fname.f &&
 > +		git add $fname.d/$fname.f &&
 > +		git commit -m "add fname.d/fname"
 > +	'
 > +
 > +	i=3D0
 > +	for src in x $fname; do
 > +		for dst in x $fname; do
 > +			test_expect_success "add link $dst.l->$src.f on branch add_l_${i=
}_$bname" '
 > +				git checkout master &&
 > +				git checkout -b add_l_${i}_$bname &&
 > +				ln -s $src.f $dst.l &&
 > +				git add $dst.l &&
 > +				git commit -m "add fname.l $i"
 > +			'
 > +			i=3D$(($i+1))
 > +		done
 > +	done
 > +}
 > +
 > +test_expect_success "setup add rm x" '
 > +	>x &&
 > +	git add x &&
 > +	git commit -m "1st commit" &&
 > +	git rm x &&
 > +	git commit -m "rm x"
 > +'
 > +
 > +#combinations to be tested:
 > +# UTF-8     -> ISO8859-1
 > +# ISO8859-1 -> UTF-8
 > +
 > +if test "$supportspathencoding"
 > +then
 > +	srcencodings=3D"ISO8859-1 UTF-8"
 > +	for srcenc in $srcencodings
 > +	do
 > +		case $srcenc in
 > +		ISO8859-1)
 > +			dstenc=3DUTF-8
 > +		;;
 > +		UTF-8)
 > +			dstenc=3DISO8859-1
 > +		;;
 > +		UTF-8-MAC)
 > +			dstenc=3DUTF-8
 > +		;;
 > +		*)
 > +			echo >&2 "Wrong encoding $srcenc"
 > +			exit 1
 > +		;;
 > +		esac
 > +		eval fname_src=3D\$fname_$(echo $srcenc | sed -e 's/-/_/g' -e 's/=
_MAC//')
 > +		eval fname_dst=3D\$fname_$(echo $dstenc | sed -e 's/-/_/g')
 > +		test_expect_success "setup $srcenc" '
 > +			git checkout master &&
 > +			git config i18n.pathencoding $srcenc
 > +		'
 > +		add_file_dir_link $srcenc $fname_src
 > +
 > +		test_expect_success "setup $dstenc" '
 > +			git checkout master &&
 > +			echo "git checkout Master" >&2
 > +			ls -l >&2
 > +			git config i18n.pathencoding $dstenc
 > +		'
 > +
 > +		test_expect_success "checkout file $dstenc (was $srcenc)" '
 > +			git checkout add_f_$srcenc
 > +		'
 > +
 > +		test_expect_success "exists file $dstenc (was $srcenc)" '
 > +			test -f $fname_dst.f
 > +		'
 > +
 > +		test_expect_success "log file $dstenc (was $srcenc)" '
 > +			git log $fname_dst.f
 > +		'
 > +
 > +		test_expect_success "git mv" '
 > +			git checkout -b mv_file_$srcenc &&
 > +			git mv $fname_dst.f XX.f &&
 > +			git commit -m "git mv fname_dst.f XX.f"
 > +		'
 > +
 > +		test_expect_success "checkout dir $dstenc (was $srcenc)" '
 > +			git checkout add_d_$srcenc
 > +		'
 > +
 > +		test_expect_success "exist dir $dstenc (was $srcenc)" '
 > +			test -d $fname_dst.d
 > +		'
 > +
 > +		test_expect_success "log dir $dstenc (was $srcenc)" '
 > +			git log $fname_dst.d
 > +		'
 > +
 > +		i=3D0
 > +		for src in x $fname_dst; do
 > +			for dst in x $fname_dst; do
 > +				test_expect_success "checkout link $dst.l->$src.f branch add_l_=
${i}_$srcenc" '
 > +					git checkout add_l_${i}_$srcenc
 > +				'
 > +				test_expect_success "exist link $dst.l->$src.f branch add_l_${i=
}_$srcenc" '
 > +					test -L $dst.l
 > +				'
 > +				test_expect_success "log link $dst.l->$src.f branch add_l_${i}_=
$srcenc" '
 > +					git log $dst.l
 > +				'
 > +				test_expect_success "readlink $dst.l->$src.f branch add_l_${i}_=
$srcenc" '
 > +					echo "$src.f" >expect &&
 > +					readlink "$dst.l" > actual &&
 > +					test_cmp expect actual &&
 > +					rm expect actual
 > +				'
 > +				i=3D$(($i+1))
 > +			done
 > +		done
 > +	done
 > +	# Make sure that Euro sign can NOT be checked out in 8859
"8859-1", The euro sign exists in 8859-15.

 > +	#fname_src=3DEuro
 > +	test_expect_success "setup UTF-8" '
 > +		git checkout master &&
 > +		git config i18n.pathencoding UTF-8
 > +	'
 > +	add_file_dir_link Euro $Euro_utf8
 > +
 > +	test_expect_success "setup ISO8859-1" '
 > +		git checkout master &&
 > +		rm -rf * &&
 > +		git config i18n.pathencoding ISO8859-1
 > +	'
 > +	test_expect_success "checkout file Euro branch add_f_Euro" '
 > +		git checkout add_f_Euro
Missing && ?

 > +		echo *  >actual &&
 > +		echo "*" >expect &&
 > +		test_cmp expect actual &&
 > +		rm expect actual
 > +	'
 > +
 > +	test_expect_success "checkout dir Euro branch add_d_Euro" '
 > +		rm -rf * &&
 > +		test_must_fail git checkout add_d_Euro
 > +	'
 > +
 > +	test_expect_success "Cleanup" '
 > +		git config i18n.pathencoding UTF-8 &&
 > +		git checkout master &&
 > +		rm -rf * &&
 > +		git reset --hard &&
 > +		git config i18n.pathencoding ISO8859-1
 > +	'
 > +
 > +	test_expect_success "checkout link Euro.l->x.f branch add_l_1_Euro=
" '
 > +		! git checkout add_l_1_Euro
 > +	'
 > +
 > +	test_expect_success "No link Euro.l->x.f" '
 > +		echo *  >actual &&
 > +		echo "*" >expect &&
 > +		test_cmp expect actual &&
 > +		rm expect actual
 > +	'
 > +
 > +	test_expect_success "Cleanup after Euro.l->x.f" '
 > +		git config i18n.pathencoding UTF-8 &&
 > +		git checkout master &&
 > +		rm -rf * &&
 > +		git reset --hard &&
 > +		git config i18n.pathencoding ISO8859-1
 > +	'
 > +
 > +	# Checkoing out a soft link pointing to a filename outside
"checking"

 > +	# 8859-1 should fail
 > +	test_expect_failure "checkout link x.l->Euro.f branch add_l_2_Euro=
" '
 > +		! git checkout add_l_2_Euro
 > +	'
 > +
 > +	test_expect_success "No link x.f->Euro.l" '
 > +		echo *  >actual &&
 > +		echo "*" >expect &&
 > +		test_cmp expect actual &&
 > +		rm expect actual
 > +	'
 > +
 > +	test_expect_success "Cleanup after link x.l->Euro.f branch" '
 > +		git config i18n.pathencoding UTF-8 &&
 > +		git checkout master &&
 > +		rm -rf * &&
 > +		git reset --hard &&
 > +		git config i18n.pathencoding ISO8859-1
 > +	'
 > +
 > +	test_expect_success "checkout link Euro.l->Euro.f branch add_l_3_E=
uro" '
 > +		! git checkout add_l_3_Euro
 > +	'
 > +
 > +	test_expect_success "No link Euro.l->Euro.f" '
 > +		echo *  >actual &&
 > +		echo "*" >expect &&
 > +		test_cmp expect actual &&
 > +		rm expect actual
 > +	'
 > +
 > +else
 > +	test_expect_success "setup 8859" '
"8859-1"

 > +		git config i18n.pathencoding ISO8859-1 &&
 > +		git checkout -b add_file_8859 &&
 > +		> $fname_src.f &&
 > +		git add $fname_src.f &&
 > +		git commit -m "add fname_src" &&
 > +		git config i18n.pathencoding UTF-8 &&
 > +		rm -rf * &&
 > +		git reset --hard
 > +	'
 > +	test_expect_success "Silent support of pathencoding" '
 > +		test_must_fail test -f $fname_UTF_8.f
 > +	'
 > +fi
 > +
 > +test_done

-- robin
