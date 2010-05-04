From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: new platform & S_IFGITLINK problem
Date: Mon, 3 May 2010 20:52:31 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005032042470.5478@i5.linux-foundation.org>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk> <7vfx2b2ft5.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alan Hourihane <alanh@fairlite.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 05:54:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O99Cy-00043Z-DS
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 05:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959Ab0EDDyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 23:54:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58671 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754690Ab0EDDx7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 23:53:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o443rtRR027896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 May 2010 20:53:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o443rsOk006233;
	Mon, 3 May 2010 20:53:54 -0700
In-Reply-To: <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.447 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146289>



On Mon, 3 May 2010, Linus Torvalds wrote:
> On Sat, 1 May 2010, Junio C Hamano wrote:
> > 
> >  (3) write MODE_SYSTEM_TO_GIT() macro to convert from S_IF{REG,DIR,LNK} we
> >      read from struct stat to the "canonical" GIT_S_IF{REG,DIR,LNK}
> >      values; and
> > 
> >  (4) change all the code that read mode from struct stat and use it to
> >      first use MODE_SYSTEM_TO_GIT().
> > 
> > Currently 'git grep -e "S_IF[A-Z]" -e "struct stat"' reports around 250
> > hits, so it is not infeasible amount of work, but it is not a trivial and
> > mechanical replacement, either.  I or somebody need to set aside a block
> > of time to do this clean-up and audit the result.
> 
> Ugh. And since nobody sane has different values from the system ones, if 
> we miss some case we'll never notice on any sane platform ;(

As to your (3) and (4), I actually think that the best option would be to 
stop using '[lf]stat()' directly for "working tree stat", and instead just 
introduce a 'git_[lf]stat()' function that just always does the conversion 
(when necessary - the "conversion" can be a no-op on sane architectures) 
for us.

Right now, a _lot_ of the functions work either directly on 'st->st_mode' 
_or_ on random index entries, and that would be a major pain if they might 
ever be in "different number domains". So the easiest way to make sure 
that we _always_ use the GIT_IFxyz numbers would be to never ever have 
anything that uses the native ones even by mistake.

I've actually wanted to have a 'git_lstat()' wrapper for other reasons: it 
would have made it _so_ much easier to do breakpoints etc when doing the 
whole name lookup optimizations. 

Note: there are various cases of '[lf]stat()' being used not for working 
tree entries, but for things like the pack files etc internal git files. 
Those should _not_ do the conversion - they should use the "native" stat() 
functions. It's only the working tree accesses we should need to do any 
conversion on, since those are the ones that are relevant for the index 
(and tree) comparisons.

			Linus
