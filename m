From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 13:17:52 +0100
Message-ID: <20080314121752.GB3315@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site> <20080313224741.GA5000@localhost> <7vhcf9r4qp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:18:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja8rv-0007P1-Py
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 13:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYCNMSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 08:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbYCNMR7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 08:17:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:35863 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbYCNMR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 08:17:58 -0400
Received: by ug-out-1314.google.com with SMTP id z38so53059ugc.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 05:17:57 -0700 (PDT)
Received: by 10.67.106.13 with SMTP id i13mr319168ugm.49.1205497077041;
        Fri, 14 Mar 2008 05:17:57 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.54.52])
        by mx.google.com with ESMTPS id 29sm408669uga.50.2008.03.14.05.17.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 05:17:54 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Ja8rA-0001JZ-U1; Fri, 14 Mar 2008 13:17:52 +0100
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <7vhcf9r4qp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77214>

On Fri, Mar 14, 2008 at 03:15:26AM -0700, Junio C Hamano wrote:
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 34e3167..d8938cc 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1025,12 +1025,21 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
> >  			hashcpy(result.sha, b->sha1);
> >  		}
> >  	} else {
> > -		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
> > -			result.merge = 1;
> > -
> > -		result.mode = a->mode == o->mode ? b->mode: a->mode;
> > +		/*
> > +		 * If mode changed in only one branch, keep the changed
> > +		 * version. Otherwise, keep remote version and create a
> > +		 * conflict.
> > +		 */
> 
> Reading the rest of the function, I notice that it consistently favor "a"
> over "b", when a conflict cannot be reconciled.

Indeed. I think "b" should be favored over "a", however.

> > +		if (a->mode != o->mode && b->mode != o->mode &&
> > +				a->mode != b->mode) {
> > +			result.clean = 0;
> > +			result.mode = b->mode;
> > +		} else
> > +			result.mode = o->mode == a->mode ? b->mode : a->mode;
> 
> I think this is much easier to read:
> 
> 		if (a->mode == b->mode || a->mode == o->mode)
> 			result.mode = b->mode;
> 		else {
> 			result.mode = a->mode;
> 			if (b->mode != o->mode) {
> 				result.clean = 0;
> 				result.merge = 1;
> 			}
> 		}
> 
> We keep "b" only if "a" hasn't touched the mode, or it happens to be the
> same as "a".  Otherwise we take "a" anyway, but taking "a" when "b" also
> touched means we detected an unreconcilable conflict.

Yes, but if "b" and "a" both changed in the same way, we should still set
result.merge = 1, because that's more akin to an automatic merge than a
fast-forward merge, IMO.

Clemens
