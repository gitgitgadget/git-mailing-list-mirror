Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41449132475
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009478; cv=none; b=WxXmPPkMzDNNtDH8rCs0+Jsh7acdjEjN8p+QOa5HWzNY1VBXvXWQt8JDFDbZXhiqyZO8K2fdblbjAk5xULUip5CXGAnRD5mItA4EOLvk3Ig+aon85HNnSQve0rgmZN7BF3xOmTfFpHlFQdvc1OoG5GhBkpdiRTw+JRGLassHoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009478; c=relaxed/simple;
	bh=ba20QTieFQdkJsrGcjDW/D+g4JXlT7N046T7Hdyjr+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzm7wbMBFBHdRulsx8DsJ6vwu6TxcK/XAOJDdNQSwqUJ/yEI5yKY/0Te3JpVGVVw6Bomm0X956K2VAqWS7W25F9H/RnVGHCoPztSYhmpcEQIwXopN/AsnuUDU4n9HTdo1VBpluymSqFMY2FHxovhDu6SvWwxWyjEHrb3d6fsdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8556 invoked by uid 109); 15 Feb 2024 15:04:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Feb 2024 15:04:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5874 invoked by uid 111); 15 Feb 2024 15:04:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Feb 2024 10:04:31 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Feb 2024 10:04:30 -0500
From: Jeff King <peff@peff.net>
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
Message-ID: <20240215150430.GA3453@coredump.intra.peff.net>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl>
 <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g>
 <20240213080014.GB2225494@coredump.intra.peff.net>
 <CA+CvcKR9sH=qZB4oZvX9RWd+4H3Bq8WV_qUOiSj_Tsf=Dr_Xvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CvcKR9sH=qZB4oZvX9RWd+4H3Bq8WV_qUOiSj_Tsf=Dr_Xvw@mail.gmail.com>

On Thu, Feb 15, 2024 at 08:46:02AM +0100, Maarten Bosmans wrote:

> > How about:
> >
> >   cat some_commit_ids |
> >   git show --stdin -s -z --format='%H%n%N'
> >
> Wouldn't that fail horribly with non-text blobs?

Yes, if you have NULs embedded in your notes then it won't work. Any
batch output format would require byte counts, then. If we wanted to add
a feature to support that, I would suggest one of:

  - teach the pretty-print formatter a new placeholder to output the
    number of bytes in an element. Then you could do something like
    "%H %(size:%N)%n%N", but it would be generally useful for other
    cases, too.

  - teach the pretty-print formatter a variant of %N that outputs only
    the oid of the note, note the note content itself. And then you
    could do something like:

      git log --format='%(note:oid) %H' |
      git cat-file --batch='%(objectname) %(objectsize) %(rest)'

    to get the usual cat-file output of each note blob, but associated
    with the commit it's attached to (the "%(rest)" placeholder for
    cat-file just relays any text found after the object name of each
    line). You might need to do some scripting between the two to handle
    commits with no note.

Of the two, I'd guess that the second one is a lot less work to
implement (on the Git side; on the reading side it's a little more
involved, but still should be a constant number of processes).

One variant of the second one is to use "git notes list". For example,
you can get all notes via cat-file like this right now:

  git notes list |
  git cat-file --batch='%(objectname) %(objectsize) %(rest)'

You can get individual notes by asking for "git notes list <commit>",
but it will only take one at a time. So another easy patch would be
something like (indentation left funny to make the diff more readable):

diff --git a/builtin/notes.c b/builtin/notes.c
index e65cae0bcf..5fdad5fb8f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -446,22 +446,22 @@ static int list(int argc, const char **argv, const char *prefix)
 		argc = parse_options(argc, argv, prefix, options,
 				     git_notes_list_usage, 0);
 
-	if (1 < argc) {
-		error(_("too many arguments"));
-		usage_with_options(git_notes_list_usage, options);
-	}
-
 	t = init_notes_check("list", 0);
 	if (argc) {
-		if (repo_get_oid(the_repository, argv[0], &object))
-			die(_("failed to resolve '%s' as a valid ref."), argv[0]);
+		retval = 0;
+		while (*++argv) {
+		if (repo_get_oid(the_repository, *argv, &object))
+			die(_("failed to resolve '%s' as a valid ref."), *argv);
 		note = get_note(t, &object);
 		if (note) {
-			puts(oid_to_hex(note));
-			retval = 0;
+			if (argc > 1)
+				printf("%s %s\n", oid_to_hex(note), oid_to_hex(&object));
+			else
+				puts(oid_to_hex(note));
 		} else
-			retval = error(_("no note found for object %s."),
+			retval |= error(_("no note found for object %s."),
 				       oid_to_hex(&object));
+		}
 	} else
 		retval = for_each_note(t, 0, list_each_note, NULL);
 

That would allow:

  git rev-list ... |
  xargs git notes list |
  git cat-file --batch='%(objectname) %(objectsize) %(rest)'

We could even add a "--stdin" mode to avoid the use of xargs.

-Peff
