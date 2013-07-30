From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Tue, 30 Jul 2013 07:27:59 +0700
Message-ID: <CACsJy8DxSv7zP+EL0yZnkTztEm7taS0VQxcQ6XPQHMvVMLtVqg@mail.gmail.com>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com> <7v8v0p2z45.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 02:28:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3xnz-0000RQ-02
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 02:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab3G3A2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 20:28:31 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:47533 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab3G3A2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 20:28:30 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so5948225obc.15
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oQMmE02wgsTEnH4TLp8ubuJqrSI/yWHn1Fb0y4uj8KI=;
        b=PhDeYIbzRlU+ZyS2B0KLUmj7I+YxD60qCbeWdZbcR0ElTuK0w0TNoqR98AZhFV4JoZ
         t/cKf+cGUpxyuKSRj7i+jY7a0m5zHsNi0kmcIM6zQutZeW9PJ5p3keL7XdOtXwXp8tBZ
         0OXgwTCJq4yNFG0sL/TTttJkAjN+v0fEUPwj3bW76IS/YI28jE95cPlluqRPVynmcUtT
         uxzgtV5u6QiWTvQLVXGIKea8MpEgno7QK25JzJM49Any1wHqbC0LVDzLJrXWlequyOvc
         BUW0i+UgnMowjAF8I+p8TbOLI2KjuiOPz9hiqsvKnafIh77Qw1wSUeEprj58+lFCAluA
         Z4GA==
X-Received: by 10.60.143.35 with SMTP id sb3mr25197329oeb.62.1375144109421;
 Mon, 29 Jul 2013 17:28:29 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 29 Jul 2013 17:27:59 -0700 (PDT)
In-Reply-To: <7v8v0p2z45.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231338>

On Mon, Jul 29, 2013 at 9:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Co-authored-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>
> That's a bit strange---the patch text looks like the "how about
> this" patch Duy posted earlier.  Shouldn't it be From: Duy with
> S-o-b: by two of you instead?

The idea is the same, but my patch is a bit different (use of realpath
instead of real_path, I didn't remember git has real_path). I'm fine
with Ram being the author.

>> diff --git a/editor.c b/editor.c
>> index 27bdecd..0abbd8d 100644
>> --- a/editor.c
>> +++ b/editor.c
>> @@ -37,7 +37,7 @@ int launch_editor(const char *path, struct strbuf =
*buffer, const char *const *en
>>               return error("Terminal is dumb, but EDITOR unset");
>>
>>       if (strcmp(editor, ":")) {
>> -             const char *args[] =3D { editor, path, NULL };
>> +             const char *args[] =3D { editor, real_path(path), NULL=
 };
>
> While I am not fundamentally opposed to add a workaround for bugs in
> a popular tool many people use, I am a bit uneasy about this change.
>
> For editors that are not broken, this could be an annoying
> regression, isn't it?  When the user asks "What is the path of the
> file I am editing?" to the editor (i.e. an equivalent of \C-x\C-b),
> the updated code will start spewing a long full-path from the root
> directory, while we used to give a relative path that is short,
> sweet and more in line with the context of user's work.
>
> Compared to not being able to edit, it may be a small price to pay
> for those who do need to suffer the broken editor, but the patch
> makes those who do not need this workaround to pay the price.

Does looking at the edited file's path happen often? I have never done
that before. I ask because in order to avoid the price for those
users, the code could get a little bit more complicated (detecting if
the given relative path traverse backward outside a symlink..). To me
it seems like a good trade off in favor of simpler code.
--=20
Duy
