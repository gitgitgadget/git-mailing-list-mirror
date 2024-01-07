Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47613ACA
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ad0CPPSX"
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp2-g21.free.fr (Postfix) with ESMTP id BD7872003D3;
	Sun,  7 Jan 2024 16:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1704641474;
	bh=iovYTBEmEfUK4zgNNmAnN7fjapOhL23y86EjxHpgUtg=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=ad0CPPSXq3dhYxfeD8i44394mY9/pNUHrCjR24NkHv8rHrl5cRKiGsYocoOc8ei4s
	 q5PtWtunvxwUGUem0DXlsk5/NlEMfHJskIFeJZ5LNixWKHkbWyKLTfngjzr8T9hgup
	 E06komMNRLbNEkUy6o1FTUxYzs5gOMryFlOi/h62E334vziJBGgLNX2B7YRsh/ZQd7
	 60Tms9isYOuRn9UA170xh7Vgxqix5wp1Rxu0I1ELEwPBFpntxaWo3GAliSZSnErU5S
	 9cOQiwXEK9qoMiZVf4Qd11QFuuhjZLUBzRQSwUPbytWyzcERNa5bwQOwTIVOqhbCMk
	 eqzIJ8dbTGOTQ==
Date: Sun, 7 Jan 2024 16:31:14 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: git <git@vger.kernel.org>
Cc: Johannes Sixt <j6t@kdbg.org>
Message-ID: <2065332308.1823640486.1704641474724.JavaMail.root@zimbra39-e7>
In-Reply-To: <1930018756.1822864601.1704627466836.JavaMail.root@zimbra39-e7>
Subject: Interactive rebase doc (Was: Leveraging --rebase-merges
 --update-refs mechanism to rebase several branches in one run)
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

> Johannes Sixt wrote:
> > Am 06.01.24 um 20:05 schrieb Yann Dirson:
> > > The "core + 1 variant" case pretty much works out of the box,
> > > with
> > > --rebase-merges
> > > and --update-refs generating a perfect instructions sheet.
> > > 
> > > But if I was to rebase just one variant while rewriting the core
> > > branch, obviously
> > > all other variants would still fork off the pre-rewrite core
> > > branch, and we'd loose
> > > all chances of automating the same work on the other variants.
> > > 
> > > OTOH, if I get `git-rebase` to generate the instruction sheets
> > > for
> > > those other
> > > variants first, strip them (manually) from the common part, and
> > > insert them in the
> > > instruction sheet of my "core + 1 variant" case ... I do get the
> > > whole of my branches
> > > rebased together, and sharing the updated core.
> > 
> > Not a complete automation, but... You can merge all variant
> > branches
> > into a temporary branch (or detached HEAD), even if that are merely
> > -s
> > ours merges, and then rebase the temporary branch with
> > --rebase-merges
> > --update-refs. This will generate the instruction sheet that you
> > want.
> > You can remove the final merge instructions (the temporary ones)
> > from
> > the instruction sheet if you do not want them to be executed.
> 
> Nice idea, and this is indeed automatable for the most part, Q&D PoC
> below.
> 
> There are a few things I can see missing in this PoC:
> 
> - removal of the final merge from instruction sheet
> 
>   Could be done by wrapping $EDITOR - I'm not particularly fond doing
>   things
>   behind the user's back, but I lack better ideas.
> 
> - restoration of HEAD
> 
>   In the general case it cannot be done from the script, so we would
>   naturally
>   want to do that from the instruction sheet?
> 
>   While I was at manually removing the final merge, I experimented
>   with changing
>   the "reset onto" to "reset <a branch name>", but that resulted in
>   moving HEAD
>   to the pre-rebase version of the requested branch.

Related to this, I turned to the rebase manpage to get reference
information about update-ref, but I could not find anything about it:
only --update-refs is described, but this description also only seems to
address the non-interactive behavior.

In fact:
- there does not appear to be a reference to the interactive
instruction sheet in the rebase doc, only in the default template
- --interactive only directs the user to "Splitting commits", not to
"interactive mode"
- the "interactive mode" section really looks more like a didactic intro
to interactive rebase than like a reference doc

Would it seem OK to change things as follows?

- move current "interactive mode", "splitting commits", and "rebasing merges"
contents into a new gitrebase(7) guide
- leave in git-rebase(1) only an "interactive mode" with the reference doc
for the instruction sheet, and a pointer to the guide for detailed walkthrough
- selectively move back a few things like --strategy paragraph from
"rebasing merges"

Best regards,
-- 
Yann
