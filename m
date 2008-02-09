From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] New commit object headers: generation and note headers
Date: Sat, 9 Feb 2008 17:46:07 +0100
Message-ID: <200802091746.09102.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 17:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNsr5-000534-4V
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 17:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbYBIQqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 11:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbYBIQqY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 11:46:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:43204 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbYBIQqW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 11:46:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3227623fga.17
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 08:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=Z+XCBZXbRPPzHwH3Epj5Tw0JiHGK1o2yNq3+UEXMn2w=;
        b=lSHBSWjMO7ASSeaZvV3sVJ29QqUPypG57Dx4FyKO5JYKFa/M3NuMDUiqrlouIA7ix5adAcNdtC2tYw3qBHh+dNewq/cFOxMI6jbLvs6n18MRnV0v+cxose5cP8gLOECcW1d89tyVNbgfRC238IN7pFSxfvPrMq52sfu69vjaCgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=S8a3+C+iAzhUe3ObxsEwSvcS7ABCubJSGiHLo/1xpp+pWPfKiG8sDufS75XlzwOIROTmJu3gfwUBkZHyh6jr1kB9Hy/BA+wyGOnc74iTgu1Jtmqmf1J+ZIBOkCv4TeiXSU3nhOnCcGE36rAZ6JnkfZTiEAijz2qO2AbrqnK1xlc=
Received: by 10.82.116.15 with SMTP id o15mr25728320buc.3.1202575580564;
        Sat, 09 Feb 2008 08:46:20 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.206.168])
        by mx.google.com with ESMTPS id z40sm14906885ikz.4.2008.02.09.08.46.18
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 08:46:19 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73239>

As new major git release 1.6.0 is close (BTW. I wonder if git would ever 
reach/get 2.0.0 release...), I'd like to sum up here, adding my own 
thoughts and comments, ideas about extending commit object by adding 
new headers. I think it would be better to have such major feature 
introduced in major release, and not with only minor number changed.
For some headers the faster it is introduced the better.


1. 'generation' header

In the "[BUG?] git log picks up bad commit" thread:
  http://permalink.gmane.org/gmane.comp.version-control.git/72274
later "[RFH] revision limiting sometimes ignored" there was resurrected 
idea of the 'generation' header. This header is meant to simplify 
removing uninteresting commits in the presence of clock skew, to 
replace various commit-time related heuristics.

The proposed solution (which was at least once discussed in the past on 
git mailing list) is to use for this "generation number":
 1. For parentless (root) commits it equals 1 (or 0)
 2. For each commit, it equals maximum of generation numbers of parents,
    plus 1.
Of course to not to have to recalculate it from beginning it must be 
saved somewhere. Best solution is to use 'generation' header for that.

Unfortunately there is complication that commits written before this 
header introduced doesn't have generation number handy. It was proposed
then to use generation number if possible, and fallback to old date 
based heuristic if it does not exist, and do not (re)calculate it;
the idea is to avoid such cost.

My comments:
============
The problem is twofold: when to calculate generation header, and what to 
do with commits that lacks it. We could require to calculate generation 
header when creating a commit (commit, amend, rebase, filter-branch), 
but this might mean that a few first commits after 'generation' header 
is introduced would be much slower.

As for older commits which lacks generation number header: perhaps some 
(pack)-index-like external storage/cache, where generation numbers will 
be saved as we generate them? And perhaps some command to generate 
generation numbers in advance, in a free time.

Note that keeping generation numbers externally to the object database 
is more error prone (cache sync), and would not propagate.

The question is if to take grafts and shallows when creating version 
numbers: if they are to be saved in object database, then no. If saving 
to external pack-index like storage, then perhaps.


2. 'note' header (no semantical meaning)

There was some time ago discussion about adding 'note' header, initially 
to save original sha-1 of a commit for cherry-picking and rebase; then 
for saving explicit rename or corrected rename info, for saving chosen 
merge strategy, and for saving original ID of SCM import.

My comments:
============

>From all those I think what makes most sense is saving foreign SCM ID 
for a commit, for commits imported from other SCM. This way we do not 
have to parse commit message (fragile and ugly, and makes it harder for 
two-way exchange: no pristine commit message), or store them externally 
(not propagated, prone to be lost).

Another would be to save rename and copy info when importing from 
another SCM which tracks renames and not detects code movement. This 
would allow (at least theoretically) for lossless import. When 
detecting renames, in the process of finding common merge base(s), we 
could check and take into account such information. It would be purely 
advisory...

-- 
Jakub Narebski
Poland
