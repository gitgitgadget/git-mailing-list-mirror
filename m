From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck.c:fsck_commit() use starts_with() and skip_prefix()
Date: Tue, 18 Mar 2014 19:09:06 -0400
Message-ID: <CAPig+cRoRzZKjW3cY86iQxz9iZ_TKT-yyu=6Va5aV_DsCAQquA@mail.gmail.com>
References: <1395182512-17179-1-git-send-email-darrazo16@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Othman Darraz <darrazo16@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 00:09:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ38F-0002MK-SB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 00:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429AbaCRXJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 19:09:10 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:52688 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758425AbaCRXJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 19:09:08 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so7776698yhl.34
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zs8HpgrCIUOnejKgGwqOhZGNQGFOTySTylgOt2rlRy4=;
        b=w8CIfwAiQRW57A0pl++dDWRNpFiXUsqs+UfFtLaR9uvr3iDHbSXxrDjwZykNtaRMjM
         KJaJSn+JlQ0lZrecTvrFmh9prfcDrQ3NlqD1r7/AswX3hSYE3IcG1Q+lJyFw/PovTSfp
         5OC6VNdWGB0i4K8acRBRPhmVEGwcHeZHdaPSgTc5OclnNCoTDFVk9oyJCNVoYJQN3t/R
         P04gutMqbzqMPHWTbiXksEsfqJoHKw5pS7EUESHSnz+sEwmsmDMT6p6ZC28UL4Quf/ha
         p6++RD3NW7lfm52yly1uWAFciW3zzhLSrD3hjMvurWRhhpO/Kpe7Psr4unK7Pxo+T7QB
         wrXQ==
X-Received: by 10.236.122.99 with SMTP id s63mr22168680yhh.19.1395184146345;
 Tue, 18 Mar 2014 16:09:06 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 16:09:06 -0700 (PDT)
In-Reply-To: <1395182512-17179-1-git-send-email-darrazo16@gmail.com>
X-Google-Sender-Auth: mlp74Oj0o7zxiQyLsJwMNR2FqT8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244394>

Thanks for the submission. Comments below to give you a taste of the
Git review process...

On Tue, Mar 18, 2014 at 6:41 PM, Othman Darraz <darrazo16@gmail.com> wrote:
> use of starts_with() instead of memcmp()
>
> use of skip_prefix instead of memcmp() and strlen()

Write proper sentences to explain and justify the change; not sentence
fragments.

> Signed-off-by: Othman Darraz <darrazo16@gmail.com>
> ---
>
> I am planning to apply to GSOC 214

Your logic in these changes is rather severely flawed. Running the
test suite (t1450, in particular), as the GSoC microproject page
suggests, would have clued you in that something was amiss.

>  fsck.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 64bf279..5eae856 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -290,7 +290,7 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>         int parents = 0;
>         int err;
>
> -       if (memcmp(buffer, "tree ", 5))
> +       if (starts_with(buffer, "tree "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>         if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')

One of the reasons for using starts_with() rather than memcmp() is
that it allows you to eliminate magic numbers, such as 5. However, if
you look closely at this code fragment, you will see that the magic
number is still present in the expression 'buffer+5'. starts_with(),
might be a better fit.

>                 return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
> @@ -322,15 +322,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>                 if (p || parents)
>                         return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>         }
> -       if (memcmp(buffer, "author ", 7))
> +       if (starts_with(buffer, "author "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
>         buffer += 7;

Same problem here with magic number 7.

>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> -       if (memcmp(buffer, "committer ", strlen("committer ")))
> +       buffer = (char* )skip_prefix(buffer,"committer ");

Style: (char *)
Style: whitespace: skip_prefix(foo, "bar")

Regarding the (char *) cast: Is 'buffer' ever modified in this
function? If not, would it make sense to make it 'const' (and fix any
other small fallout from that change)?

> +       if (!buffer)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
> -       buffer += strlen("committer ");
>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> --
> 1.9.0.258.g00eda23.dirty
