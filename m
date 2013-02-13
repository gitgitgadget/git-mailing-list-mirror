From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Wed, 13 Feb 2013 21:25:59 +0100
Message-ID: <511BF6D7.3030404@gmail.com>
References: <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com> <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com> <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com> <511AAA92.4030508@gmail.com> <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com> <20130213181851.GA5603@sigill.intra.peff.net>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 21:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5iuQ-0003A0-BP
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760299Ab3BMU0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 15:26:01 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:36510 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab3BMU0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:26:00 -0500
Received: by mail-ee0-f51.google.com with SMTP id d17so820977eek.38
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 12:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=83MhqINwLsoZodfqByjuXBRN7FKpwzNNYnE2XvULhj4=;
        b=Vus4vXxBgMcqz2lOg0nlbXnRUnjaSPbCMKEqZZURcPYRjAc9esdiGXbmqbAoZyGaR5
         OFh/9JtrY38mnt2I3PTNip9ICyiHswlsUOWIr9fY/zK29DpkYQowdrFy9h1K3w4xDRD0
         qSLTtEnNaCMj1xRxt1Wg6eTgprVwwhk4I4bIANeG5grx9uZR9eETjIqn143BaG8YJSNB
         C5W72gZFkIPNz1CFdumEqB+32PbrIvYkoluOJQig7sJmy4EWGhiRUUzhS8p4eJyHwWp7
         oyUZHoIm/Cbhjc//YkjSBNwwoUceeEh4TWJVVKTo0d3FuX3f3PjabjaOwL7gKmSyEa+U
         3brQ==
X-Received: by 10.14.1.130 with SMTP id 2mr9157767eed.15.1360787159233;
        Wed, 13 Feb 2013 12:25:59 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id k7sm72408264een.8.2013.02.13.12.25.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 12:25:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130213181851.GA5603@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216284>

Am 13.02.2013 19:18, schrieb Jeff King:
> Moreover, looking at it again, I
> don't think my patch produces the right behavior: we have a single
> dir_next pointer, even though the same ce_entry may appear under many
> directory hashes. So the cache_entries that has to "dir/foo/" and those
> that hash to "dir/bar/" may get confused, because they will also both be
> found under "dir/", and both try to create a linked list from the
> dir_next pointer.
> 

Indeed. In the worst case, this causes an endless loop if ce->dir_next == ce
---8<---
mkdir V
mkdir V/XQANY
mkdir WURZAUP
touch V/XQANY/test
git init
git config core.ignorecase true
git add .
git status
---8<---
Note: "V/", "V/XQANY/" and "WURZAUP/" all have the same hash_name. Although I found those strange values by brute force, hash collisions in 32 bit values are not that uncommon in real life :-)

> Looking at Karsten's patch, it seems like it will not add a cache entry
> if there is one of the same name. But I'm not sure if that is right, as
> the old one might be CE_UNHASHED (or it might get removed later). You
> actually want to be able to find each cache_entry that has a file under
> the directory at the hash of that directory, so you can make sure it is
> still valid.
> 

Yes, the patch was just to show potential performance savings, I didn't consider CE_UNHASHED at all.

> I think the best way forward is to actually create a separate hash table
> for the directory lookups. I note that we only care about these entries
> in directory_exists_in_index_icase, which is really about whether
> something is there, versus what exactly is there. So could we maybe get
> by with a separate hash table that stores a count of entries at each
> directory, and increment/decrement the count when we add/remove entries?
> 

Alternatively, we could simply create normal cache_entries for the directories that are linked via ce->next, but have a trailing '/' in their name?

Reference counting sounds good to me, at least better than allocating directory entries per cache entry * parent dirs.
