From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-tree A B C: do not create a bogus index and do not
 segfault
Date: Fri, 13 Mar 2009 23:41:56 -0700
Message-ID: <7v7i2sehcb.fsf@gitster.siamese.dyndns.org>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
 <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302>
 <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com>
 <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
 <7vtz5zjnai.fsf@gitster.siamese.dyndns.org>
 <7vfxhjjkcm.fsf@gitster.siamese.dyndns.org>
 <7v3adjjj1y.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903121024400.19665@iabervon.org>
 <alpine.LFD.2.00.0903120929250.32478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 14 07:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiNaw-0008JA-D0
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 07:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbZCNGmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 02:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZCNGmL
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 02:42:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZCNGmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 02:42:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E5EFE5488;
	Sat, 14 Mar 2009 02:42:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 086A45487; Sat,
 14 Mar 2009 02:41:58 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903120929250.32478@localhost.localdomain>
 (Linus Torvalds's message of "Thu, 12 Mar 2009 09:34:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D064B78-1063-11DE-8184-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113237>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 12 Mar 2009, Daniel Barkalow wrote:
>
>> I think it might be a good idea to take this as evidence that nobody is 
>> using read-tree with multiple trees without merge, and just disallow it. 
>
> Hmm. It _has_ been used. It's been useful for really odd things 
> historically, namely trying to merge different trees by hand. So while I 
> agree that we could probably remove it, it _is_ a very interesting 
> feature in theory, and since we have the code.. 
>
> So I'd say "add a few tests for the known horrible cases" should be the 
> first approach. If it ever actually breaks again and becomes a big 
> maintenance headache, maybe _then_ remove the feature as not being worth 
> the pain?

I've added trivial tests and will start cooking it by letting it go
through the usual pu/next/master/maint cycle.

I think you are thinking about something like the "gitk" merge (aka "The
coolest merge EVER!" [*1*]), but you can do the same thing more safely
with -m option, giving an empty tree as the common ancestor.  Especially
if you run it in the aggressive mode, "addition" from our tree and their
tree, when it is an overlay, will not overlap, and will all cleanly
resolve to stage #0.

I suspect you can also use a single tree "read-tree", immediately followed
by another "read-tree --prefix=''" to read in two trees into the index and
write the results out.

[Footnote]

*1* http://article.gmane.org/gmane.comp.version-control.git/5126
