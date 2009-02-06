From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Fri, 6 Feb 2009 18:39:47 +0000
Message-ID: <b0943d9e0902061039g37eb521fl26d60d33c45a206@mail.gmail.com>
References: <20090128231305.16133.29214.stgit@localhost.localdomain>
	 <20090129034512.GD24344@diana.vm.bytemark.co.uk>
	 <b0943d9e0901300601j27ab6ebdq4b38a9f7c0cbe261@mail.gmail.com>
	 <20090130152649.GA22044@diana.vm.bytemark.co.uk>
	 <b0943d9e0901300936t4a6e0a37x1968a6949fb7bdda@mail.gmail.com>
	 <b0943d9e0902060646hd779681x821e74d9a155d97b@mail.gmail.com>
	 <20090206153106.GA28897@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 19:41:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVVde-0007sF-E1
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 19:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbZBFSju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 13:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbZBFSju
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 13:39:50 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:64563 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZBFSjt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 13:39:49 -0500
Received: by bwz5 with SMTP id 5so101498bwz.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G21ow8BlMI39Zg7QMbjmPRJZ3uW/s2j2nAg5tgQxsKo=;
        b=SF5WBE5k+2Ga1oiyNX4YilTTG/aR9srevBA7UBePWBziaM1P945MY8wJo64moYbHB5
         iRTYq95glmhAY76lH64sHfe8AU5ReDMLua6yNvOzxUS5o6n9QEGg8RPpWCgwA4f2wBj+
         muBWM9eoFUaCCw6I3Mf2tZsrLwr+mtaOkARCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fsyug5ryDcAUlfRjKN7sKoopFveP8wzRWwMF4JBZWpOG+SfRsnfvwhAL3oagx2x6js
         EE0AqS6uCPQodaFRxXCpFYccqEzuFJLu66ZNSoTe821V2hz330hC4eeftx7Qhlfz5K7C
         +fzICyq6N+BYFvqGco9NtUQ422LNa9HZR4fwk=
Received: by 10.223.112.83 with SMTP id v19mr1771305fap.66.1233945587349; Fri, 
	06 Feb 2009 10:39:47 -0800 (PST)
In-Reply-To: <20090206153106.GA28897@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108768>

2009/2/6 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-02-06 14:46:19 +0000, Catalin Marinas wrote:
>
>> 2009/1/30 Catalin Marinas <catalin.marinas@gmail.com>:
>>
>> > Now, should we add the check_clean argument to
>> > Transaction.__init__() rather than run() as we do for the
>> > allow_bad_head case?
>>
>> It looks like this may be a better option.
>
> Sorry for taking so long to respond, but ... I strongly advise agains=
t
> using default_iw in transaction.py. It's library code, and it should
> take stuff like index and worktree as input parameters from layers
> that are higher up in the abstraction stack.

OK, no problem with that.

>> The previous patch fails if "goto" pushes a patch with standard
>> git-apply followed by another patch with a three-way merge. When
>> Transaction.run() is called, even if the patch pushing succeeded,
>> the function complains about local changes because of the
>> "iw.index.is_clean(self.stack.head)" check.
>
> Hmm, so that would have to be worked around somehow ... I guess doing
> the check in __init__() might make sense after all, since that's
> before we start changing things. How about adding a
> check_clean_relative_to paramter to __init__() that's not a boolean,
> but an iw to check against? It would default to None, meaning no
> check.

OK, that's better.

>> It is also a bit weird to push/pop patches and only complain at the
>> end of local changes.
>
> You mean the behavior the new infrastructure currently gives you? It'=
s
> actually convenient in a number of cases. Assume for example that you
> have patch A that changes file foo, patch B that changes file bar, an=
d
> then local changes to file bar. At this point you can pop A without
> problem, even though a middle stage is to pop and push B which touche=
s
> the same file as your local changes -- the existing checks will only
> compare the diff between the original and final tree with your local
> changes, and that diff doesn't contain bar.

Yes, I agree that's a nice feature and it would still be available
with the --keep option (I wrote in the past why I wouldn't leave the
current behaviour to be the default).

Above I was referring to the new behaviour which checks for local
changes by default (--keep not passed). If we do the test in run() you
may push or pop patches and only fail at the end when actually the
operation shouldn't have started. I plan to add the auto interactive
merging to the new infrastructure (by invoking mergetool if
IndexAndWorktree.merge() fails, based on the stgit.autoimerge option)
and pushing may become a more complex operation if enabled.

I'll repost the patch. Thanks.

--=20
Catalin
