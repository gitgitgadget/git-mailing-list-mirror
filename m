Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50706F4F6
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="QIDzT/Az"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2023082200; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=45glwtULkTbB/HlGGF4VwAfVKm+TpOG9AQip13j2+LE=; b=QIDzT/
	AzG6IyqT0fi8bK3+kLlJU2d0Lp3A/LFiRg7BPksISgcGczWHhTnrXuvGj0xo0KN+B3CZZCZwL/NOa
	VLFLxp1Svt+wuXW5PZjqEMXzS6p9VNh1yhgPVIT9rd7fQjVC8g0eihdZgr66642xrOm8VfG9CMFUz
	PhZ2w/zrfTM=;
Received: from host-92-26-4-33.as13285.net ([92.26.4.33] helo=[192.168.1.112])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1rIsOG-00087j-Ec;
	Thu, 28 Dec 2023 15:33:45 +0000
Message-ID: <0438051f-7943-46df-bea7-7b790cddd72b@iee.email>
Date: Thu, 28 Dec 2023 15:33:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git Rename Detection Bug
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: Jeremy Pridmore <jpridmore@rdt.co.uk>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Paul Baumgartner <pbaumgartner@rdt.co.uk>
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
 <990ab7d5-e29a-4766-b112-c8908a7ed196@iee.email>
 <CABPp-BEdSGBt7DCrJCmOtG+RgZ2F3fNZQJ91PjZQxNa-ShKf8g@mail.gmail.com>
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CABPp-BEdSGBt7DCrJCmOtG+RgZ2F3fNZQJ91PjZQxNa-ShKf8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Elijah,
Many thanks.. personal notes in-line.

On 24/12/2023 07:46, Elijah Newren wrote:
> Hi Philip,
> 
> Sorry for the late reply; I somehow missed this earlier.
> 
> On Wed, Nov 15, 2023 at 8:51 AM Philip Oakley <philipoakley@iee.email> wrote:
>>
>> Hi Elijah,
>>
>> On 11/11/2023 05:46, Elijah Newren wrote:
>>> * filename similarity is extraordinarily expensive compared to exact
>>> renames, and if not carefully handled, can sometimes rival the cost of
>>> file content similarity computations given our spanhash
>>> representations.
>>
>> I've not heard of spanhash representation before. Any references or
>> further reading?
> 
> You can find more in diffcore-delta.c, especially the big comment near
> the top of the file.

+1

>         But here's a short explanation of spanhashes:
>   * Split files into chunks delimited either by LF or 64 bytes,
> whichever comes first.

neat


>   * Hash every chunk into an integer between 0 and 107926

as per the comment, this is 1 less than a nice prime 107927 that fits
17bits.
Some discussions at
https://lore.kernel.org/git/7vwtezt202.fsf@assigned-by-dhcp.cox.net/ and
surrounding  messages.

The hash is very similar to a CRC, a rotating 64bit value, using 7 bit
shifts and a 8bit char addition, then reduced to a hash computed at ~#L157

>   * Keep a character count for each of those integers as well (thus if
> a line has N characters, but appears twice in the file, the associated
> count for that integer will be 2N).
>   * A "spanhash" is the combination of the integer that a chunk (or
> span) hashes to, plus the count associated with it.
>   * The list/array of spanhashes for a file (i.e. the list/array of
> integers and character counts) is used to compare one file to another.

I was surprised to see that I'd been in the area at #L162 ;-)

Thank you for the useful summary.


> 
> Now, why do I claim that comparison of filenames can rival cost of
> file content similarity?  Well, in a monorepo of interest, the median
> sized file is named something close to
> "modules/client-resources/src/main/resources/buttons/smallTriangleBlackRight.png"
> and is 2875 bytes.  As a png, all its chunks are probably the full 64
> characters, which works out to about 45 chunks (assuming the 64-byte
> chunks are different from each other).  The filename is 79 characters.
> So, for this case, 45 pairs of integers vs 79 characters.  So, the
> comparison cost is roughly the same order of magnitude.
> (Yes, creating the spanhashes is a heavy overhead; however, we only
> initialize it once and then do N comparisons of each spanhash to the
> other spanhashes.  And we'd be doing N comparisons of each filename to
> other filenames, so the overhead of creating the spanhashes can be
> overlooked if your merge has enough files modified on both sides of
> history.)

Nice point about the hashes only being computed once.

> 
> Yes, this particular repository is a case I randomly picked that you
> can argue is special.  But rather than look at the particular example,
> I think it's interesting to check how the spanhash size vs. filename
> size scale with repository size.  From my experience: (1) I don't
> think the median-sized file varies all that much between small and big
> repositories; every time I check a repo the median size seems to be
> order of a few thousand bytes, regardless of whether the repository
> I'm looking at is tiny or huge, (2) while small repositories often
> have much shorter filenames, big repositories often will have
> filenames even longer than my example; length of filename tends to
> grow with repository size from deep directory nestings.  So, between
> these two facts, I'd expect the filename comparison costs to grow
> relative to file content comparison costs, when considering only
> median-sized files being modified.  And since it's common to have
> merges or rebases or diffs where only approximately-median-sized files
> are involved, I think this is relevant to look at.  Finally, since I
> already had an example that showed the cost likely roughly comparable
> for a random repository of interest, and it's not even all that big a
> repository compared to many out there, I think the combination
> motivates pretty well my claim that filename similarity costs _could_
> rival file content similarity costs if one wasn't careful.
> 
> I don't have a rigorous proof here.  And, in fact, I ended up doing
> this rough back-of-the-envelope analysis _after_ implementing some
> filename similarity comparison ideas and seeing performance degrade
> badly, and wondering why it made such a difference.  I don't know if I
> ever got exact numbers, but I certainly didn't record them.  This
> rough analysis, though, was what made me realize that I needed to be
> careful with any such added filename comparisons, though, and is why
> I'm leery of adding more.

Thanks again.
