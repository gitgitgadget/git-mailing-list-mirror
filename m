From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 16:30:08 -0700
Message-ID: <56b7f5510704111630p5eee3c31hbbdf2b90eac7723d@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
	 <461D6432.90205@vilain.net>
	 <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	 <461D6858.4090007@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, danahow@gmail.com
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbmHD-0001yJ-2v
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbXDKXaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbXDKXaM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:30:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:31740 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161435AbXDKXaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:30:09 -0400
Received: by wr-out-0506.google.com with SMTP id 71so288077wri
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 16:30:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eRDD9h2oHJCgHL8Xvz1g1Ve6vnJlD9UlqNBTfEZaw2L1hb/XUbOs2CLQzJ8rffhcgwPr9sefxpCDmZJ+1S/tvLHKZ59q47qZVrMVjiVJMf3wr4Ykl38zocXoKk8zyhb6LdVSC3slavym+oUJIUFrOjZurdoHo8CsGnsrzoIT5bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IVGpbacXuT9nozfUW+2TBtl+FC5LLjo1+FdAUqqw6z4omD61adfsMANCzvbodhk/yEXRuhg/+ZtXn+WL0CT6JIbefFsiTBpWleByEHoQrPizkzLsdJ2TTJt4YljzQluVgPZZ3Fd/yKq9dHgMP4fi/SYsjHHGXDFTTvSNfYWZuds=
Received: by 10.114.161.11 with SMTP id j11mr500717wae.1176334208743;
        Wed, 11 Apr 2007 16:30:08 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Wed, 11 Apr 2007 16:30:08 -0700 (PDT)
In-Reply-To: <461D6858.4090007@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44275>

On 4/11/07, Sam Vilain <sam@vilain.net> wrote:
> Linus Torvalds wrote:
> > > Does this consider the case where the intent of the subprojects are to
> > > collate multiple, small projects into one bigger project?
> > >
> > > In that case, you might want to keep all of the subprojects in the same
> > > git repository.
> >
> > I assume you mean "you might want to keep all of the subprojects' objects
> > in the same git object directory".
> >
> > And yes, that's absolutely true, but it's technically no different from
> > just using GIT_OBJECT_DIRECTORY to share objects between totally unrelated
> > projects, or using git/alternates to share objects between (probably
> > *less* unrelated repositories, but still clearly individual repos).
> >
>
> Would that be the only distinction?
>
> Would submodules be descended into for object reachability questions?
>
> > So the main point of superproject/subprojects is to allow independence
> > (because independence is what allows it to scale), but there is nothing to
> > say that things *have* to kept totally isolated.
> >
>
> I'm particularly interested in repositories with, say, thousands of
> submodules but only a few hundred meg. I really want to avoid the
> situation where each of those submodules gets checked or descended into
> separately for updates etc.

This seems slightly related to the hazy picture I'm forming of how
I'd like to use git at our site.  Essentially, everyone would have their
own working tree with .git directory, but .git/objects is a symlink
to a shared object repository.  How do you fully run git-fsck on this
shared object repository?  The actual heads (roots) are distributed amongst
many .git/refs directories (I suppose you could do something akin
to git-fsck $(cat /somepaths*/.git/refs/*), but that means you know
where all the repositories are).  So in this setup, maybe I'd want to run
fsck twice: the first time checking everything but not complaining about
dangling commit objects [but listing them?], and maybe a 2nd finding
all these in the users' repos [still need to know where these are].
Please note this is just a thought experiment at this point.

Anyway,  git started out with a 1:1 relationship between working tree,
index, and object repository. Various things could weaken that --
alternates, subprojects with different relationships to their object
repositories, etc. -- so special commands like git fsck which
focus mostly on the object repository may need a little tweaking eventually.

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
