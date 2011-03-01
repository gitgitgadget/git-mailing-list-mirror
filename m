From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Restructure projects list generation
Date: Tue, 1 Mar 2011 02:01:55 +0100
Message-ID: <201103010202.01408.jnareb@gmail.com>
References: <20110226215230.5333.92839.stgit@localhost.localdomain> <20110227100838.GA24919@elie> <201102271603.13902.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 02:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuDyh-0002GN-O8
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab1CABCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:02:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53573 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab1CABCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:02:08 -0500
Received: by wyg36 with SMTP id 36so4217526wyg.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=hKy9Dx9pOxhX/Sl/lFdaFMqH6QkbrrlQsgEcFEVVLVU=;
        b=SwECKSyHrqcSJUqq5YfDChh/lmELy55KxZjJusbxj9NR9Y4fJ3dHLetCMhjF8Mtl9D
         H+T8cQRo1oYUalHZJ5he/eIeDfPJlwU93fmf0UrOBT6ydgSTH1PZV4jV2wZNI5nHixtJ
         dPf/00WwdCEZH7Hp38t3Cg50I/KzTcwZJig04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lyu0CytAGfYXAeJIxfUxSKMimUtVUKHXJ8mWWOXvHvweoT02boNOdGLsAEgKSHep4J
         HyHHXFKCbwd1vnPg+5SDPGU7Q+H5678Xt9YP9NLW9UkTki/gXS5Pg1An7ISpJ1Z6FshO
         V9FraSSJ2H0K/Bpmaze8awIXZbZsPthKWqT+I=
Received: by 10.227.9.150 with SMTP id l22mr4053426wbl.177.1298941326814;
        Mon, 28 Feb 2011 17:02:06 -0800 (PST)
Received: from [192.168.1.13] (abwt130.neoplus.adsl.tpnet.pl [83.8.243.130])
        by mx.google.com with ESMTPS id u9sm3782520wbg.0.2011.02.28.17.02.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 17:02:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201102271603.13902.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168171>

On Sun, 27 Feb 2011, Jakub Narebski wrote:
> On Sun, 27 Feb 2011, Jonathan Nieder wrote:
> > Jakub Narebski wrote:

> > > +# this assumes that forks follow immediately forked projects:
> > > +# [ ..., 'repo.git', 'repo/fork.git', ...]; if not, set second
> > > +# parameter to true value to sort projects by path first.
> > > +sub filter_forks_from_projects_list {
> > > +	my ($projects, $need_sorting) = @_;
> > > +
> > > +	@$projects = sort { $a->{'path'} cmp $b->{'path'} } @$projects
> > > +		if ($need_sorting);
> > 
> > What happens in this scenario?
> > 
> > 	git.git
> > 	git.related.project.git
> > 	git/platforms.git
> 
> Thanks for catching this.
> 
> It looks like I have oversimplified the algorithm by requiring that 
> forked project directly precedes any of its forks (if they exists).
> I'd have to redo this part of patch.
> 
> > [...]
> > > @@ -4747,23 +4784,36 @@ sub fill_project_list_info {
> > >  		if (!defined $pr->{'owner'}) {
> > >  			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
> > >  		}
> > > -		if ($check_forks) {
> > > -			my $pname = $pr->{'path'};
> > > -			if (($pname =~ s/\.git$//) &&
> > > -			    ($pname !~ /\/$/) &&
> > > -			    (-d "$projectroot/$pname")) {
> > > -				$pr->{'forks'} = "-d $projectroot/$pname";

Let's examine what's we had, what this commit does, and what we can have.

Before this commit there were two implementations of detecting and 
filtering-out forks: one based only on directory structure in
fill_project_list_info (it detected forks, but didn't filter them out),
and one in git_get_projects_list, which was based on pathnames and was
run only for $projects_list being [index] file (it filtered-out forks).

This commit replaced both by filter_forks_from_projects_list, which
mainly detected forks based on path, with directory based detecting
if there _can_ be forks... but this solution is based on overly strict
and not true assumption that forks always directly follow forked 
project, which doesn't need to be true e.g. for scanning $projects_list
directory.


Hmmm... it looks for me like filtering out forks worked only for 
$projects_list being file; the code in fill_project_list_info() detected
which projects were forked, but didn't detect which projects were forks
and should be filtered.  The code inside $check_forks conditional that
used to be in git_projects_list_body() was about filtering out for second
time projects that are not forks of current project, for 'forks' action.

Now naive implementation of detecting forks, and also implementation used
to be used in git_get_projects_list() for $projects_list being file is
O(n^2) in number of projects.  With a bit of simplification it can be
O(<projects>*<forked projects>) + O(<projects>)*stat (cost of "-d <dir>").
Withe git.kernel.org having around 1,000 projects, and repo.or.cz having
around 4,000 projects not counting forks, O(n^2) is out of question.

Of those 4,000 projects around 300 (or 7%) has forks, according to 
repo.or.cz projects list page.  But assuming that percentage of forked
repositories remains constant with growth of number of repositories,
this is still quadratic cost... but perhaps acceptable.


We can use more advanced algorithm to find prefixes (to find forks);
for example using trie[1][2] to find forks costs O(<projects>*<depth>).
For git.kernel.org which has quite deep hierarchy of projects number
of path components (depth) is no more than 6.

Synthetic benchmark with 2000 repositories, 5% of which are forked,
with 5 forks per forked repository shows that trie-based solution is
around 25 times faster than original solution from git_get_projects_list
with %paths.

The disadvantage of this solution is that even seriously stripped-down
trie construction and lookup is around 2 pages of code... or using non-core
Tree::Trie module from CPAN.

[1]: http://en.wikipedia.org/wiki/Trie
[2]: http://p3rl.org/Tree::Trie
-- 
Jakub Narebski
Poland
