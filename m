From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] speed: reuse char instead of recreation in loop
Date: Mon, 25 May 2009 18:08:55 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905251733240.2147@iabervon.org>
References: <pan.2009.05.25.19.44.10@fedoraproject.org> <20090525201602.GA18471@atjola.homenet> <pan.2009.05.25.20.40.20@fedoraproject.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1819914988-1243288404=:2147"
Cc: git@vger.kernel.org
To: Thomas Spura <tomspur@fedoraproject.org>
X-From: git-owner@vger.kernel.org Tue May 26 00:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iLv-0003lr-O1
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbZEYWIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbZEYWIz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:08:55 -0400
Received: from iabervon.org ([66.92.72.58]:45078 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbZEYWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:08:54 -0400
Received: (qmail 11690 invoked by uid 1000); 25 May 2009 22:08:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 May 2009 22:08:55 -0000
In-Reply-To: <pan.2009.05.25.20.40.20@fedoraproject.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0905251755030.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119969>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1819914988-1243288404=:2147
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0905251755031.2147@iabervon.org>

On Mon, 25 May 2009, Thomas Spura wrote:

> Am Mon, 25 May 2009 22:16:02 +0200 schrieb Björn Steinbrink:
> 
> > On 2009.05.25 19:44:10 +0000, Thomas Spura wrote:
> >> Move a char and a char * outside of a for loop for speed improvements
> >> 
> >> Signed-off-by: Thomas Spura <tomspur@fedoraproject.org> ---
> >> Comments?
> >> 
> >>  transport.c |    7 +++----
> >>  1 files changed, 3 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/transport.c b/transport.c index 17891d5..e350937 100644
> >> --- a/transport.c
> >> +++ b/transport.c
> >> @@ -263,11 +263,10 @@ static int write_refs_to_temp_dir(struct strbuf
> >> *temp_dir,
> >>  		int refspec_nr, const char **refspec)
> >>  {
> >>  	int i;
> >> +	unsigned char sha1[20];
> >> +	char *ref;
> >>  
> >>  	for (i = 0; i < refspec_nr; i++) {
> >> -		unsigned char sha1[20];
> >> -		char *ref;
> >> -
> > 
> > I doubt that this makes any difference at all.
> 
> With ints, the loop costs about 40% of speed. Without recreation, it 
> should be always faster.

Actually, having the variables go out of scope should be at least as fast. 
The compiler doesn't actually do anything to make the old variable
inaccessible and get a new variable; with the variable uninitialized, it's 
legitimate for the compiler to simply reuse the same storage for all 
iterations. Futhermore, with the variables declared inside the loop, the 
compiler is allowed to make optimizations that would fail to preserve 
those variables between iterations. There are probably no such 
optimizations in this code for it to make, but, in general, letting 
variables in loops go out of scope (in C) only improves optimization 
possibilities.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1819914988-1243288404=:2147--
