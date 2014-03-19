From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/3] remote-hg: allow invalid bookmarks in a few edge cases
Date: Wed, 19 Mar 2014 14:07:38 +0100
Message-ID: <CALWbr2yb9_Kumm697w2c68xE6JPpkF9OfxvP2acsPjPFq=zboQ@mail.gmail.com>
References: <1395232399-60112-1-git-send-email-max@quendi.de>
	<1395232399-60112-2-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 14:16:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQGLd-0000UK-61
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 14:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbaCSNPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 09:15:51 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:53593 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933969AbaCSNHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 09:07:40 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so5943509lbg.11
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+l2XMrJsy4JBbEJAFLgHdcjVrRC6dhayLIKGBcJ/ZbA=;
        b=C/AFmcNeutpF2SXAGCNhQzKQV7uls1t1qEPFwj29hl8y8ozmpOv+CZzKsWxcLQpDjx
         IZgYPxx6urrDvOP6wBI46sbCPN2dhD66AvmMdQa0xb9nU9pzKJLk+APNBY09OJ/1QieZ
         EqdzV9VecFosN2bk+Y1a5UjlQuab/GxiW9llZRpkFH4zTYGGsDaNx0hClZmwdm++24ON
         u8nHluCwHpX/KBn75Xk4i8pIsnw8ouboKzfqU9AzqKTM3B5WrOvQp6B6dUmbbB/lC4OV
         gXUv+rh2zOOhHNVnxm0LHZYC7VNqwO/tKbp+LrKq5MoqzoBBlz+Q7z9zFqYHSxYk4u8c
         y9YQ==
X-Received: by 10.152.28.41 with SMTP id y9mr21523lag.57.1395234458958; Wed,
 19 Mar 2014 06:07:38 -0700 (PDT)
Received: by 10.112.142.68 with HTTP; Wed, 19 Mar 2014 06:07:38 -0700 (PDT)
In-Reply-To: <1395232399-60112-2-git-send-email-max@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244443>

Hi Max,

Thank you for working on this.
I believe it would be fair that you forget about patch 1/3 as you fix
it in this patch (2/3).
Also, I think it would be best NOT to integrate a patch (mine) that
breaks a test, as it
would make bisect harder to use.

Thanks,
Antoine

On Wed, Mar 19, 2014 at 1:33 PM, Max Horn <max@quendi.de> wrote:
> Fix the previous commit to workaround issues with edge cases: Specifically,
> remote-hg inserts a fake 'master' branch, unless the cloned hg repository
> already contains a 'master' bookmark. If that 'master' bookmark happens
> to reference the 'null' commit, the preceding fix ignores it. This
> would leave us in an inconsistent state. Avoid this by NOT ignoring
> null bookmarks named 'master' or 'default' under suitable circumstances.
>
> Signed-off-by: Max Horn <max@quendi.de>
> ---
>  contrib/remote-helpers/git-remote-hg | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 12d850e..49b2c2e 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -626,8 +626,11 @@ def do_list(parser):
>      repo = parser.repo
>      for bmark, node in bookmarks.listbookmarks(repo).iteritems():
>          if node == '0000000000000000000000000000000000000000':
> -            warn("Ignoring invalid bookmark '%s'", bmark)
> -            continue
> +            if fake_bmark == 'default' and bmark == 'master':
> +                pass
> +            else:
> +                warn("Ignoring invalid bookmark '%s'", bmark)
> +                continue
>          bmarks[bmark] = repo[node]
>
>      cur = repo.dirstate.branch()
> --
> 1.9.0.7.ga299b13
>
