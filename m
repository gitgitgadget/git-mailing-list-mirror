From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge --abort
Date: Tue, 24 Feb 2009 10:51:41 +0100
Message-ID: <200902241051.42800.jnareb@gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com> <200902240253.35470.jnareb@gmail.com> <7vk57goanf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu09-0002Ej-Ei
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbZBXJwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbZBXJwl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:12460 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbZBXJvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so74092fgg.17
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QZaq4gaKdWY9/b0WkrrCYbYQaKbAnJyo5bKBhzNtorI=;
        b=XBsgn4HsJKdkXgsTNPCY66l2O6rBVPO3b7NlVYgnVlDb2eCwB8moqZdf/+VznvDsSV
         C4f95WZobAyeAG645q+X2g7kXpVLtY8qyZ8J+WGViaZShniQZzoRd41eJumqrmn2WqcV
         zWCFfQ2yH6C2d+T/MT1czbpJVt4kpvGxjOj6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FeLnAPDO/N9Rjdt427qrL1Ina/VeFH6FdOt/RfV4K924wtHLeYJ6hwh1XivsPd+MKe
         G0jVuu31y/rv/z0g2cI/wwXDUBTKV2G9t1lJia6LP7BGWvykrvbd7UZknhcN+m696eQT
         wm8HjxIncEI2Y1B5L/RlGA4l83Yt32C9jbYRY=
Received: by 10.86.94.11 with SMTP id r11mr3582132fgb.53.1235469110700;
        Tue, 24 Feb 2009 01:51:50 -0800 (PST)
Received: from ?192.168.1.15? (abvk114.neoplus.adsl.tpnet.pl [83.8.208.114])
        by mx.google.com with ESMTPS id 3sm1171281fge.52.2009.02.24.01.51.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk57goanf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111276>

Junio C Hamano wrote::
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:

>>> I personally did not think "--keep" would need to be be part of a
>>> reasonable "merge --abort" implementation, but I may have missed some
>>> description of a viable design discussed on the list.

First, a description of state: here we assume that you have changes to
tracked files in working area that are neither in HEAD, nor in index,
and that you can have changes in index which are neither in HEAD nor
in working area.

If HEAD == index == working area then stashing is not necessary.

>> My idea was that merge would do the following:
>>
>>   $ <save stash into MERGE_STASH or similar, no reset>
>>   $ <do a merge>
>>
>> Then we have two possibilities:
>>
>>   # merge failed with conflicts
>>   $ git merge --abort (would unstash MERGE_STASH and delete it)
> 
> Here "would unstash" needs to follow something else, namely, make your
> work tree free of local changes.  How?  "reset --hard"?

Yes. "git merge --abort" would be equivalent to

  $ git reset --hard ORIG_HEAD
  $ git stash pop --ref=MERGE_STASH
  $ rm $GIT_DIR/MERGE_STASH

> 
>>   # we created merge conflict
>>   $ <MERGE_STASH is removed together with MERGE_HEAD>
> 
> You mean "created a merge without conflict", right?  That part is easy to
> guess and understand.

Yes. I meant here: "created merge _commit_" (not "conflict").

> 
> In fact, when you run more than one strategies, something similar to this
> already happens internally.  The C version may be harder to follow, but
> you can check the last scripted version contrib/examples/git-merge.sh and
> find two functions, savestate/restorestate pair, that does exactly that.
> 
> It way predates --keep patch, by the way.

Well, we have "git reset --merge ORIG_HEAD" which from what I understand
does at least part of "git merge --abort", but I am not sure if it
covers all cases (like dirty index in addition to dirty tree).

-- 
Jakub Narebski
Poland
