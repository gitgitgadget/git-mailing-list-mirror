From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Wed, 30 Apr 2014 15:04:51 +0200
Message-ID: <CABPQNSYDD7g3nOwb2ZaOQ9M9gQnjzQyKP4Zo-i8p4o-s30bk1Q@mail.gmail.com>
References: <1398718883-5630-1-git-send-email-dborowitz@google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 15:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfUCl-0003Eg-5F
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 15:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757878AbaD3NFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 09:05:39 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:44142 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaD3NFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 09:05:38 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so1846588ieb.27
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QH3/eb8eE+41p23y8mhnnJcNWB7mcAp1HTZpNdlE1dE=;
        b=bHGarQEqcKxY8bkOV4qaE1+ciKFO3P2u5nYD//d332WfFiSv+1kuHfF2mH/cZnfPF2
         lJ5I6mi7+lxZeh9jXiSFn4ir04TM2F3MrF8XGZviOKz62Kiv04hUJtXmWaH7upctmGWk
         MllBNDW6KDUcpaXRWLmKM1IqR3ETfA8mpO5PUh4bvKLpY2JzBoMor3lZTuXxWmgWrJlr
         702NApEGCOOWyiQqvna/Vi5RHEJ0gmPJWYnD3rS1P852QF/ywUeT6GU0Mf3cuCXscMGu
         vkdz7BsTFKbUukMlZgMxyOfhpgBI3PwBCoL+/eKXeC/wFAyHdZy3TYuwllZmu2Sc1nvm
         wKEw==
X-Received: by 10.42.204.197 with SMTP id fn5mr1071337icb.95.1398863132046;
 Wed, 30 Apr 2014 06:05:32 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 30 Apr 2014 06:04:51 -0700 (PDT)
In-Reply-To: <1398718883-5630-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247710>

On Mon, Apr 28, 2014 at 11:01 PM, Dave Borowitz <dborowitz@google.com> wrote:
> The original implementation of CURL_CONFIG support did not match the
> original behavior of using -lcurl when CURLDIR was not set. This broke
> implementations that were lacking curl-config but did have libcurl
> installed along system libraries, such as MSysGit. In other words, the
> assumption that curl-config is always installed was incorrect.
>
> Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
> to curl-config being missing), use the old behavior of falling back to
> -lcurl.
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Makefile | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 74a929b..81e8214 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -35,14 +35,17 @@ all::
>  # transports (neither smart nor dumb).
>  #
>  # Define CURL_CONFIG to the path to a curl-config binary other than the
> -# default 'curl-config'.
> +# default 'curl-config'.  If CURL_CONFIG is unset or points to a binary that
> +# is not found, defaults to the CURLDIR behavior.
>  #
>  # Define CURL_STATIC to statically link libcurl.  Only applies if
>  # CURL_CONFIG is used.
>  #
>  # Define CURLDIR=/foo/bar if your curl header and library files are in
> -# /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
> -# but is less robust.
> +# /foo/bar/include and /foo/bar/lib directories.  This overrides
> +# CURL_CONFIG, but is less robust.  If not set, and CURL_CONFIG is not set,
> +# uses -lcurl with no additional library detection (other than
> +# NEEDS_*_WITH_CURL).

This is wrong, no? With CURL_CONFIG not set, it currently *does* run
curl-config, see below.

>  #
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>  # not built, and you cannot push using http:// and https:// transports (dumb).
> @@ -1127,9 +1130,27 @@ ifdef NO_CURL
>         REMOTE_CURL_NAMES =
>  else
>         ifdef CURLDIR
> -               # Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
> -               BASIC_CFLAGS += -I$(CURLDIR)/include
> -               CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
> +               CURL_LIBCURL =
> +       else
> +               CURL_CONFIG = curl-config
> +               ifeq "$(CURL_CONFIG)" ""
> +                       CURL_LIBCURL =
> +               else
> +                       CURL_LIBCURL := $(shell $(CURL_CONFIG) --libs)
> +               endif

Doesn't that definition just define CURL_CONFIG unconditionally? How
are the first condition ever supposed to get triggered?

$ make
make: curl-config: Command not found
GIT_VERSION = 1.9.2.462.gf3f11fa
make: curl-config: Command not found
    * new build flags
    * new link flags
    * new prefix flags
    GEN common-cmds.h
...

Yuck.
