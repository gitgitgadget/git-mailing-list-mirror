From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: Much readable error output
Date: Sun, 28 Dec 2014 03:56:37 -0500
Message-ID: <CAPig+cSPOwf2Db2_LJC27T2t+FMdJ-_YtccMFn_0Oybi9-1HJw@mail.gmail.com>
References: <1419595599-19974-1-git-send-email-kuleshovmail@gmail.com>
	<1419678577-19340-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 09:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y59eV-0008PG-QF
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 09:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbaL1I4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2014 03:56:39 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:47919 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaL1I4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2014 03:56:38 -0500
Received: by mail-yh0-f52.google.com with SMTP id z6so5940362yhz.25
        for <git@vger.kernel.org>; Sun, 28 Dec 2014 00:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Du9m+SWTe7mFtLeVD4QqThIAgm69zQg4FFvKGGtsjDI=;
        b=gs0caYly+u7Utilu98oHEBEWXfR3ZDUyh0EA1oJFGOtR0NlBHgB2qDuaEkRM1bP8ea
         L6hw+q5Hke3hoX8sM9NHJjBUUlRMmYZRuqZeURUeGLwAWfKDmCXZwE+yF2eLPWn3Gty7
         /iqbRZeAjh/GmC4lIryyQk+oXYfmhvpyEVLt+JRnSn+UknzWw3R5eFqIynzWFgEsKirw
         92pH0MzQVa8g7gupkk02ejhreLwCR7JRZR1pKYgqpnlzvJQaUtZYELuNOduFqxkA/HLM
         Pk25ny9R2xwdQmGLZmfAThRy1V5+6t9ulI8UikqbjqkKUmeb2DEmq8MyL29pwk6TH4AR
         ZXHw==
X-Received: by 10.170.130.21 with SMTP id w21mr40927859ykb.22.1419756997850;
 Sun, 28 Dec 2014 00:56:37 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 28 Dec 2014 00:56:37 -0800 (PST)
In-Reply-To: <1419678577-19340-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: 7N3g00f5s_nCzdEvYBBvBw00PAc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261854>

On Sat, Dec 27, 2014 at 6:09 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>

This patch has two distinct goals. First, it's adding "\n" to 'die'
messages to suppress the file+line# information which Perl appends
automatically to 'die' output. Second, it's trying to format the "SMTP
initialization" error message in a more human-readable way. The two
goals should be covered by two patches, rather than just one.

When you split your change into multiple patches, reviewers don't need
to divide their concentration between unrelated changes. Also, if the
project maintainer (Junio) decides that some of the changes are
worthwhile, but others are not, having multiple patches makes it
easier for him to pick and choose the ones he wants.

It's also worthwhile to write a suitable commit message explaining the
change if it's not obvious. For instance, the casual reader might not
realize that adding "\n" to 'die' messages suppresses the file+line#
information, and that you want to suppress that information because it
does not particularly add value to these user-facing message.

More below.

> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 82c6fea..eb02ef9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -38,7 +38,7 @@ sub new {
>  }
>  sub readline {
>         my $self = shift;
> -       die "Cannot use readline on FakeTerm: $$self";
> +       die "Cannot use readline on FakeTerm: $$self\n";
>  }
>  package main;
>
> @@ -1274,11 +1274,11 @@ X-Mailer: git-send-email $gitversion
>                 }
>
>                 if (!$smtp) {
> -                       die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
> -                           "VALUES: server=$smtp_server ",
> -                           "encryption=$smtp_encryption ",
> -                           "hello=$smtp_domain",
> -                           defined $smtp_server_port ? " port=$smtp_server_port" : "";
> +                       die "Unable to initialize SMTP properly. Check config and use --smtp-debug.\n",
> +                           "VALUES: server=$smtp_server\n\t",
> +                           "encryption=$smtp_encryption\n\t",
> +                           "hello=$smtp_domain\n\t",
> +                           defined $smtp_server_port ? "port=$smtp_server_port\n" : "\n";

Thomas made a couple points in his review[1] which are very much worth
considering:

1. Move the "\t" to the beginning of the lines you want to indent;
don't leave it at the end of the preceding line following the "\n".

2. Don't emit an unnecessary blank line if $smtp_server_port is not defined.

A third point he didn't mention:

3. If you're indenting "encryption", "hello", and "port", for
consistency, it also makes sense to indent "server". (That is, insert
a newline after "VALUES:", before "server=".)

[1]: http://article.gmane.org/gmane.comp.version-control.git/261833

>                 }
>
>                 smtp_auth_maybe or die $smtp->message;
