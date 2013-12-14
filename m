From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/POC 2/7] Add new environment variable $GIT_SUPER_DIR
Date: Sat, 14 Dec 2013 08:11:00 +0700
Message-ID: <CACsJy8DG0yx0J6tnAT-BsHsArCRA2akK-txWv5ee6k4pxPpixQ@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1386771333-32574-3-git-send-email-pclouds@gmail.com> <xmqqmwk4r55u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 02:12:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrdlw-0004l0-Ey
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 02:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab3LNBLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 20:11:51 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:46150 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab3LNBLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 20:11:30 -0500
Received: by mail-ob0-f169.google.com with SMTP id wm4so2748222obc.14
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 17:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M1N2nySok4+HN3GJl108fFBFup5k3hl9kl1ZudqZQuI=;
        b=c4OGYvzbrNwLo+JYlDqG22NJF1Ff3tjdxBjAOq5/sVIkrcdXMUCrogIuzPJaIgbYLf
         dYt/WsyKu6vHuxLy4ckqTVZufF3UtWr85ghPCgLzrS7GwycFafx3UvCf3NcJpx7bk2B6
         i5DR5yvKbQpwooUxtzIvaHlLXbsMP3VSaCjGl21QDjX/oLFzl6bGavhM2B0WNVF2J+ob
         /PV4ZerSscp8sQI752rKnlGP7KJG42P71H1bhH0OrS7jEzWKf6v6B+RH7iuFd7QUeX98
         +TEm/4B2feaCd/K2enAj3nQVxLLXqJOBOiX3IHdq9BMp9sHJaK1avLbMb2/XvfHMguzc
         MBKw==
X-Received: by 10.182.22.18 with SMTP id z18mr3764147obe.42.1386983490118;
 Fri, 13 Dec 2013 17:11:30 -0800 (PST)
Received: by 10.182.24.2 with HTTP; Fri, 13 Dec 2013 17:11:00 -0800 (PST)
In-Reply-To: <xmqqmwk4r55u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239271>

On Sat, Dec 14, 2013 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/path.c b/path.c
>> index eda9176..86a7c15 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -75,6 +75,16 @@ static void adjust_git_path(char *buf, int git_dir_len)
>>               strcpy(buf, get_index_file());
>>       else if (git_db_env && dir_prefix(base, "objects"))
>>               replace_dir(buf, git_dir_len + 7, get_object_directory());
>> +     else if (get_git_super_dir()) {
>> +             if (dir_prefix(base, "objects") || dir_prefix(base, "info") ||
>> +                 dir_prefix(base, "refs") ||
>> +                 (dir_prefix(base, "logs") && strcmp(base, "logs/HEAD")) ||
>> +                 dir_prefix(base, "rr-cache") || dir_prefix(base, "hooks") ||
>> +                 dir_prefix(base, "svn") ||
>> +                 !strcmp(base, "config") || !strcmp(base, "packed-refs") ||
>> +                 !strcmp(base, "shallow"))
>> +                     replace_dir(buf, git_dir_len, get_git_super_dir());
>> +     }
>
> This is essentially the list of what are shared across workdirs,
> right?  I wonder if it is a bad idea to make everything under .git
> of the borrowed repository shared by default, with selected
> exceptions.  Granted, not sharing by default is definitely safer
> than blindly sharing by default, so that alone may be a good
> argument to use a set of known-to-be-safe-to-share paths, like this
> code does.

The exception list could be equally long (most of them are *_HEAD).
.git is also used for temporary files with mkstemp, but I think that's
safe for sharing. What could break is when people add a new local
*_HEAD and forget to update the exception list.

> Don't we want .git/branches and .git/remotes shared?  After all,
> their moral equivalents from .git/config are shared with the code.

Yes. I missed them.
-- 
Duy
