From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working
 directory
Date: Thu, 09 Apr 2009 01:49:35 -0700
Message-ID: <7vws9u2ov4.fsf@gitster.siamese.dyndns.org>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
 <1239260490-6318-2-git-send-email-pclouds@gmail.com>
 <1239260490-6318-3-git-send-email-pclouds@gmail.com>
 <1239260490-6318-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:51:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpzA-0004Dd-S0
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760917AbZDIItw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 04:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760729AbZDIItu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:49:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZDIItt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 04:49:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 02A85D887;
	Thu,  9 Apr 2009 04:49:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 22C44D885; Thu, 
 9 Apr 2009 04:49:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61858402-24E3-11DE-9955-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116156>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -168,6 +171,22 @@ int write_archive_entries(struct archiver_args *=
args,
>  	context.args =3D args;
>  	context.write_entry =3D write_entry;
> =20
> +	/*
> +	 * Setup index and instruct attr to read index only
> +	 */
> +	if (!args->worktree_attributes) {
> +		memset(&opts, 0, sizeof(opts));
> +		opts.index_only =3D 1;
> +		opts.head_idx =3D -1;
> +		opts.src_index =3D &the_index;
> +		opts.dst_index =3D &the_index;
> +		opts.fn =3D oneway_merge;
> +		init_tree_desc(&t, args->tree->buffer, args->tree->size);
> +		if (unpack_trees(1, &t, &opts))
> +			return -1;
> +		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);

Why use unpack_trees with oneway_merge?  You won't be doing "is this fi=
le
up-to-date in the work tree?", and you won't be writing the index out
either, so there is nothing gained by keeping the cached stat informati=
on
fresh, which is the major justification of using that mechanism.  I thi=
nk
using tree.c::read_tree() would be more appropriate.

> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index 0713bca..69a93fc 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -36,6 +36,11 @@ int cmd_tar_tree(int argc, const char **argv, cons=
t char *prefix)
>  		argv++;
>  		argc--;
>  	}
> +	if (2 <=3D argc && !strcmp(argv[1], "--fix-attributes")) {
> +		nargv[nargc++] =3D argv[1];
> +		argv++;
> +		argc--;
> +	}

I am not sure if it is worth backporting this new option to tar-tree wh=
ich
is an essentially backward-compatibility interface, and worse yet, doin=
g
it poorly (i.e. --fix-attributes must come after --remote=3D for unexpl=
ained
reason).

It would affect a bit more tests, but I think you would want to test bo=
th
the new "normal" mode of operation (generate archives with "git archive=
"
and "git tar-tree" without options and compare, for example), instead o=
f
adding --fix-attributes everywhere.
