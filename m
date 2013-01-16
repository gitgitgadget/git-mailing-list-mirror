From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 08:01:31 -0800
Message-ID: <20130116160131.GB22400@sigill.intra.peff.net>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWKg-0006KN-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639Ab3APQBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:01:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35251 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757619Ab3APQBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 11:01:36 -0500
Received: (qmail 12467 invoked by uid 107); 16 Jan 2013 16:02:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 11:02:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 08:01:31 -0800
Content-Disposition: inline
In-Reply-To: <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213770>

On Wed, Jan 16, 2013 at 02:32:03PM +0100, Max Horn wrote:

> With git 1.8.1, I get this message:
> 
>  ! [rejected]        master -> master (non-fast-forward)
> [...]
> But with next, I get this:
> 
>  ! [rejected]        master -> master (already exists)

Thanks for the detailed report. I was able to reproduce easily here.

The problem is the logic in is_forwardable:

static inline int is_forwardable(struct ref* ref)
{
        struct object *o;

        if (!prefixcmp(ref->name, "refs/tags/"))
                return 0;

        /* old object must be a commit */
        o = parse_object(ref->old_sha1);
        if (!o || o->type != OBJ_COMMIT)
                return 0;

        /* new object must be commit-ish */
        o = deref_tag(parse_object(ref->new_sha1), NULL, 0);
        if (!o || o->type != OBJ_COMMIT)
                return 0;

        return 1;
}

The intent is to allow fast-forward only between objects that both point
to commits eventually. But we are doing this check on the client, which
does not necessarily have the object for ref->old_sha1 at all. So it
cannot know the type, and cannot enforce this condition accurately.

I.e., we trigger the "!o" branch after the parse_object in your example.

-Peff
