From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Wed, 3 Feb 2016 21:58:21 -0500
Message-ID: <20160204025821.GA21105@sigill.intra.peff.net>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
 <1454443734.5545.1.camel@twopensource.com>
 <xmqq7fimrcab.fsf@gitster.mtv.corp.google.com>
 <xmqqmvrhjpzc.fsf@gitster.mtv.corp.google.com>
 <1454548352.5545.2.camel@twopensource.com>
 <56B2AF64.5020502@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:58:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRA7p-0007oT-1A
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 03:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993AbcBDC6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 21:58:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:37089 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756757AbcBDC6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 21:58:24 -0500
Received: (qmail 32579 invoked by uid 102); 4 Feb 2016 02:58:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 21:58:24 -0500
Received: (qmail 30236 invoked by uid 107); 4 Feb 2016 02:58:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 21:58:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2016 21:58:21 -0500
Content-Disposition: inline
In-Reply-To: <56B2AF64.5020502@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285392>

On Thu, Feb 04, 2016 at 01:54:44AM +0000, Ramsay Jones wrote:

> > They were working for me as-of the time I sent them.  I guess something
> > must have broken since.  I'll rebase, test, and send a new series.
> 
> I didn't spend too long looking at it, but I think this interacts with
> Jeff's patch a2d5156c ("resolve_gitlink_ref: ignore non-repository paths",
> 22-01-2016) which introduces the new test in 't3000-ls-files-others.sh'
> which fails for me.
> 
> The change which Jeff made to resolve_gitlink_ref() is effectively side-stepped
> by the call to check_submodule_backend() in the new resolve_gitlink_ref().
> (Jeff's change is now in the 'files' backend version of resolve_gitlink_ref()).

Yeah. The check_submodule_backend() function calls
strbuf_git_path_submodule(), which unconditionally requires that the
path be an actual submodule (the irony being that we are using it to
find out whether we have a submodule!). So I don't think there's a
conflict between our code, so much as that the new code has the same bug
I fixed in a2d5156c (and we didn't notice earlier, because there was no
test).

The solution in a2d5156 is to use is_nonbare_repository_dir() before
assuming we have a submodule. I think check_submodule_backend() would
want to do the same thing. This is the minimal fix:

diff --git a/refs.c b/refs.c
index 3d4c0a6..7f86c49 100644
--- a/refs.c
+++ b/refs.c
@@ -313,9 +313,8 @@ static void check_submodule_backend(const char *submodule)
 	if (!submodule)
 		goto done;
 
-	strbuf_git_path_submodule(&sb, submodule, "%s", "");
-
-	if (!is_git_directory(sb.buf))
+	strbuf_addstr(&sb, submodule);
+	if (!is_nonbare_repository_dir(&sb))
 		goto done;
 
 	strbuf_reset(&sb);


That gets the test passing. But I noticed a few other things, some
related and some unrelated, while looking at this function:

  - in files_resolve_gitlink_ref, if we do find a submodule, we cache
    the result with the ref_cache code. But here, we would read the .git
    file repeatedly (and in fact, it happens twice per call, as
    submodule_git_path has to read it itself).

    I don't know if it would be worth adding any kind of caching at this
    layer.  It may be that we don't typically resolve more than one ref
    (or do more than one for_each_ref iteration) for a submodule, so the
    cache is pointless. I didn't implement it specifically in a2d5156,
    it just came for free with the existing ref_cache code.

  - check_submodule_backend knows whether we have a submodule at all and
    is worth proceeding, but does not tell its callers. So we'll end up
    in the backend files_resolve_gitlink_ref and make the same check.
    It's probably worth moving this logic to the outer layer so each
    backend doesn't have to implement it (and then the check in
    files_resolve_gitlink_ref can actually go away).

  - for the common case of submodule==NULL (i.e., the main repository),
    check_submodule_backend should be a noop, but it allocates and frees
    the submodule_storage_backend string. Probably not a huge deal, but
    it can be easily bumped down, and the first "goto done" turned into
    a "return".

  - if the submodule does have a backend configured, we leak the memory
    for the default string. I think the submodule_backend() config
    callback needs to free() the previous value.

  - the config callback unconditionally dereferences "value", which will
    segfault if the submodule's extensions.refstorage is a pure boolean
    like:

        [extensions]
	refstorage

    That should never happen, of course, but we should be checking and
    dying for "!value" rather than segfaulting. Using
    git_config_string() will do this for you.

Hope that helps.

-Peff
