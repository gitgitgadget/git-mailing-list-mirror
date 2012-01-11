From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] diff-index: pass pathspec down to unpack-trees machinery
Date: Wed, 11 Jan 2012 19:47:38 +0700
Message-ID: <CACsJy8DvVoS9Uz94DhkC1+wTOyLRpewp5=0fU4JKqSSQh6VS-A@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-4-git-send-email-gitster@pobox.com> <20120111063104.GA3153@burratino>
 <CACsJy8D7EnOebAxBYF8ua7htu-81nKY=ghUMgg=JOe4Fc1uigQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 13:48:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkxbF-0001sm-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 13:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab2AKMsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 07:48:12 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42147 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab2AKMsK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 07:48:10 -0500
Received: by bkvi17 with SMTP id i17so471396bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KJGmJ4a3YtXF1Mg5s/3IaW4G8V7iSNnwb2GpwzmKsRM=;
        b=baeIB77HR+5F6Xrs3yVUGZna1BreMZtakh+Gw6O6PohN1cvH76hz7CZfIsFteEViDT
         t1yc5Ns0UOzTFUmnLnswsLZIUKnI2qdo2P57YvDNs9xt8FSjpvI3kEqeSF/66JuD0o0B
         ua4zuZaXWShIpiOAgGNWuCigNg0bh/QPd+qTY=
Received: by 10.205.132.14 with SMTP id hs14mr10085865bkc.130.1326286089313;
 Wed, 11 Jan 2012 04:48:09 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Wed, 11 Jan 2012 04:47:38 -0800 (PST)
In-Reply-To: <CACsJy8D7EnOebAxBYF8ua7htu-81nKY=ghUMgg=JOe4Fc1uigQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188361>

On Wed, Jan 11, 2012 at 7:33 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> Still scratching my head why this flag is zero by default, which woul=
d
> affect all other places.. Or perhaps the right fix would be this
> instead

Yep, it seems the right one. recursive flag is introduced to
enable/disable max_depth feature, which is only used by grep, so we
want this feature to be off by default. max_depth =3D=3D 0 has special
meaning, and we do not want another any other kind of initialization
but memset(), so "recursive" functions as the feature switch.

The code portions below deal with the case where we have tried and
failed prefix matching. Because this is wildcard, we don't know if
anything in the given directory may match or not, so we match all
directories, then filter unmatched files out at the end. This has
nothing to do with "recursive" flag as the max_depth switch.

Will think about it and test some more tomorrow when my mind is in bett=
er state.

> diff --git a/tree-walk.c b/tree-walk.c
> index f82dba6..0345938 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -634,7 +634,7 @@ enum interesting tree_entry_interesting(const
> struct name_entry *entry,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Match all directories. We'=
ll try to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * match files later on.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ps->recursive && S_ISDIR(entry-=
>mode))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (S_ISDIR(entry->mode))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn entry_interesting;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
>
> @@ -662,7 +662,7 @@ match_wildcards:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Match all d=
irectories. We'll try to match files
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * later on.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ps->recursive =
&& S_ISDIR(entry->mode))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (S_ISDIR(entry-=
>mode))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return entry_interesting;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return never_interesting; /* No matches */
--=20
Duy
