From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 13:49:44 -0800
Message-ID: <xmqqegccmikn.fsf@gitster.mtv.corp.google.com>
References: <1455583834-4796-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Felipe =?utf-8?Q?Go?= =?utf-8?Q?n=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: =?utf-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 22:49:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVnVH-0002Bn-JT
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 22:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbcBPVts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 16:49:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755413AbcBPVtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 16:49:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 894B145FDB;
	Tue, 16 Feb 2016 16:49:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dxfnrHkkj1kE
	U5SrKsnAhdELdOA=; b=PNm4Gv7jZAWMm/6UH+jXyggekTwf0hYlxur+/KBXXTNZ
	ADtIk2tIvsFBehZ04TmE7xmZ9O4JIO57rGm2WnkJpMVzOXTX/jtKAl8dGKT3k7Dm
	4KtxgNEcKdlAr9Th+08HXhd22TtUwD1Am0X+xYhIH05BcrJmTPOArccIhPgYHZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fq7iLd
	ef9EO1b3e5eDR/IbziTNddXw18rNCyrymhsStLMMYy2sUWkUP7U9nhGvvn3rNALN
	2fB7y/Z1orj+CEvTKIzXqY+vfg5R6LAOsOW4uZ1q9B7/Y26t6+LPt9VAbgIpIEB8
	oO9c5W2z/eMMOWFQaIU4LQe2yaetOonY6VJVg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 803EF45FDA;
	Tue, 16 Feb 2016 16:49:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F368645FD9;
	Tue, 16 Feb 2016 16:49:45 -0500 (EST)
In-Reply-To: <1455583834-4796-1-git-send-email-felipegassis@gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Mon, 15 Feb 2016
 22:50:34
	-0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31AD25B6-D4F7-11E5-93DA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286437>

"Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:

> +no-renames;;
> +	Turn off rename detection.
> +	See also linkgit:git-diff[1] `--no-renames`.

Even though by default for merge-recursive the rename detection is
on, if we are adding an option to control this aspect of the
behaviour from the command line, it should follow the usual pattern,
i.e.

 (1) the code to parse options would allow an earlier "--no-renames"
     on the command line to be overridden with a later "--renames"; and

 (2) the description in the documentation would be headed by
     "--[no-]renames", describes which one is the default, etc.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 8eabde2..ca67805 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1839,9 +1839,16 @@ int merge_trees(struct merge_options *o,
> =20
>  		entries =3D get_unmerged();
>  		record_df_conflict_files(o, entries);
> -		re_head  =3D get_renames(o, head, common, head, merge, entries);
> -		re_merge =3D get_renames(o, merge, common, head, merge, entries);
> -		clean =3D process_renames(o, re_head, re_merge);
> +		if (o->detect_rename) {
> +			re_head  =3D get_renames(o, head, common, head, merge, entries);
> +			re_merge =3D get_renames(o, merge, common, head, merge, entries);
> +			clean =3D process_renames(o, re_head, re_merge);
> +		}
> +		else {
> +			re_head  =3D xcalloc(1, sizeof(struct string_list));
> +			re_merge =3D xcalloc(1, sizeof(struct string_list));
> +			clean =3D 1;
> +		}

Yup, this is much nicer than butchering diffcore-rename.c for no
good reason ;-).

Even if you _know_ that process_renames() currently does not do
anything other than returning 1, it is a bad idea to hardcode that
knowledge on the caller's side.  Perhaps

>  		entries =3D get_unmerged();
>  		record_df_conflict_files(o, entries);
> -		re_head  =3D get_renames(o, head, common, head, merge, entries);
> -		re_merge =3D get_renames(o, merge, common, head, merge, entries);
> +		if (o->detect_rename) {
> +			re_head  =3D get_renames(o, head, common, head, merge, entries);
> +			re_merge =3D get_renames(o, merge, common, head, merge, entries);
> +		} else {
> +			re_head  =3D xcalloc(1, sizeof(struct string_list));
> +			re_merge =3D xcalloc(1, sizeof(struct string_list));
> +		}
> 		clean =3D process_renames(o, re_head, re_merge);

Preparing a new empty string_list instance with xcalloc() without
doing string_list_init() is probably "caller knows too much about
implementation detail of the API", but get_renames() seems to do so
already, so I'll let it pass.
