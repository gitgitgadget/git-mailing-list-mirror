Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659EE107
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 13:46:54 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67a8a745c43so36810876d6.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 13:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701726413; x=1702331213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY5CPC3EQ7s5BASoNg1jOxiqqJ0CjslpHzGoKgcjGnQ=;
        b=I5t5F95v49q1bFmG7Ay2YxUBX0F0ldad5peUC0GdyfWYIM7SgZ4cBrbGQVrk4bkPKl
         qmWrnQnz3vjUolIf4oBFjPM1B6QmP8I4eXoU8osOnlFpwPnSWsOvsXsoXTeOGLsRwZjD
         bUKrpkJ+4g91vBe5iE5Izw/8RAzl46sViSKL8vWk8uPjo9dozcsv1cXHQ5+DlAHzCHhY
         ZddyVIaupb6AbhJv2DZgDlQihP/5HoXsDXb4k+umIK8q0sc/IuoCegOyTWdcZY+Y2zls
         ZO+U9A2cB+m/yz+mD9O9KKxYDwaUFbJF13OKNVVuApjIoKm0QnOm1XQfkuNFHsGxmHjp
         AJcQ==
X-Gm-Message-State: AOJu0YzBRzCEp5b85WcZlb79BcNyyGRYRlHohTEnqnzQzdj/HVcd9pD3
	LK1MYQNgrvHXjrzLZm0Kv5F7jl7obRBZqnu4aWTPfpYKfdMkBw==
X-Google-Smtp-Source: AGHT+IGJ5l9TILYCoaTdKLpe/cvPNO/Siq8RtJdyqpRF73RUzJYMm3poM0/UpTOd5h2kUaLjngfMQDu1WH5EHGe6Wfk=
X-Received: by 2002:a0c:e494:0:b0:67a:a72d:fbb4 with SMTP id
 n20-20020a0ce494000000b0067aa72dfbb4mr315115qvl.50.1701726413463; Mon, 04 Dec
 2023 13:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com> <pull.1537.v2.git.git.1701699574054.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v2.git.git.1701699574054.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 4 Dec 2023 16:46:42 -0500
Message-ID: <CAPig+cQ8eEU0TOoBf2KavTyf0OLhNtmOzs8+WqZy9JMXa=ydPQ@mail.gmail.com>
Subject: Re: [PATCH v2] This PR enables a successful git build on z/OS.
To: Haritha via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Haritha D <harithamma.d@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:19=E2=80=AFAM Haritha via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Rename functions like "release" and "fetch"
> due to conflict in z/OS standard C libraries.
> Also disables autoconversion facility on z/OS
> and relies on iconv.
> New files created in binary format are also
> tagged as binary.
>
> Signed-off-by: Haritha D <harithamma.d@ibm.com>
> ---
>     Enabling z/OS workflow for git
>
>     z/OS is an IBM mainframe operating system, also known as OS/390. Our
>     team has been actively involved in porting Git to z/OS and we have ma=
de
>     significant modifications to facilitate this process. The patch below=
 is
>     the initial configuration for z/OS. I also have few follow up changes
>     and I will send that after these changes are approved. Please let me
>     know if there are any concerns.

It's fairly unlikely that this patch will be accepted as-is. Please
see brian's[1] and Junio's[2] valuable review comments in response to
your v1. They contain important suggestions which will give you a
better chance of landing these changes.

Generally speaking, the patch's commit message lacks sufficient detail
to allow a reviewer (or future reader) to understand why the changes
are being made. Moreover, this single patch seems to be addressing at
least three separate issues, hence should be split into three or more
patches, each standalone and tackling a single issue, and each easily
digested by a reviewer. The commit message of each patch should fully
explain and justify the changes made by the patch, keeping in mind
that most reviewers probably aren't familiar with z/OS, thus will need
extra hand-holding. More below...

[1]: https://lore.kernel.org/git/ZVKrWSv7JguKTSYw@tapette.crustytoothpaste.=
net/
[2]: https://lore.kernel.org/git/xmqqcywd2m9i.fsf@gitster.g/

