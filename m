From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH] fast-import: export correctly marks larger than 2^20-1
Date: Wed, 14 Jul 2010 12:18:41 +0530
Message-ID: <87iq4i8som.fsf@hariville.hurrynot.org>
References: <1279021908-21291-1-git-send-email-harinath@hurrynot.org>
	<20100713183126.GA2458@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 08:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYvm7-0006Hl-71
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 08:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab0GNGsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 02:48:53 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38268 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab0GNGsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 02:48:53 -0400
Received: by pvc7 with SMTP id 7so2597313pvc.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 23:48:51 -0700 (PDT)
Received: by 10.114.156.10 with SMTP id d10mr2698627wae.229.1279090131549;
        Tue, 13 Jul 2010 23:48:51 -0700 (PDT)
Received: from hariville.hurrynot.org ([117.192.136.70])
        by mx.google.com with ESMTPS id n32sm99317379wag.11.2010.07.13.23.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 23:48:50 -0700 (PDT)
In-Reply-To: <20100713183126.GA2458@burratino> (Jonathan Nieder's message of
	"Tue, 13 Jul 2010 13:31:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150968>

Hi,

Jonathan Nieder <jrnieder@gmail.com> writes:

> (+cc David, who I think mentioned wishing for something like this)
>
> Raja R Harinath wrote:
>
>> Subject: fast-import: export correctly marks larger than 2^20-1
>
> Thank you!  That would be a very good thing.

I needed this so that I could maintain two 'marks' counters, one for
commits counting up from 1, and one for files counting down from some
large value, where the file marks could be re-used.

  http://gitorious.org/~harinath/svn2git/rrh-svn2git/commit/ffc5270a6fa=
106fecad1a6a9f1520ca8f075c6b7

However, the 1M limit on marks is a bit too tight.  For instance, the
mono SVN repository has 160K commits, with one project alone using 60K
commits.  And one of the commits touched nearly 24K files.  The number
of marks used is uncomfortably close: within one order of magnitude of
the limit.  I'd like 10 more bits of breathing space, please :-)

>> dump_marks_helper() has a bug when dumping marks larger than 2^20-1,
>> i.e., when the sparse array has more than two levels.  The bug was
>> that the 'base' counter was being shifted by 20 bits at level 3, and
>> then again by 10 bits at level 2, rather than a total shift of 20 bi=
ts
>> in this argument to the recursive call:
>
> I haven=E2=80=99t read or grokked that code you are changing, so I ca=
n=E2=80=99t
> comment on the substance of your patch.  In case no one with such
> knowledge turns up, could you give a quick summary of what the
> existing code does and why?

This is not particular quick or clear, but here goes.

The marks are stored in a sparse array data structure.  The sparse arra=
y
is represented as a 1024-tree, with object storage only at the leafs,
and every path from root to leaf being the same length.  So, each node
can, and does, have the notion of a level, which is represented by a
number of bits to shift.

When you try to lookup at a non-leaf, the lookup index can be shifted
right the given number of bits, and masked to 10 bits [1], to get the
sub-tree to continue lookup in.  IOW, all the indices in a subtree have
a common prefix.

In dump_marks_helper, the 'base' argument contains that common prefix t=
o
the current tree.  In the recursive case, the common prefix of the
sub-tree is computed by taking this 'base', and adding to it the
contribution from this node, i.e., k << shift [2].  The bug was that
'base' was being shifted too, even though it already had the correct
value from its caller.

- Hari

[1] The code actually does something different, but equivalent.  It
    masks off the top bits immediately before recursing.  However, it's
    easier to explain dump_marks_helper if we think of the index
    surviving to the leaf.

[2] Now that I think of it, the other fix, that I called more elegant,
    is harder to explain.  So, let's not go with that.
