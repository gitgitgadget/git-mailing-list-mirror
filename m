From: Eric Wong <normalperson@yhbt.net>
Subject: Re: minimize_url in git-svn?
Date: Tue, 8 May 2007 12:34:55 -0700
Message-ID: <20070508193455.GA14602@muzzle>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net> <463F6A95.30207@midwinter.com> <9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com> <464023D4.5060101@midwinter.com> <7v4pmn4oxj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Seth Falcon <sethfalcon@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 21:35:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVSi-0007Ac-ED
	for gcvg-git@gmane.org; Tue, 08 May 2007 21:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbXEHTfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 15:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754446AbXEHTe7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 15:34:59 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46205 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114AbXEHTe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 15:34:59 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 53C437DC0A0;
	Tue,  8 May 2007 12:34:55 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 08 May 2007 12:34:55 -0700
Content-Disposition: inline
In-Reply-To: <7v4pmn4oxj.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46610>

Junio C Hamano <junkio@cox.net> wrote:
> I was trying to run git-svn against this:
> 
> 	https://repo.socialtext.net:8999/svn/socialtext/trunk
> 
> This is an open source project [*1*] and the trunk is supposed
> to be readable by everybody, but it seems that anything outside
> that area needs authentication.  If I mimick the example in
> git-svn.txt manual page to clone from there, it creates trunk,
> trunk/.git, and then asks for password:
> 
> 	$ URL=https://repo.socialtext.net:8999/svn/socialtext/trunk
> 	$ git-svn clone $URL
>         Authentication realm: <https://repo.socialtext.net:8999> Auth for SVN
> 	Password for 'junio': ^C
> 
> I've narrowed it down to this part of git-svn.  If I tell it not
> to bother "minimiz"ing the URL, it seems to import without
> stepping outside of the URL it was given.
> 
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1038,7 +1038,8 @@
>  		}
>  		$self->{repo_id} = $existing;
>  	} else {
> -		my $min_url = Git::SVN::Ra->new($url)->minimize_url;
> +		my $ra = Git::SVN::Ra->new($url);
> +		my $min_url = $url; # $ra->minimize_url;
>  		$existing = find_existing_remote($min_url, $r);
>  		if ($existing) {
>  			unless ($no_write) {

That should be fine.

> Two and half questions.
> 
>  * What does minimize do, and why is it necessary?

I try to connect to the root (or closer to the root) of the repository.
This allows branches and tags to be tracked more effectively without
needing reconnects.  There's a reparent function in SVN 1.4, but it
doesn't work correctly with svn:// repos last I checked (1.4.3)

>  * The resulting git-svn remote tracking branch (and 'master')
>    seems to check out fine, but I do not know what damage the
>    hack to avoid minimizing is causing.  Are there any?  I see
>    many 0{40} lines in trunk/.git/svn/git-svn/.rev_db.* file,
>    and also many lines in unhandled.log file (+empty_dir,
>    +file_prop, and +dir_prop).  Are these something to worry
>    about?

Nope.  unhandled.log is strictly informational.

.rev_db is offset-based database.  Revision numbers to git commits can
be looked up using (SVN revision * 41).

If the project has really high revision numbers (like gcc) or lots of
tags, it's a space-killer.  I've been meaning to add an optional SQLite
alternative to .rev_db for people tracking those projects.  Patches
welcome :)

>  * Assuming there aren't any damage, or maybe some damage that
>    would cause minor decreased functionality/interoperability,
>    would it perhaps make sense to optionally allow skipping the
>    minimizing to avoid this problem?  Would it make sense, or is
>    the setting at socialtext site too esoteric and it isn't
>    worth to worry about?

It *should* be automatically detecting the highest level up it can
access and stop there.  In your case, there's obviously something
broken in my code :(

I've definitely tested this as working against Seth Falcon's hedgehog
repo (URL is somewhere in the archives).  I also setup a test repository
somewhere that I can double-check against.

> [Footnote]
> 
> *1* http://www.socialtext.net/stoss/index.cgi?developing_with_a_dev_env

I'll try to take a look at that in the next few days.  I also have
segfaults to fix that I haven't gotten to :(

-- 
Eric Wong
