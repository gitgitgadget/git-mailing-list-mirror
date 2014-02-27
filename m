From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] shallow: verify shallow file after taking lock
Date: Thu, 27 Feb 2014 17:18:58 +0700
Message-ID: <CACsJy8AHwyy0wwFD3fu+Aak+k=bFM1NAWzVSs1G4389UWqZptg@mail.gmail.com>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
 <20140227090426.GA21892@sigill.intra.peff.net> <20140227091012.GB21892@sigill.intra.peff.net>
 <20140227092227.GA28551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 11:19:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIy48-0005Il-I7
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 11:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbaB0KTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 05:19:30 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:61139 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaB0KT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 05:19:29 -0500
Received: by mail-qg0-f48.google.com with SMTP id a108so5057520qge.7
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 02:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WXdtsACClYIcC715qSp2CkoJgncpzuv2WlamJC9fCo4=;
        b=JBw8au5/lt9ih61CZY7dIhnOiLNLNx6tJQKaNQ/XmAlBBaGYeTtVaW91Avm29aANol
         UMdUCkajp+xbLBIa+1F2jG8au9Mm7YQ80L81woY2bdPYDVbEpzpwroFtZSVj8Gnz33eG
         KT+Lism565rPLzkQG4/xlh0neGV6S9xO+/qBHHNt4q0ucbG+0SCCmgvRneobNRJ5T/+Q
         2dAExH0irctxAEEUFbTvAz4ADvc9VguScDnHlcwunfWDv99SAGI+FaokwpRlQUo/0ZCH
         vUEH6vSfaM1srh7aV5BIpnVehfEWkXQvQcryLizZ8CmyMY6SPiblr7F9WpVKxl7L0nic
         f05A==
X-Received: by 10.140.47.212 with SMTP id m78mr5762868qga.21.1393496368906;
 Thu, 27 Feb 2014 02:19:28 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 27 Feb 2014 02:18:58 -0800 (PST)
In-Reply-To: <20140227092227.GA28551@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242799>

On Thu, Feb 27, 2014 at 4:22 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 27, 2014 at 04:10:12AM -0500, Jeff King wrote:
>
>> I also notice that check_shallow_file_for_update returns early if
>> !is_shallow. Is that safe? Is it possible for another process to have
>> made us shallow since the program began? In that case, we would have to
>> stat() the file always, then complain if it exists and !is_shallow.

I think it's safer to do it your way.

>
> That patch would look like this:
>
> diff --git a/shallow.c b/shallow.c
> index 75da07a..e05a241 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -139,13 +139,13 @@ void check_shallow_file_for_update(void)
>  {
>         struct stat st;
>
> -       if (!is_shallow)
> -               return;
> -       else if (is_shallow == -1)
> +       if (is_shallow == -1)
>                 die("BUG: shallow must be initialized by now");
>
>         if (stat(git_path("shallow"), &st))
>                 die("shallow file was removed during fetch");
> +       else if (!is_shallow)
> +               die("shallow file appeared during fetch");
>         else if (st.st_mtime != shallow_stat.st_mtime
>  #ifdef USE_NSEC
>                  || ST_MTIME_NSEC(st) != ST_MTIME_NSEC(shallow_stat)
>
> but again, I'm not really clear on whether this is possible.
>
> -Peff



-- 
Duy
