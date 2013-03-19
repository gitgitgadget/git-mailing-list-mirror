From: Jeff King <peff@peff.net>
Subject: [regression?] trailing slash required in .gitattributes
Date: Tue, 19 Mar 2013 13:57:56 -0400
Message-ID: <20130319175756.GA13760@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 19 18:58:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI0nv-0007Yg-0l
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 18:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347Ab3CSR6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 13:58:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58659 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933316Ab3CSR6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 13:58:01 -0400
Received: (qmail 32543 invoked by uid 107); 19 Mar 2013 17:59:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 13:59:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 13:57:56 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218541>

Prior to v1.8.1.1, if I did this:

  git init
  echo content >foo &&
  mkdir subdir &&
  echo content >subdir/bar &&
  echo "subdir export-ignore" >.gitattributes
  git add . &&
  git commit -m one &&
  git archive HEAD | tar tf -

my archive would contain only "foo" and ".gitattributes", not subdir. As
of v1.8.1.1, the attribute on subdir is ignored unless it is written
with a trailing slash, like:

  subdir/ export-ignore

The issue bisects to 94bc671 (Add directory pattern matching to
attributes, 2012-12-08). That commit actually tests not only that
"subdir/" matches, but also that just "subdir" does not match.

The commit message there is vague about the reasoning, but my
understanding is that it was meant to harmonize gitignore and
gitattributes, the former of which can take "dir/". I don't have a
problem with offering "dir/" to match only directories, but what is the
point in disallowing just "dir" to match a directory?

It seems like a pointless regression to me, but I'm not clear whether it
was intentional or not (and if it was intentional, I think we would need
to handle it with a proper transition period, not in a maint release).

-Peff
