From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1300: document some aesthetic failures of the config
 editor
Date: Fri, 29 Mar 2013 15:51:55 -0400
Message-ID: <20130329195155.GA19994@sigill.intra.peff.net>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
 <20130329172307.GA11099@sigill.intra.peff.net>
 <20130329175058.GA13506@sigill.intra.peff.net>
 <7vobe2nins.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Phil Haack <haacked@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 20:52:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULfLf-0001qo-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 20:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab3C2Tv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 15:51:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48543 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756303Ab3C2Tv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 15:51:58 -0400
Received: (qmail 9957 invoked by uid 107); 29 Mar 2013 19:53:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 15:53:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 15:51:55 -0400
Content-Disposition: inline
In-Reply-To: <7vobe2nins.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219524>

On Fri, Mar 29, 2013 at 11:51:51AM -0700, Junio C Hamano wrote:

> > +	cat >expect <<-\EOF &&
> > +	# some intervening lines
> > +	# that should be saved
> > +	EOF
> 
> I do not know if I agree with this expectation.
> 
> Most likely these comments are about the section, and possibly even
> are specific to section.key, not applicable to the section in
> general).  If we _were_ to remove the section header at this point,
> we should be removing the comment two out of three cases (if it is
> about section.key, it should go when section.key goes; if it is
> about section, it should go when section goes; if it is a more
> generic comment about this configuration file, it should stay).

I agree that probably makes more sense (I actually wrote the test before
responding to Thomas, and then got bogged down in the code change and
forgot to update it when I decided to give up).

> A better approach may be to only insist on the "when adding, reuse
> an empty section header" side of the coin.  Then we do not have to
> worry about "we keep cruft that talks about some section but what
> the comment says is illegible now the crucial bit of information,
> section name the comment talks about, is gone".

I think they are two separate problems. They happen to combine to
produce the behavior that Phil reported, but I would still expect
"--unset" not to leave cruft. It makes sense to document to me to
document both via tests; even if we end up tweaking the expected
behavior when the fix is actually implemented, the presence of the test
still serves as a reminder of the issue.

Here it is with the updated expectation. I don't care _that_ much, so if
you feel strongly and want to drop the first test, feel free.

-- >8 --
Subject: [PATCH] t1300: document some aesthetic failures of the config editor

The config-editing code used by "git config var value" is
built around the regular config callback parser, whose only
triggerable item is an actual key. As a result, it does not
know anything about section headers, which can result in
unnecessarily ugly output:

  1. When we delete the last key in a section, we should be
     able to delete the section header.

  2. When we add a key into a section, we should be able to
     reuse the same section header, even if that section did
     not have any keys in it already.

Unfortunately, fixing these is not trivial with the current
code. It would involve the config parser recording and
passing back information on each item it finds, including
headers, keys, and even comments (or even better, generating
an actual in-memory parse-tree).

Since these behaviors do not cause any functional problems
(i.e., the resulting config parses as expected, it is just
uglier than one would like), fixing them can wait until
somebody feels like substantially refactoring the parsing
code. In the meantime, let's document them as known issues
with some tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1300-repo-config.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c96fda..213e5a8 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1087,4 +1087,34 @@ test_expect_success 'barf on incomplete string' '
 	grep " line 3 " error
 '
 
+# good section hygiene
+test_expect_failure 'unsetting the last key in a section removes header' '
+	cat >.git/config <<-\EOF &&
+	[section]
+	# some intervening lines
+	# that should also be dropped
+
+	key = value
+	EOF
+
+	>expect &&
+
+	git config --unset section.key &&
+	test_cmp expect .git/config
+'
+
+test_expect_failure 'adding a key into an empty section reuses header' '
+	cat >.git/config <<-\EOF &&
+	[section]
+	EOF
+
+	q_to_tab >expect <<-\EOF &&
+	[section]
+	Qkey = value
+	EOF
+
+	git config section.key value
+	test_cmp expect .git/config
+'
+
 test_done
-- 
1.8.2.rc3.27.g5c55d5c
