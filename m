From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Tue, 3 Dec 2013 11:07:15 -0800
Message-ID: <20131203190715.GC29959@google.com>
References: <1385922611.3240.6.camel@localhost>
 <20131201190447.GA31367@kaarsemaker.net>
 <529DF64A.70801@gmail.com>
 <xmqqtxepokej.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	git@vger.kernel.org, ingy@ingy.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:07:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvJn-0005xY-ON
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab3LCTHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:07:21 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:57326 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab3LCTHT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:07:19 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so9887328yho.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 11:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=E3Fm2akT+4Pg0rL0LDAd5JRUJmP98rVFsdvU9OWrUzc=;
        b=uVJ0GLuniKZrLn7rCb/jKwIqO3Xb4LsSaFLDfqMY+ruKMYkp0BKFw/bpjYFU+g/hkj
         ynEZDySq/IH6Ogto8GI1WXFRRN+qf8t71rFq7h5GCsDZ3BU0QEQru7tUfJyga1TRj8Fb
         sbbz4xndwpZMrV/6JtycOXFf8AeAtyRhVKFkHrT/t/PGNmCvSHQW0383hIJnbD+kcL+i
         NQFbhzvVUCmk10jeZ5d/KTCmSp2r8SVI56f2z622H3TUpelaKdLQZfsvcpz3Rmy+HV8h
         EV5N+yh8woaVwUikYvDinQEHKd9/rfAlpDJCR63XM/YGIwtnqQZHzM8NepIyDHBolC3/
         8NRw==
X-Received: by 10.236.202.4 with SMTP id c4mr3313701yho.115.1386097638919;
        Tue, 03 Dec 2013 11:07:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e10sm135290235yhj.1.2013.12.03.11.07.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 11:07:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqtxepokej.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238717>

Junio C Hamano wrote:
> Karsten Blees <karsten.blees@gmail.com> writes:

>> If we don't want to support this, though, I think it would be more
>> approrpiate to issue a warning if GIT_DIR points to a worktree
>> location.
>
> But how do tell what is and isn't a "worktree location"?  Having the
> path in the index would be one, but you may find it out only after
> issuing "git checkout $antient_commit".

I think the idea was that *any* path under $(git rev-parse
--show-toplevel) would not be a valid GIT_DIR, unless its last path
component is ".git".

Alas, I don't think that would work smoothly.

 - Some people may already be using GIT_DIR=$HOME/dotfiles.git to
   track some files with a toplevel of $HOME.  That is error-prone and
   it would be cleaner to either use plain .git or keep the $GIT_DIR
   outside the worktree (for example by tucking dotfiles into a
   separate $HOME/dotfiles dir), true, but producing a noisy warning
   with no way out would not serve these people well.

 - There is no outside-the-worktree location when GIT_WORK_TREE=/.

So your suggestion of at least noticing when "git checkout" wants to
write files that overlap with the GIT_DIR seems simpler.
