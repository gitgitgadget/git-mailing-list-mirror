From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Narrow clone implementation difficulty estimate
Date: Thu, 14 May 2009 14:04:30 +0400
Organization: HOME
Message-ID: <200905141404.30695.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Asger Ottar Alstrup <asger@ottaralstrup.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 11:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Xj5-0007Zi-DH
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 11:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbZENJ7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 05:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZENJ7a
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 05:59:30 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:61255 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbZENJ73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 05:59:29 -0400
Received: by pzk13 with SMTP id 13so522661pzk.33
        for <git@vger.kernel.org>; Thu, 14 May 2009 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-disposition:from
         :organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=IIUc2UtZH7x+BOHJjf9E9psvzCrY4awOVOetdGZ//kI=;
        b=FuSJBfN4RgqUAu2PDqrp9YoOd2X9FIbbzlaAiMilrSoM/dNqfaSlsLQVe+6mJTeVz5
         dqbR5DSNsvxmVh55KvoJSr7WY1a0B448HCqcjTPFignlKd7EFVV7VHlVq0odA3oA47BG
         zcrOb7utifBapiuBdC67XNU/tNyVJKb1PmGc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-disposition:from:organization:to:subject:date:user-agent:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=x7DoTF5pm3ww+5pfdX3jrFKgS94oocdjAN5nO/XTkchb3cfScRbYYLDO1zdC4py9zT
         u7CJLg04rtYTWm3cIn3mmq6HWrm0jOuyU09tQhr8d8n/1rjDtFZVnIMdEF0OvkBGieya
         rh6GM/J2Fui3uPW90sotawHpiB1AGmwS5mo64=
Received: by 10.114.134.1 with SMTP id h1mr1826902wad.219.1242295170168;
        Thu, 14 May 2009 02:59:30 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id z20sm2497067pod.12.2009.05.14.02.59.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 02:59:29 -0700 (PDT)
Content-Disposition: inline
User-Agent: KMail/1.11.2 (Linux/2.6.27.21-170.2.56.fc10.i686; KDE/4.2.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119178>

Hello,

We are considering using Git to manage a large set of mostly binary
files (large images, pdf files, open-office documents, etc). The
amount of data is such that it is infeasible to force every user
to download all of it, so it is necessary to implement a partial
retrieval scheme.

In particular, we need to decide whether it is better to invest
effort into implementing Narrow Clone, or partitioning and
reorganizing the data set into submodules (the latter may prove
to be almost impossible for this data set). We will most likely
develop a new, very simplified GUI for non-technical users,
so the details of both possible approaches will be hidden
under the hood.


After some looking around, I think that Narrow clone would probably involve:

1. Modifying the revision walk engine used by the pack generator to
allow filtering blobs using a set of path masks. (Handling the same
tree object appearing at different paths may be tricky.)

2. Modifying the fetch protocol to allow sending such filter
expressions to the server.

3. Adding necessary configuration entries and parameters to commands,
in order to allow using the new functionality.

4. Resurrecting the sparse checkout series and merging it with the
new filtering logic. Narrow clone must imply sparse checkout that
is a subset of the cloned paths.

5. Fixing all breakage that may be caused by missing blobs.

I feel that the last point involves the most uncertainty, and may also
prove the most difficult one to implement. However, I cannot judge the
actual difficulty due to an incomplete understanding of Git internals.


I currently see the following additional problems with this approach:

1. Merge conflicts outside the filtered area cannot be handled.
However, in the case of this project they are estimated to be
extremely unlikely.

2. Changing the filter set is tricky, because extending the watched
area requires connecting to the server, and requesting missing blobs.
This action appears to be mostly identical to initial clone with a
more complex filter. On the other hand, shrinking the area would leave
unnecessary data in the repository, which is difficult to reuse safely
if the area is extended back. Finally, editing the set without
downloading missing data essentially corrupts the repository.

3. One of the goals of using git is building a distributed mirroring
system, similar to gittorrent or mirror-sync proposals. Narrow clone
significantly complicates this because of incomplete data sets.
A simple solution may be restricting download to peers whose set is
a superset of what's needed, but that may cause the system to degrade
to a fully centralized one.


In relation to the last point, namely building a mirroring
network, I also had an idea that perhaps in the current state
of things bundles are more suited to it, because they can be
directly reused by many peers, and deciding what to put in
the bundle is not much of a problem for this particular project.
I expect that implementation of narrow bundle support should
not be much different from narrow clone.


Currently we are evaluating possibilities to approach this
problem, and would like to know if this analysis makes sense.
We are willing to contribute the results to the Git community
if/when we implement it.

Alexander
