From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] submodule: Allow tracking of the newest revision of a branch in a submodule
Date: Tue, 9 Dec 2008 10:23:46 +0100
Message-ID: <8c5c35580812090123k2c6ed479odf8b625177a07005@mail.gmail.com>
References: <1228784261-18637-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Fabian Franz" <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9yq2-0003Cg-9b
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbYLIJXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYLIJXs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:23:48 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:21890 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYLIJXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:23:47 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1722517wfd.4
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 01:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XOUHgoG6p+sw0GDwj1ACDacAabgeAvypelJS1wAN6cA=;
        b=US4ZWDVjwDfqvnL5UMk9HraX4EWy0ZtAAqErmdCFxsWgL030QaDqNu5ViNGDtux20F
         7+zCzGBVri5zA9iIRl0zoYZXHty5z8uW9rZBj4Q8ihPWFPJkC1vmj9zzMrs08PHjVQM4
         vmiuIT371lpsU+q/yriFO1NE6JNbLoNvR6gZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CpXcvPSHq5kkitlaUQg7XAeqq7D/FvFYdjfrZ/CumvGR89hkSY2DQAWoKaf/RpR0KS
         Njbp5eB04sxznLie7Ss0vq4EACOvcg7zBWJsVxmc8qt0kxnDjz41mXVSve6ghZCh0qgE
         7pdk5iAIlm/sq0FgM/VWaK3dFV/qi6nVTjWFY=
Received: by 10.114.197.1 with SMTP id u1mr3062216waf.120.1228814626364;
        Tue, 09 Dec 2008 01:23:46 -0800 (PST)
Received: by 10.115.106.12 with HTTP; Tue, 9 Dec 2008 01:23:46 -0800 (PST)
In-Reply-To: <1228784261-18637-1-git-send-email-git@fabian-franz.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102610>

On Tue, Dec 9, 2008 at 01:57, Fabian Franz <git@fabian-franz.de> wrote:
> Technically the gitlink code was changed to read .git/HEAD.gitlink
> if it exists instead of the normal HEAD. If you add 0000* as sha1
> sum to .git/HEAD.gitlink the submodule code will always fetch HEAD.

This feels like the porcelain "fooling" the plumbing. How about
something like this instead:

diff --git a/read-cache.c b/read-cache.c
index 8579663..cfacea7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -137,6 +137,8 @@ static int ce_compare_gitlink(struct cache_entry *ce)
         */
        if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
                return 0;
+       if (is_null_sha1(ce->sha1))
+               return 0;
        return hashcmp(sha1, ce->sha1);
 }

This should make the plumbing happy no matter which commit is actually
checked out in the submodule (not actually tested...). Then,
cmd_update() can check if the requested sha1 is all '0' and
fetch+checkout latest HEAD (or some branch) without playing games with
.git/HEAD.gitlink. Finally, cmd_add() needs to update the index in the
containing repository with the magic '0*' sha1 if '--track' is
specifed. This can be achieved by replacing 'git add $path' with 'echo
$mode $sha1\t$path | git update-index --index-info'.

What do you think?

> @@ -327,10 +335,14 @@ cmd_update()
>                        say "Maybe you want to use 'update --init'?"
>                        continue
>                fi
> +               track=$(git config -f .gitmodules submodule."$name".track)

I'm pretty certain that we don't want to use info from .gitmodules in
cmd_update(). Instead, cmd_init() probably should move the info from
.gitmodules into .git/config and cmd_update() should check the latter.

Btw: cmd_status() probably also needs some modifications to handle
this special case.

--
larsh
