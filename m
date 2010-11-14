From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCHv6 06/23] notes.h/c: Propagate combine_notes_fn return
 value to add_note() and beyond
Date: Sun, 14 Nov 2010 18:46:36 -0200
Message-ID: <AANLkTinQhkXvfa0BS0dFK6-mXFpU+uQ=rKRJ1QaXXA1S@mail.gmail.com>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
	<1289339399-4733-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Nov 14 21:46:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHjTP-0001uC-Ai
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 21:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945Ab0KNUqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 15:46:38 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47628 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0KNUqh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 15:46:37 -0500
Received: by bwz15 with SMTP id 15so4648159bwz.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 12:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tfK28bGxHaoZv4fVpu+WARYOrovEcE5hfWTE7aohnf8=;
        b=R7cnDOTYOPe46aDfPk/jhZhBxt+qUHfV9rZe6UG4CB1HXulI2vn+u0l5VcOCjC6Z19
         TykRpEs73+5e0MU3oQdJXAvVIFyJUBFhaByQmUoAEDjbQ5JZLSmfI7KY6xhP9r6Z17eO
         yFo6S3XZmun6LK+9s4kXpDBEwGVq5cyKdV9+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ESGHXMxO78Mw7JaS0iZz2L9gE2GPbxxx7cDVimmoJFV5HSPZ2qmSlPsMhKkzQNzm3C
         1ZyhZBcksq8qW2DsnObZLr0l6Do7vH5aPNarwPbC06W2UIM0YDULwjjrYad5DfBQ5gip
         a8gzyuPw2EsiIDqj8qBRL/7VWSKUiUXNd3XIg=
Received: by 10.204.99.195 with SMTP id v3mr5288287bkn.94.1289767596337; Sun,
 14 Nov 2010 12:46:36 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 14 Nov 2010 12:46:36 -0800 (PST)
In-Reply-To: <1289339399-4733-7-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161438>

On Tue, Nov 9, 2010 at 7:49 PM, Johan Herland <johan@herland.net> wrote=
:
> The combine_notes_fn functions uses a non-zero return value to indica=
te
> failure. However, this return value was converted to a call to die()
> in note_tree_insert().
>
> Instead, propagate this return value out to add_note(), and return it
> from there to enable the caller to handle errors appropriately.
>
> Existing add_note() callers are updated to die() upon failure, thus
> preserving the current behaviour. The only exceptions are copy_note()
> and notes_cache_put() where we are able to propagate the add_note()
> return value instead.
>
> This patch has been improved by the following contributions:
> - Jonathan Nieder: Future-proof by always checking add_note() return =
value
> - Jonathan Nieder: Improve clarity of final if-condition in note_tree=
_insert()
>
> Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
> =C2=A0builtin/notes.c | =C2=A0 11 ++++++-----
> =C2=A0notes-cache.c =C2=A0 | =C2=A0 =C2=A03 +--
> =C2=A0notes.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 55 +++++++++++++++=
+++++++++++++---------------------------
> =C2=A0notes.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11 ++++++++---
> =C2=A04 files changed, 43 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index fbc347c..35f6eb6 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -573,8 +573,8 @@ static int add(int argc, const char **argv, const=
 char *prefix)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_null_sha1(new_note))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_note(t,=
 object);
> - =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_note(t, object=
, new_note, combine_notes_overwrite);
> + =C2=A0 =C2=A0 =C2=A0 else if (add_note(t, object, new_note, combine=
_notes_overwrite))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("confused: com=
bine_notes_overwrite failed");

This message looks like more a debug information. Could it be
rewritten to be more user friendly / more informative?
