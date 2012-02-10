From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Fri, 10 Feb 2012 20:38:54 +0100
Message-ID: <201202102038.55710.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202071531.08385.jnareb@gmail.com> <CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 10 20:39:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwJF-0007DN-Na
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab2BJTi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 14:38:59 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45445 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2BJTi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 14:38:59 -0500
Received: by eaah12 with SMTP id h12so1037262eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=CfooOORBolXbA1S9Dza8sqWImkg95rKVBcr715WLlV8=;
        b=n8pWWe5+DEOMy1kBhNKKcwJXqLlRR2mbEk9p+mKPOcerSt2W5N964TG6Al79QzfPJ1
         N4dsxj7q1dEQRxdTaJDoZQ7vBMhNiFUfu7Q8ceDAh2mVWRmbuALWMsaScp5W1C9F4R+Y
         /zoGx6/RC/judXgURuJ9rc4HLGh7Evja8bteo=
Received: by 10.213.23.20 with SMTP id p20mr547282ebb.68.1328902737770;
        Fri, 10 Feb 2012 11:38:57 -0800 (PST)
Received: from [192.168.1.13] (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id z47sm25547754eeh.9.2012.02.10.11.38.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 11:38:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190438>

On Tue, 7 Feb 2012, Johan Herland wrote:

> (we are pretty much in violent agreement, so I will only comment where
> I find it necessary)

So now comes the hard part: actually implementing (well, designing and
implementing) prototypes for 'secret' trait and 'public' trait...
 
> On Tue, Feb 7, 2012 at 15:31, Jakub Narebski <jnareb@gmail.com> wrote:

> > Also, when thinking about different scenarios of why one would like to
> > mark commit as 'secret', we might want to be able to mark commit as
> > secret / unpublishable with respect to _subset_ of remotes, so e.g.
> > I am prevented from accidentally publishing commits marked as 'secret'
> > to public repository, or to CI/QA repository, but I can push (perhaps
> > with warning) to group repository, together with 'secret'-ness state
> > of said commit...
> >
> > ... though it wouldn't be as much 'secret' as 'confidential' ;-)
> 
> Another way to achieve this would be to have a config flag to control
> whether Git checks for the 'secret' flag before pushing. This config
> flag could be set at the system/user level (to enable/disable the
> feature as a whole), at the repo level (to enable/disable it in a
> given repo), at the remote level (to enable/disable it on a given
> repo), and finally at the branch level (to enable-disable it for a
> given branch (and its upstream)). Thus you could have a .git/config
> that looked like this:
> 
>   [core]
>   refusePushSecret = true
> 
>   [remote "foo"]
>   refusePushSecret = false
>   url = ...
>   fetch = ...
> 
>   [branch "baz"]
>   remote = foo
>   merge = refs/heads/baz
>   refusePushSecret = true
> 
> This config would:
> 
>  - refuse to push 'secret' commits from branch 'baz'
> (branch.baz.refusePushSecret == true)
> 
>  - but allow to push other branches with 'secret' commits to remote
> 'foo' (remote.foo.refusePushSecret == false)
> 
>  - but refuse to push 'secret' commits to other remotes
> (core.refusePushSecret == true)
> 
> (The order of precedence would be: branch config > remote config >
> repo config > user config > system config > default when unset)

You read my mind.

> I am unsure whether the 'secret'-ness of a commit should follow across
> the push, but if you do (assuming we store the 'secret' flag using
> git-notes) this is simply a matter of synchronizing the
> refs/notes/secret to the same remote.

I think it should, so that 'secret' commit would not escape by accident
via a group secret repository.

What makes it hard (I think) is that we would prefer to transfer 
'secret'-ness only for pushed commits.  That might be problem for notes
based implementation of 'secret' annotation and 'secret'-ness transfer...
though I guess knowing that there exist 'secret' commit with given SHA1
which we do not have and should not have is not much breach of
confidentiality.  Still...

-- 
Jakub Narebski
Poland
