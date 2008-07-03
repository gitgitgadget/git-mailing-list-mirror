From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 01:33:43 +0200
Message-ID: <20080703233343.GF6677@leksak.fem-net>
References: <20080703210950.GC6677@leksak.fem-net> <7vlk0iy5we.fsf@gitster.siamese.dyndns.org> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:35:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYKK-0007W6-QR
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbYGCXdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756448AbYGCXdt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:33:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:42324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756381AbYGCXds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:33:48 -0400
Received: (qmail invoked by alias); 03 Jul 2008 23:33:46 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp021) with SMTP; 04 Jul 2008 01:33:46 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+oK/YvAW+o93u5PqpQpPqM5Ns85/whEhnUQKtxOZ
	cgspI+vC98nO1K
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEYJ5-00064k-Bs; Fri, 04 Jul 2008 01:33:43 +0200
Content-Disposition: inline
In-Reply-To: <7vlk0iy5we.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87335>

Hi again,


On Thu, Jul 03, 2008 at 03:11:45PM -0700, Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> > +		sed -e 's/[$"\\]/\\&/g' -n -e '
> >  			s/^Author: \(.*\)$/GIT_AUTHOR_NAME="\1"/p;
> >  			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL="\1"/p;
> >  			s/^Date: \(.*\)$/GIT_AUTHOR_DATE="\1"/p
> > ###
> >
> > Is escaping $, " and \ enough?
> 
> Look at how it is done in git-sh-setup get_author_ident_from_commit.

Yes, single quotes are the other variant and perhaps a little more
robust.

--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -520,8 +520,9 @@ clean_author_script () {
 
 # Take "Name <e-mail>" in stdin and outputs author script
 make_author_script_from_string () {
-	sed -e 's/^\(.*\) <\(.*\)>.*$/GIT_AUTHOR_NAME="\1"\
-GIT_AUTHOR_EMAIL="\2"\
+	sed -e "s/'/'"'\\'"''/g" \
+	    -e 's/^\(.*\) <\(.*\)>.*$/GIT_AUTHOR_NAME='\''\1'\''\
+GIT_AUTHOR_EMAIL='\''\2'\''\
 GIT_AUTHOR_DATE=/'
 }
 
@@ -779,10 +780,10 @@ insn_patch () {
 	
 	if test -z "$AUTHOR"
 	then
-		sed -n -e '
-			s/^Author: \(.*\)$/GIT_AUTHOR_NAME="\1"/p;
-			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL="\1"/p;
-			s/^Date: \(.*\)$/GIT_AUTHOR_DATE="\1"/p
+		sed -e "s/'/'"'\\'"''/g" -n -e '
+			s/^Author: \(.*\)$/GIT_AUTHOR_NAME='\''\1'\''/p;
+			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL='\''\1'\''/p;
+			s/^Date: \(.*\)$/GIT_AUTHOR_DATE='\''\1'\''/p
 		' <"$infofile" >>"$AUTHOR_SCRIPT"
 		# If sed's result is empty, we keep the original
 		# author script by appending.
###

On Thu, Jul 03, 2008 at 11:09:50PM +0200, Stephan Beyer wrote:
> And as long as nobody is named $(rm -rf "$HOME")  [1], I thought this is
> sufficient for the prototype.

Btw, the [1] should have been a link to http://xkcd.com/327/
Just if you're wondering ;-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
