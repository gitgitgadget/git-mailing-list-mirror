From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: GIT-VERSION-GEN gives "-dirty" when file metadata changed
Date: Fri, 08 Aug 2008 10:55:50 +0200
Message-ID: <489C0A16.4040403@jaeger.mine.nu>
References: <sjj6zt28jy9qy7y8@jaeger.mine.nu> <7vd4kkijjd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:56:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRNmJ-0005vg-MJ
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbYHHIzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 04:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbYHHIzx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:55:53 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:39086 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751202AbYHHIzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:55:53 -0400
Received: (qmail 11738 invoked from network); 8 Aug 2008 08:55:50 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 8 Aug 2008 08:55:50 -0000
Received: (qmail 4729 invoked from network); 8 Aug 2008 08:55:50 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 8 Aug 2008 08:55:50 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vd4kkijjd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91639>

Junio C Hamano wrote:
> Christian Jaeger <christian@jaeger.mine.nu> writes:
>
>   
>> Today I've created custom Debian packages from Git for the first time (yes I know there are Debian packages already, I'm doing it so that I can patch Git and still have the convenience of a package system),
>>     
>
> I personally think that _you_ are responsible for doing the refresh
> yourself after becoming root, if you checkout as yourself and then build
> as root (or use fakeroot to build as if it is built as root).
>
> By the way "man fakeroot" says...
>
>        -u, --unknown-is-real
>               Use the real ownership of files previously unknown  to  fakeroot
>               instead of pretending they are owned by root:root.
>
>
> which sounds like a sensible thing to do (I would even imagine that would
> be a sensible default for fakeroot in general), and I would imagine that
> would help.
>   

That's true, running "dpkg-buildpackage -uc -us -b -r'fakeroot -u'" 
makes the dirty bit go away.

Although my guess is that most users who haven't read this thread will 
run into the same issue until they understand the reason after some half 
or full hour of debugging or so.

Also I don't see why I should keep in mind to run the refresh 
explicitely if any changes happened (are there any users who are using 
Git to report metadata changes to them (occasionally) which aren't 
changes that would be stored in Git when running commit?).

> Not that an extra update-index --refresh would be a huge performance hit,
> but I hesitate to take a patch that adds something that should
> conceptually be unnecessary.
>   

Isn't conceptually of interest whether the *contents* of the files have 
changed (or a metadata piece that matters to Git)? As mentioned, even 
just moving the sources to another partition using "mv" after checkout 
but before running "make" will give a binary that is "dirty", and the 
user might be confused and led into wrong conclusions or needless 
investigations.

I realize that also some git porcellain does not fall back to checking 
the contents, for example the current gitk will report the working dir 
as having "local uncommitted changes" (which in fact did confuse me when 
it happened to me, IIRC because of "mv"-ing a checkout, and left a 
feeling of slight brokenness). Still at the more relevant places like 
"git commit" there will of course be the content check.

I personally think it would be cleaner to always only report changes if 
really changes which can be stored in Git have happened. Not only in 
GIT-VERSION-GEN but also in gitk and maybe some other places. Isn't the 
metadata checking only used as a performance optimization? It would be 
sensible to report changes if metadata has changed that is actually 
being stored in Git, i.e. the exec bit, of course (and then no content 
check would be necessary).

Christian.
