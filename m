From: Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com>
Subject: Re: [PATCH] request-pull: return the entered branch if more
 branches are at the same commit
Date: Thu, 08 Apr 2010 22:37:17 +0200
Organization: Home
Message-ID: <1270759037.27317.104.camel@neo>
References: <1270678956.27317.34.camel@neo>
	 <7vvdc290ol.fsf@alter.siamese.dyndns.org>
Reply-To: Lars.Jarnbo.Pedersen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 22:37:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzyTi-0006VF-SD
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 22:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933325Ab0DHUhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 16:37:24 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41521 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933259Ab0DHUhX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 16:37:23 -0400
Received: by ewy20 with SMTP id 20so1143782ewy.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=QoILY83m3Ae15PhbBq4sBskND/oy953oBYPTsETJlns=;
        b=JnAiqJV5OW6GWV4dl+Z9R43dtMXIuEB1MtQuhjT3fn4w4sowa9X4HJIJ8nFBR9lUbW
         gsTc7WRlMy5TEMRVfXIaq5tbXHtTIkOPYTVf7yBB7/0DObBNXWpSDPOqFPLNtgLbmOkA
         d4uorj4ko2VjJejQ0Uk7LKOBPH/D8I/IlKJH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=TPNzUXMM7u3Q6aww79yJneMbKhM9CkNFQIpTjznNSrAlJ38+nk+MIpgEFcoU4pC7mH
         q5zA8LeMBudKpXKWMeoPNJYJt+ekiL+Ni77tLslAwz6u/jI0DQFIYR//+XFUKaGy6Zm4
         PsQ2omjUw6NtGHLc7CpHmUAB6/2bjcKTFoY/c=
Received: by 10.213.54.147 with SMTP id q19mr426773ebg.46.1270759040671;
        Thu, 08 Apr 2010 13:37:20 -0700 (PDT)
Received: from [192.168.1.109] (port137.ds1-kj.adsl.cybercity.dk [217.157.186.14])
        by mx.google.com with ESMTPS id 13sm289803ewy.5.2010.04.08.13.37.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 13:37:19 -0700 (PDT)
In-Reply-To: <7vvdc290ol.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144380>

Hi,

I clearly did not understand the full usage of the request-pull command
when I wrote this patch. 

The development group I'm working with uses the request-pull command in
a pretty "naive" way. We all have one or more development repos all
cloning from the same public repo. We have one "Release Manager" that
puts the next release together by pulling from our development repos on
request. When the next release is ready the public repo gets updated.

When I want to notify the Release Manager that I have new commits I run
the following command:

git request-pull origin/master <my repo> my_dev_branch

So we dont use public repos for each developer (even if it may be best
practice) and therefore I missed some of the points of the request-pull
command.

My main problem with the fact that request-pull may pick the wrong
branch is that there is often a delay between sending of the
request-pull command and the Release Manager actually pulling the
commits and therefore pulling from the wrong branch is potentially very
dangerous. 

That said I agree with all of your points below.

Regards,

- Lars

On Wed, 2010-04-07 at 18:45 -0700, Junio C Hamano wrote:
> Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com> writes:
> 
> >  git-request-pull.sh |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-request-pull.sh b/git-request-pull.sh
> > index 8fd15f6..787383f 100755
> > --- a/git-request-pull.sh
> > +++ b/git-request-pull.sh
> > @@ -49,11 +49,21 @@ merge_base=`git merge-base $baserev $headrev` ||
> >  die "fatal: No commits in common between $base and $head"
> >  
> >  branch=$(git ls-remote "$url" \
> > +	| sed -n -e "/^$headrev	refs.heads.$head/{
> 
> Isn't $head often omitted, defaulting to HEAD?
> 
> Since the original version of this logic was written, git has changed a
> lot, not in an incompatible way, but simply it got a lot richer.  Some
> assumptions the script made when it was written may need to be revisited,
> working backwards from the command line to see what we can compute better
> and how.
> 
>     $ git request-pull [options] start url [end]
> 
> When "end" is specified, and if that is the name of a branch, we know what
> branch you are talking about.  We can dereference HEAD with symbolic-ref
> if "end" was missing and we defaulted to HEAD.  Either way, in majority of
> the cases, the user has pushed out the tip of a local branch and that is
> what "end" would be.
> 
> But that "end" branch may not necessarily be the name of the branch your
> publishing repository has.  By looking at configured refspec mapping and
> the push.default configuration, we can tell which remote ref a push to the
> url should have updated.  The script predates many configurations that
> control this process, and that is the primary reason it currently guesses
> from ls-remote output.
> 
> You are introducing something better than a guess, but it is not quite
> there, I suspect.  Who says that your branch 'my/topic' will push to your
> published branch 'my/topic', not 'topic' with "push = my/topic:topic", or
> "branch.my/topic.merge = topic", for example?
> 
> We can take one step at a time, and your patch might be a good first step
> in the right direction, but I think overhauling this script to be more
> aware of the ref mapping is worth discussing before moving forward.  After
> such a discussion, it may turn out that majority of people do:
> 
>     $ git push $my_public_repo master~3:for-linus
> 
> and say "git request-pull origin master~3", in which case the current
> program output is already correct and the new code may not be adding much
> value in practice.
> 
