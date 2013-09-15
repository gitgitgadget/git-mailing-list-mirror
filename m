From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] repack: rewrite the shell script in C
Date: Sun, 15 Sep 2013 23:24:34 +0530
Message-ID: <CALkWK0nG4+pdSEEUhHrN=+kXEetJ4sJxVOc0VWSweRuJUL-jsA@mail.gmail.com>
References: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 15 19:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLGXj-0000cq-Ep
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 19:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab3IORzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 13:55:18 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:61856 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3IORzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 13:55:17 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so6082500ieb.12
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uzbS4hGmy5/03uNiix1+FQ0XS67yg0b8nT8WtofteUk=;
        b=TPuM9f5OKktLn7zDp94lFpaqodxBIKgTIA0pPT7H8N66KrYhFTsNKeKpEV68zwpduy
         I1UB0xYSVErNpr1QK1GGswFms2+8yCFToSPZybT+hPYeaG9CTETq0jEq/gsCNXgJS5CZ
         ORXdEheW0JbJJRBCr1AEPY+Fo5emaYCqhTijzu4KuUvK4UFGFVOZGQ0cQt9w55igGcqC
         fWpDsYlhcYUOIMhQc8Y6nXv/YJwWKaGs7Wo7h1btpFX+a1ZyzrWQEI5l91WxPfG22ivt
         UgGQnUNjDNHLMm0420baJ8w9diM+khQ+jLDVRCFv2X3pk8kXojoJKSzBpk4/qp+W6roJ
         1How==
X-Received: by 10.50.23.16 with SMTP id i16mr4912068igf.50.1379267714909; Sun,
 15 Sep 2013 10:55:14 -0700 (PDT)
Received: by 10.64.73.5 with HTTP; Sun, 15 Sep 2013 10:54:34 -0700 (PDT)
In-Reply-To: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234824>

Stefan Beller wrote:
>  Makefile                       |   2 +-
>  builtin.h                      |   1 +
>  builtin/repack.c               | 387 +++++++++++++++++++++++++++++++++++++++++
>  contrib/examples/git-repack.sh | 194 +++++++++++++++++++++
>  git-repack.sh                  | 194 ---------------------
>  git.c                          |   1 +
>  6 files changed, 584 insertions(+), 195 deletions(-)
>  create mode 100644 builtin/repack.c
>  create mode 100755 contrib/examples/git-repack.sh
>  delete mode 100755 git-repack.sh

Looks like repack.c is significantly larger than git-repack.sh. I look
forward to reading the code.

> diff --git a/builtin/repack.c b/builtin/repack.c
> new file mode 100644
> index 0000000..a15bd9b
> --- /dev/null
> +++ b/builtin/repack.c
> @@ -0,0 +1,387 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "dir.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "sigchain.h"
> +#include "strbuf.h"
> +#include "string-list.h"
> +#include "argv-array.h"
> +
> +static int delta_base_offset = 1;
> +static char *packdir, *packtmp;
> +
> +static const char *const git_repack_usage[] = {
> +       N_("git repack [options]"),
> +       NULL
> +};
> +
> +static int repack_config(const char *var, const char *value, void *cb)
> +{
> +       if (!strcmp(var, "repack.usedeltabaseoffset")) {
> +               delta_base_offset = git_config_bool(var, value);
> +               return 0;
> +       }
> +       return git_default_config(var, value, cb);
> +}

Configuration option: one bool. I wonder what other configuration
options the future will bring in.

> +/*
> + * Remove temporary $GIT_OBJECT_DIRECTORY/pack/.tmp-$$-pack-* files.
> + */

Is $GIT_OBJECT_DIRECTORY a standard variable, or should it be
$GIT_DIR/objects? A quick grep tells me that there are a few
references to it, but I'm yet to be convinced that it can be something
other than $GIT_DIR/objects.

> +static void remove_temporary_files(void)
> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       size_t dirlen, prefixlen;
> +       DIR *dir;
> +       struct dirent *e;
> +
> +       dir = opendir(packdir);
> +       if (!dir)
> +               return;

Wait a minute: where did we initalize packdir? Ah, it's static, so it
must have been initalized before the function was called (in some sort
of setup function), right? Why don't you return an int from the
function so it's possible to differentiate between success and
failure?

> +       /* Point at the slash at the end of ".../objects/pack/" */

Is packdir a relative or absolute path? The ... isn't helping.

> +       dirlen = strlen(packdir) + 1;
> +       strbuf_addstr(&buf, packtmp);

Mysterious initalization of packtmp.

> +       /* Hold the length of  ".tmp-%d-pack-" */
> +       prefixlen = buf.len - dirlen;

Okay, so that's what packtmp contains: a reading of repack.sh told me
that you didn't even change the variable names.

> +       while ((e = readdir(dir))) {
> +               if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
> +                       continue;

Skip the dentry that points to the .tmp-* thing.

> +               strbuf_setlen(&buf, dirlen);
> +               strbuf_addstr(&buf, e->d_name);
> +               unlink(buf.buf);
> +       }
> +       closedir(dir);
> +       strbuf_release(&buf);
> +}

Okay.

> +static void remove_pack_on_signal(int signo)
> +{
> +       remove_temporary_files();
> +       sigchain_pop(signo);
> +       raise(signo);
> +}

Okay, although I'd have named the variable "signal", not "signo".

> +/*
> + * Adds all packs hex strings to the fname list, which do not
> + * have a corresponding .keep file.
> + */

The packs which don't have a corresponding .keep file must be removed/
repacked. Okay.

> +static void get_non_kept_pack_filenames(struct string_list *fname_list)
> +{
> +       DIR *dir;
> +       struct dirent *e;
> +       char *fname;

Filename, I assume.

> +       size_t len;
> +
> +       if (!(dir = opendir(packdir)))
> +               return;

An int return, please.

> +       while ((e = readdir(dir)) != NULL) {
> +               if (suffixcmp(e->d_name, ".pack"))
> +                       continue;

If we didn't find a .pack file, skip over?

> +               len = strlen(e->d_name) - strlen(".pack");
> +               fname = xmemdupz(e->d_name, len);

You can probably use the pathbufs to save some memory here, but I
wouldn't worry about it at this stage.

> +               if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
> +                       string_list_append_nodup(fname_list, fname);
> +               else
> +                       free(fname);
> +       }
> +       closedir(dir);
> +}

Okay.

> +static void remove_redundant_pack(const char *path_prefix, const char *hex)
> +{
> +       const char *exts[] = {".pack", ".idx", ".keep"};
> +       int i;
> +       struct strbuf buf = STRBUF_INIT;
> +       size_t plen;
> +
> +       strbuf_addf(&buf, "%s/%s", path_prefix, hex);

hex is the sha1-hex written out to the full 40 characters?

> +       plen = buf.len;
> +
> +       for (i = 0; i < ARRAY_SIZE(exts); i++) {
> +               strbuf_setlen(&buf, plen);
> +               strbuf_addstr(&buf, exts[i]);
> +               unlink(buf.buf);
> +       }
> +       strbuf_release(&buf);
> +}

So you find the redundant sha1-hexes and unlink the corresponding
.pack, .idx and .keep files. Okay.

> +#define ALL_INTO_ONE 1
> +#define LOOSEN_UNREACHABLE 2

Wait, isn't all_into_one supposed to be configurable? What is
loosen_unreachable?

> +int cmd_repack(int argc, const char **argv, const char *prefix)
> +{
> [...]

So argument parsing and spawning pack-objects appropriately is what
blew up the size of this file. I'll review this monolith in another
sitting.

Thanks for the enjoyable read.

Ram
