From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Thu, 02 Oct 2008 14:52:17 +0200
Message-ID: <48E4C401.90409@drmicha.warpmail.net>
References: <48CF5127.5040507@gnu.org> <48CF5ABC.5060507@gmail.com> <48CF6A7C.4020604@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 14:53:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlNgk-00088S-HS
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 14:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYJBMwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 08:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYJBMwY
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 08:52:24 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47678 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753432AbYJBMwX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2008 08:52:23 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 907B617167A;
	Thu,  2 Oct 2008 08:52:21 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 02 Oct 2008 08:52:21 -0400
X-Sasl-enc: hZiA+1mRr+rKUu1iO7kX89Qh0IlIYXvgB4VYhTWXq2rd 1222951940
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 011472758A;
	Thu,  2 Oct 2008 08:52:19 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48CF6A7C.4020604@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97320>

Following up on the discussion about tracking oo files I conducted a
minimalistic test. I simulated tracking an oo spreadsheat, where from
one version to the next only a few cells would be entered in an existing
spreadsheet. These are the sizes of the individual files:

48K     0.ods
48K     1.ods
60K     2.ods
60K     3.ods
56K     4.ods
64K     5.ods
68K     6.ods
64K     7.ods
64K     8.ods
68K     9.ods
600K    total

I then tracked this in three different ways, each in a fresh repo:

"packed": copy $i.ods to t.ods as is, git add t.ods and commit.
"unpacked": use the unzipped contents of $i.ods instead.
"rezip": use the rezipped version (compression 0, using Sergio's script).
"oofilter": use clean/smudge filters (calling Sergio's rezip)

Here are the resulting sizes: first ".git/objects" as is, then after
repacking -adf, finally the total size of .git + the work tree (i.e. the
last revision).

packed
708K    .git/objects
492K    .git/objects
692K    .git + wt

unpacked
1,3M    .git/objects
144K    .git/objects
1,5M    .git + wt

rezip
992K    .git/objects
148K    .git/objects
1,4M    .git + wt

oofilter
984K    .git/objects
148K    .git/objects
352K    .git + wt

Unsurprisingly, the total size is dominated by the work tree size if you
 have few revisions. (Also, templates and such contribute.)
Note that git log --stat will report the sizes of packed files in the
first case, but the sizes of unpacked files in all other cases. In
particular, it reports a different size for the  HEAD revision than you
have in a HEAD checkout.

I tried rewriting "packed" after configuring the filters: filter-branch
refuses to work with a dirty work-tree, even after "checkout -f HEAD"
and "reset --hard". It seems that git status is permanently confused
here. (Has anyone successfully rewritten existing oo files?)

I'm not sure about the lessons, but I wanted to share the numbers
anyways. I think this (your script and its usage) is heading in a useful
direction and should maybe made more known, if not made easier from the
git side. Also I'm still looking for a good (deterministic) pdf
recompressor.

Michael

git version 1.6.0.2.426.g2cfa6
