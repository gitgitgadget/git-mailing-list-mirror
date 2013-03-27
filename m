From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] merge-tree: fix "same file added in subdir"
Date: Wed, 27 Mar 2013 22:57:39 +0000
Message-ID: <20130327225739.GT2286@serenity.lan>
References: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk>
 <7vk3osjwgv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzIN-0006Ec-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab3C0W5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:57:47 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49205 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab3C0W5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:57:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id CF7956064CA;
	Wed, 27 Mar 2013 22:57:46 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zRvo+YP5-s4e; Wed, 27 Mar 2013 22:57:46 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 334BB6064E1;
	Wed, 27 Mar 2013 22:57:41 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vk3osjwgv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219351>

On Wed, Mar 27, 2013 at 03:42:40PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When the same file is added with identical content at the top level,
> > git-merge-tree prints "added in both" with the details.  But if the file
> > is added in an existing subdirectory, threeway_callback() bails out early
> > because the two trees have been modified identically.
> >
> > In order to detect this, we need to fall through and recurse into the
> > subtree in this case.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> 
> The rationale the above description gives is internally consistent,
> but it is rather sad to see this optimization go.  The primary
> motivation behind this program, which does not use the usual
> unpack-trees machinery, is to allow us to cull the identical result
> at a shallow level of the traversal when the both sides changed (not
> added) a file deep in a subdirectory hierarchy.
> 
> The patch makes me wonder if we should go the other way around,
> resolving the "both added identically" case at the top cleanly
> without complaint.

I don't use merge-tree so I have no opinion on this, just wanted to fix
an inconsistency :-)

I'll try to have a look at doing the other change tomorrow if no one
else gets there first.

> >  builtin/merge-tree.c  |  9 +++++++--
> >  t/t4300-merge-tree.sh | 17 +++++++++++++++++
> >  2 files changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index e0d0b7d..ca97fbd 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -298,12 +298,17 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
> >  {
> >  	/* Same in both? */
> >  	if (same_entry(entry+1, entry+2)) {
> > -		if (entry[0].sha1) {
> > +		if (entry[0].sha1 && !S_ISDIR(entry[0].mode)) {
> >  			/* Modified identically */
> >  			resolve(info, NULL, entry+1);
> >  			return mask;
> >  		}
> > -		/* "Both added the same" is left unresolved */
> > +		/*
> > +		 * "Both added the same" is left unresolved.  We also leave
> > +		 * "Both directories modified identically" unresolved in
> > +		 * order to catch changes where the same file (with the same
> > +		 * content) has been added to both directories.
> > +		 */
> >  	}
> >  
> >  	if (same_entry(entry+0, entry+1)) {
> > diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> > index d0b2a45..be0737e 100755
> > --- a/t/t4300-merge-tree.sh
> > +++ b/t/t4300-merge-tree.sh
> > @@ -298,4 +298,21 @@ test_expect_success 'turn tree to file' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'add identical files to subdir' '
> > +	cat >expected <<\EXPECTED &&
> > +added in both
> > +  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/ONE
> > +  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/ONE
> > +EXPECTED
> > +
> > +	git reset --hard initial &&
> > +	mkdir sub &&
> > +	test_commit "sub-initial" "sub/initial" "initial" &&
> > +	test_commit "sub-add-a-b-same-A" "sub/ONE" "AAA" &&
> > +	git reset --hard sub-initial &&
> > +	test_commit "sub-add-a-b-same-B" "sub/ONE" "AAA" &&
> > +	git merge-tree sub-initial sub-add-a-b-same-A sub-add-a-b-same-B >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> >  test_done
