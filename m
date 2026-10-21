Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.107.222.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604378;
	b=xOlAEpm8/EXal/z2e08QqHjE2jo9Zs2yK9ivGUyO1Dd9c3FEPAlBxwANECHtCukwooHl
	 0uiR4Sbn6Z8xlfYQpJAJXUq3CsJ2e2/u0eQ3HsAi+TChMDkXBcbstG+l6JTwqqXOJomfF
	 xEbHUPotettuMM6ACyDNIkPsix5p3iqSWiN6g15KvkrkU0btuOymSeWU6FkuZ+cPL0lxC
	 QQCk6YCNrLnQk8c9jvJOmQICbsk7Z+oxut6vg6yoD/HYHqkKXV//6VDTLKEoBOAlaqELo
	 dZy4WxI33J/R/WupHdNHfxOyvQ0SBtLpjNt00/FzxxUToCgz3GWw84NOjZOpGkH3p3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604378;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:Content-Language:Content-Type:
	 Content-Transfer-Encoding;
	bh=0uNcyODTkLsW1fAdWPYWlRUDS9supBNam+H5e6ihd+4=;
	b=3+RWbxEoST/1EHFMprD4deOpAcR7OlCj2NxOFdXSp0Uf6eWxDbowIg1q/X3m3t7JuxYO
	 budsXbMyodqM3jRJ5uwFRBxq69TEUJukL6OvFAgzCG/UpD4ku++3SNGle/OPjFBmXrQhN
	 p9XvkWfKfQmWt1QFfmWSvqvjXMyaRQ6o1ax9emCmsXqu+csbtzFf5rzcfYNmeG0YiAawh
	 53i9Qn51Cmc2GmdmY+bgYrjh6lQYoIpZkIF5a2tNrlw8FpYd4KVsrvKdR1MOqvpfhHEpj
	 aDtp2dg/LVNiiZx6VtU+vopOIFY67wBZqKCHIYgEGFNVcAxeOaBh6cpoZg5WvGXVZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zombino.com;
	spf=pass smtp.mailfrom=zombino.com;
	arc=none smtp.remote-ip=91.107.222.152
Received: from mail.zombino.com (c3.zombino.com [91.107.222.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF8606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68CF8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zombino.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zombino.com
Received: from [192.168.0.135] (ipservice-092-209-243-142.092.209.pools.vodafone-ip.de [92.209.243.142])
	by mail.zombino.com (Postfix) with ESMTPS id 679631BFBD71;
	Wed, 21 Oct 2026 17:39:28 +0000 (UTC)
Message-ID: <ce3756bc-704c-41ff-bf8a-c060a2848aeb@zombino.com>
Date: Wed, 21 Oct 2026 19:37:13 +0200
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Adam Majer <adamm@zombino.com>
Subject: discussion: sha1/sha256 repositories and convert_commit_object
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm been experimenting with having both OID types in a repository. 
First, I tried nodejs, which failed due to missing submodules, so I 
could not import it.. Then I tried linux. This proved somewhat more 
problematic.

I've been using convert_commit_object to convert a commit from one OID 
type to another. The current implementation of convert_commit_object 
function has some comments about requiring to convert all types of OID 
references. These includes mergetag and it just bails on other, unknown 
headers.

In the linux tree, some dozen or so mergetags contain references that do 
not seem to be fetchable from anywhere.

Also, a number of commits in linux history contains these unknown headers:

ab5af2903baa472930c94a421efdd22a49036213:
   predecessor bc6a71940d5182103469a479d12f4266ac155a39
   predecessor-op rebase

3a413ece2504c70aa34a20be4dafec04e8c741f9:
   predecessor 86d97728d053d6584be5592480ff3687d3d616ab
   predecessor-op amend

And the objects references here are unavailable.


How can we deal with these if we ever want to have the sha1-sha256 
interop? If we require stubborn adherence to 1-1 mappings of all OIDs, 
these repositories cannot ever be imported into sha256 repositories with 
their histories. Even recent commits cause issues here as git is not 
holding on to referenced objects.

Would it be possible to have a little different approach? For example, 
mergetag headers and other unknown headers, maybe we can consider these 
as just text and copy verbatim in convert_commit_object? I understand 
this would result in different commit ids, depending if coming 
originally from sha256 or sha1 repo, but since git is not really 
preserving references to these objects anyway, this may call for a 
little flexibility.

Best regards,
- Adam
