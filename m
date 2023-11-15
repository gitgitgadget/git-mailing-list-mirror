Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C733069
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="sxt6pEIp"
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015EAAB
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2023082200; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=d+pZO9/v2PTjXb3ifOLMjRekLAJIgUnLCBlcyUwnHYA=; b=sxt6pE
	IpKhl8OEjIMYdGsRV+FPXMNiWuMClqmn5CP2vWZVa5KnYaVKRcaQYQqsYRc7C+UkWPTxzPhkef3Pp
	MOMufH6Dqn9fpxZon5TJVvpiTDRa4t3t19I8TLOx4/yEMUBTNWNbZVrh8uHmr1vZ5VpWNPAJbMlrY
	+GB61ZOFI+E=;
Received: from host-2-103-195-242.as13285.net ([2.103.195.242] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1r3H0E-0000Md-Dj;
	Wed, 15 Nov 2023 14:36:26 +0000
Message-ID: <781fc667-6597-4327-80d5-721fb273d2e2@iee.email>
Date: Wed, 15 Nov 2023 14:36:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git Rename Detection Bug
To: Elijah Newren <newren@gmail.com>
Cc: Jeremy Pridmore <jpridmore@rdt.co.uk>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Paul Baumgartner <pbaumgartner@rdt.co.uk>
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
 <9baca4af-a570-4b7a-a1ee-de91b809e79c@iee.email>
 <CABPp-BEtva2WTGQG3Qs4EbZLK_RJC9vuA-2OYxkTPExgowwvqQ@mail.gmail.com>
Content-Language: en-GB
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CABPp-BEtva2WTGQG3Qs4EbZLK_RJC9vuA-2OYxkTPExgowwvqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Elijah,
sorry for the delay in replying.

On 11/11/2023 15:13, Elijah Newren wrote:
> Hi,
> 
> On Sat, Nov 11, 2023 at 3:08 AM Philip Oakley <philipoakley@iee.email> wrote:
>>
>> Hi all,
>>
>> On 11/11/2023 05:46, Elijah Newren wrote:
>>> The fact that you were trying to "undo" renames and "redo the correct
>>> ones" suggested there's something you still didn't understand about
>>> rename detection, though.
>>
>>
>> Could I suggest that we are missing a piece of terminology, to wit,
>> BLOBSAME. It's a compatriot to TREESAME, as used in `git log` for
>> history simplification (based on a tree's pathspec, most commonly a
>> commit's top level path).
> 
> We could add it, but I'm not sure how it helps.  We already had 'exact
> rename' which seems to fit the bill as well,

My point was that we already had the confusion of mental models, with
both sides essentially thinking they had an "exact rename", hence my
thought was to add a rather distinct technical name which reflected the
Git mind-shift. Without something to bring folks up short they'll
continue, erroneously, with their prior mental models.


 and 'blob' is something
> someone new to Git is unlikely to know.

I'd agree that BLOBSAME is new, but we should be proactive in ensuring
folk do have the mind shift from the old centralised VCS misunderstandings.

> 
> Perhaps it's useful in some other context, though?
> 
>> File rename, at it's most basic, is when the blob associated with that
>> changed path is identical, i.e. BLOBSAME. There is no need to 'record'
>> the action of renaming, moving or whatever, the content sameness is
>> right there, in plain sight, as an identical blob name.   After that
>> (files with slight variations) it is a load of heuristics, but starting
>> with BLOBSAME we see how easy the basic rename detection is, and why
>> renames (and de-dup) don't need recording.
> 
> This is incorrect.  Let's say you have a file foo:
>    * base version: foo has hash A
>    * our version: foo has been renamed to bar, but bar still has hash A
>    * their version: foo has been modified; it now has hash B
> 
> The foo->bar is an exact rename (or they are BLOBSAME if you prefer),
> but the renaming/moving/whatever is a critical piece of information
> because the changes to foo in 'their' version need to be applied to
> bar to get the correct end results.

Isn't that what I thought I'd said?
Hash A = Hash A => identical content;
Hash A != B => different content.

> 
> I do not know if in Jeremy's case foo has been modified on the
> unrenamed side.  But the following hypothetical is exactly the type of
> problem Jeremy is hitting: what should happen when 'our' version has
> both a new 'bar' and a new 'baz' file that each have hash A?  In that
> case, to which one was foo renamed?  It's inherently ambiguous.

true, the terminology hasn't kept up with the methodology for blob
content, and the independent meta-data. In previous 'ort' discussions I
didn't really understand what the '1/2' renames (and other
nomenclatures) really meant with respect to paths, filenames, content
and the ours / theirs / base distinctions.
> 
>> The heuristics of 'rename with small change' is trickier, but for a
>> basic understanding, starting at BLOBSAME (and TREESAME for directory
>> renames) should make it easier to grasp the concepts.
> 
> Interesting; TREESAME isn't used within directory rename detection
> currently; it is only used currently when two (or three) trees with
> the same name are TREESAME, in order to potentially avoid recursing
> into the tree.  But even then, having two trees with the same name be
> TREESAME isn't enough on its own to avoid recursing into that tree,
> because the other side could have added files within the same-named
> tree and we need to know about those added files because they could be
> part of renames involving other files outside that tree. 

definitely easy to get confused on these cases...

>      There would
> probably be similar challenges to attempting to apply the concept of
> TREESAME to directory rename detection to two trees of different
> names, but it's at least an interesting idea.  Hmm....
> 


Thanks for the insights.

Philip
