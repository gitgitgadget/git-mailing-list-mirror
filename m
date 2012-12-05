From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw_rmdir: do not prompt for retry when non-empty
Date: Wed, 5 Dec 2012 16:18:07 +0100
Message-ID: <CABPQNSbcSEKApDBWWt7z67DvV6=JwTGebdk6hjgR1OppPyOQwg@mail.gmail.com>
References: <1354617713-7436-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1212041728210.31987@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 16:19:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgGkb-0006mQ-4p
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 16:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093Ab2LEPSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 10:18:49 -0500
Received: from mail-vb0-f52.google.com ([209.85.212.52]:62801 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab2LEPSs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 10:18:48 -0500
Received: by mail-vb0-f52.google.com with SMTP id ez10so2305239vbb.11
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZqCSgROw8sUKEzrPIXa4+nF9SLy0OfIyhlCZYLCJcC4=;
        b=MrAqy+7GqIOY0j62KB6bLmI58MSvyRg2R23gRATavVGYh+rUnHzq914hpkIVpdZD+1
         e5dGTCJ6lXM8NFC1c7lTeI7fQ8LlDlGsFhApxnRJ2UC18Sl1TbuYmqHLNcWlWVLgYxld
         ziWBFM3pS1ggtK1XUCD5ZEZkF4KuoKoEwL0alTX7YnYt59wh9Sfs6ZtGSHqwgTPABZOE
         pQpehMn4TLuLoE1+Uuaq904aoxzLZgQ9Cw/kcVeW8vkwK5eBKZc5RWUse5GIwQ4ubLvq
         8txFNWbsE0TOOoHRurA2aCeKCU/yLYPL6xt+gPVs9MyNSlouUiGPOcA2Et4f7azk3txa
         YKzA==
Received: by 10.52.92.148 with SMTP id cm20mr13625806vdb.12.1354720727766;
 Wed, 05 Dec 2012 07:18:47 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Wed, 5 Dec 2012 07:18:07 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1212041728210.31987@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211126>

Sorry for a late reply.

On Tue, Dec 4, 2012 at 5:35 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi kusma,
>
> On Tue, 4 Dec 2012, Erik Faye-Lund wrote:
>
>> in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"),
>> a check was added to prevent us from retrying to delete a directory
>> that is both in use and non-empty.
>>
>> However, this logic was slightly flawed; since we didn't return
>> immediately, we end up falling out of the retry-loop, but right into
>> the prompting loop.
>>
>> Fix this by simply returning from the function instead of breaking
>> the loop.
>>
>> While we're at it, change the second break to a return as well; we
>> already know that we won't enter the prompting-loop, beacuse
>> is_file_in_use_error(GetLastError()) already evaluated to false.
>
> I usually prefer to break from the loop, to be able to add whatever
> cleanup code we might need in the future after the loop.
>
> So does this fix the problem for you?
>
> -- snipsnap --
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 04af3dc..504495a 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -259,7 +259,8 @@ int mingw_rmdir(const char *pathname)
>                 return -1;
>
>         while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
> -               if (!is_file_in_use_error(GetLastError()))
> +               errno = err_win_to_posix(GetLastError());
> +               if (errno != EACCESS)
>                         break;
>                 if (!is_dir_empty(wpathname)) {
>                         errno = ENOTEMPTY;
> @@ -275,7 +276,7 @@ int mingw_rmdir(const char *pathname)
>                 Sleep(delay[tries]);
>                 tries++;
>         }
> -       while (ret == -1 && is_file_in_use_error(GetLastError()) &&
> +       while (ret == -1 && errno == EACCESS &&
>                ask_yes_no_if_possible("Deletion of directory '%s' failed. "
>                         "Should I try again?", pathname))
>                ret = _wrmdir(wpathname);

Yes, as long as you do s/EACCESS/EACCES/ first. I don't mind such a
version instead.
