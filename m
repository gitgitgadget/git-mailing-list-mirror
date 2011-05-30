From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Mon, 30 May 2011 22:23:21 +0200
Message-ID: <4DE3FCB9.1010401@kdbg.org>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com> <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org> <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	Theo Niessink <theo@taletn.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon May 30 22:23:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8zs-0006Nx-VL
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 22:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab1E3UX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 16:23:27 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:27813 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751011Ab1E3UX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 16:23:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0B166A7EB4;
	Mon, 30 May 2011 22:18:54 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A993219F3CC;
	Mon, 30 May 2011 22:23:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174776>

Am 30.05.2011 11:32, schrieb Erik Faye-Lund:
> On Fri, May 27, 2011 at 8:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 27.05.2011 18:00, schrieb Erik Faye-Lund:
>>> If someone manage to create a repo with a 'C:' entry in the
>>> root-tree, files can be written outside of the working-dir. This
>>> opens up a can-of-worms of exploits.
>>>
>>> Fix it by explicitly checking for a dos drive prefix when verifying
>>> a paht. While we're at it, make sure that paths beginning with '\' is
>>> considered absolute as well.
>>
>> I think we do agree that the only way to avoid the security breach is to
>> check a path before it is used to write a file. In practice, it means to
>> disallow paths in the top-most level of the index that are two
>> characters long and are letter-colon.
>>
>> IMHO, it is pointless to avoid that an evil path enters the repository,
>> because there are so many and a few more ways to create an evil repository.
>>
> 
> Yes, but this patch doesn't prevent that; it prevents an evil path
> from entering the index and from being checked out if the index is
> evil.
> 
>>> diff --git a/read-cache.c b/read-cache.c
>>> index f38471c..68faa51 100644
>>> --- a/read-cache.c
>>> +++ b/read-cache.c
>>> @@ -753,11 +753,14 @@ int verify_path(const char *path)
>>>  {
>>>       char c;
>>>
>>> +     if (has_dos_drive_prefix(path))
>>> +             return 0;
>>> +
>>
>> Isn't verify_path used to avoid that a bogus path enters the index? (I
>> don't know, I'm not familiar with this infrastructure.)
>>
> 
> Yes, it's being used to do that. But it's also being used when reading
> the index into memory, which is "the good stuf" for our purposes.

OK, I agree with the changes proposed in this patch. git reset and git
checkout go through this function via unpack_trees(). Are there other
ways to write a file, e.g., in merge-recursive?

-- Hannes
