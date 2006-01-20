From: Peter Baumann <peter.baumann@gmail.com>
Subject: Re: [PATCH] Support precise tracking of file modes
Date: Fri, 20 Jan 2006 15:16:29 +0100
Message-ID: <802d21790601200616l7d872cbal@mail.gmail.com>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>
	 <7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>
	 <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
	 <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
	 <43CF3061.2030504@michonline.com>
	 <7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
	 <20060119094156.GY28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jan 20 15:16:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezx4D-0005hK-K0
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 15:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWATOQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 09:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWATOQa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 09:16:30 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:27441 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751009AbWATOQa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 09:16:30 -0500
Received: by wproxy.gmail.com with SMTP id i3so466159wra
        for <git@vger.kernel.org>; Fri, 20 Jan 2006 06:16:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TIPAS9fK7FDSINzdMKRnIfTMbcuazsixNl3OfPP1yuN0C3w09ijKb6Tbx5gU2NBR3JNOq12GJsNpuZJM/FuhVj9y+cIodi/3v1TNQDtfVji7tAz0FYID1aMSABgUbLoDiav9P1dVaXUa9rGryRII1PTFu86e6qUtAYVsmnUEdmo=
Received: by 10.64.251.4 with SMTP id y4mr1296472qbh;
        Fri, 20 Jan 2006 06:16:29 -0800 (PST)
Received: by 10.64.21.6 with HTTP; Fri, 20 Jan 2006 06:16:29 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20060119094156.GY28365@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14963>

2006/1/19, Petr Baudis <pasky@suse.cz>:
> It seems that this is mostly an artificial imposition and it's annoying.
> Hey, I need to leave for an exam in 15 minutes and I have few urgent
> items in my Cogito TODO (sorry, Pavel!), but I couldn't resist.
>
> Taking "quick'n'dirty" to the extreme _and_ combining it with Linus'
> attitude to testing and documentation... ;-)
>
> diff --git a/cache.h b/cache.h
> index 29c9e81..0311066 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -94,7 +94,9 @@ struct cache_entry {
>  #define ce_size(ce) cache_entry_size(ce_namelen(ce))
>  #define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
>
> -#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
> +extern int track_filemode;
> +
> +#define ce_permissions(mode) (track_filemode ? (mode) : (((mode) & 0100) ? 0755 : 0644))
>  static inline unsigned int create_ce_mode(unsigned int mode)
>  {
>         if (S_ISLNK(mode))
> diff --git a/checkout-index.c b/checkout-index.c
> index 53dd8cb..b073baa 100644
> --- a/checkout-index.c
> +++ b/checkout-index.c
> @@ -115,6 +115,8 @@ int main(int argc, char **argv)
>         int newfd = -1;
>         int all = 0;
>
> +       git_config(git_default_config);
> +
>         prefix = setup_git_directory();
>         prefix_length = prefix ? strlen(prefix) : 0;
>
> diff --git a/config.c b/config.c
> index 8355224..a92ee0f 100644
> --- a/config.c
> +++ b/config.c
> @@ -222,6 +222,11 @@ int git_default_config(const char *var,
>                 return 0;
>         }
>
> +       if (!strcmp(var, "core.trackallfilemodes")) {
> +               track_filemode = git_config_bool(var, value);
> +               return 0;
> +       }
> +
>         if (!strcmp(var, "core.symrefsonly")) {
>                 only_use_symrefs = git_config_bool(var, value);
>                 return 0;
> diff --git a/entry.c b/entry.c
> index 410b758..493f2b9 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -87,6 +87,11 @@ static int write_entry(struct cache_entr
>                         return error("git-checkout-index: unable to create file %s (%s)",
>                                 path, strerror(errno));
>                 }
> +               if (track_filemode) {
> +                       if (fchmod(fd, ntohl(ce->ce_mode)) < 0)
> +                               return error("git-checkout-index: unable to chmod file %s (%s)",
> +                                       path, strerror(errno));
> +               }
>                 wrote = write(fd, new, size);
>                 close(fd);
>                 free(new);
> diff --git a/environment.c b/environment.c
> index 0596fc6..53248ec 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -12,6 +12,7 @@
>  char git_default_email[MAX_GITNAME];
>  char git_default_name[MAX_GITNAME];
>  int trust_executable_bit = 1;
> +int track_filemode = 0;
>  int only_use_symrefs = 0;
>  int repository_format_version = 0;
>  char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
> diff --git a/fsck-objects.c b/fsck-objects.c
> index 90e638e..719add2 100644
> --- a/fsck-objects.c
> +++ b/fsck-objects.c
> @@ -174,7 +174,8 @@ static int fsck_tree(struct tree *item)
>                         if (!check_strict)
>                                 break;
>                 default:
> -                       has_bad_modes = 1;
> +                       if (!track_filemode || (entry->mode & ~(S_IFREG|0777)))
> +                               has_bad_modes = 1;
>                 }
>
>                 if (last) {
> diff --git a/read-cache.c b/read-cache.c
> index c5474d4..624d2c3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -98,7 +98,7 @@ static int ce_match_stat_basic(struct ca
>                  * "mode changes"
>                  */
>                 if (trust_executable_bit &&
> -                   (0100 & (ntohl(ce->ce_mode) ^ st->st_mode)))
> +                   ((track_filemode ? 0777 : 0100) & (ntohl(ce->ce_mode) ^ st->st_mode)))
>                         changed |= MODE_CHANGED;
>                 break;
>         case S_IFLNK:
>
>
> --
>                                 Petr "Pasky" Baudis

I didn't test the patch, but the feature the patch tries to implement
is really something I'm missing from git (or any other scm I know of).
Ideally, this will be combined with exact owner tracking, but exact
permission and/or owner handling should be activated independently per
repository.

Peter Baumann
