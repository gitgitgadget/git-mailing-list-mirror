From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] merge-recursive: Workaround unused variable warning
Date: Wed, 18 Aug 2010 16:02:04 -0600
Message-ID: <AANLkTik9mho7Pm5m=3dEbtMrH1r81Lc480i_z2_aHCxs@mail.gmail.com>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
	<1281665352-10533-2-git-send-email-newren@gmail.com>
	<AANLkTikLXy4gPttmX=wzcDaFAfZO=OEk4PEDKh3sCSOF@mail.gmail.com>
	<20100818001032.GA7694@burratino>
	<7veidvagz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 00:02:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olqi5-0003FS-TY
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 00:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab0HRWCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 18:02:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50777 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0HRWCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 18:02:06 -0400
Received: by fxm13 with SMTP id 13so635816fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JV4GCZlXShrP3FaY4c6CkMn1R++fo3y60/dzqZRCkUg=;
        b=EKtNM8CfVZMDqG9mlh27AF72wnBRWsvaafEW0KMCN3XyW8k4MEq9VTJbRLBUyCnERs
         Qntq3o6Gb1HIYLpi61NVzWF/ogLdCdcAp7f6ua6P5bYy+MSom5Y3breoZn62qNNXB67i
         rUFWfljwPwpo1JdMdqhppP368ZSLdZzBXq8Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R397SRZ/bqPhjLDr4Dhi4B3JnGpS2xDUJryq0kW78lO+63yiXrr1wXRYO3PsJ82Pio
         wpmZLlDItG8gvYVfQHQNAuw67Flzc6kbXH4VftySLQYYeS7tbB5hO24osQ9J62hEwWJ5
         AVDwl4zeTSMNyHW9F+aBk3NvLRSbOMS4iI4b4=
Received: by 10.223.119.10 with SMTP id x10mr8508954faq.1.1282168924875; Wed,
 18 Aug 2010 15:02:04 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 18 Aug 2010 15:02:04 -0700 (PDT)
In-Reply-To: <7veidvagz8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153887>

Hi,

On Wed, Aug 18, 2010 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
<snip>
>> Yes, that sounds like a good idea. =C2=A0The user would probably ben=
efit
>> from knowing what happened.
>
> I'd agree. =C2=A0This assert() is not about protecting new callers fr=
om making
> obvious programming error by passing wrong parameters, but about Elij=
ah
> not being confident enough that the changes made to process_entry() w=
ith
> this series really covers all the cases so that only D/F cases are le=
ft
> unprocessed.

Actually, it is pretty clear right now that only D/F cases are left
unprocessed, and in particular D->F cases.  This is because
process_entry() starts with unconditionally setting "entry->processed
=3D 1" and only unsets it in the one 'if' block where we know that
(!o_sha && !!a_sha !=3D !!b_sha &&
string_list_has_string(&o->current_directory_set, path)).

So, I'd say it is more about programming errors, in particular ones
where people modify the code to make process_entry() leave more cases
unprocessed than what is currently possible without also making the
necessary modifications to process_df_entry().

> Another possibility is to move this assert() out of process_df_entry(=
) and
> have it on the calling side. =C2=A0Perhaps something like the attache=
d.
>
> BTW, it is not so obvious if (!o_sha && !!a_sha !=3D !!b_sha) is equi=
valent
> to "we are handling a D-F case". =C2=A0Can you explain why?

It's not equivalent.  Things are slightly confusing, because !<sha>
can mean either (a) there is nothing at the given path, or (b) there
is a directory at the given path.  The only way to tell which of the
two it means is to look up the path in o->current_directory_set.

A directory/file conflict ("D-F" in my shorthand) implies !!a_sha !=3D
!!b_sha (but not vice versa).

A directory/file conflict where the relevant path was a file in the
merge-base ("F->D" in my shorthand) implies (o_sha && !!a_sha !=3D
!!b_sha).  This case is handled just fine by process_entry() (if the
file was unchanged, the correct resolution is to delete it, allowing
paths beneath the directory of the same name to be handled by later
process_entry() calls -- although this silently relies on the order of
entries from get_unmerged() to be such that things do operate in this
order.  That seems to be correct for the cases I've seen).

A directory/file conflict where the path was a directory in the
merge-base ("D->F" in my shorthand) implies (!o_sha && !!a_sha !=3D
!!b_sha).  This is the case the process_df_entry needs to be invoked
to handle.  That function was explicitly written explicitly for that
one case, hence the assert.  The assert might be triggered, for
example, if get_unmerged() were changed to return entries in a
different order and someone decides to make the F->D case be
unprocessed by process_entry() as well (and forgets to update
process_df_entry).

> diff --git a/merge-recursive.c b/merge-recursive.c
> index b0f055e..7bab728 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1208,9 +1208,8 @@ static int process_df_entry(struct merge_option=
s *o,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *conf;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat st;
>
> - =C2=A0 =C2=A0 =C2=A0 /* We currently only handle D->F cases */
> - =C2=A0 =C2=A0 =C2=A0 assert((!o_sha && a_sha && !b_sha) ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!o_sha && !a_sha &=
& b_sha));
> + =C2=A0 =C2=A0 =C2=A0 if (! ((!o_sha && a_sha && !b_sha) || (!o_sha =
&& !a_sha && b_sha)))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1; /* we do=
n't handle non D-F cases */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0entry->processed =3D 1;
>
> @@ -1321,6 +1320,12 @@ int merge_trees(struct merge_options *o,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&& !process_df_entry(o, path,=
 e))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clean =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < =
entries->nr; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct stage_data *e =3D entries->items[i].util;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!e->processed)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Unprocessed path??? %s",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entries->items[i].str=
ing);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string_list_cl=
ear(re_merge, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string_list_cl=
ear(re_head, 0);
>

Other than possible wording of the comment ("we only handle
directory/file conflicts where the path was not a directory in the
merge-base"? "we don't currently handle any other cases"? something
else?), the patch looks good to me.

Elijah
