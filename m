From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone --depth: shallow clone problems
Date: Tue, 26 May 2015 07:54:12 -0700
Message-ID: <xmqqmw0rl78r.fsf@gitster.dls.corp.google.com>
References: <CALxdAKiyRMR-jF2KcBQGYgXUb+D8=YaESU3E9KN+zBLx=0UCNw@mail.gmail.com>
	<20150526124702.GA12101@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michal Pomorski <misieck@gmail.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 16:54:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxGFJ-0002hi-3f
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 16:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbbEZOyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 10:54:16 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33966 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbEZOyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 10:54:15 -0400
Received: by ieczm2 with SMTP id zm2so93951724iec.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ybsMY0LbyHFSoFkJD+X904YBjbUNCT+LAhr9OL8n7k4=;
        b=PaT4qhF5R15yskbxzhEsJOca/BQZ670oSym5AXM8BZ0+778JnuDDbEBdCI/CP1F8CM
         5wGdomCWN4vwx87DNKWyRW6Dvq+2TWwSOigVuKzWtJBcg5+cK8gG6K1MYgfkNfAUjRc7
         3uerQsUuRWy2Xq+wCZPlVv8tBuvR2rBpg1FgkExmRkq0Ye7gk4LIv6UWlzD+7+XQ6Pc4
         bM8hYebK8EDt6uhnELbXwyGFIpgQVWhpd+bKIyOM0i6Juys5hQMWIa9CQkADQFTjl/Di
         GUC/ugRbNmKihQYjIRctnQoy9I5V42jhyjg6lbfxJbnwGQP2Md+JAiAR8+5qSpwrRQHV
         hNSg==
X-Received: by 10.50.132.33 with SMTP id or1mr30808626igb.31.1432652055213;
        Tue, 26 May 2015 07:54:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id ot6sm8474178igb.11.2015.05.26.07.54.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 07:54:13 -0700 (PDT)
In-Reply-To: <20150526124702.GA12101@lanh> (Duy Nguyen's message of "Tue, 26
	May 2015 19:47:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269944>

Duy Nguyen <pclouds@gmail.com> writes:

>  --unshallow::
> -	If the source repository is complete, convert a shallow
> -	repository to a complete one, removing all the limitations
> +	If the source repository is complete, convert all shallow
> +	refs to complete ones, removing all the limitations

Define "shallow ref", or better yet explain without introducing such
a new term (I do not think shallow-ness is a property of a ref, by
the way---I think you meant all refs that can reach the points the
history is cauterised by .git/shallow, but we shouldn't assume that
the target audience of this paragraph to know Git as well as I do).

>  	imposed by shallow repositories.
>  +
>  If the source repository is shallow, fetch as much as possible so that
> -the current repository has the same history as the source repository.
> +the all existing refs of current repository have the same history as in
> +the source repository.

Makes sense, modulo "so that the all existing refs" sounds strange
to my ears ("all the existing refs" perhaps).

> ++
> +Note that if the repository is created with --single-branch, which is
> +default for a shallow clone, only one ref is completed. `--unshallow`
> +does not fetch all remaining refs from source repository.

I do not think this "Note" is being as helpful as it could be.

 - If the repository was created with --single-branch but if the
   user later fetched and started tracking other branches, the
   statement "only one ref is completed" is untrue; the true version
   is "only the existing refs are completed", which leads to a more
   important point.  It says the same thing as "all existing refs"
   above and does not add any useful information.

 - The last sentence is less than useful but merely frustrating---it
   says what you cannot do with this option, strongly hints that the
   writer of the sentence knows what the reader wants to achieve,
   but without saying what other way the reader go to achieve it.

Perhaps replace that Note paragraph with something along this line?

    +
    By fetching and tracking refs that you haven't been tracking,
    you can add these new refs to "all refs" to be unshallowed.

>> 2) git fetch --unshallow should convert the clone into an actual
>> equivalent of a normal, not shallow clone.
>
> I was thinking of some way to undo --single-branch too. I don't think
> it should be the job of --unshallow, maybe a new option, but I can't
> think of a name better than --really-unshallow :P

Isn't that just the matter of updating remote.origin.fetch?  I do
not think it belongs to "clone" (or "fetch").  Perhaps it belongs to
"remote", where it already shows with "git remote -v" what is
fetched and pushed.

>  --depth <depth>::
>  	Create a 'shallow' clone with a history truncated to the
> -	specified number of revisions.
> +	specified number of revisions. --single-branch is
> +	automatically specified unless the user overrides it with
> +	--no-single-branch

Yeah, something like that would be a definite improvement.

By the way, while composing this message, I scratched my head after
typing

    $ git clone --shallow=4 --no-local ./git.git ./playpen

Is it just me or do we want to add such a synonym?

Thanks.
