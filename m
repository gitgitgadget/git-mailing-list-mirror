From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG when trying to delete symbolic refs
Date: Tue, 16 Oct 2012 09:09:09 -0700
Message-ID: <7vr4oytn4q.fsf@alter.siamese.dyndns.org>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com>
 <507D315E.8040101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@suse.cz>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO9hs-00071b-M3
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab2JPQJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 12:09:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab2JPQJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 12:09:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF4108809;
	Tue, 16 Oct 2012 12:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o2cUJz5FFZSs
	afvTejpW4jpzQvE=; b=EOaVb21YMwprnYzeMrJ3G7x11sp9cdOle3kjgwySJN5O
	c+5C5hdjrOMlfPxVQBNUJVUl7JKsPhY/7/AlcQ/qj1N3L6O4wksU0d9FR7X/Od3q
	+TzXD5FS5z0kmLvz0aT1wKDgCPUSMrvx9PwNAhmDYYLfwtgfazQF1XbTOCscB6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aLhaTj
	iCFZo3WlRD5/Fjcj8W+AonrR7fQ8q8ijv17GNDWF1rWC1h89snf1fmFD/rRCDQ+n
	7RZfu4E3D1o3hytx00fqILDxKOe0jGJy1IRrBDLZYomd5HOqon98U2ocmuWNIxSx
	SAMig5Tn79NrLep/YNbmve+aCy7y0XxLDsbuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D53B8808;
	Tue, 16 Oct 2012 12:09:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA5518807; Tue, 16 Oct 2012
 12:09:10 -0400 (EDT)
In-Reply-To: <507D315E.8040101@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 16 Oct 2012 12:05:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D23984E6-17AB-11E2-85DE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207840>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 15.10.2012 10:50, schrieb Johan Herland:
>> Basically, there is a "master" branch, and an "alias" symref to
>> "master". When we naively try to delete the symref with "git branch =
-d
>> alias", it ends up:
>>=20
>>   - NOT deleting the "alias" symref
>>   - DELETING the "master" loose ref
>>   - NOT deleting the "master" packed ref
>>=20
>> So, from the user perspective, "git branch -d alias" ends up resetti=
ng
>> "master" (and "alias") back to the last time we happened to run "git
>> gc". Needless to say, this is not quite what we had in mind...
>>=20
>> AFAICS, there may be three possible "acceptable" outcomes when we ru=
n
>> "git branch -d alias" in the above scenario:
>>=20
>>   A. The symbolic ref is deleted. This is obviously what we expected=
=2E..
>
> Below is a patch to do that.
>
>>   B. The command fails because "alias" is a symref. This would be
>> understandable if we don't want to teach "branch -d" about symrefs.
>> But then, the error message should ideally explain which command we
>> should use to remove the symref.
>
> Renaming of symrefs with branch -m is disallowed because it's more
> complicated than it looks at first; this was discussed here:
> http://thread.gmane.org/gmane.comp.version-control.git/98825/focus=3D=
99206

Thanks for a reminder.

> I can't imagine why deletion should be prohibited as well, though.

I am not sure if it is a good idea to let "update-ref -d" work on a
symref, with or without --no-deref.  There are cases where you want
to remove the pointer ("symbolic-ref -d" is there for that), and
there are cases where you want to remove the underlying ref (but of
course you can "update-ref -d" the underlying ref yourself).  If
"update-ref -d" refused to work on a symref, we do not have to worry
about the confusion "which one is removed---the pointer, or the
pointee?"

> But I wonder why most delete_ref() calls in the code actually don't u=
se
> the flag REF_NODEREF, thus deleting symref targets instead of the
> symrefs themselves.  I may be missing something important here.

I suspect that is primarily because using a symref to represent
anything other than $GIT_DIR/HEAD and $GIT_DIR/refs/remotes/*/HEAD
is outside the normally supported use case and in the "may happen to
work" territory.

Having said all that, I think your patch is going in the right
direction.  If somebody had a symbolic ref in refs/heads/, the
removal should remove it, not the pointee, which may not even
exist.  Does "branch -d sym" work correctly with your patch when
refs/heads/sym is pointing at something that does not exist?

> ---
>  builtin/branch.c  |  2 +-
>  t/t3200-branch.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index ffd2684..31af114 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -221,7 +221,7 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds,
>  			continue;
>  		}
> =20
> -		if (delete_ref(name, sha1, 0)) {
> +		if (delete_ref(name, sha1, REF_NODEREF)) {
>  			error(remote_branch
>  			      ? _("Error deleting remote branch '%s'")
>  			      : _("Error deleting branch '%s'"),
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 79c8d01..4b73406 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -262,6 +262,16 @@ test_expect_success 'config information was rena=
med, too' \
>  	"test $(git config branch.s.dummy) =3D Hello &&
>  	 test_must_fail git config branch.s/s/dummy"
> =20
> +test_expect_success 'deleting a symref' '
> +	git branch target &&
> +	git symbolic-ref refs/heads/symlink refs/heads/target &&
> +
> +	git branch -d symlink &&
> +
> +	test_path_is_file .git/refs/heads/target &&
> +	test_path_is_missing .git/refs/heads/symlink
> +'
> +
>  test_expect_success 'renaming a symref is not allowed' \
>  '
>  	git symbolic-ref refs/heads/master2 refs/heads/master &&
