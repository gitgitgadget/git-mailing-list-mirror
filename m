From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Puzzled by a t9500 test failure
Date: Mon, 13 Oct 2008 17:22:46 -0700
Message-ID: <20081014002246.GA4856@spearce.org>
References: <7vljws83nd.fsf@gitster.siamese.dyndns.org> <20081013234851.GY4856@spearce.org> <7vhc7g8257.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 02:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpXhg-0001cG-KT
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 02:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931AbYJNAWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 20:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757612AbYJNAWr
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 20:22:47 -0400
Received: from george.spearce.org ([209.20.77.23]:54274 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479AbYJNAWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 20:22:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 692293835F; Tue, 14 Oct 2008 00:22:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vhc7g8257.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98168>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> With recent tip of 'master':
> >> 
> >>     $ make
> >>     $ mkdir t/trash
> >>     $ cd t && sh t9500-*.sh -i
> >> 
> >> fails at the very first test.  Can anybody figure out why?
> >
> > Hmmph.  Near as I can tell its because gitweb.log has this in it:
> >
> > $ cat gitweb.log
> > [Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in scalar chomp at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 1811.
> > [Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in addition (+) at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 3772.
> > HASH..
> >
> > The test does a grep for '[[]' and if it matches, fails.  I'm not
> > sure why this started showing up now.  Obviously I merged something
> > that failed the test suite, but I was pretty sure I had run the full
> > set before publishing anything.
> 
> Nothing as far as I can tell changed while you were the pumpking.
> 
> I was just wondering why the presense of that extra, should-be-unused,
> t/trash directory affects the outcome of the test.

Seriously?

Oh.  Some time with strace later...

Its because Perl totally borked the $projectroot path when it was
looking at $GIT_DIR/ctags.  $GIT_DIR has a space in the path and
Perl bound the first aprt, opened it, but cannot open the second
part of the $GIT_DIR/ctags string because it doesn't exist.

The code in question is the new tag cloud code in gitweb that
Peter added.  So bisect is still correct.

My guess is its the code in git_get_project_ctags(), around
l.1804-1816.

-- 
Shawn.
