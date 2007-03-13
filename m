From: "David Tweed" <david.tweed@gmail.com>
Subject: [ANNOUNCE] chronoversion: chronological archiving script with temporary commits
Date: Tue, 13 Mar 2007 12:26:40 +0000
Message-ID: <e1dab3980703130526t4b573f18h793a065d54c9369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jonsmirl@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR65h-0004hM-FL
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 13:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965707AbXCMM0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 08:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965715AbXCMM0m
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 08:26:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:19896 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965707AbXCMM0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 08:26:41 -0400
Received: by wr-out-0506.google.com with SMTP id i28so1312104wra
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 05:26:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oUZ80Bf2P8XOAbu7cNroQWDsWknMxGtkyhWPr93D9AgmmXPZ8iGFE8QKayMT5I7r7+LwxiS8GfxuzA+Pt/VIJqbYyYr2P6vOOI8oI4LwSZ3CDEHIBp5eTRn+I7W2UerR+sF/1DfHZ5Wilg/IzIXKSuyezNe6ulGDD6gvkBADM4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OItwE5rMOwtK+EHp00VNXU4oe5gnwkohF0bOnl6XWRcSvc8S8tS3crpCiq+dwNQXgPQVYfpeMDoC9zgf35ORX2J4au6itaL/D5aqF4QtA884rNq2OKKf2v6PnJVkJQ+KPCWlgHqhac1+jv2rSmt8tO+eyCGuTdceZwPZm7wNEXM=
Received: by 10.64.233.12 with SMTP id f12mr1794399qbh.1173788800636;
        Tue, 13 Mar 2007 05:26:40 -0700 (PDT)
Received: by 10.65.160.2 with HTTP; Tue, 13 Mar 2007 05:26:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42114>

Hi, I believe that I've now got temporary commits (for bookkeeping,
hi-granularity bisecting recent changes) working, so I'm just
mentioning there's a new version of chronoversion at

http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.tgz

It maintains two parallel branches, master and temp, using temp for
high-granularity temporary commits that can be cleaned away at any
time. When a filetree state needs to be recorded on both branches it
doesn't merge branches but instead writes a commit tree and then
writes commit objects using that tree on both branches. Note: I don't
completely understand what all the low-level git stuff is supposed to
do so this code was experimented with until it appears to work.
Consequently, be very careful about entrusting any hyper-important
data to this.

A question for those who understand things: I stash the last written
_tree_'s hash in a tag and then when a new "commit's" directory tree
is written starts look to see if it's the same SHA value. If it is I
know I can avoid the commit. At the moment I'm using

    if os.path.exists(lastTreeFile) and
tree==open(lastTreeFile,"r").read()[:40]:

to be safe just in case a user, eg, goes mad and manually deletes that
record. Clearly this is going to hit trouble if git ever decides to
put this tag into a packed refs file.
Is there any neat way of using builtin stuff like git-rev-parse to ask
if a ref has a given SHA1 value and return an easily parsed yes/no
answer?

As a side note to Jon Smirl: I think kernel development is relatively
special in that you really can't safely test things at the same time
as you're editing the code (since clearly a kernel hang/oops/whatever
is possible). However, as I work on userspace programs I quite often
have my monte-carlo simulation code running on all the cores at the
same I edit its source code to try and refine it for the next run. So
in general if using git is "free" it'll be because editing tools and
git take tiny portions of current CPU's power rather than because
there're unused cores :-) (Actually, that's a serious point: I did put
in some thought into chronoversion to try and minimise its cpu usage
so it intruded as little as possible.)
-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
