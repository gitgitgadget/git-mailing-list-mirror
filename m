Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE451862A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351358; cv=none; b=HLXEGcsseL5roL9jqNSxVB+j/AHgE76VlxcPQwfKJosYhW272wVbxljLH6drbfdaJcuFtKr91UqIzca9UGF12F/6Wdln4LYVyvDMxZ+ZvXsr9z00v9ZE91EAIAFJnHZl5mRXru3iBH8//9Hzp+Q7KjGJ857vXspqiPd0VEEM6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351358; c=relaxed/simple;
	bh=pZPItKLQjeY44eiILGQhWEnYGRMMvRL/VFcV1fp16fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goJ6Nl281hZsW/6R4F/gIum0z6T/AUcKOuqACb4dvU4ZaMvCmA83yZPD6IIjqkWMH6YUsubsCjxIt9i+k03kCRwsyE1zsWiby1SDto9RiHt9oXOYzK/5rLymGVfj/+PJsx6Jmw9PE93fqT7l6Zb61mQBuS2i2dIytZbLHB7FXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=PI0FjYaX; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="PI0FjYaX"
Received: from [192.168.43.16] (unknown [37.168.1.79])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id BBED3B0054E;
	Fri,  6 Feb 2026 05:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770351356;
	bh=pZPItKLQjeY44eiILGQhWEnYGRMMvRL/VFcV1fp16fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PI0FjYaXYGSTHXN9jrABi5nVkxemLlc17F60rrnS8TPTURVhrzAMWR1V/8b3FUeA8
	 BP6vCDDOLrE539PJs8G+KyHLD4f1Cemifd+lquOfY6Dbw25s7V9SUsKWstFKqfCs23
	 hHnsHtLdZnoTuIaS32AqS48YdOZRammyQe66QuBJl8eZcIiWPy5VZipWGzWs+vy38Q
	 3pMhV1K7k0K9bALdPt4qevdm9tXlm21lA6dUVgN4NOjLH3RYP/jy5H7AEKf6oiWrxQ
	 dgO865yS+Aq2Olgpr+GiG6Y+zs/TK22T29v4YiQYXg242/pLaw3oJy+eMkTj0Oe2GJ
	 bAiZlhma8DhRA==
Message-ID: <f6f8c84b-4672-49ac-bda3-0205cdeaff9c@free.fr>
Date: Fri, 6 Feb 2026 05:15:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] config-batch: create parse loop and unknown command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <ecd26a0f1fad5615aea07a388e34f02e9f33b870.1770214803.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <ecd26a0f1fad5615aea07a388e34f02e9f33b870.1770214803.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/02/2026 à 15:19, Derrick Stolee via GitGitGadget a écrit :
> From: Derrick Stolee <stolee@gmail.com>
> 
> As we build new features in the config-batch command, we define the
> plaintext protocol with line-by-line output and responses. To think to the
> future, we make sure that the protocol has a clear way to respond to an
> unknown command or an unknown version of that command.
> 
> As some commands will allow the final argument to contain spaces or even be
> able to parse "\ " as a non-split token, we only provide the remaining line
> as data.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-config-batch.adoc |  23 ++++-
>  builtin/config-batch.c              | 133 +++++++++++++++++++++++++++-
>  t/t1312-config-batch.sh             |  19 +++-
>  3 files changed, 170 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
> index dfa0bd83e2..9ca04b0c1e 100644
> --- a/Documentation/git-config-batch.adoc
> +++ b/Documentation/git-config-batch.adoc
> @@ -13,7 +13,28 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -TODO
> +Tools frequently need to change their behavior based on values stored in
> +Git's configuration files. These files may have complicated conditions
> +for including extra files, so it is difficult to produce an independent
> +parser. To avoid executing multiple processes to discover or modify
> +multiple configuration values, the `git config-batch` command allows a
> +single process to handle multiple requests using a machine-parseable
> +interface across `stdin` and `stdout`.
> +
> +PROTOCOL
> +--------
> +By default, the protocol uses line feeds (`LF`) to signal the end of a

Characters are typefaced as placeholders: _LF_

> +command over `stdin` or a response over `stdout`.
> +
> +The protocol will be extended in the future, and consumers should be
> +resilient to older Git versions not understanding the latest command
> +set. Thus, if the Git version includes the `git config-batch` builtin
> +but doesn't understand an input command, it will return a single line
> +response:
> +
> +```
> +unknown_command LF> +```
>  
This is Markdown. For Asciidoc, use code block:

----
unknown_command LF
----





