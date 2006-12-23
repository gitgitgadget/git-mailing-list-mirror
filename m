From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Paginate commit/author/committer search output
Date: Sat, 23 Dec 2006 23:43:19 +0100
Message-ID: <200612232343.20815.jnareb@gmail.com>
References: <11668449162618-git-send-email-robfitz@273k.net> <200612231400.18774.jnareb@gmail.com> <20061223145712.GE11474@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 23:40:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyFXw-0000FE-O6
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 23:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbWLWWki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbWLWWki
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 17:40:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:48732 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbWLWWkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 17:40:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3262096uga
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 14:40:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m7HhQLC9H+nRcqld08uv1XDuTHjs7jaMRTUv4je+fLKPprUNou0Di+M5E3ipEL58gJA4/1fjOZZ5v8aHfmyFGrwTommeAtoz/ejKq63g+nqMRscaqJBHGOfU+JDYSO6V7Hb4pWonmBZ50/VGoHU28oexQQOGfoOvWOhyF1zX7jw=
Received: by 10.67.21.11 with SMTP id y11mr2561342ugi.1166913636206;
        Sat, 23 Dec 2006 14:40:36 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id c1sm3333124ugf.2006.12.23.14.40.35;
        Sat, 23 Dec 2006 14:40:35 -0800 (PST)
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061223145712.GE11474@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35331>

Robert Fitzsimons wrote:
> Paginate commit/author/committer search output to only show 100 commits
> at a time, added appropriate nav links.
> 
> Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
> --- 
> 
>> Although with search you have additional complication with marking match,
>> and "log" view like rather than "shortlog" like view... so I'm not sure
>> if it would truly help. On the other hand you can use --skip option you
>> have introduced...
> 
> I used the slower non--skip workflow for the moment, so at least there
> is no need to upgrade the core git commands.

First, git has tradition of introducing options (first) meant for gitweb,
and immediately making use of them. Examples: --git-dir=<path> option to
git wrapper because in mod_perl doesn't pass environmental variables to
subprocesses so setting $ENV{'GIT_DIR'} in gitweb wouldn't work;
--full-history option to git-rev-list for "history" view, because using
path limit instead of piping to git-diff-tree and using path limit of
git-diff-tree changed returned revisions, git-for-each-ref introduced
for better gitweb performance in "summary" view... So you wouldn't do
something unusual. And it is fairly easy to compile and install additional,
newest version of git.

Second, without --skip you have ugly tradeoff if you want to paginate
(search result, but not only that): either get pages*page-size revisions
and call parse_commit which in turn usually calls git-rev-list page-size
times; or get full info pages*page-size and skip (pages - 1)*page-size
bits of output.

And finally, --skip with your abandoned for now parsing revisions not
one by one, but by a bunch using one git command call would help
performance not only of non-pickaxe search, but also history view,
and log and shortlog views.

[...]
> +sub git_search_grep_body {

I'm not sure if it wouldn't be better to try to reuse git_log machinery,
just adding marking match, and removing everything but the immediate
context of match, to format_log_line_html... Just a thought...

-- 
Jakub Narebski
Poland
