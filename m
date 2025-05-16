Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE4227B9A
	for <git@vger.kernel.org>; Fri, 16 May 2025 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439033; cv=none; b=j3il8P6mWL08bVcVIhrAfKM0hlOvbKY0YbuPU9xU8wyODIOefq/jWqJRQJUzsLemWPW7k3BPS6poUhv6X0OjdMH5oLwrbtskJ0KyB5p0ft+WaGGRtdLq+cryh/l1jGp3+KyniDbIM01Hsz1RLxcJrzuqNkJ33mPO2wArCl000hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439033; c=relaxed/simple;
	bh=6wnSHtVsRAwsSOVp2SukPxtm0BpW1eUvtAVen/s5zK0=;
	h=To:From:Subject:Date:Message-ID:Mime-Version:Content-Type; b=IUs9/L4XjsrmlfSvAJJQqmzQu7zYd0J7Q7n7y73upgC+GtcXfLY0gpy1gHY2A1Hv4+ET/JtvTeczvc6fLdD8HYSREg1af3OfvZFR2rsaFEmQ2kDQL1PWd+zbE9x/fgSrEdf1gOugdmDw2jQNfw62ZzlmNjwluz/mHM8Mb9GGZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcvg-git-3@m.gmane-mx.org>)
	id 1uG4iO-0001p2-F1
	for git@vger.kernel.org; Sat, 17 May 2025 01:43:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
From: Jon Forrest <nobozo@gmail.com>
Subject: Question About Sorting the Index
Date: Fri, 16 May 2025 16:43:37 -0700
Message-ID: <1008ijb$6j0$1@ciao.gmane.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US

I've learned that entries in the index file "are
sorted in ascending order on the name field".

Am I right in thinking that this means that
every time a file is added to the index by
running "git add" the whole index file must
be resorted? If so, this seems like a lot of
work, especially since not all the entries
are the same size.

Has any thought been made about improving this,
such as perhaps having an "index index"? This
would be a separate file that contains the name
field of each entry, the location of where the entry
starts in the index, and the length of the entry.
I'll call this a partial index entry.
The "index index" would also be sorted by the name field.

With this approach, running "git add" would simply
append a full index entry to the index, and
append the partial entry to the "index index", which
would then be sorted. The full index would not be
sorted. I'm guessing this is the common path.

To delete a file from the index, I'd propose adding an
"deleted" bit to the full cache entry. When "git rm --cached"
is run, 2 things would happen:

1) The "deleted" bit would be turned on in the full index
entry for the file. The index itself will not be sorted.
Every so often, perhaps when "git fsck" is run, these
entries could be deleted. The full index won't have
to be resorted when this happens because it won't be
assumed to be in sorted order any longer.

2) The "index index" would be modified by removing the
partial entry for the file. This could be done by
writing the partial entries up to the entry being
deleted, and then the entries following. No sort would
be necessary because the "index index" is already sorted.

One drawback of this approach would be that since the "index index"
entries also won't be the same length, sorting it will still require
extra work. However, this wouldn't be any harder then sorting the full
index, and a lot less data wouldn't have to be moved around.

All this is so simple that I suspect that it's been considered before.
Am I missing something?

Cordially,
Jon Forrest

P.S. I'm trying to read the Git source code to get a better handle
on what actually goes on in the index but this is taking some time.







