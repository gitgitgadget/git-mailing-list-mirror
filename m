From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Introducing different handling for small/large transactions
Date: Fri, 16 Jan 2015 11:00:46 -0800
Message-ID: <CAGZ79kZ9vFebD9nsNkfU759msT9CvF4gRS_Apmi5-u5XWsiGYQ@mail.gmail.com>
References: <1421361371-30221-1-git-send-email-sbeller@google.com>
	<xmqqppaf4o04.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCC8b-0008LI-Md
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbbAPTAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:00:49 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38462 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbbAPTAs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:00:48 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so4836173iga.0
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 11:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3/m9UJutlzr9Bo6C5NAAh08cIfoQb22YEdRuOdqAriU=;
        b=hu9zqqO9lSOHLafXviKeIiFv7JXLJql6HzVnCezZI3S+BmgJ+UCTH88A5fhOaDdUBa
         89SiorSVftBbKUA4WdRfsHJvjgpqgMYVX6qKXQxrSXTYDNs4sV8cQTnCVbIe6kmxCSJE
         j2yG6o0bmuUBsn1ZxdcKJHcbAA6ZAUsYdM5Aa6b2cXI6nR5sZt5wuZm8LUqC2ZH97L/+
         nrAc/xZy5zwRv9CvlzMHSqy0BsMXNSlkh9SnLBgs2FV970OqR8yGFylauFEeUizDmC2I
         L3qdq+7quhOsE0R1XpLfErVOt3jQDuh2kw0plC9tluQSFJLFhfVxnvLtRyqVaAu4INC0
         ZuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3/m9UJutlzr9Bo6C5NAAh08cIfoQb22YEdRuOdqAriU=;
        b=CO3Kwu5I1t3I1JwSKUw4rvgEL+XwGOq3cnjyhSG1IzLVI+wU8A47LAhxRtFwvfJ8fF
         lkzwni0qd+pJpUn3ip/IWZ2qHwOHMrgtLwZgGtdgI/vrILvYRdWPlaKCsSABBWOYCE7X
         wqan9nenbXc3OdWIGRNMQXh5AnYYSNY8ac+EoTfnDY9Q1vB/g0MLxFh6umY+UTG5rl1H
         5huYLPYf1vobLvr4gfkn/IWjIgs0AmBw0npgLsRdJ7SGjmL3r0liJaFTADskr5ChdTBD
         uVbxTpsI60q5gvwfH58kONFlpywNM68ooYByPoBLFuZZJ2DaQ8cesWyfMgCBmcS62c2X
         M4MA==
X-Gm-Message-State: ALoCoQlVIBD/4XiUbwZkschpTwCVC1xptPJEmpaWKIbuLxLX0EIgFNFqsg2MUFb44/ZDOdlo2MYz
X-Received: by 10.50.79.161 with SMTP id k1mr5306376igx.14.1421434847079; Fri,
 16 Jan 2015 11:00:47 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 16 Jan 2015 11:00:46 -0800 (PST)
In-Reply-To: <xmqqppaf4o04.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262559>

On Thu, Jan 15, 2015 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In ref_transaction_commit
>>       * commit the .lock file to its destination
>>       * in case this is a deletion:
>>               * remove the loose ref
>>               * and repack the packed refs file if necessary
>
> Don't you need to repack and then remove the loose one, though?
> Otherwise you would expose a stale packed ref in the middle to the
> other readers, no?

You're right.

>
>> The larger transactions would be handled differently by relying
>> on the packed refs file:
>> In ref_transaction_update:
>>       * detect if we transition to a large transaction
>>         (by having more than one entry in transaction->updates)
>>         if so:
>>               * Pack all currently existing refs into the packed
>>                 refs file, commit the packed refs file and delete
>>                 all loose refs. This will avoid (d/f) conflicts.
>>
>>               * Keep the packed-refs file locked and move the first
>>                 transaction update into the packed-refs.lock file
>>
>>       * Any update(delete, create, update) is put into the locked
>>         packed refs file.
>
> I am not sure if you mean (a) keep updates only in-core, to be
> flushed at the commit time, or (b) each and every update in the
> large transaction results in rewriting the entire packed-refs.lock
> file, only to be renamed to the final name at the commit time.
> I am hoping it would be the former.

I wasn't sure which I mean. The first one is obviously better to do.

>
>>       * Additionally we need to obtain the .lock for the loose refs
>>         file to keep guarantees, though we should close the file
>>         descriptor as we don't wand to run out of file descriptors.
>
> Yes, this last point is important.
>
