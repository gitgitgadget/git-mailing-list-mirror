Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=guillaume.yziquel@mailfence.com header.b="ixYmCOFE"
X-Greylist: delayed 362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 04:19:36 PST
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42010CE
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 04:19:36 -0800 (PST)
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id E5D161E4E
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 13:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700741611;
	s=20210208-e7xh; d=mailfence.com;
	i=guillaume.yziquel@mailfence.com;
	h=MIME-Version:From:To:Subject:Message-ID:Date:Content-Type:Content-Transfer-Encoding;
	l=1402; bh=RjZ6DVTeneE0SXwRCbQWk1ldZW1vnbReYQJNKwqbWoA=;
	b=ixYmCOFEW0+BcRadn9S/O9AJ7zod7PaF7SyH6YdwIfX3ijR4bbYFREa/eJjZwFn6
	GFCpFQ0s7qWWo3fT1+mOtetzDer264vBPrnYSG15HE8d5OoGWKgf5dIDikAXDTBlVkR
	YRX/M26PMt8YRzatqD2FGoms/IOmoRHTT+u8bumw2WUu/UUQMUo3XMsYvNL21J05YDd
	yzvvKc7IGLWC+920ci9H5UFZqaCCT58m7iQrYRU2DioXAUAZ/KJFn3yrd45+ehP9gkE
	8AxwCkKSeb9AvFSJyjcfC9MuGCGTEoJOqkQ7G+OCu6KfEpj+JDhoP3XFFLlPXAgNoOp
	9cvoNrGrTw==
Received: by smtp.mailfence.com with ESMTPSA
          for <git@vger.kernel.org> ; Thu, 23 Nov 2023 13:13:27 +0100 (CET)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: guillaume.yziquel@mailfence.com
To: git@vger.kernel.org
Subject: [BUG?] Semantics of HEAD when bare cloning non-bare repositories
Message-ID: <179a3f7b2605b295.375e54053ab898bd.31bd44aeb0344c08@hilbert>
Date: Thu, 23 Nov 2023 12:13:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:454061815

Hi.

Observation: When git clone --bare is used on a non-bare repo, the HEAD is put in ./refs/HEAD, and conflicts with ./HEAD in the sense that they may end up decorelated over time.

Suggestion: When bare cloning on a non-bare repo, do not put the HEAD of the non-bare repo in refs/HEAD like every branch, but treat it separately: put it in ./HEAD, not ./refs/HEAD.

Context: I was setting up an alternate repository for cargo crates, which requires a git repo to hold the index. So I wrote my config.json in a non-bare git repo, and "deployed" as a bare repo by git clone --bare. This created a ./refs/HEAD. However, the cargo crates repository I deployed (ktra) also updated the HEAD of that repo whenever I published private crates on it. So HEAD and refs/HEAD were not in sync. And, in the end, these got unsynchronised and I could not perform cargo fetch or cargo build with this alternate repo.

Ratonale: HEAD is just not a normal branch, semantically. It is what you have at the tip of your fingers in the shell with non-bare git repos. Treating as "just as all other branches" may be programatically convenient, but, in the end, it bypasses the fact that it just is not quite a normal branch. As the problem I experienced highlights. Which is why I would argue in favour of a distinguished treatment of HEADs when bare cloning a non-bare repo.

Best regards,

Guillaume Yziquel.
