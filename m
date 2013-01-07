From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid overwrites
Date: Mon, 7 Jan 2013 16:28:28 +0100
Message-ID: <CABPQNSbpyO5k8TauFi4+Yan_SiXgULn5F2SMJ_VkL-XX_vDB8w@mail.gmail.com>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 16:36:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsEkF-0005nY-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 16:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3AGPfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 10:35:52 -0500
Received: from mail-ia0-f182.google.com ([209.85.210.182]:58542 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab3AGPfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 10:35:51 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so16557225iad.27
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 07:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cY19ji7xNfps1pXNwBAeYlw+IWf3h1YOkkBHgHtnT88=;
        b=rIaDMZS+G8Je2/vs0119Brthyz3hlLo3NY7jBEbjJWhgupUOXQ14Z/YMEzxK4RQs4O
         azdTbUw79wAJxrU2ZmPk016MnuPTYREZQtXxntmDvJgKqt5t63lr3UCHKrtK94JYqVRA
         coJfIQJi1KMrckDU11ap9QW4OkCHGwbHqHq7GDURtNdZi56/PxMEm4N1OEXiPmJF5q06
         iHuJsZ+1VBSjGfMcvBhNtr7Ij4OFnB6ABFpnOnF8IBkPuNnYSVEhOymo0QRY/sdGkiVf
         Vrj9uffafuRZ91W+HchuZpE61O+8Dp5hfA5vS90hmmbA/C4E/rw9jX2ZhlqzPqOfnw2B
         NmRA==
Received: by 10.42.27.74 with SMTP id i10mr45819496icc.47.1357572549223; Mon,
 07 Jan 2013 07:29:09 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Mon, 7 Jan 2013 07:28:28 -0800 (PST)
In-Reply-To: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212898>

On Sat, Jan 5, 2013 at 1:35 AM, David Michael <fedora.dm0@gmail.com> wrote:
> It is possible for this pointer of the GIT_DIR environment variable to
> survive unduplicated until further getenv calls are made.  The standards
> allow for subsequent calls of getenv to overwrite the string located at
> its returned pointer, and this can result in broken git operations on
> certain platforms.
>
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
>
> I have encountered an issue with consecutive calls to getenv
> overwriting earlier values.  Most notably, it prevents a plain "git
> clone" from working.
>
> Long story short: This value of GIT_DIR gets passed around setup.c
> until it reaches check_repository_format_gently.  This function calls
> git_config_early, which eventually runs getenv("HOME").  When it
> returns back to check_repository_format_gently, the gitdir variable
> contains my home directory path.  The end result is that I wind up
> with ~/objects/ etc. and a failed repository clone.  (Simply adding a
> bare getenv("GIT_DIR") afterwards to reset the pointer also corrects
> the problem.)
>
> Since other platforms are apparently working, yet this getenv behavior
> is supported by the standards, I am left wondering if this could be a
> symptom of something else being broken on my platform (z/OS).  Can
> anyone more familiar with this part of git identify any condition that
> obviously should not be occurring?
>
> Thanks.

I have some patches of a similar nature here:

https://github.com/kusma/git/commits/work/getenv-safety

These were written for an earlier version of the UTF-8 patches for Git
for Windows, where we were looking into allowing getenv to use a
static buffer to convert the environment variables from UTF-16 (which
is what Windows maintains) to UTF-8. We ended converting the
environment on start-up instead, so these weren't needed for us. But
perhaps they can be of use to someone else?
