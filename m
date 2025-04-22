Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862121B9F4
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365657; cv=none; b=oTlLyVH6xtoFoO+wHG1+JYTMSXx6YaxOkUd7RF9DoF9xFVjL8oh3irCGc8jREu22GS23utotAz6Onuq7b1PpBHwgdFPBRmJ9eNIXBGdi4CYtsT52C7kC0cn0bzUcotJceM0inNEMvvIkBYvuN/3jkwXz0XHpKAXhHmc2CHjKSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365657; c=relaxed/simple;
	bh=+V3vmhmXTsymZkG4X8HUVoSEVRaONiGsZdWUh/hquEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=keGZVBouS1xUoLpiGDjLIMutQeiZMpOSMtlP+aCz70iWhr8hZVClfh6aSnQf5rBCatO4qlpm1vPhxeY3/Bzcx9M7tKDLfJDT+imWEFDcOKRV/fGv670pUhID5hfnv1qnQd6eJVCfLE8INY7JgHzJYl9rPfWzEKiXHiWoxGXtKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZhzS365gmz9tgf;
	Wed, 23 Apr 2025 01:47:31 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 01:47:29 +0200
Message-Id: <D9DKHI316ER9.PNEG774QLFL8@buenzli.dev>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Martin von Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Nico Williams" <nico@cryptonector.com>, "Junio C Hamano"
 <gitster@pobox.com>
References: <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
 <aAgdauFt/mdCY+GZ@ubby>
In-Reply-To: <aAgdauFt/mdCY+GZ@ubby>

On Wed Apr 23, 2025 at 12:51 AM CEST, Nico Williams wrote:
>
> Using ticket IDs as change IDs implies a globally unique ID assigner,
> and should work well enough where things like bugzilla are used.

This email thread contains recurring ideas of stuffing unrelated
metadata into the change-id header (patch-id, ticket-id). I think we
should be careful not to do that.

The purpose of the proposed change-id is to identify and track how a
change evolves over time. We have talked about how those semantics may
or may not be clear enough, and that's a good thing to discuss.

It's also a good thing to discuss potential alternatives. E.g. "If we
have a patch-id, we don't need a change-id." I don't agree with that,
but it's a good thing to discuss.

But _deriving a change-id from_ a patch-id or ticket-id or whatever
completely destroys its purpose of tracking how a change evolves over
time. The change-id can only do that job if it _doesn't_ have other
unrelated semantics attached to it.

A patch can contain multiple changes. A ticket can be associated with
multiple changes. Deriving a change-id from either of them makes it
impossible to identify and track a single change.

So let's avoid mixing these concepts and talk about them as distinct
alternatives.
