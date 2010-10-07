From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Trac+Git: rev-list with pathspec performance?
Date: Thu, 7 Oct 2010 22:33:59 +0200
Message-ID: <201010072234.00994.jnareb@gmail.com>
References: <2595121.446745.1286473792827.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 22:34:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3xAb-00076f-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 22:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab0JGUeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 16:34:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33354 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab0JGUeL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 16:34:11 -0400
Received: by fxm14 with SMTP id 14so75439fxm.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qZaFsZl3tH0XN+MsEj2bs6xFMBVHh5YYfK6U96oro2Y=;
        b=p92EFptrOXFcf5iSsjolB18laIHgu7FJlG4CyN4GhSduYxdRwG8WVL2A81mNrfV4SA
         1NSuq+bi1RGYsbsC/9i1Rfhn22PW90E2Hk/9LP5IdsOo2bmQNr5yvW9wB0d2DkHkq+jD
         CvuXePnsw7DDab0cZA50gQi+ZC5FEPfuWH0Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v+i5hmzQ+EhtzDtTZgZ9DDKzpicvx40eAuDfY7b+34FBLO1PD/UwEh0XX78/Jrr0yB
         9jEXmQoc2FBlKaEtBNlxERknp7c/efrRvX43hm9kFgRXqqAnmOXxRa8LLGyAw3iz7Hw4
         L46zN2xy1kYUngVt2rwHmcOeJ5kL5fuTIfG7k=
Received: by 10.223.101.18 with SMTP id a18mr1903670fao.19.1286483649257;
        Thu, 07 Oct 2010 13:34:09 -0700 (PDT)
Received: from [192.168.1.13] (abvx243.neoplus.adsl.tpnet.pl [83.8.221.243])
        by mx.google.com with ESMTPS id c20sm1276281fak.33.2010.10.07.13.34.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 13:34:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <2595121.446745.1286473792827.JavaMail.root@mail.hq.genarts.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158455>

On Thu, 7 Oct 2010, Stephen Bash wrote:

>>> Note that there is proof of concept
>>> "tree blame" (in Perl) which generates such 'last change to file'
>>> information, I think faster than running 'git rev-list -1 <file>'
>>> for
>>> each file. Even better would be to encode used algorithm in C.
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/150063/focus=150183
>> 
>> My early experiments with your script are good for speed, but for some
>> reason I'm always getting the first commit for a file rather than the
>> most recent. I'll do some experimenting to see if I can uncover the
>> issue.
> 
> Following up, I had to add -r to the diff-tree command line when
> requesting a subdirectory to work around the problem (script always
> returned the first commit).  

Hmmm... I thought that I have added '-r' if there is path provided,
i.e. we don't run tree blame on root commit.

> I'm curious if it's faster to get the SHA of the sub-tree and compare
> that before actually running diff-tree?  And for that matter, just run
> diff-tree on the sub-tree that we care about rather than a recursive
> sub-tree on the root?  These may be early optimizations, but they're
> ideas that occurred to me while debugging the code...    

There are many possible optimizations (see also below); for the time
being I was concerned with getting the fast tree blame algorithm right
(and as you can see didn't get it, not completely).

>>> P.S. Alternate solution would be to simply get rid of SVN-inspired
>>> view.  Git tracks history of a *project* as a whole, not set of
>>> histories for individual files (like CVS).
> 
> After a lot of experimentation, this is basically what we did.
> I modified the Trac templates to not list the last change SHA or log
> message in the directory view.  After all my testing, I just don't
> think there's a fast way to get this information from Git.  This
> blame-dir script is the fastest alternative I've tried (about 5x
> faster than rev-list'ing each file), but it's still ~30 seconds on my
> machine (which is faster than our web server), and IMHO that's too
> long to ask a user to wait for a page to load.       

First, there is lot of room for optimization of tree blame script, some
of which I have noted as comments, some which you have found.  During
developing this script I noticed that current plumbing doesn't completly
fit the tree blame algorithm; for example we need '-r' for blaming 
subtree (subdirectory), while we need paths only up to depth of blamed
directory, no more.

Rewriting tree-blame in C, using in-core revision and tree traversal
should be faster, though I'm not sure how much would that be.  
Unfortunately I don't know enough git API; I thought that writing
Perl script would be easier.

But you are right in that such view would always be expensive in Git,
because Git tracks history of porject *as a whole*.  If file was 
created in root commit (first commit) and left unchanged, it would be
easy to find in VCS that stored history on per-file basis at least to
some extent; in git you have to go through comit up till the root 
commit in this case.  If history is long, it might take some time.


Second, you can use the trick that GitHub web interface uses to display
similar view, namely in displaying first just a tree of files, and then
incrmentally filling in 'last changed' info.  Gitweb does something 
similar in 'blame_incremental' view; that is why the idea was to have
tree blame ("git blame <directory>") to have support for incremental 
format, similar to an ordinary blame.

This might take some effort to develop, though...
-- 
Jakub Narebski
Poland
