From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] shallow clones over http
Date: Thu, 6 Feb 2014 19:30:33 +0700
Message-ID: <CACsJy8Bx6voBepHLmmB0qfXx8MHtrBebB2tsan9iQipC-VCVyw@mail.gmail.com>
References: <20130403040352.GA8284@sigill.intra.peff.net> <7v38txffqn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 13:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBO6p-0001MI-4M
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 13:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbaBFMbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 07:31:06 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:39551 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084AbaBFMbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 07:31:05 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so2998403qcy.29
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZzOjO86q2ysrxVm7pidnEIGqTxca5gx8FYRMCkO9sK4=;
        b=p4LLGN9E1QvlumgxuKI2j/pCuWeT/Z6I64b3OsU0RiETAX1NN6qCd8EdW8iOceS/Bj
         KmNQLC0cGowOTlM2IH1JZEovtSnJ2xNFtY1QsBvkqjCo9a40CcbeJ9lRJqzINAETy3oz
         7kBJKBTL6d8G3GTaaAcBL7ufd+zwaFxJSI/9AOoon0L3qEd0Y0LK/iwfadVn2YG0ppsR
         vZdMkk9LK0rjpj5l8aESNGnO82y9DhQ9Dkzi1hOa0ShYC/2yTk5cy1zPO7YqZ7CFfSpQ
         Om4DVdDI6uwhf8QyT61U5r1mTPsyOXPXdOVU8dxdHZHNEKrYVv7wLiZjodPlW1sWN3bj
         3WLA==
X-Received: by 10.140.84.19 with SMTP id k19mr11265105qgd.98.1391689864005;
 Thu, 06 Feb 2014 04:31:04 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Feb 2014 04:30:33 -0800 (PST)
In-Reply-To: <7v38txffqn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241689>

(Digging back an old topic after Jeff mentioned it)

On Thu, May 9, 2013 at 2:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I'm trying to track down a protocol bug that happens with shallow clones
>> over smart-http. As far as I can tell, the bug has existed in all
>> versions.
>>
>> You can reproduce it using the attached repository, which is a shallow
>> clone of https://github.com/mileszs/ack.vim.git, like:
>>
>>   $ tar xzf repo.tar.gz
>>   $ cd repo.git
>>   $ git fetch --depth=10
>>   fatal: git fetch-pack: expected shallow list
>>
>> In that test my fetch actually hit github.com as the upstream full repo,
>> but you can also clone it down locally and demonstrate it with purely
>> local copies of git (but it's more of a pain, because you have to set up
>> a smart http server).
>>
>> The last part of the conversation looks like this:
>>
>>   packet:   fetch-pack< 0000
>>   packet:   fetch-pack< ACK f183a345a0c10caed7684d07dabae33e007c7590 common
>>   packet:   fetch-pack> have f183a345a0c10caed7684d07dabae33e007c7590
>>   packet:   fetch-pack< ACK 33312d4db4e91468957b1b41dd039c5d88e85fda common
>>   packet:   fetch-pack< ACK 34d0b2fbc182b31d926632d170bc07d6a6fc3f9b common
>>   packet:   fetch-pack< ACK 45c802e07c60686986474b6b05b2c7048330b6b5 common
>>   packet:   fetch-pack< ACK e93f693fd2a9940d6421bf9e4ddd1f535994eaa5 common
>>   packet:   fetch-pack< ACK 132ee41e8e2c8c545b3aed120171e1596c9211a4 common
>>   packet:   fetch-pack< ACK 973deb3145a99992638b2301cfd654721cf35d68 common
>>   packet:   fetch-pack< ACK e53a88a4e72d84562493313e8911ada4def787da common
>>   packet:   fetch-pack< ACK 90be0bf3eee6f7a0cb9c2377a50610f4ce738da3 common
>>   packet:   fetch-pack< ACK aeab88ccf41bf216fde37983bd403d9b913391e7 common
>>   packet:   fetch-pack< ACK 5f480935d3ce431c393657c3000337bcbdbd5535 common
>>   packet:   fetch-pack< ACK db81e01b433501b159983ea38690aeb01eea1e6b common
>>   packet:   fetch-pack< ACK 06c44b8cab93e780a29ff7f7b5b1dd41dba4b2d5 common
>>   packet:   fetch-pack< ACK 65f3966becdb2d931d5afbdcc6a28008d154668a common
>>   packet:   fetch-pack< ACK 10e8caef9f2ed308231ce1abc326c512e86a5d4c common
>>   packet:   fetch-pack< ACK 6b55dd91f2e7fc64c23eea57e85171cb958f9cd2 common
>>   packet:   fetch-pack< ACK 6b55dd91f2e7fc64c23eea57e85171cb958f9cd2 ready
>>   packet:   fetch-pack< NAK
>>   packet:   fetch-pack< ACK 6b55dd91f2e7fc64c23eea57e85171cb958f9cd2
>>   fatal: git fetch-pack: expected shallow list
>>
>> So we see that upload-pack sends a bunch of detailed ACKs, followed by a
>> NAK, and then it sends another ACK.
>>
>> Fetch-pack is inside find_common, reading these acks. At the beginning
>> of each stateless-rpc response, it expects to consume any
>> shallow/unshallow lines up to a flush packet (the call to
>> consume_shallow_list). And then it reads the acks in a loop. After it
>> sees the NAK, it assumes that the server is done sending the packet, and
>> loops again, expecting another set of shallow/unshallow lines. But we
>> get the next ACK instead, and die.
>>
>> So who is wrong? Is upload-pack wrong to send an ACK after the NAK?
>
> 3e63b21aced1 (upload-pack: Implement no-done capability, 2011-03-14)
> claims that the above sequence of acks and naks is what upload-pack
> wants to show.
>
> What happens when you disable no-done extension handling on the
> server end, I wonder?

fetch succeeded when no-done was disabled. An immediate workaround
would be disable no-done in fetch-pack.c in a shallow repo but maybe
we can do better..
-- 
Duy
