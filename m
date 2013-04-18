From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/2] rev-parse: add --filename-prefix option
Date: Thu, 18 Apr 2013 19:58:25 +0530
Message-ID: <CALkWK0nir7pJF-7YLRQF0jCR4dbb-JNBheD-4zKeQR0K9F9nZg@mail.gmail.com>
References: <cover.1365364193.git.john@keeping.me.uk> <cover.1365539059.git.john@keeping.me.uk>
 <0d570e110dbf714310f9cbc4fa47e711630707f2.1365539059.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 16:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USppp-0002XU-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 16:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966970Ab3DRO3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 10:29:08 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:61850 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966588Ab3DRO3H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 10:29:07 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so1236706ieb.27
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PzjDHevglzSa42oq9/wvv0Kk/qKsuWStMRZpP57LwcU=;
        b=nb8ekchI7kk2EAHwiZA5JYFbaSR32EqtaN4CNwLEreER/ZQT4rf5GiyhzRiTYp1stu
         HS8IsmNTydZQlsvW0nY/aefBC7KP3ZTBy47oeUsJRuwncFXbXhRs9zRCRug7pZ7r0Eqe
         CmO4lrt2VSVLarDN1AgcrFXsDvsvGZ8EH6slQz4uXb0ngvaTw2aKHXDr5yLp4rpYWV1Z
         r3x9ZwEJSJJ5cqv3kvLi0x6Z2+wCl/XIkgZuhKtpCXyM+IWtH/8dJj/L+WfAY9Pvhrhr
         fWFR5m+Tcoo9SVhFEa2IL70bJEc0f+SR2KUZA7mcREfLEHcmd6tAk4A0HLCeR/T4w9+C
         q9SQ==
X-Received: by 10.50.50.71 with SMTP id a7mr13199632igo.14.1366295345876; Thu,
 18 Apr 2013 07:29:05 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 07:28:25 -0700 (PDT)
In-Reply-To: <0d570e110dbf714310f9cbc4fa47e711630707f2.1365539059.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221659>

John Keeping wrote:
> This adds a prefix string to any filename arguments encountered after it
> has been specified.

Very nice.  I thought we'd have to resort to path mangling in shell to
fix git-submodule.sh.  Glad to see that we can go with something
cleaner.

Perhaps pull some bits from your nice Documentation into the commit message?
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index f267a1d..de894c7 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -212,11 +212,17 @@ static void show_datestring(const char *flag, const char *datestr)
>         show(buffer);
>  }
>
> -static int show_file(const char *arg)
> +static int show_file(const char *arg, int output_prefix)

Okay, so you've essentially patched show_file() to accept an
additional argument, and modified callers to call with this additional
argument.  I suppose
show_(rev|reference|default|flag|rev|with_type|datestring|abbrev)
don't need to be patched, as they are path-independent.

>  {
>         show_default();
>         if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
> -               show(arg);
> +               if (output_prefix) {
> +                       const char *prefix = startup_info->prefix;
> +                       show(prefix_filename(prefix,
> +                                            prefix ? strlen(prefix) : 0,
> +                                            arg));
> +               } else
> +                       show(arg);

Uh, why do you need output_prefix?  If startup_info->prefix is set,
use it.  Is startup_info->prefix set by anyone by cmd_rev_parse()?

> @@ -470,6 +476,7 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
>  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> @@ -535,6 +542,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                                 i++;
>                                 continue;
>                         }
> +                       if (!strcmp(arg, "--prefix")) {
> +                               prefix = argv[i+1];
> +                               startup_info->prefix = prefix;
> +                               output_prefix = 1;
> +                               i++;
> +                               continue;
> +                       }

Wait, why isn't prefix filled in when run_builtin() calls this?  Oh,
right: because we didn't mark this builtin with RUN_SETUP or
RUN_SETUP_GENTLY.  Okay, now why didn't we change that?  Because it
would be a major problem (all our scripts would break) if rev-parse
did cd-to-toplevel.

Why are you setting prefix to argv[i+1], and then setting
startup_info->prefix to that?  Is anyone else in cmd_rev_parse() going
to use it?

> +prefix=$(git rev-parse --show-prefix)
> +cd "$(git rev-parse --show-toplevel)"
> +eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"

I'm wondering if you need such a convoluted usage though.  Will you
ever need to specify a prefix by hand that is different from what git
rev-parse --show-toplevel returns?  If not, why don't you just
rev-parse --emulate-toplevel, and get rid of specifying prefix by hand
altogether?  Then again, this is a plumbing command, so the simplicity
is probably more valuable.

> diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
> new file mode 100755
> index 0000000..5ef48d2
> --- /dev/null
> +++ b/t/t1513-rev-parse-prefix.sh
> +test_expect_success 'empty prefix -- file' '
> +       git rev-parse --prefix "" -- top sub1/file1 >actual &&
> +       cat <<-EOF >expected &&

Nit: when you're not putting in variables, you can cat <<-\EOF.

> +test_expect_success 'empty prefix HEAD:./path' '
> +       git rev-parse --prefix "" HEAD:./top >actual &&
> +       git rev-parse HEAD:top >expected &&

Nit: why did you change "./top" to "top"?  Your --prefix option
doesn't require you to change your arguments accordingly, does it?
