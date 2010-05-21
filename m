From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 0/6 v2] Make git log --graph looks better with -p and 
	other diff options
Date: Thu, 20 May 2010 18:49:20 -0700
Message-ID: <AANLkTim5R94ZmIfujvhky5zFQYT5MIgJJ58tVnjvQkHF@mail.gmail.com>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
	 <20100520123650.GA7665@sigill.intra.peff.net>
	 <20100520132425.GA5504@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 21 03:52:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFHP6-0003sj-VC
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 03:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab0EUBtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 21:49:22 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:53113 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab0EUBtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 21:49:21 -0400
Received: by qyk13 with SMTP id 13so796871qyk.1
        for <git@vger.kernel.org>; Thu, 20 May 2010 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sCQ3N5qU7A7sTfLZxiu9Ylt+agehq4Ah2Xm6Km8QP4A=;
        b=OcVEs3SqheJOjGaNZQaMGK2dF1ws7bK+pIy/xiBv1JXkZ01Taj4NKhKDlH1rHW8yED
         RkipfZzuLAziBJ0SO0Itt8nr8nzBdzukkAKRIg0HtAbr+OmMwYuPhLaDgezlX3hewIZF
         zhqrVS/H+kWGcbm6mkKDvPO1GFXi9fUoq61+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AxlxDCu8VmNc3bYQjFQ0EjHfcRIqheyqHwQ1/0EwumaO8XXvAPe18NjzVeLbj3qNAa
         B6m2ANd5kow4sfiTaa35obk/CHlqD7kK9KpVLFpJCeV6DBAl5ZgR19o/V9rW2he8dhMa
         wR8nEZS4H+/onPltM8RcbCOM/DV0lsBv5a5VU=
Received: by 10.229.213.199 with SMTP id gx7mr232037qcb.187.1274406560404; 
	Thu, 20 May 2010 18:49:20 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Thu, 20 May 2010 18:49:20 -0700 (PDT)
In-Reply-To: <20100520132425.GA5504@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147420>

Hi Jeff,
On Thu, May 20, 2010 at 6:24 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 20, 2010 at 08:36:50AM -0400, Jeff King wrote:
>
>> =A0 git log --graph --oneline --summary 212f0ba
>>
>> Summary lines for some reason don't get properly indented or prefixe=
d
>> with branch lines.
>
> This is my naive attempt at fixing it just by copying your other
> changes. However, it seems to sometimes put several copies of the pre=
fix
> in front of summary lines (and sometimes the next commit line!?). So
> clearly there is something about the output prefix code that I don't
> quite understand.

Thanks a lot for reporting this bug. I would not to ignore the
--summary option, :) Thanks again!

> Maybe this is helpful, and maybe not. :)
>
> diff --git a/diff.c b/diff.c
> index 3a1e05a..656f40b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3460,27 +3460,41 @@ static void show_rename_copy(FILE *file, cons=
t char *renamecopy, struct diff_fil
> =A0 =A0 =A0 =A0show_mode_change(file, p, 0);
> =A0}
>
> -static void diff_summary(FILE *file, struct diff_filepair *p)
> +static void diff_summary(struct diff_options *opt, struct diff_filep=
air *p)
> =A0{
> + =A0 =A0 =A0 FILE *file =3D opt->file;
> + =A0 =A0 =A0 char *line_prefix =3D "";
> +
> + =A0 =A0 =A0 if (opt->output_prefix) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct strbuf *buf =3D opt->output_pref=
ix(file, opt->output_prefix_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 line_prefix =3D buf->buf;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0switch(p->status) {
> =A0 =A0 =A0 =A0case DIFF_STATUS_DELETED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fputs(line_prefix, file);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_file_mode_name(file, "delete", p-=
>one);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case DIFF_STATUS_ADDED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fputs(line_prefix, file);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_file_mode_name(file, "create", p-=
>two);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case DIFF_STATUS_COPIED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fputs(line_prefix, file);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_rename_copy(file, "copy", p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case DIFF_STATUS_RENAMED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fputs(line_prefix, file);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_rename_copy(file, "rename", p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->score) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fputs(line_prefix, file=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fputs(" rewrite ", fil=
e);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_name_quoted(p->t=
wo->path, file, ' ');
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(file, "(%d%%)\=
n", similarity_index(p));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fputs(line_prefix, file);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_mode_change(file, p, !p->score);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> @@ -3692,7 +3706,7 @@ void diff_flush(struct diff_options *options)
>
> =A0 =A0 =A0 =A0if (output_format & DIFF_FORMAT_SUMMARY && !is_summary=
_empty(q)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < q->nr; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 diff_summary(options->f=
ile, q->queue[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 diff_summary(options, q=
->queue[i]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0separator++;
> =A0 =A0 =A0 =A0}

Ah, thanks for patch and of course it helps! I have make --summary
works well and make some other changes for the output_prefix call, and
I will resend the series later. Thanks!

Regards!
Bo
--=20
My blog: http://blog.morebits.org
