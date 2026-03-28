Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC9199949
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774710016; cv=none; b=CC3fpZxpxZeNraYFRtIetLg3TTTy4HIMdVO390cQqHp8Tb6TxdWe27jqogRAOZ4bGxYyUlhxtNnuKvwob8XYblQZNggeKkp5/hFEOIU0OHZR0wbJ2EM1F+2sjbrxNpDia71hvzcIJVcV3h3hq3SquPzHmOdDftgYG6IZQ7ofACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774710016; c=relaxed/simple;
	bh=C7OJ1wfem/kgsCmc2SzijvYyXkeWX8IxvBB6npgkZeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obrMfFnzxt9+RAVUYPM1764WW8KiZ1MWFj65BVo00EYWrn8+sV7pLL5U6cUYpu6iUUW5t8QQykR8VmotL7aB3qrNAeEG4JXekjLhve77rePRIBg6K4k0qxKWjUXUMdQoBchBReUH9Zk0Y7CUXGY70IWAuJGDSCUaeM3K2SY2Cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=opperschaap.net; spf=unknown smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=opperschaap.net
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fjgfN3c3vz9tMN;
	Sat, 28 Mar 2026 15:59:56 +0100 (CET)
Message-ID: <3d8c9b3f-66d0-460d-bd61-a879a6bbfc56@opperschaap.net>
Date: Sat, 28 Mar 2026 10:59:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org> <xmqqbjg9mex2.fsf@gitster.g>
 <09c5fe7d-8379-4f68-bf1c-9869e2924cb8@opperschaap.net>
 <becf040c-b425-4fd1-affa-b6368c812b42@kdbg.org>
Content-Language: en-US
From: Wesley <wesleys@opperschaap.net>
In-Reply-To: <becf040c-b425-4fd1-affa-b6368c812b42@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/26 03:46, Johannes Sixt wrote:
> Am 27.03.26 um 17:49 schrieb Wesley:
>> On 3/27/26 12:10, Junio C Hamano wrote:
>>> I somehow thought that this practice is so widespread that it was
>>> one of the few first things any new people learn to do, but perhaps
>>> we do not have a good documentation coverage?
>>
>> As said before it is weird thing to configure a global ssh configuration
>> just for git transport. It doesn't make much sense.
>>
>> The problem with ssh_config usage is that you need to change your ssh
>> config, which is machine global, not just git.
> 
> Are thinking about the SSH configuration in /etc/ssh? You do not have to
> change that. There is also a .ssh/config in the user's home directory.
> That configuration isn't machine global, it's obviously per user. And
> the way to make the configuration work only for Git is precisely to use
> fake host names that are only used in remote URLs of Git repositories.

I refered to that as the .ssh/config unit. But /etc/ssh/ssh_config is a 
more global setting indeed.

>> And not portable across
>> teams with configurations committed to git. Myrepos is a good example of
>> this. My former employer had this and I know the Perl metacpan project
>> also uses mysrepos. Changing every URL dynamically in committed configs
>> isn't really a nice ask.
> 
> I cannot comment on this, because I do not know these tools.
> 
> There are ways to achieve a considerable amount of customization of SSH
> connections with existing tools. If you need additional features, you
> should sell your change with a more specific justification, including
> examples that show reviewers who do not know the tools you are using
> what is needed, but missing.

The ways to do it all involve configuring ssh to configure git, instead 
of configuring git to configure git. The remote is already configured in 
git, having your sshIndentityFile and possible other options close to 
that configuration is beneficial to users. The escape-hatch of 
core.sshCommand doesn't need to be utilized for a simple "Use this 
indentityFile on this remote".

The only way to configure git without touching ssh is to fiddle with the 
core.sshCommand, which I did in my own zsh script. This script also 
utilized the git config, I used my own namespace for this, which in this 
patch became "core". The whole idea was: git owns git operations, thus 
the config should live in git.

The need for me arose precisely because upstream encoded git repos on a 
forge where my personal projects also resided and forced me to create a 
second account. Having to change ssh config was to me the wrong knob to 
turn. I fixed it years ago, and while refactoring it I thought the 
pattern would be helpful for every git user resulting in the above patch.

I think this is helpful for freelancers who have multiple clients and 
don't feel the need to add a specific host in their .ssh/config for each 
client. They can includeIf it, setting repos with a particular "owner" 
to a specific identity file or they can set it on remote level basis if 
the need is there. That is why the cascading configuration was added.

There is no need to configure both ssh and possible git with rewrite 
rules with this patch. Which to me is a cleaner solution. One knob in 
git for git.

Cheers,
Wesley

-- 
Wesley

Why not both?
