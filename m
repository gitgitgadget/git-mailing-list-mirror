From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] "diff -p" patch header generation updates
Date: Wed, 29 Feb 2012 18:14:13 -0800
Message-ID: <1330568057-27304-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 03:14:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2vXF-0003p8-In
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 03:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172Ab2CACOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 21:14:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab2CACOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 21:14:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73A417D47
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=dUvDPObN9v78Lu5khI03MucgXNk
	=; b=XPq3d81L7soklMoscdjzGd+37354AjPjSJXjcaFP+0vUCbq/G4UVv+ObOaE
	uWJN5ByRIOil5XWjCB6CU9dTgoKOh3He/bVqEVxeCsNI0k19huA/BIm+kTJShsdN
	foLI3knom9PeHo5rPPJsiO5eDd8BHI3cAGX1jFvC6DX7syM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Gu+o2xi4BxCcnqhnBoOLZvmFFljjL
	OKjFGBfjIXHJx/zGH6wDxlL7bubJoP3OEldBnPsiX9uZv1AJElsxGM+yFsaVaLcx
	37IiKnoudyUgWYZCiSDrcJwwRyLTttVfw+1iz1Hlc2vPSFjbKdqLT/CjQvhF8Sia
	Uc2ip/hbcZvixU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ABFE7D45
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9F017D3A for
 <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:18 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.350.g74d65
X-Pobox-Relay-ID: 40824B26-6344-11E1-B53F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191885>

There has always been one thing fishy about the plumbing level "diff" used
to generate patches with "-p" option: we produced a header-only diff when
there is no patch necessary to be shown, when there is no contents change.
We are calling into xdiff to produce a patch, and we should have all the
necessary information to suppress the unnecessary header, but because
historically we didn't, we never updated the code to do so.

It turns out that we already have the necessary machinery to notice such a
situation and suppressing the useless header. We just did not realize that
we could use it. There is a backward compatibility worry for scripts, but
I would imagine that the scripts saw these header-only diff as a nuisance
that needs to be filtered out, not a feature to learn about paths that are
only stat-dirty.  And more importantly, even if this _were_ a feature, it
was not working correctly when "-w" option was in effect to begin with, as
the second one in the series illustrates.

This series changes the world order that is almost 6 years old.  No more
phantom diff headers in patch output due to stat-dirtiness.

The first patch in this series replaces the one I posted earlier (one
block that prepares the expected result was in a wrong test).

The second patch adds test vectors that illustrate the current behaviour
that will be changed with this series.

The third patch is the real change, whose effect can be seen in the patch
to the test the second one introduces.

The fourth one is unrelated from the rest of the series from the feature
point of view, but its implementation depends on the updated semantics of
header suppression.

The series is designed to apply on top of v1.7.4-rc0~147 and has trivial
conflict in diff.h if applied/merged to 'master'.  Just take the addition
of DIFF_OPT* macros from both sides.

Junio C Hamano (4):
  t4011: modernise style
  t4011: illustrate "diff-index -p" on stat-dirty paths
  diff -p: squelch "diff --git" header for stat-dirty paths
  diff --ignore-mode-change

 diff.c                  |   31 +++++++-
 diff.h                  |    1 +
 t/t4011-diff-symlink.sh |  196 +++++++++++++++++++++++++++--------------------
 3 files changed, 141 insertions(+), 87 deletions(-)

-- 
1.7.9.2.350.g74d65
