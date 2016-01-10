From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Sat, 9 Jan 2016 23:17:58 -0500
Message-ID: <CAPig+cRjy+xU7dZEbVfqD3LQ8YdzS2gWKL4tufSHfGSaUU-M1Q@mail.gmail.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 10 05:18:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aI7Si-0005BM-IP
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 05:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbcAJESA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 23:18:00 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35094 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794AbcAJER7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 23:17:59 -0500
Received: by mail-vk0-f65.google.com with SMTP id i129so4135951vkb.2
        for <git@vger.kernel.org>; Sat, 09 Jan 2016 20:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xxcOP1VD6DZgtOB8oGccsU5Orxvf1+MgEhqGGXiv22I=;
        b=FEWmB8tfQtsVoKg06hr02QT6O8lIM7RkvLFU4r+460eIqj+ecPQRN+JRVXz87gqvp5
         vp4+T1bnAOB2q1SZHKLECXFcuJ44KFjS/DA+CCdEEE5Y3Lj/4oWA4WPFxBxU//+0Yfob
         ppR3e7a5DYYYciFCAuC9cOfT3c+/YAQI/ekzMuqhaKKloK/pUDhflSITt3/VuS5qBm1q
         S5YRhrWpA1bjqsnXmntjgfykWWoTYRUsq76IjYfvqbyXSQkQ5dWEKWFJp2WmdCztVBpr
         dAZZCh4Xv8UP3MgjHLwpI3WUNxE44PURkWV+PR4OgtvqR86QqhvAjVnb2BsLvnBFAGB/
         lS4Q==
X-Received: by 10.31.58.74 with SMTP id h71mr84006814vka.151.1452399478636;
 Sat, 09 Jan 2016 20:17:58 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 9 Jan 2016 20:17:58 -0800 (PST)
In-Reply-To: <eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: QVR6g1xn-waJ17MW8tmlB2N4uOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283614>

On Fri, Jan 8, 2016 at 11:21 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Unfortunately, some libgen implementations yield outcomes different from
> what Git expects. For example, mingw-w64-crt provides a basename()
> function, that shortens `path0/` to `path`!
>
> So let's verify that the basename() and dirname() functions we use conform
> to what Git expects.
>
> Derived-from-code-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/test-path-utils.c b/test-path-utils.c
> @@ -39,6 +39,168 @@ static void normalize_argv_string(const char **var, const char *input)
> +struct test_data {
> +       char *from;  /* input:  transform from this ... */
> +       char *to;    /* output: ... to this.            */

Can these be 'const'? If I'm reading the code correctly, I don't think
these values ever get passed directly to functions expecting non-const
strings.

> +};
> +
> +static int test_function(struct test_data *data, char *(*func)(char *input),
> +       const char *funcname)
> +{
> +       int failed = 0, i;
> +       static char buffer[1024];

Why is this 'static'? It is never accessed outside of this scope.

> +       char *to;
> +
> +       for (i = 0; data[i].to; i++) {
> +               if (!data[i].from)
> +                       to = func(NULL);
> +               else {
> +                       strcpy(buffer, data[i].from);
> +                       to = func(buffer);
> +               }
> +               if (strcmp(to, data[i].to)) {
> +                       error("FAIL: %s(%s) => '%s' != '%s'\n",
> +                               funcname, data[i].from, to, data[i].to);
> +                       failed++;

Since 'failed' is only ever used as a boolean, it might be clearer to say:

    failed = 1;

> +               }
> +       }
> +       return !!failed;

And then simply:

    return failed;

> +}
> +
> +static struct test_data basename_data[] = {
> +       /* --- POSIX type paths --- */
> +       { NULL,              "."    },

NULL is tested here.

> +       { "",                "."    },
> +       { ".",               "."    },
> [...]
> +#endif
> +       { NULL,              "."    },

And also here. Is that intentional?

> +       { NULL,              NULL   }
> +};
> +
> +static struct test_data dirname_data[] = {
> +       /* --- POSIX type paths --- */
> +       { NULL,              "."      },
> [...]
> +#endif
> +       { NULL,              "."      },

Ditto.

> +       { NULL,              NULL     }
> +};
