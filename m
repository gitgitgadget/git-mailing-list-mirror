Received: from kaefer-engelbart.com (kaefer-engelbart.com [217.76.55.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133D3EA77
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.76.55.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529259; cv=none; b=ON7FjWFF49JD0Irx5hznbGQMj/FxDiYwBj3LnV6Ud3aqDqM4K3dVlDBdGiK/28TToAkjetn95U3VH8AdY3NMC8a3SMdb6bJb70HvHPdefwa+H2Pg4JEJPgaJwgrD/Zs1vuQWggMgBnKbBAu6kbNIAtcnUx8mCQZ6Dm1kxGwRBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529259; c=relaxed/simple;
	bh=eYtpzRy0WQNmeiCSY0B3YKKLVGEKmdu9N7KIQSZdf40=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=fqNahtX3X7U7oUUW+Sbn36VUxR184+gG1/fdBKMKFgQbO0ubVVFpAE/dXlRalMisDyuNiiSh6r976DeFYL+rqSegvGT/w/RVokR7danm+q04XtCcuFlGIObF40vFEMD7PRraoB34VVWe6dsXmzCzuX2Xya2KKpV/ZMQ/8qUM9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kske.dev; spf=pass smtp.mailfrom=kske.dev; dkim=pass (2048-bit key) header.d=kske.dev header.i=@kske.dev header.b=gBzKNjpY; arc=none smtp.client-ip=217.76.55.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kske.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kske.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kske.dev header.i=@kske.dev header.b="gBzKNjpY"
Received: from [IPV6:2003:e4:a702:8500:8c8f:a1c1:d0a0:5e6c] (p200300e4A70285008C8Fa1C1D0a05E6c.dip0.t-ipconnect.de [IPv6:2003:e4:a702:8500:8c8f:a1c1:d0a0:5e6c])
	by kaefer-engelbart.com (Postfix) with ESMTPSA id 8BF4A1A022A
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kske.dev; s=mail;
	t=1710528938; bh=eYtpzRy0WQNmeiCSY0B3YKKLVGEKmdu9N7KIQSZdf40=;
	h=Date:From:Subject:To:From;
	b=gBzKNjpYATnVjmFgvV9q71sseyomthcC2LsBynNd5RuNr2+Ho/l0aPdvyEmiiYiz4
	 mtlVFODU/ug8aHWn4rmWFrjx0Yhg8gqiQseOeGmu3pdL6a0AbU67UD/MTRf0c79roo
	 UQBnMyazA6nYm17dOMPxc/z0leTiEHVcm1cBAmVc3Qxdor+cSrWRf8D3qzZhktMDZY
	 7kE6zZpOq62Nypff9CnXKByg7oeNCW+KLVZonqjgvoSA/bmd0Rca4jW7YrJFfREWTq
	 rruKVLNXgZrUPKyLfMlW5/IPZHYejwRzJFIDU51aXlJ5iaPTCWg4ZmEwYCTM7E/EzY
	 eFyfO+ODXUEVQ==
Message-ID: <5f4701bf-3121-4c78-90c8-b1f3a942512b@kske.dev>
Date: Fri, 15 Mar 2024 19:55:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: leon <leon@kske.dev>
Subject: [Idea] Only allow commits when no undeletable file has been deleted
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I have an idea for a feature I am missing often enough within Git (and 
it **needs** to be part of Git itself as it would be rather useless 
within third-party tools):
Oftentimes, when you have submodules, you are depending on specific 
files being present within them, i.e. so that your Shell scripts and/or 
CI tools work correctly.
However, especially when the submodule is under your own control, you 
currently have no option to tell future collaborators that deleting or 
renaming such a file will break things.
Or even your future self, FWIW.
So, what if there was a recognized attribute within the `.gitattributes` 
that said `files matching this path spec cannot be deleted`?
The actual content of the file is irrelevant as long as it exists.
I don't care how this attribute is called in the end and cannot think of 
any good name.
My best approach was something like `depended-on-externally` or 
`undeletable`.

My proposed behavior is thus the following:
- Git stores the list of files from HEAD that may not be deleted somehow 
(probably best to compute it on the fly when necessary)
     - To allow for deleting a file in the same commit as removing its 
`.gitattribute` entry, the list of files that cannot be deleted depends 
on the `.gitattributes` as it should be committed.
- When you try to create a commit, all undeletable files are checked for 
if they still appear in the tree
- If files are no longer present in the tree, the commit is aborted with 
an error message telling the user something like `You are trying to 
delete the undeletable file <x>/ files <x, y, z>. Either restore 
it/them, or remove <corresponding path specs> from the '.gitattributes'`
- In particular, this means the following behavior for changes:
     - Adding a new file: Nothing to do
     - Deleted file: Checking if it can actually be deleted
     - Renamed file: Checking if another file replaced it
- No idea how to handle path specs pointing inside submodules. I'm fine 
either way:
     - Path specs going into submodules are ignored (more performant, 
plus you cannot influence them directly)
     - Path specs going into submodules are checked too (helps catch 
bugs early as an error can only happen when you update the submodule. As 
such, you'll quickly know that you just broke something)

Drawbacks of this approach:
- `git commit` will be slower. Don't know how much, probably depends on 
the implementation

Advantages:
- You can ensure that you don't accidentally break something in other 
repos (or even your own, if you have enough dependencies on your own 
filenames…)

So, what do you think?

