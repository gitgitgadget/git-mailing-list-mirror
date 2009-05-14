From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 21:38:08 -0700
Message-ID: <7viqk4z4cv.fsf@alter.siamese.dyndns.org>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
	<1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
	<alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de>
	<200905130724.44634.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 14 06:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Si5-0003Kk-Qi
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 06:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbZENEiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 00:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbZENEiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 00:38:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56617 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbZENEiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 00:38:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514043809.INIY20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 May 2009 00:38:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id rGe81b00P4aMwMQ03Ge9CR; Thu, 14 May 2009 00:38:09 -0400
X-Authority-Analysis: v=1.0 c=1 a=PG8unGKUAAAA:8 a=EhOrEaQkaT3B0ORA8WMA:9
 a=JQWbPRQ3DkDygo37jywA:7 a=-klT1kajr2f_MmlWSAut1blnrVEA:4 a=Fv4NUtouRssA:10
X-CM-Score: 0.00
In-Reply-To: <200905130724.44634.robin.rosenberg@dewire.com> (Robin Rosenberg's message of "Wed\, 13 May 2009 07\:24\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119130>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

>> This is ugly.
>
> I told you so. No news.
>
>> Okay, I'll stop here.  You might want to clean up your patch series before 
>> resending.
>
> I also told you why why I stopped working on the patches. The patches are not part of
> a beauty contest and not meant for inclusion as such.

It is rather sad; I suspect that the core of the series is buried in too
much cruft deep enough to discourage many potential reviewers.  I think
the entire series look incoherent because attacking two largely unrelated
things at once.

 (1) Normalizing pathnames internally to UTF-8 and possibly convert it
     back to native upon use (e.g. creat(), lstat(), unlink()) and output.
     As Linus analyzed, this shouldn't be done too early in the callchain
     for performance reasons, but I think your patch would give us a good
     set of starting points to follow where the result from readdir(),
     user input and other things that are pathnames come from and go.

     This part of the patch series was inspiring.  You have to worry about
     gitignore, gitattributes and readlink() vs contents of a blob object
     that records a symbolic link values, which I think either escaped
     analysis people have done so far or being ignored as a small detail,
     but they are important;

 (2) Passing cat-file output through iconv to convert it.

     I think this is unwarranted, even if the object given to cat-file
     happens to be a commit or a tag object and you want to convert their
     messages in native encoding.

     I am not sure what should happen to "cat-file tree", "ls-files" and
     "ls-tree".  The output from these plumbing does show pathnames, but I
     tend to think it is Porcelain's job to turn them into whatever
     encoding they want to use.  So are input to "update-index --stdin",
     but I am still just thinking out loud.
