From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Tue, 29 Jan 2013 13:13:37 +0700
Message-ID: <CACsJy8DsKFfGoPUt5b=3MuSmZ2z2Z5vJ20D_kqEowAUc8QTryA@mail.gmail.com>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal> <7vd2wotuxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 07:14:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U04St-0006Sp-P8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 07:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3A2GOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 01:14:10 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:58775 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab3A2GOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 01:14:08 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so77448obb.37
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 22:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=l/4WnIJxAWHRJ95PGAK2PbkKq1euPFw4YKtSUsXeLwA=;
        b=WYiQrMgbWxhqS+3RdQtkLo3j0r+cSWu84BXHY2SUqcQwiYc7f+Ephrr7kdpfKfnQu7
         RAUKUGM8ra5LE4/euXa9dKyhMFcyGgfw72GnzYFdig2Atg9NG4VAb3wmXZMuIYANmrz6
         omwer3JgCumFU/DnVAqY36ouwuw+/Kd7iKBrCF+3Zj0hNi4tOZqgs0dBcpK/53LepXZs
         wdiTbQ4LDh9xfQzrS2ezdMPRuHFc2kfGuUO7V10AtRst/0tlUbcCkQ7xX195a+Q/6AI7
         /VdxBweWw7RGuaUeFoQjGM1DPNhoiS746pYFLNhXR8Ejr215kdgrGxB1962U7z0mVovQ
         Th/Q==
X-Received: by 10.182.159.33 with SMTP id wz1mr275205obb.57.1359440047417;
 Mon, 28 Jan 2013 22:14:07 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Mon, 28 Jan 2013 22:13:37 -0800 (PST)
In-Reply-To: <7vd2wotuxm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214906>

On Tue, Jan 29, 2013 at 12:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Have you considered if it may be helpful to have a :(literal) magic
> (or any magic in general) that applies only to the first N
> characters of the pathspec pattern?

Not user-driven. But the prefix part is :(literal)-applied. :(glob) is
currently implemented this way, using nowildcard_len as you mentioned.
:(icase) is more complicated and does not follow yet.

> I personally think we do not need to support something like this:
>
>         prefix=$(git rev-parse --show-prefix)
>         n=${#prefix}
>         pathspec=":(literal-$n)$prefix$1"
>
> but other aspiring Porcelain script writers may disagree and would
> want to have it.  We can always solve it by giving them an easy and
> uniform way to get the glob-quoted version of prefix to solve this
> particular issue, i.e.
>
>         prefixq=$(git rev-parse --show-prefix-glob-quoted)
>         pathspec="$prefixq$1"
>
> but magic that applies only to a substring may have other uses.

Yeah, that simplifies things. Supporting applying magic over just
parts of the pathspec pattern sounds complex. Just a small
modification. That rev-parse needs to look at "$1" as well. If
:(literal) is already specified, glob quoting will backfire. The user
script can deal with that, but it's harder (e.g. parsing magic from
scripts and deal with magic combination) than letting rev-parse does
it.

I've done some form of this already, for supporting add--interactive.
git-add prefixes the pathspec but keeps all the magic in place, before
passing pathspec to add--interactive. But I missed the quoting point
you mentioned above. I probably need de-quoting the prefix as well.
Many optimizations stop short at the sign of any glob symbols,
including backslash. This could be a new task for wildmatch.
-- 
Duy
