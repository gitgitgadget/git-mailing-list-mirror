From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] pack-refs: write peeled entry for non-tags
Date: Sun, 17 Mar 2013 02:02:28 -0400
Message-ID: <20130317060228.GD16070@sigill.intra.peff.net>
References: <20130316090018.GA26708@sigill.intra.peff.net>
 <20130316090103.GA26855@sigill.intra.peff.net>
 <514478C0.6060008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Mar 17 07:03:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6gU-0003bS-JG
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 07:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919Ab3CQGCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 02:02:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54048 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3CQGCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 02:02:30 -0400
Received: (qmail 7065 invoked by uid 107); 17 Mar 2013 06:04:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 02:04:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 02:02:28 -0400
Content-Disposition: inline
In-Reply-To: <514478C0.6060008@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218337>

On Sat, Mar 16, 2013 at 02:50:56PM +0100, Michael Haggerty wrote:

> > @@ -39,14 +40,13 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
> >  		return 0;
> >  
> >  	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
> > -	if (is_tag_ref) {
> > -		struct object *o = parse_object(sha1);
> > -		if (o->type == OBJ_TAG) {
> > -			o = deref_tag(o, path, 0);
> > -			if (o)
> > -				fprintf(cb->refs_file, "^%s\n",
> > -					sha1_to_hex(o->sha1));
> > -		}
> > +
> > +	o = parse_object(sha1);
> > +	if (o->type == OBJ_TAG) {
> 
> You suggested that I add a test (o != NULL) at the equivalent place in
> my code (which was derived from this code).  Granted, my code was
> explicitly intending to pass invalid SHA1 values to parse_object().  But
> wouldn't it be a good defensive step to add the same check here?

Hmm, yeah. That is not new code, but rather just reindented from above
("diff -w" makes it much more obvious what is going on).

It is probably worth dying rather than segfaulting, though it should be
a separate patch (and I do not think it is sane to do anything except
die here). I almost wonder if parse_object should die by default on
bogus or missing objects, and the few callers who really want to handle
the error can call parse_object_gently. I do not relish analyzing each
caller, though. It would be simpler to add parse_object_or_die.

> > +# This matches show-ref's output
> > +print_ref() {
> > +	echo "`git rev-parse "$1"` $1"
> > +}
> > +
> 
> CodingGuidelines prefers $() over ``.

Old habits die hard. :)

I'll re-roll with your suggestions in a moment.

-Peff
