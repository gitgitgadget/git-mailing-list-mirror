From: James Utter <james.utter@gmail.com>
Subject: [Fwd: Re: strange git delays]
Date: Fri, 21 Mar 2008 11:32:59 +1100
Message-ID: <1206059579.29416.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 01:33:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcVCf-0001uO-Ny
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 01:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYCUAdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 20:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbYCUAdG
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 20:33:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:47431 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYCUAdF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 20:33:05 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1111901wra.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=JYhrlswNG5UxO7OdXc8fc1eeBlm+N0XurQW5JqCr4W4=;
        b=d8aTPEZKKIuLTfDm1hCe8HAYSqWAteNq8oMP88PM1+owCFQndrbzwWqyu7YqZLAjvDkE80IxIHHf75Qqs5QIaimsFqCFWpUkmF0duDBr2mqJFS/LY8SqZ52q+JKKr9LgmINy9xSMS6mHXMwZ5ekbOF1Ru/GK6wGixTlf20DO4iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Uf6Idf9Z59+AmHqCBMouQGQtewuISvnJcM11vE8FdHh5FahpvjMs9fqjpzvyCR42jVmUTdKQRjIRHEUFkYx32JzVbaGQGmFF853/Fnd1AdNmgpQdfuFz9lQnVfgehcvmwv0NpzLr+2P/ghXzSyVBwf+v5FiAnrQiQqhhBp7gyMY=
Received: by 10.150.122.13 with SMTP id u13mr1245104ybc.131.1206059584447;
        Thu, 20 Mar 2008 17:33:04 -0700 (PDT)
Received: from ?10.5.5.2? ( [121.44.247.12])
        by mx.google.com with ESMTPS id h14sm541805wxd.26.2008.03.20.17.33.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Mar 2008 17:33:03 -0700 (PDT)
X-Mailer: Evolution 2.12.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77690>


On Thu, 2008-03-20 at 14:53 -0700, Linus Torvalds wrote:
> 
> On Fri, 21 Mar 2008, James Utter wrote:
> >
> > james@timesink:~/testgit$ time git commit --message "initial commit"
> > Created initial commit 4f4b3a3: initial commit
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >  create mode 100644 hello
> > 
> > real	0m10.008s
> > user	0m0.000s
> > sys	0m0.008s
> 
> Ok, that is almost exactly 10 seconds longer than it should take.
> 
> And I can almost guarantee that it's something like a problem looking up 
> your hostname or perhaps user identity - I would guess you have some name 
> service problem.
> 
> Do an
> 
> 	strace -tT git commit --message "initial commit"
> 
> on that git commit to make sure, but I would almost bet that it's when git 
> does tget "getpwuid()" thing to get your name from the gecos fields, and 
> you have some setup problem with nscd o similar.
> 
> It might just go away if you set up your user name and email manually, ie 
> try doing
> 
> 	git config --global user.name "James Utter"
> 	git config --global user.email james.utter@gmail.com
> 
> and see if that makes the delay go away. It probably tries to look up your 
> login info from some non-existent NIS setup, and then times out after ten 
> seconds and picks the data from your /etc/passwd file instead.
> 
> (There can be other things that do similar things - misconfigured name 
> servers etc can cause delay etc. So maybe I'm wrogn on blaming nscd, but 
> it would be my first guess).
> 
> 		Linus

It looks like you are right. Setting the git config --global settings
makes the problem disappear. I am not aware of (actively) setting up any
NIS, but there may be trouble in the DNS server.

>From the strace (attached):

10:55:34 sendto(3, "\307\304\1\0\0\1\0\0\0\0\0\0\ttimesink\n\5svana
\3net"..., 37, MSG_NOSIGNAL, NULL, 0) = 37 <0.000159>
10:55:34 poll([{fd=3, events=POLLIN}], 1, 5000) = 0 <4.995564>
10:55:39 poll([{fd=3, events=POLLOUT, revents=POLLOUT}], 1, 0) = 1
<0.000098>
10:55:39 sendto(3, "\307\304\1\0\0\1\0\0\0\0\0\0\ttimesink\n\5svana
\3net"..., 37, MSG_NOSIGNAL, NULL, 0) = 37 <0.000130>
10:55:39 poll([{fd=3, events=POLLIN}], 1, 5000) = 0 <4.999161>
10:55:44 close(3)                       = 0 <0.000111>
10:55:44 open("/etc/ld.so.cache", O_RDONLY) = 3 <0.000066>

Thank you,

James Utter
