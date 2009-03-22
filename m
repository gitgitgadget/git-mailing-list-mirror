From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/7] check-ref-format --branch: give Porcelain a way to 
	grok branch shorthand
Date: Sun, 22 Mar 2009 11:18:29 +0100
Message-ID: <36ca99e90903220318g2cfb192fi9d4ef0da95e1a65b@mail.gmail.com>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
	 <1237673619-12608-2-git-send-email-gitster@pobox.com>
	 <1237673619-12608-3-git-send-email-gitster@pobox.com>
	 <1237673619-12608-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 11:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlKnY-0005lJ-AP
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 11:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbZCVKSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 06:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbZCVKSd
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 06:18:33 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:47008 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbZCVKSc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 06:18:32 -0400
Received: by ewy9 with SMTP id 9so1234050ewy.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8cxDNKyKyV+J90ZEYUpgea77B5W4Hi6wj3QAf4/65gs=;
        b=sz1LZsm0cxKsorqE/V89E5T1xVG8hCyLRZJfBX1I7uBJthl8IYjNO+jpngKbHwlSTx
         lORfs5D5Eu+tuU+dUmX0EvGJPVTXXjK36E0sxzDDMrxtYCR1zgTKBsRcjowIV/+DdVpu
         y5kK0JYZLMeNmcHL5fCNl4nx6S4upns3CIG7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BwT3NZdf7MxYQVA4w34Vu5L+vmLQizEAR695Yh97QsuMjLN/Ot7QovmGKMNqgROpuF
         MqYOb6f/21seThbNzNNjFrSDEoztb0l2+d6qMm0j2U5lpEqeOK5zY3/oIBajA1YbrNGt
         W4AlAvSHCg+DqgNdTGRh2pdg9HJC/UgE1zgek=
Received: by 10.210.91.17 with SMTP id o17mr1307746ebb.65.1237717109219; Sun, 
	22 Mar 2009 03:18:29 -0700 (PDT)
In-Reply-To: <1237673619-12608-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114134>

On Sat, Mar 21, 2009 at 23:13, Junio C Hamano <gitster@pobox.com> wrote=
:
> The command may not be the best place to add this new feature, but
>
> =C2=A0 =C2=A0$ git check-ref-format --branch "@{-1}"
>
> allows Porcelains to figure out what branch you were on before the la=
st
> branch switching.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0builtin-check-ref-format.c | =C2=A0 10 ++++++++++
> =C2=A01 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
> index 701de43..39db6cb 100644
> --- a/builtin-check-ref-format.c
> +++ b/builtin-check-ref-format.c
> @@ -5,9 +5,19 @@
> =C2=A0#include "cache.h"
> =C2=A0#include "refs.h"
> =C2=A0#include "builtin.h"
> +#include "strbuf.h"
>
> =C2=A0int cmd_check_ref_format(int argc, const char **argv, const cha=
r *prefix)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 if (argc =3D=3D 3 && !strcmp(argv[1], "--branc=
h")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct strbuf sb =3D=
 STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_branchname(=
&sb, argv[2]);
strbuf_branchname() will be introduced in the next patch!

Bert
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_splice(&sb,=
 0, 0, "refs/heads/", 11);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (check_ref_form=
at(sb.buf))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("'%s' is not a valid branch name", argv[2]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("%s\n", sb.=
buf + 11);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(0);
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc !=3D 2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage("git che=
ck-ref-format refname");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return !!check_ref_format(argv[1]);
> --
> 1.6.2.1.299.gda643a
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
