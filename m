From: Patrick Steinhardt <ps@pks.im>
Subject: [RFC/PATCH 0/4] submodule remotes
Date: Wed,  8 Apr 2015 12:58:21 +0200
Message-ID: <1428490705-11586-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 13:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfnyt-0007pe-0t
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 13:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbbDHLRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 07:17:11 -0400
Received: from sender1.zohomail.com ([74.201.84.157]:50224 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbbDHLRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 07:17:08 -0400
X-Greylist: delayed 1067 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2015 07:17:08 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id; 
  b=aggCz842bPNgxVaxvFDpnthyv1wsdu4wUmvi5eQXYELC/t+xOnEKWFs7OQI276w3PI3+OJS4Shjy
    uP5jYqSzQp8HjqnDjISK9U7eGmiB/WLtXTUjT1C4UEChr+c2z0zTLD9n6qKdi39y5RXr0+BS/SD/
    ptVUZjTOmEJri7elhrQ=  
Received: from localhost (x5ce10f35.dyn.telefonica.de [92.225.15.53]) by mx.zohomail.com
	with SMTPS id 1428490754792847.2734519283326; Wed, 8 Apr 2015 03:59:14 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468 iZSF-HLOLL_2  SGR3_0_01045_96
X-ZohoMail-Owner: <1428490705-11586-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.15.53
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266953>

The following patch series implements a new feature on top of the
submodule command that allows for configuring multiple remotes for
a given submodule. Next to new subcommands `git submodule remote
(add|rm|set-url|show)` that allow to show and modify remotes for
a given submodule, `git remote sync` has been extended to apply
settings to the repositories.

The commands are implemented in such a way that they write the
remote configuration into .gitmodules according to the following
example:

    [submodule-remote "submodule-name.remote-name"]
    url = http://example.com/remote.git
    pushurl = git@example.com:remote.git

where "submodule-name" is the submodule's name and "remote-name"
is the name of the remote when it will be synchronized into the
submodule repository. The section-name is definitly up for
discussion and I don't really know if there might be issues with
the format "submodule-name.remote-name", but as far as I know
there is no possibility of having sub-subsections inside config
files.

There are some issues that I am currently aware of:

    - If we specify a remote "origin" for a submodule, `git
      submodule sync` will happily overwrite
      submodule.${submodule-name}.url. We certainly don't want to
      drop the old way of specifying a single URL but I am not
      sure what to do when a new "origin" has been specified.
      Perhaps a warning or user confirmation would suffice?

    - If the user specifies his own remotes and afterwards syncs
      the submodule's remotes, his settings will be overwritten.
      Maybe remotes should only be synced when a switch is
      specified (e.g. `git submodule sync --remotes` or `git
      submodule remotes sync`)?

This patch series is not intended to be included as-is as there
are no tests yet and the implementation has not been tested that
much. It should only evaluate if there is any interest and
hopefully spark some discussion as to if this feature is
something that is regarded as useful to others.

iveqy in IRC told me that there has been a discussion on
something similar, I wasn't able to find that though.

Regards
Patrick


Patrick Steinhardt (4):
  submodules: implement synchronizing of remotes.
  submodules: implement remote commands.
  submodules: update docs to reflect remotes.
  submodules: add bash completion for remotes.

 Documentation/git-submodule.txt        |  23 +++
 contrib/completion/git-completion.bash |   2 +-
 git-submodule.sh                       | 252 ++++++++++++++++++++++++++++++++-
 3 files changed, 274 insertions(+), 3 deletions(-)

-- 
2.3.5
