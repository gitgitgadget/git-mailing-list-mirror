From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC/GSoC 03/17] builtin-rebase: implement skeletal builtin rebase
Date: Mon, 14 Mar 2016 11:31:27 -0700
Message-ID: <CAGZ79ka64xBABfsWtX6GmK+sdy=VziZeGBKz9A3V=jX9ZcyfyA@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:31:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afXHC-0007tk-IE
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbcCNSb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 14:31:29 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35647 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbcCNSb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:31:28 -0400
Received: by mail-ig0-f177.google.com with SMTP id vf5so68458404igb.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JOABCe/3AYkklBrX1E+F3cVO74M1/Ck62BqxmLJkwGk=;
        b=NhbEc0bTird0LC2zAd5QEmm5UnI5YzSaih9jhmR/l5RCr78g0FYNF9aZIAOCDNdaBI
         FP/L0cS5yGYgf5HsXbq+WeML+CwSGhvn2jTpAH7cpJ61+DCXkF2gDxwU1yz33terF/W2
         IbWh+ncSgE025K7iY4Kejl56PLt05yykmJyzVgCVUGMH+g3f14HvGUY+YwaaFmGBDtDb
         dPEEaDkBweOPF+BWFe8Lxx4ABSBEhsEVdO9cwz5NC4znybbhQ3xO2Db9ZUPdbCmFAPY4
         Mm9SEe85ee0jQ9koqw3DCgjYnwFYwai8OtktYblOJzIP3RppZ3Nv42IcQkrjo0pLP9gj
         0xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JOABCe/3AYkklBrX1E+F3cVO74M1/Ck62BqxmLJkwGk=;
        b=d4JRvrWLX9kl7ehMTWiTwc9ebGX/M+z4NeyWzTBrJNDhaDDvm0lNHScGPHJPlqs2vr
         M8DFHKNkDic2jiOmBpaaqsfICKvF63uqcYGM+5jiMB6NyP5iCV/7pzeMOn4+7mMRY6e6
         UxqiddGbq6XK95zDNUqHijzgL23jvwchtwWxdB69cPMJayj+jbEf2eiI00rdjk43RNn6
         SGKc8/EbXfhvOYtFxyX59Vkjs0LKxjbZIOdgtogajtzGxJ4+HDQoM7RXgrZtS3317jz5
         4MlF1L6gtzN11qTjLVtprxzs2GeddzaBQHiJk34ixf30bJoXUBzQmp/pVOEQNDVpd6bn
         D/Mg==
X-Gm-Message-State: AD7BkJLmLpU+BNohaQ64haUgp4wFGRpAZI0YUkeeGqwY3z//fRKIbWT/XboiZ4p7dHnW8b5FGN4oT4Pe0rAT09Gk
X-Received: by 10.50.112.10 with SMTP id im10mr19344102igb.93.1457980287262;
 Mon, 14 Mar 2016 11:31:27 -0700 (PDT)
Received: by 10.107.58.6 with HTTP; Mon, 14 Mar 2016 11:31:27 -0700 (PDT)
In-Reply-To: <1457779597-6918-4-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288798>

On Sat, Mar 12, 2016 at 2:46 AM, Paul Tan <pyokagan@gmail.com> wrote:

   "Unlike when doing git-am, "git am" kept working during the whole series
    and being switched from the shell to the C implementation in the
last commit,
    this time rebase is broken in the series, and built up from here again" ?

> @@ -505,9 +504,6 @@ SCRIPT_SH += git-web--browse.sh
>
>  SCRIPT_LIB += git-mergetool--lib
>  SCRIPT_LIB += git-parse-remote
> -SCRIPT_LIB += git-rebase--am
> -SCRIPT_LIB += git-rebase--interactive
> -SCRIPT_LIB += git-rebase--merge

You would also want to retire these files to the contrib directory in
the same patch as you unlink them from the build process?

>         { "read-tree", cmd_read_tree, RUN_SETUP },
> +       { "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },

#TIL you cannot run rebase in a bare repository(, yet). I would have
assumed you could.
