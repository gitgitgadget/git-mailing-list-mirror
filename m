From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] path.c: implement xdg_config_home()
Date: Thu, 16 Apr 2015 17:41:19 -0400
Message-ID: <CAPig+cTrErOBwPteeA1d_gdve5SiyLnbyFPpQ1sTN7aajGJfeA@mail.gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
	<20150414172854.GA27623@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 23:41:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YirXJ-0003oO-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 23:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbDPVlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 17:41:21 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35601 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbDPVlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 17:41:20 -0400
Received: by iejt8 with SMTP id t8so62083634iej.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4RwQ1nwbjDqQiL3Ha368nURT5yKGXRIU4U3jj9+tHmw=;
        b=mxRAdBILECCXAJ7KF79/QCHbAN5FA48Ouuh+xV18LhRfcuzvDp/umU/VduLchnWuBc
         2Ea5RChrgCwRkWY8ZXbFiIAciM90KD+a7UBHnL/h0KBQlAmC8wUd88zlRjEHriQuWl7p
         /lw5k7G8r2+xNXOem1YjoAUQ8QeUIGHxeryaBnoYcFO38UEEfqtehuULQFatS4YoJDDg
         tATs+iSacalupSULQIXqSaDcYtGZHr0oYD9jHRz3a7QbY60cYWQ1dkzVPlkK+ze37ia+
         zRKG91Ysz+LOZuZpiuz4OtHmpiZ/EAiU26jfRk1i4WkSxrAv8q1wkrTw+XyqLwrkWicO
         5afA==
X-Received: by 10.107.31.206 with SMTP id f197mr46100433iof.19.1429220479857;
 Thu, 16 Apr 2015 14:41:19 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 16 Apr 2015 14:41:19 -0700 (PDT)
In-Reply-To: <20150414172854.GA27623@yoshi.chippynet.com>
X-Google-Sender-Auth: ztyN7SEuOrAcNlhXegd-I-tdlu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267335>

On Tue, Apr 14, 2015 at 1:28 PM, Paul Tan <pyokagan@gmail.com> wrote:
> Below is the fixed patch. I also decided to return NULL if `filename` is
> NULL because such an input usually indicated an uncaught error.

Unfortunately, this blurs the line between programmer error (passing
NULL for filename) and a user/configuration error (XDG_CONFIG_HOME and
HOME being undefined). If there is indeed no valid interpretation for
filename==NULL, then it may be better to die() or assert() here to
flag the programmer error as early as possible, rather than returning
NULL.

More below.

> ---- >8 ----
> The XDG base dir spec[1] specifies that configuration files be stored in
> a subdirectory in $XDG_CONFIG_HOME. To construct such a configuration
> file path, home_config_paths() can be used. However, home_config_paths()
> combines distinct functionality:
>
> 1. Retrieve the home git config file path ~/.gitconfig
>
> 2. Construct the XDG config path of the file specified by `file`.
>
> This function was introduced in commit 21cf3227 ("read (but not write)
> from $XDG_CONFIG_HOME/git/config file").  While the intention of the
> function was to allow the home directory configuration file path and the
> xdg directory configuration file path to be retrieved with one function
> call, the hard-coding of the path ~/.gitconfig prevents it from being
> used for other configuration files. Furthermore, retrieving a file path
> relative to the user's home directory can be done with
> expand_user_path(). Hence, it can be seen that home_config_paths()
> introduces unnecessary complexity, especially if a user just wants to
> retrieve the xdg config file path.
>
> As such, implement a simpler function xdg_config_home() for constructing
> the XDG base dir spec configuration file path. This function, together
> with expand_user_path(), can replace all uses of home_config_paths().
>
> [1] http://standards.freedesktop.org/basedir-spec/basedir-spec-0.7.html
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> diff --git a/cache.h b/cache.h
> index 3d3244b..2db10b8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -836,6 +836,14 @@ char *strip_path_suffix(const char *path, const char *suffix);
>  int daemon_avoid_alias(const char *path);
>  extern int is_ntfs_dotgit(const char *name);
>
> +/**
> + * Returns the newly allocated string "$XDG_CONFIG_HOME/git/{filename}".  If
> + * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
> + * "$HOME/.config/git/{filename}". Returns NULL if filename is NULL or an error
> + * occurred.
> + */

This is better than the original which said "$XDG_CONFIG_HOME/git/%s",
but is still potentially confusing. When I read the earlier iteration,
I was left with the impression that it was returning that literal
string, with '$' and '%s' embedded, and that the caller would have to
process it further to have '$' and '%s' expanded. Perhaps rephrasing
it something like this will help?

    Return a newly allocated string with value xdg+"/git/"+filename
    where xdg is the interpolated value of $XDG_CONFIG_HOME if
    defined and non-empty, otherwise "$HOME/.config". Return NULL
    upon error.

Also, for consistency with other API documentation, say "Return"
rather than "Returns".

More below.

> +extern char *xdg_config_home(const char *filename);
> +
>  /* object replacement */
>  #define LOOKUP_REPLACE_OBJECT 1
>  extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
> diff --git a/path.c b/path.c
> index e608993..8ee7191 100644
> --- a/path.c
> +++ b/path.c
> @@ -856,3 +856,19 @@ int is_ntfs_dotgit(const char *name)
>                         len = -1;
>                 }
>  }
> +
> +char *xdg_config_home(const char *filename)
> +{
> +       const char *config_home = getenv("XDG_CONFIG_HOME");
> +
> +       if (!filename)
> +               return NULL;

See above regarding conflation of programmer error and user/configuration error.

> +       if (!config_home || !config_home[0]) {

On this project, *config_home is usually favored over config_home[0].

> +               const char *home = getenv("HOME");
> +
> +               if (!home)
> +                       return NULL;
> +               return mkpathdup("%s/.config/git/%s", home, filename);
> +       } else
> +               return mkpathdup("%s/git/%s", config_home, filename);

This logic is more difficult to follow than it ought to be due to the
use of 'config_home' so distant from the 'if' which checked it, and
due to the nested 'if'. It could be expressed more straight-forwardly
as:

    if (config_home && *config_home)
        return mkpathdup("%s/git/%s", config_home, filename);

    home = getenv("HOME");
    if (home)
        return mkpathdup("%s/.config/git/%s", home, filename);

    return NULL;

> +}
> --
> 2.1.4
