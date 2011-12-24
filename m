From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Sat, 24 Dec 2011 17:55:14 +0700
Message-ID: <CACsJy8DbfE8r3KsxCnb30-sb3LUAAWapAKJUSJ1zBZme1FoMwg@mail.gmail.com>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com>
 <87mxaihpiq.fsf@thomas.inf.ethz.ch> <CACBZZX67WhcdhXdqOm8gZHW7C3YMbV2KzeytwjHwsnF=8-M_+w@mail.gmail.com>
 <20111224070715.GA32267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 24 11:56:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RePGq-0000Zw-1W
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 11:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab1LXKzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Dec 2011 05:55:48 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36597 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab1LXKzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2011 05:55:47 -0500
Received: by eaad14 with SMTP id d14so3287526eaa.19
        for <git@vger.kernel.org>; Sat, 24 Dec 2011 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CgIarWpkrwj2vKtdooto0T+trgXo4MtpYEnxF0ucoeI=;
        b=U+906l3a9tJl9AtQ8ec1VeKaA2eNKukWa7c5Ljmt0So/gFYq4ketfirtkvE43ve8H2
         Vtyp7RkaiqIGCMSsd8zuHrCvOD3S9Sks8y23AJzoR9+VbmkElOrGz0gEa35Y5/fP6nkS
         5aETM5HdXMmiU4tk3DLntLub1bhxd2OymtlJ8=
Received: by 10.204.145.74 with SMTP id c10mr4943808bkv.62.1324724146216; Sat,
 24 Dec 2011 02:55:46 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Sat, 24 Dec 2011 02:55:14 -0800 (PST)
In-Reply-To: <20111224070715.GA32267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187658>

(Sorry I replied without reading though the mail)

On Sat, Dec 24, 2011 at 2:07 PM, Jeff King <peff@peff.net> wrote:
> The case where we would most expect the setup cost to be drowned out =
is
> using a more complex regex, grepping tree objects. There we have a
> baseline of:
>
> =C2=A0$ time git grep 'a.*c' HEAD >/dev/null
> =C2=A0real =C2=A0 =C2=A00m5.684s
> =C2=A0user =C2=A0 =C2=A00m5.472s
> =C2=A0sys =C2=A0 =C2=A0 0m0.196s
>
> =C2=A0$ time git ls-tree --name-only -r HEAD |
> =C2=A0 =C2=A0 =C2=A0xargs git grep 'a.*c' HEAD -- >/dev/null
> =C2=A0real =C2=A0 =C2=A00m10.906s
> =C2=A0user =C2=A0 =C2=A00m10.725s
> =C2=A0sys =C2=A0 =C2=A0 0m0.240s
>
> Here, we still almost double our time. It looks like we don't use the
> same pathspec matching code in this case. But we do waste a lot of ex=
tra
> time zlib-inflating the trees in "ls-tree", only to do it separately =
in
> "grep".

I assume this is gree_tree(), we have another form of pathspec
matching here: tree_entry_interesting() and it's still a bunch of
strcmp inside. Does strcmp show up in perf report?
--=20
Duy
