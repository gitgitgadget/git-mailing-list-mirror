From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Wed, 8 Jan 2014 02:00:44 +0530
Message-ID: <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:31:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dJD-0000MG-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbaAGUb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:31:27 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38903 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbaAGUb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:31:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so1011736iec.33
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 12:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K+R8b+zN1sZXxVaSrqbpycKGAjyGAFuvJqRDSj2wZpA=;
        b=hpOPxeLDdbYi6EGdhRrO6aIBaXDHFl+MT1oVf8zyyYSx/fH+C93IWyKVoaQP04A9GJ
         G5CWrJu2SwQs7IPZ6MJ+sxoPGnHmNv84drqwHTBz0jVILGdRqb4jFoG9wlbajabUSL90
         bOIBUxxnGKp86mVaIM7Ive+ZgnuSd4ETj+7iBds/sy3Ym60l1TQFTWsOqCR8UCoAOkH8
         NYfuxYZXGscUwF4zxO+DWsHG8lR+DhYP7d73Nv9y9Jl6t6r61Lq+i/5lkfQM1e8IMhVM
         5OAtO3XY65GvNYUPwLFmtepY8xPCQ3g+mU/vYyQucoAh7NsRwHRBNUklcYVBwMjHIxpK
         E1yw==
X-Received: by 10.42.40.83 with SMTP id k19mr83461525ice.3.1389126684725; Tue,
 07 Jan 2014 12:31:24 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Tue, 7 Jan 2014 12:30:44 -0800 (PST)
In-Reply-To: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240145>

[Fixed typo in Junio's address]

On Wed, Jan 8, 2014 at 1:59 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> A very common workflow for preparing patches involves working off a
> topic branch and generating patches against 'master' to send off to the
> maintainer. However, a plain
>
>   $ git format-patch -o outgoing
>
> is a no-op on a topic branch, and the user has to remember to specify
> 'master' explicitly everytime. This problem is not unique to
> format-patch; even a
>
>   $ git rebase -i
>
> is a no-op because the branch to rebase against isn't specified.
>
> To tackle this problem, introduce branch.*.forkedFrom which can specify
> the parent branch of a topic branch. Future patches will build
> functionality around this new configuration variable.
>
> Cc: Jeff King <peff@peff.net>
> Cc: Junio C Hamano <gister@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Since -M, -C, -D are left in the argc, checking argc < 2 isn't
>  sufficient.
>
>  I wanted to get an early reaction before wiring up checkout and
>  rebase.
>
>  But I wanted to discuss the overall idea of the patch.
>  builtin/log.c           | 21 +++++++++++++++++++++
>  t/t4014-format-patch.sh | 20 ++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index b97373d..525e696 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -674,6 +674,7 @@ static int thread;
>  static int do_signoff;
>  static const char *signature = git_version_string;
>  static int config_cover_letter;
> +static const char *config_base_branch;
>
>  enum {
>         COVER_UNSET,
> @@ -750,6 +751,22 @@ static int git_format_config(const char *var, const char *value, void *cb)
>                 config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>                 return 0;
>         }
> +       if (starts_with(var, "branch.")) {
> +               const char *name = var + 7;
> +               const char *subkey = strrchr(name, '.');
> +               struct strbuf buf = STRBUF_INIT;
> +
> +               if (!subkey)
> +                       return 0;
> +               strbuf_add(&buf, name, subkey - name);
> +               if (branch_get(buf.buf) != branch_get(NULL))
> +                       return 0;
> +               strbuf_release(&buf);
> +               if (!strcmp(subkey, ".forkedfrom")) {
> +                       if (git_config_string(&config_base_branch, var, value))
> +                               return -1;
> +               }
> +       }
>
>         return git_log_config(var, value, cb);
>  }
> @@ -1324,6 +1341,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 die (_("--subject-prefix and -k are mutually exclusive."));
>         rev.preserve_subject = keep_subject;
>
> +       if (argc < 2 && config_base_branch) {
> +               argv[1] = config_base_branch;
> +               argc++;
> +       }
>         argc = setup_revisions(argc, argv, &rev, &s_r_opt);
>         if (argc > 1)
>                 die (_("unrecognized argument: %s"), argv[1]);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 73194b2..2ea94af 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1370,4 +1370,24 @@ test_expect_success 'cover letter auto user override' '
>         test_line_count = 2 list
>  '
>
> +test_expect_success 'branch.*.forkedFrom matches' '
> +       mkdir -p tmp &&
> +       test_when_finished "rm -rf tmp;
> +               git config --unset branch.rebuild-1.forkedFrom" &&
> +
> +       git config branch.rebuild-1.forkedFrom master &&
> +       git format-patch -o tmp >list &&
> +       test_line_count = 2 list
> +'
> +
> +test_expect_success 'branch.*.forkedFrom does not match' '
> +       mkdir -p tmp &&
> +       test_when_finished "rm -rf tmp;
> +               git config --unset branch.foo.forkedFrom" &&
> +
> +       git config branch.foo.forkedFrom master &&
> +       git format-patch -o tmp >list &&
> +       test_line_count = 0 list
> +'
> +
>  test_done
> --
> 1.8.5.2.234.gba2dde8.dirty
>
