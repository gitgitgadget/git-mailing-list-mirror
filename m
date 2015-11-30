From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6] Add git-grep threads param
Date: Mon, 30 Nov 2015 20:31:08 +0100
Message-ID: <CACsJy8AdRnW88uy+U-Q0TKf05KvDQLf3bDcKmqoLTDT3sAzg+w@mail.gmail.com>
References: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:31:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3UAp-0008EM-U9
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbbK3Tbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:31:40 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34660 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbK3Tbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:31:39 -0500
Received: by lffu14 with SMTP id u14so211574361lff.1
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=V3ATQkclXKJTpX+uoOZ/f7gKxNX5bVQ1qN8BpbPjXfI=;
        b=0W/9N4W8EruBFNsqADtbPQ54KSZSaq5msiKUwpxXcn+1jBakDLCzj10m+VieDA+Og9
         JfBCombosj+xtKJ9j1FRka57kWgLsS60wzt4+DsTL+Ka8TZkumgnfr48r2D/YJagf69h
         Xhhfx39wL8xMCKc2zuijxj9vYf9hbvkgR5oXq18ejdSzBSMpRtIWR8hMD0X3Poeeh71S
         CZjMWDZ8bJY1b0ye0cPmcY0EOMU/jNh+oBEzK9UjXE0zHk+icFAM94ZfwvQ9fD5WDUce
         K40LfgPhIkOCjLHscOzGUSRB8/XsbVJdalREZpRu9/yZ77k9ZmZ4a+c9xPf3gRqi40Uo
         eJyg==
X-Received: by 10.112.137.101 with SMTP id qh5mr6215304lbb.81.1448911897879;
 Mon, 30 Nov 2015 11:31:37 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 30 Nov 2015 11:31:08 -0800 (PST)
In-Reply-To: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281816>

On Wed, Nov 11, 2015 at 12:52 PM, Victor Leschuk <vleschuk@gmail.com> wrote:
> "git grep" can now be configured (or told from the command line)
>  how many threads to use when searching in the working tree files.
>
>  Changes to default behavior: number of threads now doesn't depend
>  on online_cpus(), e.g. if specific number is not configured
>  GREP_NUM_THREADS_DEFAULT (8) threads will be used even on 1-core CPU.

Why? (I'm asking for an explanation in the commit message so that I
will not have to ask again in future)

> @@ -206,7 +206,8 @@ static void start_threads(struct grep_opt *opt)
>                 strbuf_init(&todo[i].out, 0);
>         }
>
> -       for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +       threads = xcalloc(num_threads, sizeof(pthread_t));

I think we usually go with sizeof(*threads), but not sure if it's just
a personal taste or the preferred style for git.

>  static int grep_cmd_config(const char *var, const char *value, void *cb)
>  {
>         int st = grep_config(var, value, cb);
> -       if (git_color_default_config(var, value, cb) < 0)
> +       if (grep_threads_config(var, value, cb) < 0)
> +               st = -1;
> +       else if (git_color_default_config(var, value, cb) < 0)
>                 st = -1;
>         return st;

Hm... isn't it simpler to just return -1 instead of assigning to st
first? I think you could just merge grep_threads_config() in this
function because it's not that complex to stay separate..

>  }
-- 
Duy
