From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 23:06:02 -0500
Message-ID: <20121220040602.GA15172@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
 <20121220031327.GB9917@sigill.intra.peff.net>
 <7vehil7557.fsf@alter.siamese.dyndns.org>
 <20121220035543.GA14965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 05:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlXOz-0005xO-EP
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 05:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab2LTEGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 23:06:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59280 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194Ab2LTEGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 23:06:06 -0500
Received: (qmail 6786 invoked by uid 107); 20 Dec 2012 04:07:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 23:07:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 23:06:02 -0500
Content-Disposition: inline
In-Reply-To: <20121220035543.GA14965@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211876>

On Wed, Dec 19, 2012 at 10:55:43PM -0500, Jeff King wrote:

> On Wed, Dec 19, 2012 at 07:51:16PM -0800, Junio C Hamano wrote:
> 
> > > ++		if (limit_pathspec_to_literal())
> > > ++			item->nowildcard_len = item->len;
> > > ++		else {
> > > ++			item->nowildcard_len = simple_length(path);
> > > ++			if (item->nowildcard_len < item->len) {
> > > ++				pathspec->has_wildcard = 1;
> > > ++				if (path[item->nowildcard_len] == '*' &&
> > > ++				    no_wildcard(path + item->nowildcard_len + 1))
> > > ++					item->flags |= PATHSPEC_ONESTAR;
> > > ++			}
> > >  +		}
> > 
> > Hmph.  I thought that returning the length without any "stop at glob
> > special" trick from simple_length() would be a simpler resolution.
> > 
> > That is what is queued at the tip of 'pu', anyway.
> 
> I don't think we can make a change in simple_length. It gets used not
> only for pathspecs, but also for parsing exclude patterns, which I do
> not think should be affected by this option.

Our test suite wouldn't catch such a misfeature, of course, because the
feature is not turned on by default. But I found it instructive to run
all of the tests with GIT_LITERAL_PATHSPECS on. There are failures, of
course, but by inspecting each failure you can see that it is an
intended effect of the patch (i.e., each tries to use a wildcard
pathspec, which no longer works).

When you suggested changing common_prefix, I ran such a test both with
and without the change[1] and confirmed that it did not change the set
of failure sites. I did not try it, but I suspect running such a test
with the tip of pu would reveal new failures in the .gitignore tests.

-Peff

[1] This is in addition to reading and reasoning about the code, of
    course. I would not consider this a very robust form of testing,
    though a test failure which cannot be easily explained would be a
    good starting point for investigation.
