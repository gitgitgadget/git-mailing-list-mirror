From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/5] disallow test_when_finished in subshells
Date: Sat,  5 Sep 2015 14:12:44 +0100
Message-ID: <cover.1441458341.git.john@keeping.me.uk>
References: <20150905085429.GB25039@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDHQ-0007wv-VO
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbIENMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 09:12:52 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48168 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbIENMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 09:12:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C4A09CDA548;
	Sat,  5 Sep 2015 14:12:50 +0100 (BST)
X-Quarantine-ID: <y2Rc3psUxKcM>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y2Rc3psUxKcM; Sat,  5 Sep 2015 14:12:50 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 36A9ECDA5D8;
	Sat,  5 Sep 2015 14:12:34 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <20150905085429.GB25039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277370>

On Sat, Sep 05, 2015 at 04:54:30AM -0400, Jeff King wrote:
> On Fri, Sep 04, 2015 at 11:43:15AM -0700, Junio C Hamano wrote:
> 
> > > t7800 (in its final test) calls test_config in a subshell which has cd'd
> > > into a submodule.
> > >
> > > Is this something worth worrying about, or is it sufficiently rare that
> > > we can live with the current behaviour?
> > 
> > Fixing the instances you found is good, obviously ;-).  Thanks for
> > working on this.
> > 
> > Even though the proposed detection is BASH-ism, I think it would not
> > hurt other shells (they obviously do not help you catch bugs, but
> > they would not misbehave as long as you make sure BASH_SUBSHELL is
> > either unset or set to 0 at the beginning of the test), and the only
> > impact to them would be a invocation of (often built-in) 'test'
> > utility, whose performance impact should be miniscule.
> > 
> > I'll wait for opinion from others, of course.
> 
> I like it. In general I'm in favor of any lint-like fixes (whether for
> the tests or the C code itself) as long as:
> 
>   1. they don't create false positive noise
> 
>   2. they don't require extra effort at each call-site
> 
>   3. they don't have a performance impact
> 
> And I think this passes all three. Of course it would be nice if the new
> check ran on all shells, but even this seems like a strict improvement.

Here are the changes to do this.  The first two are pretty
straightforward, but the t7800 change may be more controversial; in this
particular case we could get away with using "git config" instead of
test_config but I think the more generic solution will be better for the
future.

I don't think it's worth trying to clear $BASH_SUBSHELL before the tests
start because to do so we have to reliably detect that we're not running
under Bash, and if we don't trust people not to set $BASH_SUBSHELL why
do we trust them not to set $BASH?


John Keeping (5):
  t7610: don't use test_config in a subshell
  t5801: don't use test_when_finished in a subshell
  test-lib-functions: support "test_config -C <dir> ..."
  t7800: don't use test_config in a subshell
  test-lib-functions: detect test_when_finished in subshell

 t/t5801-remote-helpers.sh | 12 ++++--------
 t/t7610-mergetool.sh      |  2 +-
 t/t7800-difftool.sh       |  8 ++++----
 t/test-lib-functions.sh   | 25 ++++++++++++++++++++++---
 4 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.5.0.466.g9af26fa
