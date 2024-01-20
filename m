Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D6642
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711600; cv=none; b=I3bn2gVZJvZpIAhdMij1+ecjKU/wJYt3YXhB66JSxRy+y8/1zn9+at2Uw5j/9yGuk5j3EdlgEzzCEsBiSNgzt+rS9lky0Lyo1gvvqAOBWlWipqe/kAqzdg3TM0RGMy00mdCDY0XKKcTnu3Pr6UIiM+950OXySkycZk/FoLrtKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711600; c=relaxed/simple;
	bh=Aro8HITcqRAyvVaEretfVRXMAXvkB0dsX6CcB2dUAMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOPl6DnyFzign9zbvrhy/zV3YTE4/FVZmyE0F5RjkfGOvbAXmEdZ/1wQg42rDPo+uNzk8x9f47bX5f4eXNtztjDr/pKNAzNyQ5fGwHzXEfxrcH726PQjiXqPQr293+ojM4Kp9IAsF1+EQ72petNlBcY2buKrg2BufDkncb33VdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 393 invoked by uid 109); 20 Jan 2024 00:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Jan 2024 00:46:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6478 invoked by uid 111); 20 Jan 2024 00:46:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jan 2024 19:46:30 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Jan 2024 19:46:28 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Frank Schwidom <schwidom@gmx.net>,
	git@vger.kernel.org
Subject: partial commit of file-to-directory change, was Re: Bugreport
Message-ID: <20240120004628.GA117170@coredump.intra.peff.net>
References: <20240119132551.GA31532@debian64>
 <ZasCZ0YetzmlBFvw@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZasCZ0YetzmlBFvw@tapette.crustytoothpaste.net>

On Fri, Jan 19, 2024 at 11:14:47PM +0000, brian m. carlson wrote:

> > $ git commit . -m +
> > error: 'd' does not have a commit checked out
> > fatal: updating files failed
> 
> I can confirm this behaviour[0], and it's definitely wrong that it
> thinks `d` is a submodule.  It does, however, work if you do `git commit
> -m +` (that is, without the .), which makes sense since the relevant
> change is already staged in the index.
> 
> I'm not going to get to a patch or more thorough investigation, but
> perhaps someone else will.

I peeked at this a bit earlier; I didn't come up with a solution, but
here are a few more details.

As you noted, the problem is only with giving a pathspec to "git
commit". The bug is in the custom code git-commit uses to set up the
index for a partial commit. It generates a list of entries for the
partial commit via list_path(), and then tries to add them to the index.
But of course "d", being a directory, does not make any sense as an
index entry itself (unless as a submodule).

I'd have thought that we should just be using the same code that "git
add" does here (which obviously works). But all of this comes from
2888605c64 (builtin-commit: fix partial-commit support, 2007-11-18),
which explicitly says "you can't just run add_files_to_cache()", which
is what git-add does under the hood.

I don't know if we could revisit those assumptions and reuse some of the
existing code, or if the custom partial-commit code could be fixed.  I
guess the root of the issue is that in the call to list_paths(), we call
overlay_tree_on_index(). And that's how we end up thinking that "d" is a
useful path to talk about, even though it has already been removed from
the index (we have "d/b.txt" instead).

So I'm not sure if we need a solution here-ish:

diff --git a/builtin/commit.c b/builtin/commit.c
index 65196a2827..25e65e986d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -302,7 +302,9 @@ static void add_remove_files(struct string_list *list)
 			continue;
 
 		if (!lstat(p->string, &st)) {
-			if (add_to_index(&the_index, p->string, &st, 0))
+			if (S_ISDIR(st.st_mode))
+				warning("woah, %s is a dir", p->string);
+			else if (add_to_index(&the_index, p->string, &st, 0))
 				die(_("updating files failed"));
 		} else
 			remove_file_from_index(&the_index, p->string);

but I'm not quite sure what we should be doing instead of that
warning(). Should we updating and including everything in "d/"? What
about if there were a "d/c.txt" that was not a tracked file at all?

It might also be that the bug is earlier in list_paths(), where we
should notice that "d" is gone and now we have entries under "d/".

I dunno. I probably won't dig much further on this myself, but it's
possible Junio (cc'd) might have an idea right away.

-Peff
