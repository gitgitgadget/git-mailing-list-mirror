From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: new platform & S_IFGITLINK problem
Date: Mon, 3 May 2010 20:39:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk> <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alan Hourihane <alanh@fairlite.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 05:41:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O990I-0008Mi-Ra
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 05:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab0EDDk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 23:40:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32809 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753606Ab0EDDk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 23:40:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o443en3j026917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 May 2010 20:40:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o443emZx005617;
	Mon, 3 May 2010 20:40:48 -0700
In-Reply-To: <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.447 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146288>



On Sat, 1 May 2010, Junio C Hamano wrote:
> 
> Yikes.  The current codebase pretty much assumes that IFREG is 0100000,
> IFDIR 0040000, and IFLNK 0120000, and the bits read from "struct stat" and
> the mode bits we store in the index and tree objects are interchangeable.

Yeah. This is painful. I knew it was wrong to just assume everything was 
sane and used the same traditional values, but I optimistically thought 
that the st_mode bits were the _one_ thing that everybody agrees on.

I was wrong. 

> Yes, that assumption is a gross POSIX violation but we so far haven't seen
> any platform that matters in real life that assigns the IFMT bits
> differently.

Indeed. Just out of interest - Alan, what _is_ the crazy platform that 
doesn't match what absolutely everybody else has always done?

> We would need to:
> 
>  (1) rename S_IFGITLINK to GIT_S_IFMODULE;

I'd suggest dropping the "_S_" part, and just calling it

	GIT_IFxyz
	GIT_ISxyz()

>  (2) define GIT_S_IF{REG,DIR,LNK} as 0100000, 0040000, and 0120000;
> 
>  (3) write MODE_SYSTEM_TO_GIT() macro to convert from S_IF{REG,DIR,LNK} we
>      read from struct stat to the "canonical" GIT_S_IF{REG,DIR,LNK}
>      values; and
> 
>  (4) change all the code that read mode from struct stat and use it to
>      first use MODE_SYSTEM_TO_GIT().
> 
> Currently 'git grep -e "S_IF[A-Z]" -e "struct stat"' reports around 250
> hits, so it is not infeasible amount of work, but it is not a trivial and
> mechanical replacement, either.  I or somebody need to set aside a block
> of time to do this clean-up and audit the result.

Ugh. And since nobody sane has different values from the system ones, if 
we miss some case we'll never notice on any sane platform ;(

		Linus
