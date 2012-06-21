From: Jeff King <peff@peff.net>
Subject: Re: Missing hyperlinks in HTML docs
Date: Thu, 21 Jun 2012 02:24:10 -0400
Message-ID: <20120621062410.GB19485@sigill.intra.peff.net>
References: <4FE235DC.9080202@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Hertling <mhertling@online.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShaoX-000698-4C
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab2FUGYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:24:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41024
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab2FUGYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:24:14 -0400
Received: (qmail 2543 invoked by uid 107); 21 Jun 2012 06:24:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Jun 2012 02:24:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2012 02:24:10 -0400
Content-Disposition: inline
In-Reply-To: <4FE235DC.9080202@online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200384>

On Wed, Jun 20, 2012 at 10:43:08PM +0200, Michael Hertling wrote:

> shows that git.html does have the expected hyperlinks; e.g., diffing
> git-1.7.11.rc{2,3}/Documentation/git.html reveals the following hunk:
> 
> @@ -964,7 +964,6 @@
>  <h3 id="_main_porcelain_commands">Main porcelain commands</h3>
>  <div class="dlist"><dl>
>  <dt class="hdlist1">
> -<a href="git-add.html">git-add(1)</a>
>  </dt>
>  <dd>
>  <p>
> 
> Other files, e.g. git-add.html, are affected, too.
> 
> AFAICS, this is caused by fe77b41, more precisely the change of the
> Documentation/asciidoc.conf file. Indeed, reverting that commit on
> v1.7.11-rc3 results in git.html containing hyperlinks as expected.
> 
> Can anyone confirm this? If so, is this intended behaviour? So far,
> I haven't found any clues in the release notes / mailing list / etc.
> Am I doing something wrong? Do I miss something? Thanks for any hint.

Eek. I can easily replicate it here. The problem is that the new
git-relative-html-prefix attribute is not defined by default (whereas we
want it defined but blank). Which puzzles me, as I thought I tested how
fe77b41 impacted files outside of technical/. But obviously I screwed
something up.

The patch below should solve it.

-- >8 --
Subject: docs: always define git-relative-html-prefix attribute

Commit fe77b41 introduced a new attribute to let the linkgit macro
create cross-directory HTML references from the technical/ and howto/
subdirectories back to the main documentation. We define that attribute
to "../" on the command-line when building inside those subdirectories,
and otherwise leave it unset under the assumption that it would default
to being blank.  Instead, asciidoc omits the link entirely, leading to
broken documentation. Fix this by defining git-relative-html-prefix to
blank in asciidoc.conf (and an instance on the command-line, when
present, will override it).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/asciidoc.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 6d06271..a26d245 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -90,6 +90,8 @@ endif::backend-docbook[]
 endif::doctype-manpage[]
 
 ifdef::backend-xhtml11[]
+[attributes]
+git-relative-html-prefix=
 [linkgit-inlinemacro]
 <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
