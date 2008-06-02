From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up git-cherry
Date: Mon, 2 Jun 2008 10:23:55 -0700
Message-ID: <7f9d599f0806021023r64affb36ne491792a962d455c@mail.gmail.com>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
	 <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
	 <7f9d599f0806020750g78e6816dl884d36bb903c707b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 19:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Dm5-0001Vn-0B
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 19:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYFBRX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 13:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYFBRX5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 13:23:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:7081 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbYFBRXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 13:23:55 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1137429rvb.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ALMObppKgnGjf3XfJjjJuHn0hub5OchccwrjHT7H6WA=;
        b=RAMt9bIwxSBXv04LkQUZregX+7IMWlEJIXdZvTCRKa/eC90HB8asNMz8KRM3hv1tNPSNO+351o7VWLmby+Cyg2KWVPI+46mGqBkXOlOkmwpfoaCbFqcRDX0wQ/HvMftahuuFKjk2aXFHK8VzYWoB/AKASp9/0LMTM6u1e8FcgJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fSE0A2gO6aXEJq6HdOWj8CskrTrhz/UmMgeXVH/Qyaj3kVkfZ6sbaEMRuIYrbDfVBkMAor3BASGsixIunl6o5OJbE4UxpwzTzLcH8WTeeylDDVsWBpjxyLGyhsEDQFnRJ0WDX+h0jK7tqQhvO5/Ks8rF4p8nmeKjiwp9+74bH0k=
Received: by 10.141.23.7 with SMTP id a7mr5129747rvj.5.1212427435351;
        Mon, 02 Jun 2008 10:23:55 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Mon, 2 Jun 2008 10:23:55 -0700 (PDT)
In-Reply-To: <7f9d599f0806020750g78e6816dl884d36bb903c707b@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 2e0ebd94aa7b7826
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83546>

On Mon, Jun 2, 2008 at 7:50 AM, Geoffrey Irving <irving@naml.us> wrote:
> On Sun, Jun 1, 2008 at 11:13 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Sun, 1 Jun 2008, Geoffrey Irving wrote:
>>
>>> The dominant cost of git-cherry is the computation of patch-ids for each
>>> relevant commit.  Once computed, these pairs are now stored in a hash
>>> table in $GIT_DIR/patch-id-cache to speed up repeated invocations.
>>>
>>> The basic structure of patch-id-cache.c was cannibalized from Johannes
>>> Schindelin's notes-index structure, though most of the code was
>>> rewritten. The hash table is still kept strictly sorted by commit, but
>>> the entire table is now read into memory.
>>
>> I do not think that this "read-the-entire-table-into-memory" paradigm is a
>> wise choice. mmap()ing, I would have understood, but reading a potentially
>> pretty large table into memory?
>
> I'll switch to mmapping.

The git_mmap function in compat/mmap.c dies if NO_MMAP is defined and
the map isn't MAP_PRIVATE.  If I want to write an entry, will the
memory be automatically updated if I write directly to the file
descriptor (I haven't used mmap before)?

Also, do you think it's okay to write directly into the mmap'ed memory
for every insertion, or should I try to be fancier?  Immediate writing
would simplify the code a lot, and I don't think there's a significant
performance issue since computing an entry is expensive.

Thanks,
Geoffrey
