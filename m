From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 08:53:01 +0100
Message-ID: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 09:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnpOl-0006qR-KJ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 09:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbZIPH5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 03:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbZIPH5q
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 03:57:46 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36068 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754848AbZIPH5q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 03:57:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id DD30633FA29
	for <git@vger.kernel.org>; Wed, 16 Sep 2009 08:57:48 +0100 (BST)
Received: (qmail 30289 invoked by uid 103); 16 Sep 2009 08:53:10 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9808. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025046 secs); 16 Sep 2009 07:53:10 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Sep 2009 08:53:10 +0100
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128613>

I have a repository at $dayjob where fetch was taking ~30s to tell me
that there were no updates.

It turns out that I appear to have added a nasty linear search of all
remote refs for every commit (i.e. tag^{}) tag ref way back in the
original C implementation of fetch.  This doesn't scale well to large
numbers of refs, so this replaces it with a hash table based lookup
instead, which brings the time down to a few seconds even for very large
ref counts.

I haven't tested it with non-native transports, but there is no reason
to believe that the code should be transport specific.

Julian Phillips (2):
  ref-dict: Add a set of functions for working with a ref dictionary
  fetch: Speed up fetch by using ref dictionary

 Makefile        |    1 +
 builtin-fetch.c |   19 ++++++-------
 ref-dict.c      |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ref-dict.h      |   13 +++++++++
 4 files changed, 99 insertions(+), 10 deletions(-)
 create mode 100644 ref-dict.c
 create mode 100644 ref-dict.h
