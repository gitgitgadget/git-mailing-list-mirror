From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 16:43:38 -0700
Message-ID: <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 01:43:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUNsX-0002xC-5L
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 01:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbbHYXnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 19:43:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33856 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbbHYXnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 19:43:40 -0400
Received: by pabzx8 with SMTP id zx8so48537480pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lfZtkD9UVJkD9TXUZSMmuUXG20sIgVs5b/nsjjESRKw=;
        b=Wt764J4FvhWl29fqsCuXAzRTGHHIyl9Sqb/LNXbVbHTiTAhKZ5r2WZTnd364aSCSOH
         H+h0luA8/vVoQLlEBTPnsGvZCq+DLAA5v6EIACWLl4TeykkHDAylMYkv/F26kFyylGVi
         hmAec5KzBqWfr+Ad1kSndRZSoNExF+jDQjsuaBp3P2L3y3HSRxw7VWTRuLRelOmeDeax
         b+Bs6qtLomO89lCjfA6S+3tq6E0hUdO1duF3uRqJz/GccEn91Ncg86EgAXPhWwErJdGx
         PQA8/VNkezMrvccD9QMRRJEvLMcGPLOUlrpybuY/wdxwvIyfxO9EXSwvcSfEnTZXJVjp
         7FnQ==
X-Received: by 10.68.241.103 with SMTP id wh7mr61815503pbc.88.1440546219650;
        Tue, 25 Aug 2015 16:43:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id qr5sm22332875pbb.26.2015.08.25.16.43.38
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 16:43:39 -0700 (PDT)
In-Reply-To: <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 25 Aug 2015 15:06:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276587>

Stefan Beller <sbeller@google.com> writes:

>  $ git tag --delete master
>  $ echo $?
>  # 0 # actually works as of today!
>
>  $ git tag delete master
>  #  Due to the planned switch to command words, this doesn't work.
>  #  For details see road map at  `man git commandwords-roadmaps`
>  $ echo $?
>  # 128 maybe ?

This is way too aggressive behaviour and is unacceptable as the
first step.  The first step of a transition that breaks backward
compatibility should warn loudly about a command line that would
behave differently in the endgame version (either the command line
that will not do anything or do a totally different thing), but
still perform the operation asked for the current version.

    e.g. "git tag delete master" would create a tag named 'delete'
    out of 'master', but tell the user that this will instead delete
    'master' in future versions of Git.  "git tag create master"
    would create a tag named 'create' out of 'master', but tell the
    user that this will instead create 'master' out of HEAD in
    future versions of Git.

    e.g. "git tag -d foo" would delete a tag named 'foo', but tell
    the user that this will have to be spelled 'git tag delete foo'
    in the future versions of Git.

One thing that I am not enthused about the transition plan is that
"git tag delete master" will *never* be an invalid operation during
the transition.  When making an operation that used to mean one
thing to mean something else, a good transition plan should be to

 * First warn but do the old thing, and tell users a new way to do
   that in the new world order.  At the same time, find the new way
   that used to be an invalid operation in the old world order, and
   implement it.

 * Then stop supporting the old thing and support only the new
   thing.

Then during the transition period, while transitioning to the new
way, people can gradually start using the new way with the new
system, and when they occasionally have to interact with an old
system, the new way will _error out_, because we make sure we find
the new way that "used to be an invalid operation" when planning the
whole transition plan, without causing any harm.  And once people
retrain their finger after 2-3 years, nobody will be hurt if we
dropped the old way.

I do not see a good way to do such a safe transition with command
words approach, *unless* we are going to introduce new commands,
i.e. "git list-tag", "git create-tag", etc.

So don't hold your breath.  What you two are discussing is way too
uncooked for 2.6 timeframe.
