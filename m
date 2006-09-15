From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (take 2)] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Fri, 15 Sep 2006 12:49:35 +0200
Message-ID: <200609151249.35872.jnareb@gmail.com>
References: <200609142327.23059.jnareb@gmail.com> <200609150343.28334.jnareb@gmail.com> <7v4pv91wqk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 12:49:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOBG6-0002Ei-AW
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 12:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWIOKtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 06:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWIOKtL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 06:49:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:10579 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751228AbWIOKtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 06:49:10 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2202747nfa
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 03:49:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ug8zSKeTHRJspAnHPz+F/fX5D3BL41FpUGkuryedYGdp6Tfi5oBJsqyFbUwviUiGVpZR4mixtVplVVSU/anZYsvK47REYsHnNthJM1QbUpdmhU8JPgVEU2N6xufzJvrqtPR4z4pYjnJsJG5571bagds5XtR37lYyW04NeXVb0vk=
Received: by 10.49.55.13 with SMTP id h13mr13125554nfk;
        Fri, 15 Sep 2006 03:49:09 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id z73sm21151775nfb.2006.09.15.03.49.08;
        Fri, 15 Sep 2006 03:49:08 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <7v4pv91wqk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27074>

Junio C Hamano wrote:
> Now, once we start doing this, it may make sense to rethink how
> this function and git_get_references functions are used.  I
> think
> 
> 	git grep -n -e '^sub ' \
>         	-e git_get_references \
>                 -e git_get_refs_list gitweb/gitweb.perl
> 
> would be instructive how wasteful the current code is.
> 
> get_refs_list is called _TWICE_ in git_summary and worse yet
> very late in the function, after calling git_get_references that
> could already have done what the function does (by the way,
> git_get_references already knows how to use peek-remote output
> but for some reason it uses ls-remote -- I think you can safely
> rewrite it to use peek-remote).  So you end up doing peek-remote
> three times to draw the summary page.
> 
> git_get_references are called from almost everywhere that shows
> the list of commits, which is understandable because we would
> want to see those markers in the list.
> 
> I very much suspect that you can use git_get_refs_list to return
> a hash and a sorted list at the same time from the same input
> and make git_summary to do with just a single call to it, and
> get rid of git_get_references with a little bit of restructuring
> of the caller.

We can easily collapse two calls for git_get_refs_list in gi_summary, 
one for tags and one for heads into one call plus some filtering. 
Changing git_get_refs_list to do also the job of git_get_references 
means that in git_tags and git_heads we do extra the job of 
git_get_references. Neither git_tags, nor git_heads use references and 
refs marker; using the heads references in git_heads and tags 
references in git_tags is repeating the same information twice, 
cluttering the output. Unless we want to add yet another subroutine...

But as call to git-peek-remote is what takes most time, we can waste 
some time processing references which we would not use for the sake of 
clarity. Well, we can get rid of git_get_references too, if we don't 
mind slight decrease in performance.


We would then use:
git_summary:
  my ($refs, $reflist) = git_get_refs_list();
  my @taglist = map { s!^tags/!! } grep { m!^tags/! } @$reflist;
  my @headlist = map { s!^heads/!! } grep { m!^heads/! } @$reflist;

git_heads, git_tags:
  my (undef, $taglist)  = git_get_refs_list("tags");
  my (undef, $headlist) = git_get_refs_list("heads");

everywhere else
  my ($refs, undef) = git_get_refs_list($type);

-- 
Jakub Narebski
Poland
