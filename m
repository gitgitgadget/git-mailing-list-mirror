From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Convert resolve_ref+xstrdup to new resolve_refdup
 function
Date: Mon, 12 Dec 2011 10:07:26 -0800
Message-ID: <7vpqft4qap.fsf@alter.siamese.dyndns.org>
References: <1323688832-32016-1-git-send-email-pclouds@gmail.com>
 <1323688832-32016-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAHm-00017f-Pa
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1LLSHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 13:07:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab1LLSH3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 13:07:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC6266FF9;
	Mon, 12 Dec 2011 13:07:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BsVGSP9qwAEx
	qU3In4YhAjO6cjo=; b=jTbTA/Cpl2ygQF4f433IOxoID6a3FiFLdIuTOdDcoedJ
	IJrCG7+8YuoDiP8hXp0RrzYNhBUlPwQyClXHagwbdpivk/WF0z9FsRjxdxSDK5i9
	Vytto5+1TEFwpRgqVjDM9w64/OATiAVllk5TYG3T+oqS5HVvfa0VpmlqO6dsAvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Bv2J8W
	SoPYnZlst0D08IN3aDMXRr2GDyWZEOoeZZRtCAPTjmXANkqSn0z+Re73WlkWoSMD
	SimzO0bUuBDd+vK6KgF8M11wqv5iPmmqxiqpWRabE+q5lZlHxS/hjfErcHQzai3Y
	4/j/nqZMQlq9pedKzOeWs0wk/DVM6Np1qLFOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A289A6FF8;
	Mon, 12 Dec 2011 13:07:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0735E6FF7; Mon, 12 Dec 2011
 13:07:27 -0500 (EST)
In-Reply-To: <1323688832-32016-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 12 Dec
 2011 18:20:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26D8196C-24EC-11E1-8023-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186922>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Thanks.

The patch looks correct but I have a slight maintainability concern and=
 a
suggestion for possible improvement.

> ...
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b7c6302..a66d3eb 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -696,17 +696,14 @@ static int switch_branches(struct checkout_opts=
 *opts, struct branch_info *new)
>  {
>  	int ret =3D 0;
>  	struct branch_info old;
> +	char *path;
>  	unsigned char rev[20];
>  	int flag;
>  	memset(&old, 0, sizeof(old));
> -	old.path =3D resolve_ref("HEAD", rev, 0, &flag);
> -	if (old.path)
> -		old.path =3D xstrdup(old.path);
> +	old.path =3D path =3D resolve_refdup("HEAD", rev, 0, &flag);

This uses "one 'const char *' pointer that is used for reading data fro=
m
and an extra 'char *' pointer that is used only for freeing" approach,
which has two advantages and one disadvantage:

 + Obviously, we do not have to cast away constness when freeing.

 + A caller that follows the pattern could move the "for-data" pointer
   without having to worry about affecting "for-freeing" pointer. It co=
uld
   even do something like this:

     char *for_freeing;
     const char *for_data;
     for_data =3D for_freeing =3D resolve_refdup(...);

     if (prefixcmp(for_data, "refs/heads/"))
     	for_data =3D skip_prefix(for_data, "refs/heads/");
     ... do other things using for_data pointer ...

     free(for_freeing);

 - If the for-freeing and for-data pointers are named too similarly, th=
e
   code becomes harder to read. It is easy for a person who is new to t=
he
   codebase to start using the for-freeing pointer to manipulate the da=
ta
   (mostly harmless) or even advance the pointer by mistake (bad).

A handful of places in the existing codebase use this "two pointers"
approach primarily for the second advantage. The way they avoid the
disadvantage is by naming the other pointer "$something_to_free" (and t=
he
"$something_" part is optional if there is only one such variable in th=
e
context) to make it clear that the variable is not meant to be looked a=
t
in the code and its primary purpose is for cleaning up at the end.

Perhaps renaming this "path" to "to_free" (or "path_to_free" if you wan=
t
to hint the "path-ness" to the readers, but see below) would make it le=
ss
likely that future tweakers mistakenly look at, modify the string thru,=
 or
worse yet move the pointer itself.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index a1c8534..6437db2 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1096,6 +1096,7 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>  	struct commit_list *common =3D NULL;
>  	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
>  	struct commit_list **remotes =3D &remoteheads;
> +	char *branch_ref;
> =20
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_merge_usage, builtin_merge_options);
> @@ -1104,12 +1105,9 @@ int cmd_merge(int argc, const char **argv, con=
st char *prefix)
>  	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
>  	 * current branch.
>  	 */
> -	branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
> -	if (branch) {
> -		if (!prefixcmp(branch, "refs/heads/"))
> -			branch +=3D 11;
> -		branch =3D xstrdup(branch);
> -	}
> +	branch =3D branch_ref =3D resolve_refdup("HEAD", head_sha1, 0, &fla=
g);

Without s/branch_ref/to_free/ this part is unreadable and unmaintainabl=
e,
as it invites the "which variable should I use?" question.

It is more important to clarify that the "branch" variable is what the
code should look at and manipulate by *not* calling this for-freeing
pointer after what it contains (i.e. "branch").

When naming a "for-freeing" pointer variable, the kind of data the area=
 of
memory happens to contain is of secondary importance. Being deliberatel=
y
vague about what the area of memory may contain is a good thing, becaus=
e
it actively discourages the program from looking at the area via the
pointer if the variable is named "to_free" or something that does not
specify what it contains.

Other places in this patch that call the for-freeing variable "ref" sha=
re
the same issue but they are less specific than their for-data variable
counterpart, which makes it slightly less risky than this instance.
