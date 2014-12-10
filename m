From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: filter-branch performance
Date: Wed, 10 Dec 2014 15:25:44 +0000
Message-ID: <CAFY1edZqt-VY7afBjhtzQV6QW0zS8Cbd09XJbNZ9bj+T6GWOGg@mail.gmail.com>
References: <548744F1.9000902@gmx.de>
	<20141209185933.GC31158@peff.net>
	<CAFY1edYYC9TZmLE6b3=QAoTB1zQHi_Y97rHL-5wk5Pbpa_oj_w@mail.gmail.com>
	<20141210143706.GA2996@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Henning Moll <newsScott@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 16:25:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyj9H-000051-K2
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 16:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455AbaLJPZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 10:25:48 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:52490 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757695AbaLJPZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 10:25:45 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so6603020igj.16
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 07:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pbzAh+PrIUA5HBWZmJpeBzJCAcLP9eDPdzlfCyg2YQI=;
        b=kqvlfEjlqowzoDQa6sBdfCmuJMT/X82DGeD7KGpi1yq84xpL7crmK5kuISzMbEEdpr
         dEKVAe+4R1K428gO2cJXI5g99WpfclQyCnJ592xM5SDUQV68Kfh6IFli55/vgOSIpU0u
         WqF3m8mWWKoMn6v4JypCiD6vPeZOgAhW1x6zRxoMEs4897UuheFbphh2cotDXHsPY7sz
         JJJPmAExLw8s6A34UJaYAK3K/iVmkI2c6MFSIeON2SWeL884VZbpGCUZpt9ZaczJN2lF
         nZ6TEpwSJAHOgMIbp6Ii5BUSB6O4nnnY3Ecm8zw2qy1L8RvzGoAxVM6LfQK9WsuwEfwq
         6j5g==
X-Received: by 10.50.103.3 with SMTP id fs3mr26090949igb.6.1418225144719; Wed,
 10 Dec 2014 07:25:44 -0800 (PST)
Received: by 10.64.240.171 with HTTP; Wed, 10 Dec 2014 07:25:44 -0800 (PST)
In-Reply-To: <20141210143706.GA2996@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261215>

On 10 December 2014 at 14:37, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 10, 2014 at 02:18:24PM +0000, Roberto Tyley wrote:
>> object SetCommitterToAuthor extends CommitNodeCleaner {
>>   override def fixer(kit: CommitNodeCleaner.Kit) = c =>
>> c.copy(committer = c.author) // PersonIdent class holds name, email &
>> time
>> }
>
> Thanks. I _almost_ mentioned BFG in the original email, but I didn't
> think it could do arbitrary fixes like this. Can you monkey-patch in
> arbitrary code, or do you have to rebuild all of BFG to include the
> snippet above?

Well, I publish a bfg-library jar to Maven Central, so you don't need
to rebuild that:

http://search.maven.org/#search%7Cga%7C1%7Ca%3A%22bfg-library_2.11%22

...in principle you can write a Java/Groovy/whatever project that
calls that jar (your entry point would be
com.madgag.git.bfg.cleaner.RepoRewriter) - tho' to be honest, I can't
swear to how /friendly/ the API would be to call from non-Scala-land
though, as I haven't tried it.

Incidentally, if people want to try compiling this monkey-patched BFG
at home, this is how you'd do it:

* Install SBT - http://www.scala-sbt.org/download.html (or 'brew
install sbt' for Mac OS X)
* git clone https://github.com/rtyley/bfg-repo-cleaner.git --branch
set-committer-to-author
* cd bfg-repo-cleaner
* sbt "bfg/run --no-blob-protection"

There will be a lot of automated downloading of dependencies, and
compilation will be slow the first time around, but at least there
aren't that many steps. I do realise that being Scala/JVM based makes
working on the BFG a bit of a specialist activity at the moment!

>> A DSL for non-Scala people to define their own
>> BFG scripts would be good, I must get on that some day.
>
> That would be cool.  Even if the DSL was just Java, if you could do
> something like:
>
>   vi fix.java
>   javac fix.java
>   bfg --filter=fix.class
>
> that would be very useful (and I am probably showing my lack of Java chops
> by getting the compilation command or filenames wrong :) ).

Your syntax is right :) I'll give it some thought.


>> I started running the same test some time ago using filter-branch,
>> unfortunately that test has not completed yet - the BFG appears to be
>> substantially faster.
>
> No fair if you didn't run filter-branch on a PC and BFG on a Raspberry
> Pi. You have to give us a fighting chance. :)

I guess I made that rod for my own back :) http://youtu.be/Ir4IHzPhJuI
for those who haven't seen it.
