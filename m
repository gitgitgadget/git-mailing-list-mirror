From: Eric Kidd <git@randomhacks.net>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Sat, 14 Feb 2009 00:17:25 -0500
Message-ID: <431341160902132117s1696c975mbf20dfbdc65a7df3@mail.gmail.com>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
	 <1234578258-48870-1-git-send-email-git@randomhacks.net>
	 <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 06:25:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYD16-0008GJ-J0
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 06:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbZBNFXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 00:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbZBNFXN
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 00:23:13 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:4440 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZBNFXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 00:23:12 -0500
Received: by yw-out-2324.google.com with SMTP id 5so740203ywh.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 21:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Gm93eKSgxi+EfxKQduCQ66JmzjPLe19AxU4XACAtPEs=;
        b=LeXQ0I8+gOKjO9j+dAmbxvEKJr7/6nKu1PtQJ8jP1+t7V9uR/B7fGe/vmIHvGYC8HB
         ywK7Ra8HRBy95PJxsYMqiZX3nC9Mu/7BOaVX06UrvjwxUNMUCI9k+Tw7glE3OHzIrkfm
         FR+O8GGSDIsHuTQVUsUSEJoxPUawI4k+J39hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=wHSwhjyTTVJBK7c2jwdaKfQoUQyPKVV465m0HYPvTPJjAVxjgRB0GTjJKbMerTYeaH
         2OWdE/5FnDI05HQAeLJIrI3auq13veza52axsSiyDBzKM2NuWFt1r6wOPu+gBW8wmSfn
         nXMH/ugYMBEou7Gt7EAplMr4VN6Hf+cD6tkrU=
Received: by 10.151.106.4 with SMTP id i4mr2779948ybm.204.1234588645993; Fri, 
	13 Feb 2009 21:17:25 -0800 (PST)
In-Reply-To: <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 2919d41f46af1174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109820>

On Fri, Feb 13, 2009 at 11:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Kidd <git@randomhacks.net> writes:
>> ...
>> If the submodule has moved around the source tree, specify one or more
>> values for alternate_dir.  To specify the URL of the newly created
>> repository (for use in .gitmodules), use the --url parameter.
>
> Unfortunately, I do not think we have designed fully (nor implemented at
> all) behaviour to check out different points of history that has the same
> submodule moved around in the superproject tree.
>
> There were several unconcluded discussions done in the past (and I admit I
> participated in a few of them), but it may be hard to use the resulting
> repository out of this tool.

Thank you for looking at this proposal!

I think that the resulting repository is usable (though it could
certainly be better). In particular, the following commands will
always give you a working checkout:

  git checkout any-version
  git submodule update --init

The unit tests for git-submodule-split.sh actually walk through the
entire history and run 'git submodule update --init' at each revision.
This works correctly because git-submodule-split creates the necessary
.gitmodules entries for each revision, and includes the
submodule.*.url value that you specify.

Unfortunately, this means that whenever the submodule moves to a new
location in the tree, 'git submodule --init' will actually have to
clone it again. That's not a perfect situation, but it will work for
reasonably small submodules.

>>   1) Right now, this command is actually git-submodule-split.sh.  Should
>>      I include this code directly into git-submodule.sh, or move it
>>      to git-submodule--split.sh and hook it into git-submodule.sh?
>
> How about in contrib/ somewhere?

Sounds good to me! I'd like to include the unit tests and some
documentation, if that's OK.

I'll let you know when the patch has been reviewed, and submit it for
inclusion in contrib.

>>   2) Should I implement a --force flag based on filter-branch?  Johannes
>>      Schindelin has suggested that it might be better to remove the
>>      --force flag from filter-branch and just rely on the reflog to keep
>>      backups.
>
> Sounds sensible to me, but I do not have strong feeling about this either way.

I realized that there's a problem with removing  --force from
filter-branch: The reflog doesn't contain backups of the rewritten
tags. So I'm afraid --force and the refs/original/ directory will need
to remain for now. (Any thoughts, Johannes?)

>>   4) We're obviously going to need to support revision arguments other
>>      than --all (which is what we currently pass to filter-branch).  Should
>>      we default to the current branch only, or to --all?
>
> Matching what filter-branch defaults to would be the most natural,
> wouldn't it?

I think so, although many (or most?) users will probably want to use '-- --all'.

Thank you very much for your suggestions!

Cheers,
Eric
