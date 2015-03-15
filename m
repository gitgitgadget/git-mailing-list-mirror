From: t.gummerer@gmail.com
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file"
 DWIM better.
Date: Sun, 15 Mar 2015 18:34:52 +0100
Message-ID: <20150315173451.GB17591@hank>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 18:35:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCRI-0007zZ-CD
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 18:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbCORe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 13:34:56 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:35580 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbbCORez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 13:34:55 -0400
Received: by webcq43 with SMTP id cq43so23468155web.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g3OETAcnbnVZHIxTnAdrSuZhw4MrJz3+EFCsstfFHfc=;
        b=bpjACYkk8o0+YbUPfteIJFlz+wniFNrtNtWzuvOWOQwhV0DMB95Vks1u7buLNKnrfv
         NHg5i3btn/HteDYpI1zHn4FrsJnkW2fg53XwYbskOjehb3gUBz8z4/8VNzOY/lQd4bIZ
         74Vha1f3D9srHXF+mbcFTnnm3OGCmfke2e0+ZL7wfOeGeFGdiuq1Pnkbj5VTzZUJ+pS1
         kxxhsvOL48TBKk4gGvepdISoCprjfM3O/4ER22Ietj/k8bKjCayNDdryoz1fx5SIcd9V
         ZJ66JJ5mMQRhi60Jzdr/1skGTvv+t07PA+mJ2yqQ3BcZlDrDaiAhpGFthmdNL9LZeHTX
         cigg==
X-Received: by 10.180.126.69 with SMTP id mw5mr160890127wib.12.1426440894117;
        Sun, 15 Mar 2015 10:34:54 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id i10sm11781542wja.40.2015.03.15.10.34.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2015 10:34:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265500>

Hi,

On 03/15, Yurii Shevtsov wrote:
> Changes 'git diff --no-index $directory $file' behaviour.
> Now it is transformed to 'git diff --no-index $directory/&file $file'
> instead of throwing an error.

The commit message should describe why the change is made, see
Documentation/SubmittingPatches, section (2)

> Signed-off-by: Yurii Shevtsov <ungetch <at> gmail.com>

Please use your full email here, without replacing @ with <at>

> ---
>  diff-no-index.c |   21 +++++++++++++++++++--

You should probably add a test for the new behaviour in
t/t4053-diff-no-index.sh.

>  1 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 265709b..4e71b36 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>                 return -1;
> 
> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -               return error("file/directory conflict: %s, %s", name1, name2);
> +       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> +               struct strbuf dirnfile;
> +               const char *dir, *file;
> +               char *filename;
> +               int ret = 0;
> +
> +               dir = S_ISDIR(mode1) ? name1 : name2;
> +               file = (dir == name1) ? name2 : name1;

This makes git diff --no-index $directory $file the same as
git diff --no-index $file $directory.  Shouldn't these commands give
different results?  (See the behaviour of diff in this case, and
compare it to the behaviour you introduced here)

> +               strbuf_init(&dirnfile, strlen(name1) + strlen(name2) + 2);
> +               strbuf_addstr(&dirnfile, dir);
> +               if (dirnfile.buf[dirnfile.len - 1] != '/')
> +                       strbuf_addch(&dirnfile, '/');
> +               filename = strrchr(file, '/');
> +               strbuf_addstr(&dirnfile, filename ? (filename + 1) : file);
> +               ret = queue_diff(o, dirnfile.buf, file);
> +               strbuf_release(&dirnfile);
> +
> +               return ret;
> +       }

Your MUA seems to have replaced tabs with spaces in this email.  The
easiest way to get the formatting correct is the git send-email tool.
You should also try to sending the mail to yourself first and see if
it applies correctly with git am.

> 
>         if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
>                 struct strbuf buffer1 = STRBUF_INIT;
> --
> 
> I hope I understood task correct. I think this patch requires writing
> additional tests, so that's what I'm going to do now.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
