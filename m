From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/3] p7300: added performance tests for clean
Date: Mon, 06 Apr 2015 22:40:09 +0200
Message-ID: <5522EF29.9000008@web.de>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com> <1428320904-12366-3-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?RXJpayBFbGZzdHLDtm0=?= <erik.elfstrom@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 22:40:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfDok-0004Vq-Vh
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 22:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbbDFUkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 16:40:19 -0400
Received: from mout.web.de ([212.227.15.14]:56542 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062AbbDFUkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 16:40:17 -0400
Received: from [192.168.2.107] ([79.223.111.123]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LvB2o-1ZMQX948iw-010IqW; Mon, 06 Apr 2015 22:40:14
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1428320904-12366-3-git-send-email-erik.elfstrom@gmail.com>
X-Provags-ID: V03:K0:J71oyAuLR94ZWciAchyamv54BU3RhXVtRaGf/xtf7T6ywcNLvtT
 vR7dvCw3UCq5C7DhxSSoOpU5XEBmDfy7YEFxxzLN5S47fHzsCc8JHVzfNwSty0ESPJ3g0+R
 0iTpDAfJ8byj5TJuNOLnWEk1JiqNmKpwZX+3l5wbx44n4UI3pD1/1RJhPNy0vn5WIGvKDLY
 cjXO01fO/SRANHLQoxkkg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266880>

On 2015-04-06 13.48, Erik Elfstr=C3=B6m wrote:
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
>  t/perf/p7300-clean.sh | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100755 t/perf/p7300-clean.sh
>=20
> diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
> new file mode 100755
> index 0000000..3f56fb2
> --- /dev/null
> +++ b/t/perf/p7300-clean.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description=3D"Test git-clean performance"
> +
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +test_checkout_worktree
> +
> +test_expect_success 'setup untracked directory with many sub dirs' '
> +	rm -rf 500_sub_dirs 50000_sub_dirs clean_test_dir &&
> +	mkdir 500_sub_dirs 50000_sub_dirs clean_test_dir &&
> +	for i in $(seq 1 500)
I think "seq" is bash-only, and can be easily replaced by "test_seq"=20

> +	do
> +		mkdir 500_sub_dirs/dir$i
> +	done &&
> +	for i in $(seq 1 100)
> +	do
> +		cp -r 500_sub_dirs 50000_sub_dirs/dir$i
> +	done
> +'
> +
> +test_perf 'clean many untracked sub dirs, check for nested git' '
> +	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
> +	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
> +	git clean -q -f -d  clean_test_dir/ &&
> +	test 0 =3D $(ls -A clean_test_dir/ | wc -l)

Is the "ls -A" portable on all systems:
http://pubs.opengroup.org/onlinepubs/009695399/utilities/ls.html

My feeling is that the "emptiness" of a directory can by tested by simp=
ly removing it:
> +	git clean -q -f -d  clean_test_dir/ &&
> +	rmdir clean_test_dir
(And similar below)
