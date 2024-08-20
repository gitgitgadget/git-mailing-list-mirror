Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB728E8
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137844; cv=none; b=h4e7JmKneJeHyjAzoh6Jx0OQPWneGoQcF94vn163MyCHpFZH30maNoYPzY/c6zaTmpFM473QtTNd6enQ7aII6dPsT4OXczgnuIeyjCcfLGqzw3UeiKRjBl8hn8p8uZqbxFOb71zs8DaZZjRKRxmaBQoZieHezDYBlCBpZ9gH61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137844; c=relaxed/simple;
	bh=IuSijI2Dsgns7qwjilBzoXeTnBozr/L3Rig7h0W2K/A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ioDNo+nUadiyZOv1RHnSwd8Dn4E9cMptbfrTryxmY/qDCJCgzCFD3Jec3MOwUHiwAG5d9bt/YLO93UfAG/X/wyMS0X2gs9DpavoN7/0YEmOAWFgYJ4pM3aDd71gLVRDRE6HFJxlsq5yO9EplPQ2+WkZC9LwFiXalpBtHyXVDNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from [192.168.10.169] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 295163F003;
	Tue, 20 Aug 2024 09:10:38 +0200 (CEST)
Message-ID: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org>
Date: Tue, 20 Aug 2024 16:10:34 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org, debian-devel@lists.debian.org
From: Simon Richter <sjr@debian.org>
Subject: Representing Debian Metadata in Git
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

there's a bit of a discussion within Debian on collaborating using Git.

One of the long-standing issues is that there are multiple ways Debian 
packaging can be represented in a git tree, and none of them are optimal.

The problem at hand is that the packaging workflow consists of

1. importing an upstream release
2. optionally stripping out undistributable parts
3. adding packaging metadata
4. optionally adding a patch stack

The workflow for upgrading a package is

1. import a new upstream release
2. apply and possibly modify the exclusion list
3. apply the packaging metadata, updating it in the process
4. rebase the patch stack

Right now, git is used mainly as a network file system, and only tagged 
releases are expected to be consistent enough to compile, because often 
going from one consistent state to another as an atomic operation would 
require multiple changes to be applied in the same commit.

The imported archive is represented either directly as a tree (which may 
be imported from the upstream project if no files are undistributable 
for Debian), or via a mechanism that can reproduce a compressed archive 
that is bitwise identical to the upstream release, from a tree and some 
additional patch data.

The patch stack is stored as a set of patches inside a directory, and 
rebased using quilt.

An alternate representation stores the patch stack as a branch that is 
rebased using git, and then exported to single files.

The Debian changelog is stored as a file inside Git, but some automation 
exists to update this from Git commit messages.

Debian changelog entries refer to bugs in the Debian Bug Tracking 
system. There is a desire to also incorporate forges (currently, GitLab) 
and refer to the forges' issue tracker from commit messages (where the 
issue tracker is used for team collaboration, while the Debian BTS is 
used for user-visible bugs).

All of this is very silly, because we're essentially storing metadata as 
data because we cannot express in Git what we're actually doing, and the 
conflicting priorities people have have led to conflicting solutions.

I'd like to xkcd 927 this now, and find a common mapping.

 From a requirements perspective, I'd like to be able to

  - express patches as commits:
    - allow cherry-picking upstream commits as Debian patches
    - allow cherry-picking Debian patches for upstream submission
  - generate the Debian changelog from changes committed to Git
  - express filter steps for generating the upstream archive(s) from a 
tree‑ish and some metadata
  - store upstream signatures inside Git
  - keep a history of patches, including patches applied to previously 
released packages

A possible implementation would be a type of Git "user extension" object 
that contains

  - an extension name
  - an object type (interpreted by the extension)
  - type-tagged references to other objects
  - other type-tagged data

Validity of the object would be determined by the extension, and git 
would treat this object as mostly opaque (i.e. whenever one is 
encountered, the extension needs to be called). The only exception would 
be references, because we need to be able to transfer these objects and 
all their dependencies efficiently (so the extension would generate a 
list of references that should be recursively packed or omitted).

On top of that, we could represent a Debian package through special 
objects, such as

  - debian::debian-dir (a tree-like object referenced from the root 
tree, contains a tree for plain files plus links to special objects for 
generated items, such as patch stacks)
  - debian::upstream-archive (a tree-like object that marks the boundary 
between objects imported from upstream, and objects that are part of 
packaging, and gives instructions for regenerating the upstream archives 
without storing them as blobs)
  - debian::update-upstream (a commit-like object to move to a new 
upstream-archive object, this contains the upstream version number that 
the following upload object must use)
  - debian::changelog-entry (a commit-like object that adds an item to 
the Debian changelog)
  - debian::upload (a commit-like object that adds a version to the 
Debian changelog)
  - debian::rebase-patches (a commit-like object that links the patch 
stacks before and after a rebase)
  - ...

Changes to packaging would still be represented as commit objects 
containing a tree, but that tree would contain a special entry for the 
"debian" subdirectory that points to the last packaging change.

This is very high-level so far, because I'd like to get some feedback 
first on whether it makes sense to pursue this further. This would use 
up the last unused three-bit object type in Git, so it will have to be 
very generic on this side to not block future development -- and it 
would require a lot of design effort on the Debian side as well to 
hammer out the details.

Any feelings/objections/missed requirements?

    Simon
