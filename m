Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34632D3225
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883177; cv=none; b=egb5bSZFHvdhveJzBJvXReq7T8LHHLqTpCCcnyV4QVcXqzgKuh7DHzsfD5b5hs3TwWiSD9No1taxfey1SmLjB7nCgmmcJfwx1++w76070P4NE22rPRzWEOaMECLbEnZbFVS9g2ThHojf1hLEE/f40xCB1qrfmmj31XEz1DHGXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883177; c=relaxed/simple;
	bh=1bhbgMuR9+O/v+I66T1TYEmgoFij5i1DHGxbspyZemM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtJjh8vyCoccN5KhsCkNuanXiWBfmyZW6dOfP3auT7ysa2vxjZbehy7PksLCgI+GIZ/HZpPKMl/XFCSzBRpY3lDkudUyHUGQWUiEXYBBrfGea5zkf1bzN5ZL/XKTY9c6QpxgksFmK8UKbDMF3fTFD5Urozn3ozRfy2RLUlu7l7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fSh316L1rzRnlT;
	Sat,  7 Mar 2026 12:32:45 +0100 (CET)
Message-ID: <e17f094f-f869-4cc9-b59c-091b7e61a021@kdbg.org>
Date: Sat, 7 Mar 2026 12:32:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] run auto maintenance in git-gui
To: Wolfgang Faust <contrib-git@wolfgangfaust.com>
Cc: Birger Skogeng Pedersen <birger.sp@gmail.com>,
 Pratyush Yadav <me@yadavpratyush.com>, Marc Branchaud
 <marcnarc@xiplink.com>, git@vger.kernel.org
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.03.26 um 06:15 schrieb Wolfgang Faust:
> Resurrecting the 2019 conversation "git-gui: disable the "loose objects
> popup" dialog?":
> <https://lore.kernel.org/git/CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com/t/#u>
> 
> The consensus there seems to be that git's auto maintenance is now
> good enough and if git-gui implemented the same behavior as `git commit`
> then the "repository currently has approximately %i loose objects"
> dialog would no longer be necessary. This patch series implements that.

Generally, I like the idea.

However, the consequences for users need to be considered. You replace
the custom implementation of `git gc` with `git maintenance run --auto`.
The latter CAN do a lot more than the former. It turns out, that Git GUI
already calls into `git maintance` indirectly via `git merge` and `git
fetch`. So, users who set gui.gcwarning to false (myself included) were
already prone to occasional inadvertent cleanups.

So, users that are hurt by this new change are those where all these
conditions are true:

- They make commits with Git GUI.

- They configure maintenance.* to do more cleanups than the default
confituration (which is the same as `git gc --auto`, I think).

- They never use one of `commit`, `am`, `fetch`, `merge`, `rebase` (and
possibly more) on the command line.

- They never use `git maintenance run` through some other facility.

- They never use Git GUI's "Local Merge" dialog.

- They never use Git GUI's "Fetch From" command.

- They still expect certain stale data to *not* be pruned.

How many could this be? Not many, I guess. The conservative safe
approach would be to treat gui.gcwarning=false as an indication that
automatic cleanup is not desired.

> 
> Wolfgang Faust (4):
>   git-gui: run auto maintenance on commit
>   git-gui: remove hint_gc dialog
>   git-gui: remove "Compress Database" feature
>   scalar: remove obsolete gui.GCWarning setting
> 
>  Documentation/config/gui.adoc |  5 -----
>  Documentation/scalar.adoc     |  6 ------
>  git-gui/git-gui.sh            |  6 ------
>  git-gui/lib/commit.tcl        |  6 ++++++
>  git-gui/lib/database.tcl      | 40 -----------------------------------
>  git-gui/po/bg.po              | 22 -------------------
>  git-gui/po/de.po              | 27 -----------------------
>  git-gui/po/el.po              | 27 -----------------------
>  git-gui/po/fr.po              | 28 ------------------------
>  git-gui/po/hu.po              | 27 -----------------------
>  git-gui/po/it.po              | 26 -----------------------
>  git-gui/po/ja.po              | 26 -----------------------
>  git-gui/po/nb.po              | 27 -----------------------
>  git-gui/po/pt_br.po           | 27 -----------------------
>  git-gui/po/pt_pt.po           | 27 -----------------------
>  git-gui/po/ru.po              | 20 ------------------
>  git-gui/po/sv.po              | 27 -----------------------
>  git-gui/po/vi.po              | 27 -----------------------
>  git-gui/po/zh_cn.po           | 26 -----------------------
>  scalar.c                      |  1 -
>  t/t9210-scalar.sh             | 20 +++++++++---------
>  21 files changed, 16 insertions(+), 432 deletions(-)

Please separate the patches such that they modify either only files in
the git-gui directory or only files outside it. The git-gui/ patches are
applied to my repository at https://github.com/j6t/git-gui. Plan the
patches such that the remaining patches can be applied later when my
repository has been merged into the Git repository.

Please do not modify translation files. It's too much noise. They are
only modified when new translations are contributed.

-- Hannes

