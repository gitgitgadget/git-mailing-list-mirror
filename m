From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 09:11:48 +0200
Message-ID: <CAHGBnuOwf2cBMZf1A6HuSoVTPxCem7fH3TOCHnYg3tW-QkoOEg@mail.gmail.com>
References: <1432095635-96710-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 09:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuyCQ-0000OV-C6
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 09:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbbETHNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 03:13:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35180 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbETHLt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 03:11:49 -0400
Received: by iesa3 with SMTP id a3so32499318ies.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8nShz0qnAB5MMJGAQOPkzuq4p0GsEPj/34xWJKykdg8=;
        b=g5gfA/WO5OzYI1CrPKVIKfJtRz9K7pjmfpXS/5crszR9uS8zWqmqbORo7RXYZhmxwZ
         s+5eoeQqDopT1ibNyk6X+Cw+G7VbLN0V+I9ylspKTJ94gns0YcBhWebNq4RgcuG+PvH0
         bW5EGmpckqtNhmFV8wODylbNYsyxfkO8/HrHnm8DZ/cED+9CuXJ4PHi0fob8Ai0IWfuF
         +1aR59CGUWK758JGCU6Qz8AnmyarAsFsJxvQe4j90Nqailjvo8HQw2xYNuR9R+PBpHEq
         wUVhVKNUF6cyxpN6cnEJRHIp4bc+mOMidY0tNtBqSP9mqxSLu0fRPNW1pkjfPKoHPokc
         6eUA==
X-Received: by 10.42.105.3 with SMTP id t3mr44985089ico.47.1432105908548; Wed,
 20 May 2015 00:11:48 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 20 May 2015 00:11:48 -0700 (PDT)
In-Reply-To: <1432095635-96710-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269441>

On Wed, May 20, 2015 at 6:20 AM, David Aguilar <davvid@gmail.com> wrote:

> +translate_merge_tool_path() {
> +       # Use WinMergeU.exe if it exists in $PATH
> +       if type WinMergeU.exe >/dev/null 2>&1

Maybe "type -p" here?

> +       # Look for WinMergeU.exe in the typical locations
> +       winmerge_exe="WinMerge/WinMergeU.exe"
> +
> +       if test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES (x86)/$winmerge_exe"
> +       then
> +               printf '%s' "$PROGRAMFILES (x86)/$winmerge_exe"
> +       elif test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES/$winmerge_exe"
> +       then
> +               printf '%s' "$PROGRAMFILES/$winmerge_exe"
> +       else
> +               echo WinMergeU.exe
> +       fi
> +}

This does not solve the problem reported by Dscho that some versions
of Cygwin / MSYS 1 / MSYS 2 might export "$ProgramFiles" instead of
"$PROGRAMFILES" (or similar for related variables).

Also there is a bit too much string duplication for my taste. And why
use "echo" in some places and "printf" in others?

I still like a loop-based solution best:

IFS=$'\n'
for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
cut -d '=' -f 2- | sort -u)
do
    test -n "$directory" &&
    test -x "$directory/$winmerge_exe" &&
    echo "$directory/$winmerge_exe" &&
    break
done

-- 
Sebastian Schuberth
