From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH-v2/RFC 2/6] xutils: fix hash with whitespace on incomplete
 line
Date: Sun, 23 Aug 2009 12:02:14 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908231050240.29625@GWPortableVCS>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-2-git-send-email-git@tbfowler.name> <7veir3ynma.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfGSw-0006sG-2G
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 19:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934019AbZHWRCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933980AbZHWRCj
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 13:02:39 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:40833 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933977AbZHWRCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 13:02:38 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MfGSm-0003YM-FB; Sun, 23 Aug 2009 12:02:40 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <7veir3ynma.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126862>

Junio C Hamano (gitster@pobox.com) wrote on Aug 23, 2009:
> Thell Fowler <git@tbfowler.name> writes:
> 
> >   - Make xdl_hash_record_with_whitespace stop hashing before the
> >     eof when ignoring space change or space at eol on an incomplete
> >     line.
> >
> >   Resolves issue with a final trailing space being included in the
> >   hash on an incomplete line by treating the eof in the same fashion
> >   as a newline.
> 
> Please study the style of existing commit messages and imitate them.
> 

I'll keep trying.

> > Signed-off-by: Thell Fowler <git@tbfowler.name>
> > ---
> >  xdiff/xutils.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> > index 04ad468..c6512a5 100644
> > --- a/xdiff/xutils.c
> > +++ b/xdiff/xutils.c
> > @@ -248,12 +248,12 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
> >  			if (flags & XDF_IGNORE_WHITESPACE)
> >  				; /* already handled */
> >  			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
> > -					&& ptr[1] != '\n') {
> > +					&& ptr[1] != '\n' && ptr + 1 < top) {
> >  				ha += (ha << 5);
> >  				ha ^= (unsigned long) ' ';
> >  			}
> >  			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
> > -					&& ptr[1] != '\n') {
> > +					&& ptr[1] != '\n' && ptr + 1 < top) {
> >  				while (ptr2 != ptr + 1) {
> >  					ha += (ha << 5);
> >  					ha ^= (unsigned long) *ptr2;
> 
> Thanks.
> 
> The issue you identified and tried to fix is a worthy one.  But before the
> pre-context of this hunk, I notice these lines:
> 
> 		if (isspace(*ptr)) {
> 			const char *ptr2 = ptr;
> 			while (ptr + 1 < top && isspace(ptr[1])
> 					&& ptr[1] != '\n')
> 				ptr++;
> 
> If you have trailing whitespaces on an incomplete line, ptr initially
> points at the first such whitespace, ptr2 points at the same location, and
> then the while() loop advances ptr to point at the last byte on the line,
> which in turn will be the last byte of the file.  And the codepath with
> your updates still try to access ptr[1] that is beyond that last byte.
> 
> I would write it like this patch instead.
> 
> The intent is the same as your patch, but it avoids accessing ptr[1] when
> that is beyond the end of the buffer, and the logic is easier to follow as
> well.
> 

I appreciate your taking the time to look at the issue and explaining the 
reasons for your change.

> -- >8 --
> Subject: xutils: fix hashing an incomplete line with whitespaces at the end
> 
> Upon seeing a whitespace, xdl_hash_record_with_whitespace() first skipped
> the run of whitespaces (excluding LF) that begins there, ensuring that the
> pointer points the last whitespace character in the run, and assumed that
> the next character must be LF at the end of the line.  This does not work
> when hashing an incomplete line, that lacks the LF at the end.
> 
> Introduce "at_eol" variable that is true when either we are at the end of
> line (looking at LF) or at the end of an incomplete line, and use that
> instead throughout the code.
> 
> Noticed by Thell Fowler.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Yeah... comparing this commit message to the original shows a pretty stark 
difference.  I'll get it 'the git way' eventually.

-- 
Thell
