From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Tue, 7 Jun 2005 11:49:47 +0200
Message-ID: <20050607094947.GC2676@pasky.ji.cz>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Jun 07 11:48:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfafF-0006Z1-IL
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 11:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVFGJuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 05:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVFGJuL
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 05:50:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45504 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261819AbVFGJtt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 05:49:49 -0400
Received: (qmail 7464 invoked by uid 2001); 7 Jun 2005 09:49:47 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <20050607091523.14051.qmail@blackcubes.dyndns.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jun 07, 2005 at 11:15:23AM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
> 
> This patch is a complete replacement for:
> 	[PATCH] Add support for --wrt flag to git-rev-list
> 
> This patch adds support for --wrt-author, --exclude-author and --author switches
> to git-rev-list.

I'd prefer just --wrt-author and --exclude-author to take an argument on
their own.

(Note that I don't endorse this patch and the --wrt-author behaviour in
particular seems strange. I don't have enough time to comment on it
sensibly now, though. I'm just focusing on style here since I'd like to
still be able to read git's source code few weeks from now on.)

> Diverged from ed37b5b2b94398f3ab8312dfdf23cfd25549e3ec by Linus Torvalds <torvalds@ppc970.osdl.org>
> ---
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -9,13 +9,25 @@ git-rev-list - Lists commit objects in r
>  
>  SYNOPSIS
>  --------
> -'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--merge-order* [ *--show-breaks* ] ] <commit>
> +'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--pretty* ] [ *--parents* ] [ *--header* ] [ *--merge-order* ] [ *--show-breaks* ] [ *--wrt-author* ] [ *--exclude-author* ] [ *--author=author@domain* ]  <head-to-include> <head-to-include> ... 
> +^<base-to-exclude> 
> +^<base-to-exclude> ...
>  
>  DESCRIPTION
>  -----------
> -Lists commit objects in reverse chronological order starting at the
> -given commit, taking ancestry relationship into account.  This is
> -useful to produce human-readable log output.
> +
> +Lists commit objects in reverse chronological order starting at the commits specified by head-to-include values, 
> +taking ancestry relationship into account.  git-rev-list will not print any commits that are reachable 
> +by any of the base-to-exclude values. 

Could you please break your lines somewhere before the 80th column?
This applies to the code too (actually it applies more to the code,
comments in particular).

> diff --git a/commit-tree.c b/commit-tree.c
> --- a/commit-tree.c
> +++ b/commit-tree.c
> @@ -128,18 +128,8 @@ int main(int argc, char **argv)
>  	}
>  	if (!parents)
>  		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
> -	pw = getpwuid(getuid());
> -	if (!pw)
> -		die("You don't exist. Go away!");
> -	realgecos = pw->pw_gecos;
> -	len = strlen(pw->pw_name);
> -	memcpy(realemail, pw->pw_name, len);
> -	realemail[len] = '@';
> -	gethostname(realemail+len+1, sizeof(realemail)-len-1);
> -	if (!strchr(realemail+len+1, '.')) {
> -		strcat(realemail, ".");
> -		getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
> -	}
> +
> +        get_real_identity(&realemail, &realgecos);

Whitespace police emergency.

>  
>  	datestamp(realdate, sizeof(realdate));
>  	strcpy(date, realdate);
> diff --git a/commit.c b/commit.c
> --- a/commit.c
> +++ b/commit.c
> @@ -302,3 +302,65 @@ int count_parents(struct commit * commit
>          return count;
>  }
>  
> +int copy_commit_header(struct commit * commit, char * header, int index, char * buffer, int len)
> +{
> +	char * p = commit->buffer;
> +	
> +	while (*p) {		
> +
> +		char * q = header;
> +		if (*p == '\n') {
> +			break;
> +		}
> +
> +		int matched;
> +
> +		for (matched = 1; *p != ' ' && *p != '\n'; p++, q++) {
> +			matched = matched & (*q==*p);
> +		}
> +		
> +		if (matched && index) {
> +			// if we matched but we haven't seen the index'th element yet, 
> +			// just decrement the index then pretend we didn't match
> +			index--;
> +			matched = 0;
> +		}
> +		
> +		if (!matched) {
> +			
> +			// skip to start of next header line
> +			
> +			for (;*p!='\n';p++)
> +				;
> +			p++;
> +			
> +		} else {
> +			
> +			int count = 0; // number of characters in value
> +			
> +			if (*p == ' ') {				
> +				p++;
> +				
> +				for (count = 0; *p != '\n'; p++, count++, len--) {
> +					if (len > 0) {
> +						*buffer++=*p;				
> +					}						
> +				}
> +								
> +			} 
> +			
> +			if (len > 0) {
> +				*buffer = 0;
> +			}
> +			
> +			return (len > 0) ? count+1 : -(count+1);
> +			
> +		}			
> +	}
> +	return 0;
> +}

Another style comment - I think the code is way too diffused, suffering
by hyperemptylineosis, which subsequently causes unreadability. Do you
think you could dense it down a little, please?

> diff --git a/epoch.c b/epoch.c
> --- a/epoch.c
> +++ b/epoch.c
> @@ -450,11 +450,15 @@ static void mark_ancestors_uninteresting
>  // Sorts the nodes of the first epoch of the epoch sequence of the epoch headed at head
>  // into merge order.
>  //
> -static void sort_first_epoch(struct commit *head, struct commit_list **stack)
> +static void sort_first_epoch(struct commit *head, struct commit_list **stack, marker_func marker)
>  {
>  	struct commit_list *parents;
>  	struct commit_list *reversed_parents = NULL;
>  
> +        if (marker) {
> +	        (*marker)(head);
> +        }
> +
>  	head->object.flags |= VISITED;

These whitespaces seem quite strange too. Check your editor settings.
;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
