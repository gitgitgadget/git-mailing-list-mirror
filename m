From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sun, 11 May 2008 04:07:09 -0400
Message-ID: <20080511080709.GA6971@sigill.intra.peff.net>
References: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com> <20080510233918.GA315@sigill.intra.peff.net> <7ce338ad0805101730n5b964a0em39d9fdcd9fc45f00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Krzysztof Kowalczyk <kkowalczyk@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 10:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv6c1-0003uj-5r
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 10:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbYEKIHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 04:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYEKIHT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 04:07:19 -0400
Received: from peff.net ([208.65.91.99]:1349 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbYEKIHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 04:07:07 -0400
Received: (qmail 8579 invoked by uid 111); 11 May 2008 08:07:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 May 2008 04:07:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 May 2008 04:07:09 -0400
Content-Disposition: inline
In-Reply-To: <7ce338ad0805101730n5b964a0em39d9fdcd9fc45f00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81747>

On Sat, May 10, 2008 at 05:30:56PM -0700, Krzysztof Kowalczyk wrote:

> >> -     ref = alloc_ref(strlen(refname) + 1);
> >> -     strcpy(ref->name, refname);
> >> +     ref = alloc_ref_from_str(refname);
> >
> > So this turns a 2-line construct into a 1-line construct...
> 
> And avoids future prossible mistakes with not terminating the string,
> like the one just commited.

Yes. Please don't interpret my comment as "this change isn't worth it";
I meant it as "yes, it is good to be simplifying and making this part
less error prone; I just want to nitpick your exact implementation".

> You're absolutely right - it's a micro-optimization and your version
> might be preferred for clarity. This is the first time I submit a
> patch to git so I don't have a good feel for what kind of treadoffs
> people find acceptable.

OK. Ultimately it is up to Junio. I think your version is a bit complex,
but at the very least it contains that complexity neatly in one function.

Actually, the version I posted actually has an optimization, too (it
remembers the strlen calculation to reuse it). I think the simplest
would just be:

  struct ref *alloc_ref_from_str(cons char *str)
  {
    struct ref *ret = alloc_ref(strlen(str) + 1);
    strcpy(ret->name, str);
    return ret;
  }

But really my main worry is that now we have _two_ functions which
allocate refs, so if "struct ref" ever grows a new field that needs
initializing, it has to go in two places (whereas if alloc_ref_from_str
calls alloc_ref, it works automatically).

> I should also mention that
> static struct ref *try_explicit_object_name(const char *name)
> {
> 	unsigned char sha1[20];
> 	struct ref *ref;
> 
> 	if (!*name) {
> 		ref = alloc_ref(20);
> 		strcpy(ref->name, "(delete)");
> 		hashclr(ref->new_sha1);
> 		return ref;
> 	}
> ...
> 
> could also be replaced with alloc_ref_str() - I just wasn't 100% sure
> if overallocating 10 bytes (20 - strlen("(delete)")) was just sloppy
> code or does other code relies on that (which is unlikely and if true
> then it wouldn't be good).

It looks like just slop, and should probably be fixed at the same time.
There are also quite a number of:

  ret = alloc_ref(strlen(name) + 6);
  sprintf(ret->name, "refs/%s", name);

which are error-prone and owuld be nice to fix. However, I don't think
there is an easy way short of making ref->name a strbuf. And now it
seems we are getting into a lot of code churn for a relatively small
benefit.

-Peff
