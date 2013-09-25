From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "git gc" leaving gc.pid files around
Date: Thu, 26 Sep 2013 02:06:59 +0700
Message-ID: <CACsJy8D2Amtzv0j1_3tKWyhRBUoKDL+1TiJGuvqFXb6UNDUdvg@mail.gmail.com>
References: <vpqzjr0rbz5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 25 21:07:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOuR0-0002wv-7D
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab3IYTHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:07:32 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34064 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851Ab3IYTHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:07:30 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so218805obc.18
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k+2zVuag847aOwnEwEZATZxmHtQ/yIofXseGPAD/Zi4=;
        b=ySgWKxgknHalL39Mowtm87Zr0EYg6cZYvpi9tEv9GoHH5WX99wf9WTnOxfy0vm3aFI
         sBpc8dHS7h1AQzQryPg43MT9dz2Kzn2WKa/66BEh1sMYCIN0rOmgmhCO08rEOlzSDUBp
         3Q9coErmO46WefU0lOaP253VUcO6fBQfHHiuLO1kNS4gSlDEQZ0jDD85+5A3eINbGbBK
         CwNG7oG7n95j8VNi+hQGDxqFiYnpBlHafBdP/UYppn0U69t6linRuH7/YdedEB2hiiMT
         oLfzO9YhnqKz5r+KKYahC8dyIKAJk1gAB4NwJYvkU0xu0K4I9VSmz8/qXqgH6tMTV8sr
         2l4A==
X-Received: by 10.60.160.197 with SMTP id xm5mr3238214oeb.53.1380136049447;
 Wed, 25 Sep 2013 12:07:29 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 25 Sep 2013 12:06:59 -0700 (PDT)
In-Reply-To: <vpqzjr0rbz5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235364>

On Thu, Sep 26, 2013 at 1:29 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> Since 64a99eb47, "git gc" creates a lock file gc.pid while running. I
> just noticed that the file is never deleted. The locking mechanism
> works, but leaving these files around creates a minor annoyance.
>
> For example, I run "git gc" in all my repos from time to time (in a cron
> job). It normally does nothing in repos that have not changed, but now,
> it updates the gc.pid file.
>
> As a result, all the gc.pid files show up in unison (synchronization
> tool between machines) for example.
>
> Is there any reason not to do something like this:
>
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -316,5 +316,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>                 warning(_("There are too many unreachable loose objects; "
>                         "run 'git prune' to remove them."));
>
> +       unlink(git_path("gc.pid"));
>         return 0;
>  }
>
> ?

I considered this and decided it was not a big problem for another
file lying around in .git. Moreover it could provide the last gc time
to gc itself, so we could avoid running gc too often, for example no
more than one gc a day. But if it causes actual annoyance, I think
unlink() is ok.
-- 
Duy
