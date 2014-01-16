From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 0/6] submodule: Local branch creation in module_clone
Date: Wed, 15 Jan 2014 20:09:14 -0800
Message-ID: <cover.1389837412.git.wking@tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 05:10:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3eHe-0007Q6-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 05:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbaAPEKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 23:10:17 -0500
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:34110
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbaAPEKP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 23:10:15 -0500
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id EU8g1n00216LCl053UAE7S; Thu, 16 Jan 2014 04:10:14 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id EUAC1n005152l3L3SUACC7; Thu, 16 Jan 2014 04:10:14 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id 4E2EAEFE481;
	Wed, 15 Jan 2014 20:10:10 -0800 (PST)
Received: (nullmailer pid 11454 invoked by uid 1000);
	Thu, 16 Jan 2014 04:09:45 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389845414;
	bh=2ZcL4ivmhFvAjlLnjuzo205ZEJGUI5Xy+xm2ghYDvEg=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id:MIME-Version:Content-Type;
	b=gk+bEDMoTMstUzUdr2HLg8eFoG1LesLRWs3B51P+9B60L1InQElddrJ/yh4NngAev
	 UNsjUpXNFaClkr4vGqjdiUjN03MrtY0g7TiaE9rUBXqrUaf9fouHVdGE2MVpL8yShq
	 rGS3bNn4qlatX0X74LtqAD+aXLqcmv3sQgWcG/mXVo4x427AY88a0r7DdSSic7mX8F
	 dE4U7DacW8WAC2cbuAcb31YREz1178aF7FZ73JwEx4fx3hgNQN/UgySBuV2BWYAm2y
	 Kr0AKJgQyX/B7A6oeduR8b3O74mguR93nfEMkmMGvQ0/C4ofXFjATeDxoES8gBH665
	 pEhMlOba3wp4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240498>

Here is the next iteration of cloning-update local branch setup.  This
version is based on Francesco's fp/submodule-checkout-mode [1], and
moves back towards the weakly-bound v2 approach and away from the
tightly-bound v3 approach.

The first patch in this series extends that commit to consolidate ''
and 'checkout' update_module values.  I wouldn't mind if that gets
squashed into Francesco's patch.

The meat of the series is in the third patch, which changes the v2
implementation by triggering attached HEADs based on the update-mode
instead of on the existence of a non-empty submodule.<name>.branch
[2].  There has been pushback from both Heiko [3] and Jens [4] on my
mapping checkout updaters to =E2=80=9Cdevelopers not interested in loca=
l
submodule development=E2=80=9D, but I still think it's the right
interpretation.  I'm not clear on Heiko or Jens' current possitions,
maybe I've won them over ;).

The other patches in this series are all new in v4.

This still does a double checkout (once in module_clone to create a
local branch, and again in cmd_update to point that branch at the
correct commit), which Heiko was not excited about [5].

I'm also not sure if defaulting to $remote_name/$branch in cmd_update
is appropriate.  cmd_add defaults to using the remote's HEAD, and that
makes more sense to me than defaulting to the master branch.  However,
changing this logic is probably food for another series.

I still think that this series is only useful as a temporary stop-gap
[6] until we get something like my v3 [7], so the appropriate
submodule branch is automatically checked out when you change
superproject branches.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240036
[2]: http://article.gmane.org/gmane.comp.version-control.git/239973
[3]: http://article.gmane.org/gmane.comp.version-control.git/239978
[4]: http://article.gmane.org/gmane.comp.version-control.git/240368
[5]: http://article.gmane.org/gmane.comp.version-control.git/239968
[6]: http://article.gmane.org/gmane.comp.version-control.git/240232
[7]: http://article.gmane.org/gmane.comp.version-control.git/240248

W. Trevor King (6):
  submodule: Make 'checkout' update_module explicit
  submodule: Document module_clone arguments in comments
  submodule: Explicit local branch creation in module_clone
  t7406: Just-cloned checkouts update to the gitlinked hash with 'reset=
'
  t7406: Add explicit tests for head attachement after cloning updates
  Documentation: Describe 'submodule update' modes in detail

 Documentation/git-submodule.txt | 36 +++++++++++++-----
 Documentation/gitmodules.txt    |  4 ++
 git-submodule.sh                | 84 +++++++++++++++++++++++++--------=
--------
 t/t7406-submodule-update.sh     | 39 ++++++++++++++++++-
 4 files changed, 121 insertions(+), 42 deletions(-)

--=20
1.8.5.2.8.g0f6c0d1
