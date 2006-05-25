From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git-format-patch possible regressions
Date: Thu, 25 May 2006 22:10:01 +0200
Message-ID: <e5bfff550605251310n251df046r5124ec018688d321@mail.gmail.com>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
	 <Pine.LNX.4.64.0605251233300.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 22:10:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjM9p-0003Wc-IP
	for gcvg-git@gmane.org; Thu, 25 May 2006 22:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWEYUKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 16:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWEYUKF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 16:10:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:60083 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751104AbWEYUKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 16:10:03 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1906420wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 13:10:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ASJqxuLnltMAFcLFLZErqsirj1XHGJpOHrBMvmZN71ClA+A1YF/yO1NYbE8onXgjm5r1JFesoyNeV/q0b+MqorYb/eBtNvq208KrzjDqWNL+6uta08U38tJ9HR4maqZuaDRKb9+I+RaQUW/vwpcywXzJFQuUHcV3nMpWY8CzDU0=
Received: by 10.65.188.10 with SMTP id q10mr8823qbp;
        Thu, 25 May 2006 13:10:01 -0700 (PDT)
Received: by 10.64.142.14 with HTTP; Thu, 25 May 2006 13:10:01 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605251233300.5623@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20759>

On 5/25/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> The "x..y" format is defined to mean the same thing "y ^x", and that means
> that "HEAD^..HEAD HEAD^^..HEAD^" really does mean the same thing as
> "^HEAD^ ^HEAD^^ HEAD HEAD^", which in turn means the same thing as "^HEAD^
> HEAD" from a reachability standpoint (since HEAD^ is by definition
> reachable from HEAD, adding it won't change the revision list, and the
> same goes for ^HEAD^^ vs ^HEAD^).
>
> So thus "HEAD^..HEAD HEAD^^..HEAD^" really _is_ the same thing as
> "HEAD^..HEAD", and any tool that thought otherwise was just being
> very confused.
>

Perhaps I have chose the wrong example but it was  _only_
instrumental in better explaing the regression.

The general problem is how to format patches files named with
consecutive numbers starting from a set of possible unrelated
revisions.

> Now, we could choose to try to make "a..b" mean something else (ie make
> the "^a" part only meaningful for that particular "sub-query"), and yes,
> in many ways that would be a more intuitive thing, but it's not how git
> revision descriptions work currently, and if we make that change we should
> do it across the board.
>
> (It's not an easy change to make, but it should be possible by having
> multiple separate NECESSARY/UNNECESSARY bits, and make the revision
> walking logic a whole lot more complicated than it already is).
>
> So I'd argue that you should really do something like
>
>         ( git-rev-list a..b ; git-rev-list c..d ) |
>                 git-format-patch --stdin
>
> in qgit if you want the ranges to be truly independent.
>
> (And no, I don't think git-format-patch takes a "--stdin" argument, but it
> might not be unreasonable to add it as a generic revision walking
> argument for scripting like this).
>

To fix qgit problem could be enough to add/modify the option -nx to
make git-format-patch do not default with 0001 number but with x and
then simply call git-format-patch in a loop:

    for(int i = 0;  i  <selectedRevisions.count(); i++)
         git-format patch -n<i+1> selectedRevisions[i]  ^selectedRevisions[i];


But of course it is clear your suggestion could be a solution for
much broader cases.

    Marco
