Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA26E56D
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="RkwQBs9r"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7E052DF94A1
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 20:05:39 +0100 (CET)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 59AB419F5A5
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 20:05:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1704567932;
	bh=3YL3JTKV7Aw3efdIf9kLRfCFRumMryFjrWSwNlOIIjU=;
	h=Date:From:To:In-Reply-To:Subject:From;
	b=RkwQBs9rHdnFVXXpSNKT/ZpnClc5aAusH57vFrxiT74wjq/eK/LtYKRL1AkWJWQZW
	 2ZSV5HFj6GiAlW1bVYFA5VQtBQ3oX4KHitplMekO5br80ESQrMaD+o0G/Ef+Ex0rAp
	 NZoOcMqZQjCUcw/71RsT1PvkUEupMrI5+FDeWmUmoOUr3+fV2PFqM2azwGTrMhtwRK
	 O7kvsitrWsGUGW8oASsY53llEzIFPI+qakkUytNLud5RdKKLcz9w2d4AJMu0QcMZKg
	 Zlxzlm9QIatSjxIw7SxAPhF/q1b4WGJ/bFLeYRJSbbTsjrXnVs5Vky9rKdeS9WQk/S
	 EK6Bk505KeUrQ==
Date: Sat, 6 Jan 2024 20:05:32 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: "git " <git@vger.kernel.org>
Message-ID: <133456672.1820149400.1704567932308.JavaMail.root@zimbra39-e7>
In-Reply-To: <763603689.1820092086.1704566524953.JavaMail.root@zimbra39-e7>
Subject: Leveraging --rebase-merges --update-refs mechanism to rebase
 several branches in one run
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr

This idea comes from a repo[1] where I am experimenting with code variants:
on one side I have a branch where I add to the core mechanisms, and on the
other(s) I have several branches where I experiment with different rendering
options.

There are indeed 2 different workflows here:
- improving the variants themselves, where occasionally some fixup or new
  commit for the core branch gets introduced
- adding feature to the core branch, then merging that into each variant,
  where fixups already appear quite regularly

That produces a set closely-related branches with lots of merges, and applying
the fixups is a bit tricky.

The "core + 1 variant" case pretty much works out of the box, with --rebase-merges
and --update-refs generating a perfect instructions sheet.

But if I was to rebase just one variant while rewriting the core branch, obviously
all other variants would still fork off the pre-rewrite core branch, and we'd loose
all chances of automating the same work on the other variants.

OTOH, if I get `git-rebase` to generate the instruction sheets for those other
variants first, strip them (manually) from the common part, and insert them in the
instruction sheet of my "core + 1 variant" case ... I do get the whole of my branches
rebased together, and sharing the updated core.


So the question is, would there be any obstacles to let git-rebase automate this
completely?  By chance it could even be a trivial change?
I guess we'd only want this feature to be enabled under certain conditions, like
--update-refs being specified so the many heads of the rebase would be reachable.


[1] https://github.com/ydirson/test-yew-tutorial/tree/opr is the "core" branch,
and branches opr-* are the variants

