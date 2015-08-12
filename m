From: Junio C Hamano <gitster@pobox.com>
Subject: Re: proper remote ref namespaces
Date: Wed, 12 Aug 2015 09:10:06 -0700
Message-ID: <xmqqfv3omqsh.fsf@gitster.dls.corp.google.com>
References: <CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Jeff King <peff@peff.net>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 18:10:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPYbb-0000yi-1d
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 18:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbbHLQKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 12:10:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36643 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbbHLQKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 12:10:08 -0400
Received: by pacrr5 with SMTP id rr5so17453210pac.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rY00D4ZaI16F91UruJl1S1EeEAlWK/Eneuf1ZVT8Bw4=;
        b=CKd4ywzEdFCPmmSlRhdtIwE8dUxUx88awEJmuGQAk7thuz89/YMj6s8ptG5oSpoTzP
         yUDMASXSze8GDj8ZYYlV1BjWvlOOhElOQSrMHANuQral6GY8pMXHLogplh2XKdqypllC
         ucHZSO9ELKsGIYxz1RwhGg85W1NzW1KMEDjhRwnftL5+kaXAqSd/44AZCPB8QI6L2t0P
         3dPf7LhDqjPQep433jPKmuxAqb6IHlch6WN2qt+dvJYBcYtxvba17tJjI0gNtbVkTnHr
         3Rh6XU9r5rQqXn2GmDgu7uhxlZnXT+LPaVfnrU6We49zfbbHX4wjZr5+8I/RSu74Bzr4
         L8uA==
X-Received: by 10.66.222.103 with SMTP id ql7mr67843687pac.144.1439395808345;
        Wed, 12 Aug 2015 09:10:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id gh5sm6925114pbc.87.2015.08.12.09.10.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 09:10:07 -0700 (PDT)
In-Reply-To: <CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com>
	(Jacob Keller's message of "Tue, 11 Aug 2015 23:43:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275777>

Jacob Keller <jacob.keller@gmail.com> writes:

> Recently there was some discussion about git-notes and how we do not
> fetch notes from remotes by default. The big problem with doing so is
> because refs/remotes/* hierarchy is only setup for branches (heads),
> so we don't have any clean location to put them.

I wouldn't call this topic "proper" namespaces, though.  What we
have is widely used and it shouldn't be broken.  Call it "enhanced",
perhaps.

Some design boundaries:

 - Moving the remote-tracking branch hierarchy from refs/remotes/$O/*
   to refs/remotes/$O/heads/* would not fly, because it will break
   existing repositories.  Do not even waste time on pursuing
   refs/remotes/$O/{heads,tags,notes...}/*

 - Extending the current refs/remotes/$O/* (for branches) and doing
   refs/remote-tags/$O/* (for tags) may work, would not break
   existing repositories, and could to be extended further to cover
   refs/remote-notes/$O and friends.  It however may not look pretty
   (weak objection) and more importantly, it would make it harder to
   "cull" things that came from a single remote.

Just thinking aloud, perhaps we can introduce a brand new top level
hierarchy refs/remote/$O/{heads,tags,notes,...}, and give backward
compatibility by making a moral equivalent of a symbolic link from
refs/remote/$O/heads to refs/remotes/$O/.  The true remote-tracknig
refs continue to live in refs/remotes/$O/* and old tools that do not
know the new layout would not be hurt.  New tools that want to
ignore and look only at refs/remote/$O/* can do so through the moral
equivalent of a symbolic link.  "remote remove" needs to be taught
about this single exception (i.e. "the symbolic link"), but the
places it needs to touch is limited only to two places and will not
grow.

If somebody got confused, notice that in the above description, I
said refs/remotes/ and refs/remote/.  The former must stay.  The
name of the latter is open to bikeshedding.  Some may prefer a name
that is more distinct (refs/tracking/ or something, perhaps?).  I
happen to prefer a name that is similar, but this preference is very
weak and I can persuaded to go either way.
