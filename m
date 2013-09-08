From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 08 Sep 2013 16:05:30 -0400
Message-ID: <522CD88A.3060708@bbn.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com> <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com> <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com> <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com> <20130904081047.GB2582@serenity.lan> <xmqqa9jso69u.fsf@gitster.dls.corp.google.com> <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley> <xmqqr4d4jird.fsf@gitster.dls.corp.google.com> <CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com> <522C168B.7050300@bbn.com> <xmqqa9jn6v6q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 22:06:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIlFC-0005D5-3K
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab3IHUFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:05:47 -0400
Received: from smtp.bbn.com ([128.33.0.80]:55385 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab3IHUFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:05:47 -0400
Received: from socket.bbn.com ([192.1.120.102]:55382)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VIlEl-00045i-5g; Sun, 08 Sep 2013 16:05:35 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0141F3FF85
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqa9jn6v6q.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234260>

On 2013-09-08 14:10, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
>> What about something like:
>>
>>     pull.mergeoptions (defaults to --ff-only)
>>     pull.rebaseoptions (defaults to empty?  --preserve-merges?)
>>     branch.<name>.pull.mergeoptions (defaults to pull.mergeoptions)
>>     branch.<name>.pull.rebaseoptions (defaults to pull.rebaseoptions)
> 
[snip]
> But it does not help Philip's case, if I understand correctly, where
> running "git pull" on some branches is always a mistake and the user
> wants it to stop at "fetch the history and objects needed to
> complete the history from the other side" phase without proceeding
> to the "then integrate the history from the other side and the
> history of your branch into one" step, which may be done with either
> merge or rebase.

How about:

    branch.<name>.pull.defaultIntegrationMode = merge | rebase | none
        If 'merge', pull acts like 'git pull --merge' by default,
        merging the other commits into this branch.
        If 'rebase', pull acts like 'git pull --rebase' by default,
        rebasing this branch onto the other commits.
        If 'none', pull acts like 'git fetch' by default.
        Default: whatever pull.defaultIntegrationMode is set to.

    branch.<name>.pull.mergeoptions
        Arguments to pass to 'git merge' during the merge phase of
        'git pull --merge'.
        Default: whatever pull.mergeoptions is set to.

    branch.<name>.pull.rebaseoptions
        Arguments to pass to 'git rebase' during the rebase phase of
        'git pull --rebase'.
        Default: whatever pull.rebaseoptions is set to.

    pull.defaultIntegrationMode = rebase | merge | none
        See branch.<name>.pull.defaultIntegrationMode.
        Default: merge

    pull.mergeoptions
        See branch.<name>.pull.mergeoptions.
        Default: empty, but warn that a future version will change
        this to --ff-only.

    pull.rebaseoptions
        See branch.<name>.pull.rebaseoptions.
        Default: empty, but warn that a future version will change
        this to --preserve-merges?

There's probably a better alternative to the term 'defaultIntegrationMode'.

We could even add a defaultIntegrationMode = merge-there that
reverses the parent order (the other commits become the first parent,
the current branch becomes the second parent).

-Richard
