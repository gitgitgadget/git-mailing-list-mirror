From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file.c: make sure open_sha1_file does not open a
 directory
Date: Sun, 8 Feb 2015 19:54:44 -0500
Message-ID: <20150209005444.GA16827@peff.net>
References: <b0993cc1fcac290d7506b24942af300@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <me@jonathonmah.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 01:54:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKccm-0002YC-96
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 01:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759086AbbBIAys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 19:54:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:46592 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759080AbbBIAyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 19:54:47 -0500
Received: (qmail 15411 invoked by uid 102); 9 Feb 2015 00:54:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 18:54:47 -0600
Received: (qmail 26751 invoked by uid 107); 9 Feb 2015 00:54:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 19:54:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2015 19:54:44 -0500
Content-Disposition: inline
In-Reply-To: <b0993cc1fcac290d7506b24942af300@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263537>

On Sun, Feb 08, 2015 at 03:05:32PM -0800, Kyle J. McKay wrote:

> Since "sha1_file: fix iterating loose alternate objects", it's possible
> for the base member of the alt_odb_list structure to be NUL terminated
> rather than ending with a '/' when open_sha1_file is called.

Good catch. Users of "struct alternate_object_database" expect to be
able to fill in the "name" field, and have a full path in the "base"
field. That is part of the contract of the struct, and the recent fix
does not live up to that contract inside the for_each_loose_file...
callbacks.

For that reason, I don't think your fix is complete. It fixes _one_
caller to work around this breakage of the contract, but it does not do
anything about the other callers (of which you can find several if you
grep for `fill_sha1_path`). I don't know if those can be hit from this
code path, but it does not matter. We jump to a callback with the NUL
set, so we must assume any arbitrary code can be run.

So either we must amend the contract, so that users of alt->base must
check the termination themselves (i.e., your patch, but extended to all
users of alt->base), or we have to fix for_each_loose_file not to leave
the alt_odb struct in such a broken state. I think I'd prefer the
latter.

> While this patch can be applied without "sha1_file: fix iterating
> loose alternate objects" you cannot even get to the failure this fixes
> without first having that patch applied.

Right. This is literally a bug introduced by that patch. It's OK to
munge alt->name[-1] temporarily, but you have to make sure you are not
calling functions which will look at it while it is munged. The way
refs_from_alternate_cb does it is OK (NUL-terminate, xstrdup, then fix
it; or just xmemdupz the correct length, which we know from alt->name).

Something like:

diff --git a/sha1_file.c b/sha1_file.c
index 9e0c271..7253213 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3396,11 +3396,11 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
 {
 	struct loose_alt_odb_data *data = vdata;
 	int r;
-	alt->name[-1] = 0;
-	r = for_each_loose_file_in_objdir(alt->base,
+	char *buf = xmemdupz(alt->base, alt->name - alt->base - 1);
+	r = for_each_loose_file_in_objdir(buf,
 					  data->cb, NULL, NULL,
 					  data->data);
-	alt->name[-1] = '/';
+	free(buf);
 	return r;
 }
 

However, the first thing for_each_loose_file_in_objdir is going to do is
stick the path into a strbuf. So perhaps the most sensible thing is to
just teach it to take a strbuf from the caller. I'll work up a patch.

It looks like a1b47246 isn't even in "next" yet, so I'll build it
directly on what is already in master, dropping Jonathan's patch.

-Peff
