From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 08:46:09 +0200
Message-ID: <8D126F5A-5998-4CB2-89BE-1CAEF5AE621F@zib.de>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:46:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKTgZ-00064f-LO
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 08:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939291AbXHMGph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 02:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939369AbXHMGpf
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 02:45:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:58095 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S939126AbXHMGpd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 02:45:33 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7D6jO7j010978;
	Mon, 13 Aug 2007 08:45:24 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10789.pool.einsundeins.de [77.177.7.137])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7D6jMUC028395
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 08:45:23 +0200 (MEST)
In-Reply-To: <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55747>


On Aug 13, 2007, at 8:14 AM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>> ...
>>> This works only together with the commit
>>>
>>> 'attr: fix attribute handling if .gitattributes is involved'
>>
>> While I think it is _one_ good approach to make things two-pass,
>> I do not know if this is enough.  A logic similar to this should
>> be made available to the codepath that switches branches,
>> shouldn't it?
>
> Ok, let's step back a bit and I'll suggest an alternative
> approach to your 1/2.  This would hopefully solve 2/2 without
> any code change your patch 2/2 has.

That would be great.


> I think this approach is very much in line with how the git
> plumbing works, but you would need to know how the world is
> designed to work in order to appreciate it fully.  Let's have a
> few paragraphs to give the readers some background.
>
> The work tree side of git is primarily about the index, and what
> is on the work tree is more or less secondary.  At the lower
> level, often we deliberately treat not having a working tree
> file as equivalent to having an unmodified work tree file.  We
> can apply the same principle to this "missing .gitattributes
> file" case.
>
> People who only know modern git may not be aware of this, but
> you can apply patches and perform a merge in a work tree that
> does not have any file checked out, as long as your index is
> fully populated.  For example, you can do something like this:
>
>     $ git clone -n git://.../git.git v.git
>     $ cd v.git
>     $ git update-ref --no-deref HEAD $(git rev-parse v1.5.3-rc4^0)
>     $ git read-tree HEAD
>     $ git apply --index patch.txt
>
> You will have the files that are patched in the resulting work
> tree, so that you can inspect the result.  If you like the
> result, you can even make a commit in such a sparsely populated
> tree:
>
>     $ git commit
>
> Of course, "git commit -a" and "git add -u" Porcelain options
> are more recent inventions, and they would not work with such a
> sparsely populated work tree.  But the above demonstration shows
> that at the plumbing level the index is the king and the work
> tree is secondary, and this is very much as designed.  The merge
> operation has similar characteristics:
>
>     $ git merge master
>
> ... will check out the paths that need file-level 3-way merge,
> so that you can inspect the result, but what you will have is a
> sparsely populated work tree, and this is as designed.

Ah, merge ...


> Currently, the attr_stack code reads only from the work tree
> and work tree alone.  We could change it to:
>
>  - If the directory on the work tree has .gitattributes, use it
>    (this is what the current code does);
>
>  - Otherwise if the index has .gitattributes at the
>    corresponding path, use that instead.
>
> This essentially treats not having .gitattributes files checked
> out as equivalent to having these files checked out unmodified,
> which is very much in line with how the world is designed to
> work.
>

We may have conflicts in the .gitattributes file during a merge.
.gitattributes may be present in different stages, and with
conflict markers in the work tree.

Could we drop reading the file in the work tree completely?
.gitattributes would be a property of the index alone. To control
attributes you first need to add them to the index, before adding
the file that has attributes set in .gitattributes.

If we have .gitattributes in different stages, the right one
should be chosen to checkout corresponding files in the same stage.

	Steffen
