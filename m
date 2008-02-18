From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 1/2] Tidy up git mergetool's backup file behaviour and variable names
Date: Mon, 18 Feb 2008 08:08:41 +0000
Message-ID: <20080218080841.GA12008@hashpling.org>
References: <9543203388d64839de78822efb538903fc15bf7f.1203251306.git.charles@hashpling.org> <7vy79jsza1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR14t-0007e1-B3
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbYBRIJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbYBRIJn
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:09:43 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:58757 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbYBRIJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:09:43 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1JR14G-00048R-01; Mon, 18 Feb 2008 08:09:40 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1I88gQW012373;
	Mon, 18 Feb 2008 08:08:42 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1I88goW012372;
	Mon, 18 Feb 2008 08:08:42 GMT
Content-Disposition: inline
In-Reply-To: <7vy79jsza1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: e2648eb662abde8f69072da62ef9f5b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74240>

On Sun, Feb 17, 2008 at 07:45:42PM -0800, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> > Currently a backup pre-merge file with conflict markers is sometimes
> > kept with a .orig extenstion and sometimes removed depending on the
> > particular merge tool used.
> >
> > This patch makes the handling consistent across all merge tools and
> > configurable via a new mergetool.keepBackup config variable
> >
> > Changed the merge file path variable to MERGED for consistency with the
> > names of the merge temporary filename variables. This done with the
> > intention of having these variables used by user scripts in a subsequent
> > custom merge tool patch.
> 
> I would have preferred two separate patches, one s/path/MERGED/
> and the other save/remove clean-up, which would be much easier
> way to review, but this is what we have, so let's work on this
> version.

Fair enough, I'll send an update.
> 
> > +mergetool.keepBackup::
> > +	After performing a merge, the original file with conflict markers
> > +	can be saved as a file with a `.orig` extension.  If this variable
> > +	is set to `false` then this file is not preserved.
> > +
> 
> s/$/  Defaults to true (i.e. keep the backup files)/.

Noted.

> We might also want a command line option to override the user's
> usual default specified with this configuration but that can be
> left for later rounds.

Agreed, I'll tackle this later, given time.

> > @@ -112,11 +112,11 @@ resolve_deleted_merge () {
> >  }
> >  
> >  check_unchanged () {
> > -    if test "$path" -nt "$BACKUP" ; then
> > +    if test "$MERGED" -nt "$BACKUP" ; then
> 
> I think this is the cause of your automated test sometimes
> needing 1 sec sleep.  This check should perhaps be done with a
> "!  cmp $MERGED $BACKUP >/dev/null", which would succeed if the
> user's interaction with the backend tool touched the file.

I don't think that we should spend too much time on this seeing as I
now fail to reproduce it, but as the code was avoiding the interactive
path (i.e. trusting the exit code), it shouldn't have been this check.

> 
> The rest of the patch looked fine to me.
> 
> We might also want to add -y (assume "Yes" answer to "Did you
> resolve it" question without actually asking) command line
> option to the script, but that would be for later rounds.

Yes, and this would help the automated tests.
