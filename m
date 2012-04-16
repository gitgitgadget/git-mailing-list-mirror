From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last
 change
Date: Mon, 16 Apr 2012 12:12:42 +0200
Message-ID: <20120416101242.GK17753@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <201204041631.42905.jnareb@gmail.com>
 <20120404162208.GN10461@camk.edu.pl>
 <201204141516.02719.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 12:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJivc-0001H4-Ev
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab2DPKM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:12:56 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:45498 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab2DPKMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:12:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2F5C95F0049;
	Mon, 16 Apr 2012 12:13:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WirOPUpSkRbn; Mon, 16 Apr 2012 12:13:36 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 88C625F0047;
	Mon, 16 Apr 2012 12:13:36 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 5A63D4669F; Mon, 16 Apr 2012 12:12:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201204141516.02719.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195607>

On Sat, Apr 14, 2012 at 03:16:01PM +0200, Jakub Narebski wrote:
> On Wed, 4 Apr 2012, Kacper Kornet wrote:
> > On Wed, Apr 04, 2012 at 04:31:42PM +0200, Jakub Narebski wrote:
> >> On Wed, 4 April 2012, Kacper Kornet wrote:
> >>> On Wed, Apr 04, 2012 at 01:12:01AM +0200, Jakub Narebski wrote:
> >>>> On Tue, 3 Apr 2012, Kacper Kornet wrote:

> >> Perhaps it would be better to say it like this:

> >>   $no_list_age::
> >>   	If true, omit the column with date of the most current commit on the
> >>   	projects list page. [...]

> >> It is true that it can save a bit of I/O: the git_get_last_activity()
> >> examines all branches (some of which are usually loose), and must hit
> >> the object database, unpacking/getting commit objects to get at commit
> >> date.

> >> But the fact that it also saves a fork (a git command call) per repository
> >> reminds me of something which I missed in first round of review, namely
> >> that generating 'age' and 'age_string' fields serve also as a check if
> >> repository really exist.

> >> So either we document this fact, or use some other way to verify that
> >> git repository is valid.

> > I think that git_project_list_body always works with the list returned
> > by git_get_projects_list. And git_get_projects_list validates if the
> > path is a git repository. So it should not be a problem. Please correct
> > me, if I am wrong.

> If $projects_list points to plain file, git_get_projects_list() just
> gets list of projects (and project owners) from $projects_list file
> by reading and parsing this file.  No verification that repository
> exists is done.

I think that even in this case check_export_ok is called. But there is
still the problem you have mentioned below.

> If $projects_list points to directory (which is the default), then
> git_get_projects_list() scans starting from $projects_list directory
> for somtehing that _looks like_ git repository with check_head_link()
> via check_export_ok().  But you still can encounter something that
> looks like git repository (has "HEAD" file in it), but isn't.


> So we would probably want to have said variable or set of variables
> describe three states:

> * find date of last change in repository with git-for-each-ref called
>   by git_get_last_activity(), which as a side effect verifies that
>   repository actually exist.  

>   git_get_last_activity() returns empty list in list context if repo
>   does not exist, hence

>   	my (@activity) = git_get_last_activity($pr->{'path'});
>   	unless (@activity) {
>   		next PROJECT;
>   	}

> * verify that repository exists with "git rev-parse --git-dir" or
>   "git rev-parse --verify HEAD", or "git symbolic-ref HEAD", redirecting
>   stderr to /dev/null (we would probably want to save output of the
>   latter two somewhere to use it later).

>   That saves I/O, but not fork.

> * don't verify that repository exists.

> Though perhaps the last possibility isn't a good idea, so it would be
> left two-state, as in your patch. 

My tests show that forks are also a bottleneck in my setup. On the other
hand I think that I can trust that my projects.list contains only valid
repositories. So I would prefer to have a don't verify option. Or there
is a possibility to write perl function with the same functionality as
is_git_directory() from setup.c and use it to verify if the directory is a
valid git repo.

-- 
  Kacper Kornet
