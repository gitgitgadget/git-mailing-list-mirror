From: Adam Simpkins <simpkins@facebook.com>
Subject: Re: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Tue, 18 Aug 2009 19:29:18 -0700
Message-ID: <20090819022918.GO8147@facebook.com>
References: <1250628954.114121983@192.168.1.201> <20090818211812.GL8147@facebook.com> <7vk5103chi.fsf@alter.siamese.dyndns.org>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 04:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdavZ-0000uo-T3
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 04:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbZHSC3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 22:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbZHSC3V
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 22:29:21 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:59268 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbZHSC3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 22:29:20 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.15] (may be forged))
	by pp-master.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7J2TA7m031715
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 18 Aug 2009 19:29:10 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 18 Aug
 2009 19:29:18 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1MdavO-0005op-1f; Tue, 18 Aug 2009 19:29:18 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
Content-Disposition: inline
In-Reply-To: <7vk5103chi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-18_15:2009-08-11,2009-08-18,2009-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908180219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126498>

On Tue, Aug 18, 2009 at 04:53:45PM -0700, Junio C Hamano wrote:
> Adam Simpkins <simpkins@facebook.com> writes:
> 
> > -	return (commit->object.flags & (UNINTERESTING | TREESAME)) ? 0 : 1;
> > +	return simplify_commit(graph->revs, commit) == commit_show;
> 
> If you do this after revision.c finished the traversal (e.g. "limited"
> case), I think it should be Ok.
> 
> But calling simplify_commit() while the traversal is still in progress is
> asking for trouble.  I do not recall the details anymore but when I tried
> to make the "simplify-merges" algorithm incremental, I had seen funny
> breakage caused by calling simplify_commit() twice on the same commit.
> 
> I suspect that this change will break the primary traversal.

The --graph option always enables revs->topo_order, which in turn
enables revs->limited, so this should always be after limit_list() has
already been called.

However, it looks like the call to rewrite_parents() is the only
modifying operation in simplify_commit(), and all the rest can easily
be split out into a separate helper function.  I'll submit another
version of the patch that makes the non-modifying simplify_commit()
behavior available as a separate function.

-- 
Adam Simpkins
simpkins@facebook.com
