From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH (amend)] gitweb: Use File::Find::find in git_get_projects_list
Date: 14 Sep 2006 14:50:24 -0700
Message-ID: <86bqpi15jz.fsf@blue.stonehenge.com>
References: <200609140839.56181.jnareb@gmail.com>
	<200609141939.39406.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 14 23:50:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNz6V-00010v-1k
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 23:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWINVu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 17:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWINVu1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 17:50:27 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:35950 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751199AbWINVuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 17:50:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id CED0F8F352;
	Thu, 14 Sep 2006 14:50:24 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 26769-02-20; Thu, 14 Sep 2006 14:50:24 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 5AC428F372; Thu, 14 Sep 2006 14:50:24 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>
x-mayan-date: Long count = 12.19.13.11.10; tzolkin = 2 Oc; haab = 3 Chen
In-Reply-To: <200609141939.39406.jnareb@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27046>

>>>>> "Jakub" == Jakub Narebski <jnareb@gmail.com> writes:

Jakub> +		sub wanted {
Jakub> +			# only directories can be git repositories
Jakub> +			return unless (-d $_);
Jakub> +
Jakub> +			my $subdir = substr($File::Find::name, $pfxlen + 1);
Jakub> +			# we check related file in $projectroot
Jakub> +			if (-e "$projectroot/$subdir/HEAD") {
Jakub> +				push @list, { path => $subdir };
Jakub> +				$File::Find::prune = 1;
Jakub>  			}
Jakub>  		}
Jakub> -		closedir($dh);
Jakub> +
Jakub> +		File::Find::find({
Jakub> +			follow_fast => 1, # follow symbolic links
Jakub> +			dangling_symlinks => 0, # ignore dangling symlinks, silently
Jakub> +			wanted => \&wanted,
Jakub> +		}, "$dir");

Don't define a sub inside a sub.  That's the "won't stay shared"
problem.

Move that like this:

find( {
        follow_fast => 1,
        dangling_symlinks => 0,
        wanted => sub {

                ... everything in &wanted above ...

        }, $dir);

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
