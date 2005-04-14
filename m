From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 11:11:07 +0200
Message-ID: <20050414091106.GX25711@pasky.ji.cz>
References: <20050412132307.GH22614@pasky.ji.cz> <1113375277.23299.25.camel@nosferatu.lan> <20050413075441.GD16489@pasky.ji.cz> <1113381672.23299.47.camel@nosferatu.lan> <20050413092656.GO16489@pasky.ji.cz> <1113394537.23299.51.camel@nosferatu.lan> <20050413221936.GI25711@pasky.ji.cz> <1113461754.23299.68.camel@nosferatu.lan> <1113467335.23299.77.camel@nosferatu.lan> <1113467905.23299.81.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM0KZ-00047j-H4
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 11:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDNJL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 05:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDNJL2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 05:11:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44736 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261453AbVDNJLM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 05:11:12 -0400
Received: (qmail 25655 invoked by uid 2001); 14 Apr 2005 09:11:07 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113467905.23299.81.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Please trim the replied mails a bit, snipping old and irrelevant parts.
This is insane. :-)

Dear diary, on Thu, Apr 14, 2005 at 10:38:25AM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
..snip..
> Normalize show-diff output, add --update-modes target to update-cache,
> and make sure we only show real changes after changing the tracked
> branch, as well as update the file modes according to the cache.

I'm lost. Why do you do --update-modes? That makes no sense to me.
You introduce them to the cache out-of-order w.r.t. commits, that means
in the normal git usage they are already unrevertable.

What are you trying to do? Mode changes _are_ real changes. You _don't_
want to silence them. What you want is to even show them more explicitly
in show-diff.

The --refreshes are fine.

> Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> 
> gitcancel.sh:  ec58f7444a42cd3cbaae919fc68c70a3866420c0
> --- ec58f7444a42cd3cbaae919fc68c70a3866420c0/gitcancel.sh
> +++ uncommitted/gitcancel.sh
> @@ -12,7 +12,8 @@
> 
>  # FIXME: Does not revert mode changes!
> 
> -show-diff | patch -p0 -R
> +show-diff | patch -p1 -R
>  rm -f .git/add-queue .git/rm-queue .git/merged
> 
> -update-cache --refresh
> +# --update-modes need to be before --refresh
> +update-cache --update-modes --refresh

Here, e.g., you should do the very opposite - change the modes back to
how are they in the cache.

> show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> --- a531ca4078525d1c8dcf84aae0bfa89fed6e5d96/show-diff.c
> +++ uncommitted/show-diff.c
> @@ -5,13 +5,18 @@
>   */
>  #include "cache.h"
> 
> -static void show_differences(char *name,
> +static void show_differences(struct cache_entry *ce,
>         void *old_contents, unsigned long long old_size)
>  {
>         static char cmd[1000];
> +       static char sha1[41];
> +       int n;
>         FILE *f;
> 
> -       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, name);
> +       for (n = 0; n < 20; n++)
> +               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]);
> +       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommitted/%s -u -N  - %s",
> +               sha1, ce->name, ce->name, ce->name);

The "directory" sha1 is the sha1 of the tree, not of the particular
file - that one is in the "attributes" list (parentheses after the
filename), together with mode.

>         f = popen(cmd, "w");
>         if (old_size)
>                 fwrite(old_contents, old_size, 1, f);
> @@ -99,7 +104,7 @@
>                         continue;
> 
>                 new = read_sha1_file(ce->sha1, type, &size);
> -               show_differences(ce->name, new, size);
> +               show_differences(ce, new, size);
>                 free(new);
>         }
>         return 0;
> update-cache.c:  62d0a6c41560d40863c44599355af10d9e089312
> --- 62d0a6c41560d40863c44599355af10d9e089312/update-cache.c
> +++ uncommitted/update-cache.c
> @@ -210,6 +210,39 @@
>         }
>  }
> 
> +static struct cache_entry *update_file_mode(struct cache_entry *ce)
> +{
> +       struct stat st;
> +       int changed;
> +
> +       if (stat(ce->name, &st) < 0)
> +               return NULL;
> +
> +       changed = cache_match_stat(ce, &st);
> +       if (!changed)
> +               return ce;
> +
> +       if (changed & MODE_CHANGED)
> +               if (chmod(ce->name, ce->st_mode))
> +                       return NULL;
> +
> +       return ce;
> +}
> +
> +static void update_modes(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < active_nr; i++) {
> +               struct cache_entry *ce = active_cache[i];
> +
> +               if (!update_file_mode(ce)) {
> +                       printf("%s: needs update\n", ce->name);
> +                       continue;
> +               }
> +       }
> +}
> +
>  /*
>   * We fundamentally don't like some paths: we don't want
>   * dot or dot-dot anywhere, and in fact, we don't even want

Oh. So you are actually doing the _opposite_! But that's very wrong too.
update-cache is for the direction tree -> index. For the opposite
direction, you should use checkout-cache.

> @@ -282,6 +315,10 @@
>                                 refresh_cache();
>                                 continue;
>                         }
> +                       if (!strcmp(path, "--update-modes")) {
> +                               update_modes();
> +                               continue;
> +                       }
>                         die("unknown option %s", path);
>                 }
>                 if (!verify_path(path)) {
> 
> 
> -- 
> Martin Schlemmer
> 





-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
