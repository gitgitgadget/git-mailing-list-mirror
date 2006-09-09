From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 20:04:29 +0200
Message-ID: <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <20060908184215.31789.qmail@science.horizon.com>
	 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	 <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	 <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 20:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM7CJ-0004eq-Nf
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 20:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWIISEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 14:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWIISEb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 14:04:31 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:25797 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964788AbWIISEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 14:04:30 -0400
Received: by py-out-1112.google.com with SMTP id n25so1395122pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 11:04:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jr+DN3LPqscElX9TNptcUvUQJNuMWucV78wabGFvGPzKevMXvWmJ+MKdMZdYVukFQuHhBK9Jaqv7FMLSv14kfFCx4oJK9Q9wayBhuzvHpFPveT+ouSJrb9uH6klBVsLx42OdZQ78Rs66G4g5VziNbJeLzCRopXcohwzWQkR/Eeo=
Received: by 10.35.66.12 with SMTP id t12mr5975517pyk;
        Sat, 09 Sep 2006 11:04:29 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 11:04:29 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26759>

On 9/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
>  - output all revisions in the normal non-topological ordering
>
>  - when git-rev-list notices a topological sort error, it outputs a
>    "FIXME" line, and restarts the whole thing - printing out the commits
>    in the newly fixed ordering - and does it right the next time around
>

Sorry, but I don't understand why  you should restart the whole thing
instead of store away the FIXME commit  and continue.

If you read my previous e-mail in this thread perhaps it is better
explained the whole idea.

Anyhow the basic is:

-git-rev-list starts outputting the data early (order is not guaranteed)

-before to mark for output a revision check if it breaks --topo-order

-if the above is true store the revision away and *do not send*

- at the end you get an early started steram of topological corrects
revisions without
preordering, just because you filter away the (few?) revisions that
are not in order.
The list you get is guaranteed to be in topo order although my not be complete.

- _then_  you send the missing revisions that where previously
filtered out. At this stage the receiver has already drwan the graph,
indeed it has start drwaing as soon as the first revisons arrived and
*very important* receiver used old and fast topo-order parsing code.

- finally the fixup routine at receiver's end updates the graph with
the info from the small set of out of order revisions filtered out
before and sent at the end (only this small set is sent at the end).

Sorry if it is not still clear, in the previous my e-mail in this
thread there is also a small example that could be useful.

      Marco
