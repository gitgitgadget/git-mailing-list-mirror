From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Thu, 20 Feb 2014 20:15:06 +0700
Message-ID: <CACsJy8B11ZjLgLiE=S1sqZ09z2GtbwGfdJRuQ0AC_ppnQsQvcQ@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-25-git-send-email-pclouds@gmail.com> <xmqq38je9739.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 14:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGTTa-0003wH-0j
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 14:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbaBTNPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 08:15:38 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:56473 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbaBTNPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Feb 2014 08:15:37 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so3181306qcx.35
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 05:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+i9DbR/YKzvT5uIrbznw/EeTBhZ+l4GC5v2hs5wLMfA=;
        b=TcCQpTEvfixCa9rndMCHnnDpNEQzetIPEA8IdWyc22lwtJx2FiWBPvlEShe5725a5J
         dMaxyZRZwWFcBfXYFErhiFxW3RS7haZwP7iloO1ODmLMSd1WbyUcO7g6/YgxCuERpBpc
         EGzNsqZ8sUF45/YsHczaS6O5HjYZrkqx2GFBMxxrMMTi9k5Z/YuNQW6ffEmURnNqY2D4
         bfpdAVn01rrGsbM1on+B3c3FfVgTnf273pNJYn+iQlmXHGETlBtjaxHTvaabMhd+DRb3
         muG5Xf73SsUSb4fL/D2Fd8BH2H54ARRLleGRTaQHKgBRzUpJcHFX/kuEBUsqZFxsX5xM
         woXg==
X-Received: by 10.224.19.199 with SMTP id c7mr1390632qab.78.1392902136774;
 Thu, 20 Feb 2014 05:15:36 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 20 Feb 2014 05:15:06 -0800 (PST)
In-Reply-To: <xmqq38je9739.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242432>

On Thu, Feb 20, 2014 at 3:32 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
> (Only nitpicks during this round of review).
>
>> +     if (get_device_or_die(path) !=3D get_device_or_die(get_git_dir=
())) {
>> +             strbuf_reset(&sb);
>> +             strbuf_addf(&sb, "%s/locked", sb_repo.buf);
>> +             write_file(sb.buf, 1, "located on a different file sys=
tem\n");
>> +             keep_locked =3D 1;
>> +     } else {
>> +             strbuf_reset(&sb);
>> +             strbuf_addf(&sb, "%s/link", sb_repo.buf);
>> +             link(sb_git.buf, sb.buf); /* it's ok to fail */
>
> If so, perhaps tell that to the code by saying something like
>
>                 (void) link(...);
>
> ?
>
> But why is it OK to fail in the first place?  If we couldn't link,
> don't you want to fall back to the lock codepath?  After all, the
> "are we on the same device?" check is to cope with the case where
> we cannot link and that alternate codepath is supposed to be
> prepared to handle the "ah, we cannot link" case correctly, no?

=46ilesystems not supporting hardlinks are one reason. The idea behind
"locked" is that the new checkout could be on a portable device and we
don't want to prune its metadata just because the device is not
plugged in. Checking same device help but even that can't guarantee no
false positives, unless your only mount point is /. So no I don't
really think we should go lock whenever link() fails, that would just
make fewer checkouts prunable.
--=20
Duy