> diff --git a/builtin/archive.c b/builtin/archive.c
> @@ -14,6 +14,15 @@
>  static void create_output_file(const char *output_file)
>  {
>         int output_fd =3D xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC=
, 0666);
> +#ifdef __MVS__
> +       /*
> +        * Since the data is in binary format,
> +        * we need to set the z/OS file tag
> +        * to binary to disable autoconversion
> +        */
> +       if (__setfdbinary(output_fd))
> +               die_errno(_("could not tag archive file '%s'"), output_fi=
le);
> +#endif

As mentioned in an earlier review, the project generally doesn't want
#ifdef's littering the code and prefer that this sort of
platform-specific specialization be wrapped up in its own "compat"
file/function. For instance, perhaps you could create a
platform-specific specialization of xopen() and then `#define xopen`
to reference your specialized version. Your custom xopen() might first
call the xopen() which Git defines and then perform whatever extra
special work is needed for your platform. That way, you would not have
to muck around either in the code which calls xopen() or in the
Git-supplied xopen(). See, for example, how git-compat-util.h
overriedes certain functions, such as stat(), fstat(), etc. using an
#undefine/#define dance.

> diff --git a/combine-diff.c b/combine-diff.c
> @@ -1082,6 +1082,14 @@ static void show_patch_diff(struct combine_diff_pa=
th *elem, int num_parent,
> +               #ifdef __MVS__
> +                       /*
> +                        * Disable implicit autconversion on z/os,
> +                        * rely on conversion from iconv
> +                        */
> +                       __disableautocvt(fd);
> +               #endif
>                         elem->mode =3D canon_mode(st.st_mode);

Similar comment. Try to find an abstraction which allows you to
perform this specialization in a way which does not require #ifdef's
within the main source code if possible.

> diff --git a/fetch-negotiator.h b/fetch-negotiator.h
> @@ -47,7 +47,7 @@ struct fetch_negotiator {
> -       void (*release)(struct fetch_negotiator *);
> +       void (*release_negotiator)(struct fetch_negotiator *);> diff --gi=
t a/fetch-pack.c b/fetch-pack.c
> @@ -1232,7 +1232,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
>         if (negotiator)
> -               negotiator->release(negotiator);
> +               negotiator->release_negotiator(negotiator);
>         return ref;
>  }
> diff --git a/git-compat-util.h b/git-compat-util.h
> @@ -223,7 +223,15 @@ struct strbuf;
> +#ifdef __MVS__
> +       #define release stdlib_release
> +       #define fetch stdlib_fetch
> +#endif
>  #include <stdlib.h>
> +#ifdef __MVS__
> +       #undef fetch
> +       #undef release
> +#endif

So, the problem is that z/OS is polluting the C namespace or the
preprocessor namespace with names "release" and "fetch"? When we've
run across this problem on other platforms, we modify
git-compat-util.h or some other files in compat/ to suppress the
pollution introduced by the platform headers rather than "fixing" the
Git source code. For instance, if "release" and "fetch" are macros on
z/OS, then you may be able to simply #undef them after pulling in
whichever z/OS header defines them. If they are actual system
functions (rather than macros), you may be able to employ the
#undef/#define dance to rename them to something else, such as
"zos_release" and "zos_fetch" _before_ including the system header
which declares those functions.

> diff --git a/read-cache.c b/read-cache.c
> @@ -205,6 +205,14 @@ static int ce_compare_data(struct index_state *istat=
e,
>         int fd =3D git_open_cloexec(ce->name, O_RDONLY);
>         if (fd >=3D 0) {
> +       #ifdef __MVS__
> +               /*
> +                * Since the data is in binary format,
> +                * we need to set the z/OS file tag to
> +                * binary to disable autoconversion
> +                */
> +               __disableautocvt(fd);
> +       #endif

Same comment as above about encapsulating this in a platform-specific
specialization function in compat/ rather than polluting the code with
#ifdef.
