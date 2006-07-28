From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 16:04:10 +0200
Message-ID: <20060728140410.GN13776@pasky.or.cz>
References: <20060728054341.15864.35862.stgit@machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 16:04:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Swr-0001fH-9H
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 16:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWG1OEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 10:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWG1OEO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 10:04:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2790 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161156AbWG1OEN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 10:04:13 -0400
Received: (qmail 24274 invoked by uid 2001); 28 Jul 2006 16:04:10 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060728054341.15864.35862.stgit@machine>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24387>

Dear diary, on Fri, Jul 28, 2006 at 07:44:21AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> @@ -461,11 +465,52 @@ static int send_ref(const char *refname,
>  
>  static int upload_pack(void)
>  {
> -	reset_timeout();
> -	head_ref(send_ref);
> -	for_each_ref(send_ref);
> -	packet_flush(1);
> -	receive_needs();
> +	int multirepo = 0;
> +
> +	while (1) {
> +		char *repo;
> +		char cwd[PATH_MAX];
> +
> +		reset_timeout();
> +		head_ref(send_ref);
> +		for_each_ref(send_ref);
> +		packet_flush(1);
> +		repo = receive_needs();
> +		if (!repo)
> +			break;
> +		multirepo++;
> +
> +		fprintf(stderr, "git-upload-pack: switching to repo %s", repo);
> +
> +		/* So that we still find objects of the original repository... */
> +		getcwd(cwd, PATH_MAX);
> +		if (strlen(cwd) < PATH_MAX - 8)
> +			strcat(cwd, "/objects");
> +		link_alt_odb_entry(cwd, strlen(cwd), NULL, 0, 1);
> +
> +		if (!enter_repo(repo, strict) || !security_repo_check(!check_export))
> +			die("git-upload-pack: security violation");
> +	}
> +
> +	if (multirepo) {
> +#define ALTENV_SIZE 65536
> +		/* Propagate all the repositories to the children */
> +		char altenv[ALTENV_SIZE], *p = altenv;
> +		struct alternate_object_database *alt;
> +		strcpy(p, ALTERNATE_DB_ENVIRONMENT "=");
> +		p += sizeof(ALTERNATE_DB_ENVIRONMENT);
> +		for (alt = alt_odb_list; alt; alt = alt->next) {
> +			strncpy(p, alt->base, alt->name - alt->base);
> +			p += alt->name - alt->base;
> +			if (p - altenv < ALTENV_SIZE)
> +				*p++ = ':';
> +			if (p - altenv >= ALTENV_SIZE)
> +				die("fetching too many repositories");
> +		}
> +		p[-1] = '\0';
> +		putenv(altenv);
> +	}
> +
>  	if (!want_obj.nr)
>  		return 0;
>  	get_common_commits();

  Note that you need to be more careful about ALTENV_SIZE checking here,
and I'm not sure if we even need to abuse the alternates database here;
only later I added setting up the alternates variable since I realized
we are executing external tools here, and things would be simpler if we
could get away by just doing that.

  I'm sorry, I don't have time to send the updated patch anymore. :-(

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
