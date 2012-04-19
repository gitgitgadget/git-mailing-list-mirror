From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v6 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 09:08:18 -0400
Message-ID: <20120419130818.GA18339@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-5-git-send-email-nhorman@tuxdriver.com>
 <7vmx68k5oy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 15:08:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKr6C-0007N3-LS
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 15:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab2DSNIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 09:08:32 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:51895 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab2DSNIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 09:08:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.202] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKr5v-0003PB-BD; Thu, 19 Apr 2012 09:08:25 -0400
Content-Disposition: inline
In-Reply-To: <7vmx68k5oy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195940>

On Wed, Apr 18, 2012 at 03:58:53PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Add a command line switch to git-rebase to allow a user the ability to specify
> > that they want to keep any commits in a series that are empty.
> >
> > When git-rebase's type is am, then this option will automatically keep any
> > commit that has a tree object identical to its parent.
> >
> > This patch changes the default behavior of interactive rebases as well.  With
> > this patch, git-rebase -i will produce a revision set passed to
> > git-revision-editor, in which empty commits are commented out.  Empty commits
> > may be kept manually by uncommenting them.  If the new --keep-empty option is
> > used in an interactive rebase the empty commits will automatically all be
> > uncommented in the editor.
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > ---
> 
> The earlier one in the series seem to be getting solid enough.  Nice.
> 
Thanks!

> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 5812222..cef290b 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -167,6 +167,12 @@ has_action () {
> >  	sane_grep '^[^#]' "$1" >/dev/null
> >  }
> >  
> > +is_empty_commit() {
> > +	tree=$(git rev-parse "$1"^{tree})
> > +	ptree=$(git rev-parse "$1"^^{tree})
> > +	return $(test "$tree" = "$ptree")
> > +}
> 
> Could "$1" ever be a root commit without a parent?
> 
Strictly speaking, yes.  If that happens, however, the output of git rev-parse
will be an error message that includes the passed in revision.  since tree
passes '^' while ptree passes '^^' the two revisions will always differ, and as
a result is_empty_commit will return false, and the existing behavior of git
will be followed.  So, yes, rebasing an empty tree would cause odd output in the
rev-parse calls in is_empty_comit, but the behavior of git overall would be
unaffected (which is not to say that rebasing an empty tree won't show odd
corner-case behavior, only that this changeset won't introduce any new odd
corner case behavior :) ).

If you like we can add additional checking to ensure that we explicitly catch
rev-parse errors and abort the rebase imediately, but I don't think thats
strictly necessecary.  Would you prefer that?

Regards
Neil
 
