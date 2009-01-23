From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Fri, 23 Jan 2009 12:50:55 -0800
Message-ID: <7vljt1u4pc.fsf@gitster.siamese.dyndns.org>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
 <7vzlhhu8qo.fsf@gitster.siamese.dyndns.org>
 <8c5c35580901231215q2be36abbla443975cdbb031f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 21:52:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQT0v-0005Pj-KA
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 21:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbZAWUvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbZAWUvG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 15:51:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZAWUvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 15:51:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D288893220;
	Fri, 23 Jan 2009 15:51:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 29EEC9321E; Fri,
 23 Jan 2009 15:50:57 -0500 (EST)
In-Reply-To: <8c5c35580901231215q2be36abbla443975cdbb031f0@mail.gmail.com>
 (Lars Hjemli's message of "Fri, 23 Jan 2009 21:15:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C8B0CF6-E98F-11DD-891E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106912>

Lars Hjemli <hjemli@gmail.com> writes:

> On Fri, Jan 23, 2009 at 20:23, Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Hjemli <hjemli@gmail.com> writes:
>>
>>>>> The plan is to fix these limitations by extending --submodules to allow
>>>>> certain flags/options:
>>>>> a|c|r     include any|checked out|registered submodules
>>>>> H         resolve submodule HEAD to decide which tree to include
>>
>> What do you mean by "decide"?  If HEAD exists (iow, the submodule is
>> checked out), the tree of the commit recorded in the superproject's
>> gitlink entry is included in the result?
>
> No, when H is specified the tree of the currently checked out
> submodule commit would be included.

That makes even less sense.  At that point you are mixing a tree with
random state from a work tree, and doing so only for submodules.  If you
want a work tree snapshot, it should be a work tree snapshot, and should
not be labelled as a snapshot out of a tree object of the superproject.

> I would find the H flag practical for my own usage of submodules. I
> almost never modify the content of the currently checked out submodule
> but I often check out a different HEAD than what is registered in the
> gitlink in the superproject (typically due to testing the superproject
> against different versions of the submodule). And for such a use case,
> being able to create a tarball of my currently checked out state seems
> useful to me.

That would be more like an enhanced version of "git archive" that takes
the work tree state, similar to how "git grep" operates on the work tree
today.

I agree that would be useful, but I have a moderately strong suspition
that your "H" hack that includes the work tree state for checked out
submodules into a view that is primarily about the "tree" object in the
superproject, without the same "take from the work tree" semantics for
paths in the superproject, is more harmful than being helpful to the users
in the longer term.  It might be simple to implement, but I do not think
its semantics can be explained sanely.
