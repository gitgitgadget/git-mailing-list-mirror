From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Wed, 24 Jun 2015 03:50:20 -0400
Message-ID: <20150624075019.GA827@peff.net>
References: <20150623105042.GA10888@peff.net>
 <20150623105411.GB12518@peff.net>
 <xmqq1th2cezr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 09:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7fRz-0003hN-No
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 09:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbbFXHuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 03:50:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:50846 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbbFXHuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 03:50:22 -0400
Received: (qmail 2135 invoked by uid 102); 24 Jun 2015 07:50:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 02:50:22 -0500
Received: (qmail 25517 invoked by uid 107); 24 Jun 2015 07:50:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 03:50:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jun 2015 03:50:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1th2cezr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272536>

On Tue, Jun 23, 2015 at 02:05:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  This extension does not change git's behavior at all. It is useful only
> >  for testing format-1 compatibility.
> > +
> > +`preciousObjects`
> > +~~~~~~~~~~~~~~~~~
> > +
> > +When the config key `extensions.preciousObjects` is set to `true`,
> > +objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
> > +`git repack -d`).
> 
> OK.  In essense, the 'extension' on the disk is like 'capability' on
> the wire, in that you are not supposed to ask for capability they do
> not understand, and you are not supposed to touch a repository you
> do not understand.

Yeah, I think that is a good analogy.

> > +	if (delete_redundant && repository_format_precious_objects)
> > +		die("cannot repack in a precious-objects repo");
> 
> This message initially threw me off during my cursory reading, but
> the code tells me that this is only about "repack -d".
> 
> Unfortunately the users do not get the chance to read the code;
> perhaps s/cannot repack/& -d/; or something?

I agree that would be better. I originally just blocked all use of
git-repack, but at the last minute softened it to just "repack -d". I'm
not sure if that would actually help anyone in practice. Sure, doing
"git repack" without any options is not destructive, but I wonder if
anybody actually does it. They either run `git gc`, or they probably do
something more exotic and disable the safety check during that run[1].

So I think we could squash in the patch below (which also marks the
strings for translation). But I'd also be OK with the rule covering all
of `git repack`.

-Peff

[1] One of my proposed uses for this is to revamp the way we handle
    shared objects on GitHub servers. Right now objects get pushed to
    individual forks, and then migrate to a shared repository that is
    accessed via the alternates mechanism. I would like to move to
    symlinking the `objects/` directory to write directly into the
    shared space. But the destruction from accidentally running
    something like `git gc` in a fork is very high. With this patch, we
    can bump the forks to the v1 format and mark their objects as
    precious.

---
diff --git a/builtin/prune.c b/builtin/prune.c
index fc0c8e8..6a58e75 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -219,7 +219,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	}
 
 	if (repository_format_precious_objects)
-		die("cannot prune in a precious-objects repo");
+		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
 		unsigned char sha1[20];
diff --git a/builtin/repack.c b/builtin/repack.c
index 8ae7fe5..3beda2c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -194,7 +194,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				git_repack_usage, 0);
 
 	if (delete_redundant && repository_format_precious_objects)
-		die("cannot repack in a precious-objects repo");
+		die(_("cannot delete packs in a precious-objects repo"));
 
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
