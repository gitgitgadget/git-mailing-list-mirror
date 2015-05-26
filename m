From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Mon, 25 May 2015 21:03:20 -0700
Message-ID: <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Smith <paul@mad-scientist.net>,
	Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: Daniel Smith <dansmith65@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 06:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx65f-00056U-Nc
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 06:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbbEZEDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 00:03:37 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34472 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbEZEDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 00:03:36 -0400
Received: by igbhj9 with SMTP id hj9so49902310igb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 21:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cdfr8QD5JiltHTvy6Rk/1caYzfPhZN2RXKFPxKUm/XY=;
        b=lfonCNS93H2QxO4/GOdd7NH7xfCFNkBOEUbYHQpln8WzyKcyKP6OBfXHMF9BkYwEoY
         io4r6807O3Tl33+5xUv7Jjqod7u3w4wU8HEuuBz3wksFEyZQlsB0tN6rr41vorxJHFwY
         RM9ULDlYIYl3yXf9X+72aJ2FP67Zpi3G/3kqwsSMxddnqvC9B2E2ezKBxRqA34YroLC+
         n71PU9vlglXxa+quD3K3bXQcfgQWT7UnyiVpQrwWDUWaeoTprmh3NATTpR1mdqAoH7nf
         SpBVxQDQ8NcXqFFURtPLtDDGo6o/3+BC4OGFBumsuoT9PXMADhOIEiAp0frvHnyzaThQ
         hkjA==
X-Received: by 10.50.178.230 with SMTP id db6mr27134608igc.26.1432613002347;
        Mon, 25 May 2015 21:03:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id d4sm7554908igl.1.2015.05.25.21.03.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 21:03:21 -0700 (PDT)
In-Reply-To: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
	(Daniel Smith's message of "Mon, 25 May 2015 16:44:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269929>

Daniel Smith <dansmith65@gmail.com> writes:

> When running on Windows in MinGW, creating symbolic links via ln always
> failed.
>
> Using mklink instead of ln is the recommended method of creating links on
> Windows:
> http://stackoverflow.com/questions/18641864/git-bash-shell-fails-to-create-symbolic-links
>
> Script now branches on Windows to use mklink. This change should not affect
> unix systems.
>
> Signed-off-by: Daniel Smith <dansmith65@gmail.com>
>
> Has been tested on Windows 8.1 and OS X Yosemite.
> ---

Swap the "Has been tested..." and "Signed-off-by:" lines.

I'll defer to Windows folks if "mklink" is a sensible thing to use
or not; I have no first-hand experience with Windows, but only heard
that links are for admin user only or something like that, so I want
to hear from people whose judgement on Windows matters I trust.

>
> +iswindows () {
> + [[ -n "$WINDIR" ]];
> +}

Please don't add unnecessary bash-isms.  We have kept this script
usable without stepping out of POSIX.

	test -n "$WINDIR"

> -git_dir=$(cd "$git_dir" && pwd) || exit 1
> +if iswindows
> +then
> + git_dir=$(cd "$git_dir"; cmd.exe /c cd) || exit 1
> +else
> + git_dir=$(cd "$git_dir" && pwd) || exit 1
> +fi

Indentation of lines inside a new block is done with one more level
of HT in our scripts, not with just one SP.

> - ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
> + if iswindows
> + then

Move these into a helper shell function, starting from here...

> + if test -d "$git_dir/$x"
> + then
> + # create directory symbolic link
> + isdir="/d"
> + fi
> + # convert path separator to backslash
> + targetPath=$(sed -e 's#^J:##' -e 's#/#\\#g' <<< "$git_dir/$x")
> + cmd.exe /c "mklink $isdir \"$new_workdir/.git/$x\" \"$targetPath\"" || failed

... up to here.  Also a few points about these new lines:

 * Use indentation when doing nested if/then/if/then/fi/fi block,
   i.e.

	if isWindows
        then
		if test -d "..."
                then
			isdir=/d
                fi
                target=..
                cmd.exe /c ...
	fi

 * "<<<" is a bash-ism, isn't it?

 * Use of "#" as s/// separator, when slash is not involved, looks
   ugly and makes it harder to read.

 * Is "J:" drive something special (unlike C: or D: drives)?

 * Can computation of targetPath fail?  IOW, shouldn't that line end
   with &&?

 * Share || failed between this part and POSIX part, i.e.

	if isWindows
        then
		ln_s_win "$new_workdir" "$x"
	else
		ln -s "$git_dir/$x" "$new_workdir'.git/$x"
	fi || failed

   where ln_s_win would be the "helper shell function" I suggested.

	ln_s_win () {
		if test -d "$git_dir/$2"
		then
                	isdir=/d
		fi
                target=$(printf "%s" "$git_dir/$2" | sed -e "...") &&
		cmd.exe /c "mklink $isdir ..."
	}

> + else
> + ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
> + fi
>  done
>
>  # commands below this are run in the context of the new workdir

Thanks.
