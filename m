From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 3/4] git-commit-am: Allow automatic rebasing to preserve
 empty commits
Date: Sat, 31 Mar 2012 09:03:08 -0400
Message-ID: <20120331130308.GD2409@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-4-git-send-email-nhorman@tuxdriver.com>
 <7v8vihlssj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 15:03:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDxxf-0002Dd-59
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 15:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab2CaNDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 09:03:15 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42835 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab2CaNDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 09:03:14 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDxxV-0005jn-RK; Sat, 31 Mar 2012 09:03:12 -0400
Content-Disposition: inline
In-Reply-To: <7v8vihlssj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194452>

On Fri, Mar 30, 2012 at 01:47:56PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Using the keep_empy environment variable, this change allows git-commit-am to
> > apply empty commits to the new branch we are rebasing to
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > CC: Jeff King <peff@peff.net>
> > CC: Phil Hord <phil.hord@gmail.com>
> > CC: Junio C Hamano <gitster@pobox.com>
> > ---
> >  git-rebase--am.sh |   20 +++++++++++++++-----
> >  1 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> > index c815a24..c1d1b60 100644
> > --- a/git-rebase--am.sh
> > +++ b/git-rebase--am.sh
> > @@ -20,11 +20,21 @@ esac
> >  
> >  test -n "$rebase_root" && root_flag=--root
> >  
> > -git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> > -	--src-prefix=a/ --dst-prefix=b/ \
> > -	--no-renames $root_flag "$revisions" |
> > -git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
> > -move_to_original_branch
> > +if [ -n "$keep_empty" ]
> > +then
> > +	# we have to do this the hard way.  git format-patch completly squashes
> > +	# empty commits and even if it didn't the format doesn't really lend
> > +	# itself well to recording empty patches.  fortunately, cherry-pick
> > +	# makes this easy
> > +	git cherry-pick --keep-empty "$revisions" && move_to_original_branch
> 
> Does cherry-pick know the "--ignore-if-in-upstream" trick?  Otherwise I
> suspect that this will introduce a severe regression to the command, as
> the commits that are already in the new base you are rebasing to will all
> be kept as empty commits, no?
> 
Hmm, you may be correct.  I'd not really thought of that.  I can borrow the
format-patch code for that option and incorporate it into cherry-pick to fix
that up.  Would that be sufficient?

Neil
