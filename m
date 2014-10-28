From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 02/19] untracked cache: record .gitignore information
 and dir hierarchy
Date: Tue, 28 Oct 2014 18:37:41 +0100
Message-ID: <544FD465.2040700@web.de>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com> <1414411846-4450-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 18:37:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjAiM-0002Qc-3X
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 18:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbaJ1Rhq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 13:37:46 -0400
Received: from mout.web.de ([212.227.17.12]:56494 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbaJ1Rhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 13:37:46 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M6E6g-1Y2CyN3gLq-00yATo; Tue, 28 Oct 2014 18:37:42
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1414411846-4450-3-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:8iZST1zMfbzqb/ygSbtwQnC80I6LPUIowgA4ofhcj1Vq8mjU00S
 fqhAYWb9kx1/9sMc16GEvNe22TOuAFJBiCVBPmJOb5OzuQT+eaBZ6uRI5wvOZA7mhrCsHXU
 1oDcy2Zwe+XxxWNILJARFbROClKhr1PGHbKG3A1nl1ksIjtdr/DfgjFhfK5OoBTtYH+hp95
 /sDTxd+UosJu6xiZLkA/g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-10-27 13.10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  dir.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
----------
>  dir.h |  60 +++++++++++++++++++++++++++

>  2 files changed, 189 insertions(+), 21 deletions(-)

[]

> +struct untracked_cache_dir {
> +	struct untracked_cache_dir **dirs;
> +	char **untracked;
> +	/* null SHA-1 means this directory does not have .gitignore */
> +	unsigned char exclude_sha1[20];
> +	struct stat_data stat_data;
> +	unsigned int check_only : 1;
> +	unsigned int untracked_nr : 29;
> +	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
> +	char name[1];
> +};
Are we utilizing the CPU and the L2 cache in a good way ?
I would consider to re-arrange, according to the following rule:
- 64 bit ints first (we do not have any)
- pointers (may be 64 or 32 bits)
- structs
- ints
- chars

And then we have the question why untracked_nr gets 29 bits,
and check_only one bit, which means we have 2 bits spare ?

=46rom what I know from CPUs and compilers it could be slighty better t=
o give
32 bits to untracked_nr and either 1 bit to check_only,
or simply make check_only a char.
Or do I miss something ?

> +	struct untracked_cache_dir **dirs;
> +	char **untracked;
> +	/* null SHA-1 means this directory does not have .gitignore */
> +	struct stat_data stat_data;
> +	unsigned char exclude_sha1[20];
> +	unsigned int check_only : 1;
> +	unsigned int untracked_nr : 29;
> +	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
> +	char name[1];
