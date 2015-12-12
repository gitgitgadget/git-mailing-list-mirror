From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] completion: fix completing unstuck email alias arguments
Date: Fri, 11 Dec 2015 17:56:46 -0800
Message-ID: <CA+P7+xrHhWHp8WA8EF7jzsit50uW13=-NEzf0DwNfMyu2dckhA@mail.gmail.com>
References: <1449879498-1516-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Dec 12 02:57:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7ZQw-0000Cq-6v
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 02:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbbLLB5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2015 20:57:09 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:35606 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbbLLB5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 20:57:06 -0500
Received: by ioc74 with SMTP id 74so144731385ioc.2
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 17:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=stXlxcT3ujeTpectGfZP55yDqnmCZ+Bv0fZd1SGV5nY=;
        b=iRAvSQ0muTlE9phMyMse9JqfZFRnJO8Cw0HR26Nom0xMoqlDBGO+sD7pqb1fi0EH9u
         EwaS4hz3HMwlEa/bQknkl5TLwdxM9k+g6Hiyvdhw8Gq4Iq88HGz1FVf9AjgszHKI//Qa
         XKbJUrnWIImS53MBbOzgqcpPBFY4lzWZKFHjEjt/QfI8xbxMuqoh1BU1PxqHjgCBRF7J
         JIm9puwJw73HdU6Me3LYoFvucj9GO6t4LwkRNzpUTkpIzUkTYiZjHuAFfjr77qS2nJjU
         DukqcTtMAijz6UO74wIAThRp2y7ReWnsu1DenWKTKJ2jTsRP3LAavtEhHf8TZwC3VQDf
         pn1A==
X-Received: by 10.107.136.39 with SMTP id k39mr23885806iod.0.1449885425652;
 Fri, 11 Dec 2015 17:57:05 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Fri, 11 Dec 2015 17:56:46 -0800 (PST)
In-Reply-To: <1449879498-1516-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282296>

On Fri, Dec 11, 2015 at 4:18 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Completing unstuck form of email aliases doesn't quite work:
>
>   $ git send-email --to <TAB>
>   alice   bob     cecil
>   $ git send-email --to a<TAB>
>   alice   bob     cecil
>

Woops. Is it possible to add a test for this case? I honestly don't
know how the tests for the completion works.

> While listing email aliases works as expected, the second case should
> just complete to 'alice', but it keeps offering all email aliases
> instead.
>
> The cause for this behavior is that in this case we mistakenly tell
> __gitcomp() explicitly that the current word to be completed is empty=
,
> while in reality it is not.  As a result __gitcomp() doesn't filter
> out non-matching aliases, so all aliases end up being offered over an=
d
> over again.
>
> Fix this by not passing the current word to be completed to
> __gitcomp() and letting it go the default route and grab it from the
> '$cur' variable.  Don't pass empty prefix either, because it's assume=
d
> to be empty when unspecified, so it's not necessary.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>
> On top of the recently merged dfbe5eeb32 (completion: add support for
> completing email aliases, 2015-11-19).
>
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 111b05302b..d9b995799c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1716,7 +1716,7 @@ _git_send_email ()
>         --to|--cc|--bcc|--from)
>                 __gitcomp "
>                 $(git --git-dir=3D"$(__gitdir)" send-email --dump-ali=
ases 2>/dev/null)
> -               " "" ""
> +               "

Yes this looks reasonable to me.

>                 return
>                 ;;
>         esac
> --
> 2.7.0.rc0.37.g77d69b9
>
