From: worley@alum.mit.edu (Dale R. Worley)
Subject: What I want rebase to do
Date: Wed, 6 Mar 2013 13:55:20 -0500
Message-ID: <201303061855.r26ItKtM018797@freeze.ariadne.com>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
 <7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
 <87sj4aoo3s.fsf@pctrast.inf.ethz.ch> <7vppzex2pq.fsf@alter.siamese.dyndns.org>
Cc: trast@student.ethz.ch, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 19:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDJVF-0000Eo-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 19:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab3CFSzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 13:55:24 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:54437
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753839Ab3CFSzX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 13:55:23 -0500
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id 8CTs1l0030mv7h059JvNRB; Wed, 06 Mar 2013 18:55:22 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id 8JvN1l0031KKtkw3XJvN0S; Wed, 06 Mar 2013 18:55:22 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r26ItLdL018799;
	Wed, 6 Mar 2013 13:55:21 -0500
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r26ItKtM018797;
	Wed, 6 Mar 2013 13:55:20 -0500
In-reply-to: <7vppzex2pq.fsf@alter.siamese.dyndns.org> (gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1362596122;
	bh=bZ9uEcwDCavxKSP7HQvZvTYFQrQIgKwBHxPb1nRQuN8=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=TSlgovkNZ18dayN9/86WiaoYuTqEXBBUQ76SmcfNjUsZvraC+OJPij/XPNOv61DBB
	 QjYXw3BFVpsJSoTFnONSZv4vKwUwYI5f5eKVmtEQY5XM8tmLjoDUVL4pdhmUh49mI+
	 BRxKs2Ss8JTbQKdkZ3sDGCImZcH87dQri3OOszYPQv19wk/Ppg3rJMXTw84XKJ3uK8
	 UbIv94DPO03wC9qZcCDwD6J3P/QVca3xIGQpvOkIVbsjGlxiE7faoFBBCgxUzT2+S6
	 z1L3yCl3ulAnzPW7AKQQ15F0FCxvZyM9n2fY3ueGMG5U6ptlinu3C+XYPdkf9aIUBU
	 Gq89hZjdA60UQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217537>

This is how I see what rebase should do:

The simple case for rebase starts from

               P---Q---R---S master
                    \
                     A---B---C topic

Then "git checkout topic ; git rebase master" will change it to

               P---Q---R---S master
                            \
                             A'--B'--C' topic

A' is created by a three-way merge that can be symbolized

        Q-->S
        |   |
        v   v
        A-->A'

That is, Q, applying the changes from Q to A and the changes from Q to
S, becomes A'.

After that

        A-->A'
        |   |
        v   v
        B-->B'
        |   |
        v   v
        C-->C'

A more complex case is when there is a merge from an external source

               P---Q---R---S master
                    \
                     A---M---C topic
                        /
                    ---X

We want to produce

               P---Q---R---S master
                            \
                             A'--M'--C' topic
                                /
                            ---X

So we have to merge

        Q-->S
        |   |
        v   v
        A-->A'
        |   |
        v   v
        M-->M'
        |   |
        v   v
        C-->C'

Any "evil" changes in M will be in the changes A->M (along with the
changes introduced from X), and so they will be reincorporated in
A'->M'.  M' lists A' and X as its parents.  (And not M!)

If there is an internal merge in the topic branch, things look like
this

               P---Q---R---S master
                    \
                     \   B
                      \ / \
                       A   M---D topic
                        \ /
                         C

and we want to produce this

               P---Q---R---S master
                            \
                             \    B'
                              \  /  \
                               A'    M'--D' topic
                                 \  /
                                  C'

Which can be done with these merges


        Q-->S
        |   |
        v   v
        A-->A'        A-->A'
        |   |         |   | 
        v   v         v   v 
        B-->B'        C-->C'

There are two choices for constructing M' (which ought to produce the
same results under ordinary circumstances)

        B-->B'        C-->C'
        |   |         |   | 
        v   v         v   v 
        M-->M'        M-->M'

and finally

        M-->M'
        |   |
        v   v
        D-->D'

Dale
