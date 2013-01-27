From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 21:07:49 -0800
Message-ID: <CAJDDKr5cCbNi5q5_Ds-yohXR56ZfVs7YBTgJP3THjRx1=EgG9w@mail.gmail.com>
References: <1359183058-51835-1-git-send-email-davvid@gmail.com>
	<20130126121202.GH7498@serenity.lan>
	<7v8v7fz0ii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 06:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzKU7-000142-DO
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 06:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731Ab3A0FHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 00:07:52 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54076 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab3A0FHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 00:07:51 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn17so586517wib.12
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 21:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6ERYlfPvf0QbsCY1TPh9dY2qRPdqxOusVeLFRAmOvI8=;
        b=FLZvMUDFcGrg2fS9Jkm6cZ7tW3KiyISYARunbmL/42ekrs7Ay48j1ykUP3JvOTq0PT
         iwjdWvKHLVIFoKwIqoPm0yK/32KpdxK0MSrlEFhp4wfPVHAghXizA7IicWAwqtzgbvEw
         lYbGzVyPtrwcYEAetgBREuOSTzOdovxPAU6HaCRsA10Co9KE6yrknPE093lkap9ZkenD
         YrrZCSKXuHR3kBs4mlVTdMxfseppD5X4Unwlk4HWZPt/mZ/FT7MUhDuf9NH3V24yOSHD
         kagCJnEjsLblRdE95qYIHxhrEZOvf3i6/7NX2XH/r3739E7EfFQ+rjDsRJrKl4/S4Eul
         a0MQ==
X-Received: by 10.194.58.175 with SMTP id s15mr15396314wjq.31.1359263269428;
 Sat, 26 Jan 2013 21:07:49 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Sat, 26 Jan 2013 21:07:49 -0800 (PST)
In-Reply-To: <7v8v7fz0ii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214677>

On Sat, Jan 26, 2013 at 8:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> I'm not sure creating an 'include' directory actually buys us much over
>> declaring that 'vimdiff' is the real script and the others just source
>> it.
>
> Is 'include' really used for such a purpose?  It only houses defaults.sh
> as far as I can see.
>
> As that defaults.sh file is used only to define trivially empty
> shell functions, I wonder if it is better to get rid of it, and
> define these functions in line in git-mergetool--lib.sh.  Such a
> change would like the attached on top of the entire series.

I think that's much better.


>  Makefile                       |  6 +-----
>  git-mergetool--lib.sh          | 24 ++++++++++++++++++++++--
>  mergetools/include/defaults.sh | 22 ----------------------
>  3 files changed, 23 insertions(+), 29 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 26f217f..f69979e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2724,11 +2724,7 @@ install: all
>         $(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
>         $(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>         $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> -       $(INSTALL) -m 644 $(filter-out mergetools/include,$(wildcard mergetools/*)) \
> -               '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> -       $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
> -       $(INSTALL) -m 644 mergetools/include/* \
> -               '$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
> +       $(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
>  ifndef NO_GETTEXT
>         $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
>         (cd po/build/locale && $(TAR) cf - .) | \
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 7ea7510..1d0fb12 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -57,8 +57,28 @@ setup_tool () {
>                 return 2
>         fi
>
> -       # Load the default functions
> -       . "$MERGE_TOOLS_DIR/include/defaults.sh"
> +       # Fallback definitions, to be overriden by tools.
> +       can_merge () {
> +               return 0
> +       }
> +
> +       can_diff () {
> +               return 0
> +       }
> +
> +       diff_cmd () {
> +               status=1
> +               return $status
> +       }
> +
> +       merge_cmd () {
> +               status=1
> +               return $status
> +       }
> +
> +       translate_merge_tool_path () {
> +               echo "$1"
> +       }
>
>         # Load the redefined functions
>         . "$MERGE_TOOLS_DIR/$tool"
> diff --git a/mergetools/include/defaults.sh b/mergetools/include/defaults.sh
> deleted file mode 100644
> index 21e63ec..0000000
> --- a/mergetools/include/defaults.sh
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -# Redefined by builtin tools
> -can_merge () {
> -       return 0
> -}
> -
> -can_diff () {
> -       return 0
> -}
> -
> -diff_cmd () {
> -       status=1
> -       return $status
> -}
> -
> -merge_cmd () {
> -       status=1
> -       return $status
> -}
> -
> -translate_merge_tool_path () {
> -       echo "$1"
> -}



-- 
David
