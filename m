From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] submodule: Allow tracking of the newest revision of a
  branch in a submodule
Date: Thu, 11 Dec 2008 17:17:57 -0800
Message-ID: <7v3agub396.fsf@gitster.siamese.dyndns.org>
References: <1229009982-2701-1-git-send-email-git@fabian-franz.de>
 <7vbpvicuk2.fsf@gitster.siamese.dyndns.org> <20081212002101.292020@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@fabian-franz.de, j.sixt@viscovery.net, hjemli@gmail.com,
	git@vger.kernel.org
To: "Fabian Franz" <FabianFranz@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 02:19:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAwgj-0008J9-1r
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 02:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbYLLBSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 20:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756093AbYLLBSK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 20:18:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977AbYLLBSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 20:18:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D7FC866BF;
	Thu, 11 Dec 2008 20:18:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E24FB866BE; Thu,
 11 Dec 2008 20:17:58 -0500 (EST)
In-Reply-To: <20081212002101.292020@gmx.net> (Fabian Franz's message of "Fri,
 12 Dec 2008 01:21:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB810ACC-C7EA-11DD-897A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102855>

"Fabian Franz" <FabianFranz@gmx.de> writes:

>> Fabian Franz <git@fabian-franz.de> writes:
>> 
>> > However I have both cases: Stable development, where I need one special
>> > version and "wild" development, where I always want the newest published
>> > one.
>> 
>> I do not think supporting both styles of development is a bad idea.
>> 
>> However, use of 0{40} in the index and the resulting commit object in the
>> superproject means that this is a project-wide decision, not your personal
>> preference.  It is not implausible that you would want to do a wild
>> expeeriment in your own clone of a project that uses the "Stable
>> development" approach (hence the upstream never would want to have 0{40}
>> gitlink in its commits).
>
> Yes, but at the same time I might want to record it permanently as a project decision or play at my own with it ...
>
> So both styles should be supported.

While I think they both _could_ have uses, I do not necessarily agree with
your "should be".  First of all, I am not sure project wide 0{40} really
makes sense.

By creating such a commit in your superproject, you are essentially
claiming that you will work with _any_ future version of the subproject,
which is rather absurd.

And using 0{40} in trees and in the index to mark it is not really
necessary, and here is why.

You could tell the participants that you do not care the exact version by
storing 0{40} in the trees and the index, but in order for you to tell
them the tip of which branch of the subproject to use, you need to give
that information (i.e. branch name) to them as well.  Obviously there is
not enough space to put that information in gitlink (we could make room
and I have another implementation in mind but that will be a more involved
change so for a moment let's not go there).  The infomation will come
somewhere out-of-band, not in trees nor in the index.  And at that point,
the presense of such an out-of-band information itself is a good enough
cue that such a path in the superproject is for the "wilder" style of
development with the submodule.

Such an out-of-band information is necessary to use submodules in
distributed development already (iow, the commit object name in gitlink is
not enough), and we already have a Porcelain convention for that.  The
canonical repository URL for each submodule path is distributed as part of
the superproject in .gitmodules.  I would imagine that the message from
the project that says "we expect you to use 'wilder' development style
with this submodule, and use the tip of frotz branch here", if it ever
makes sense, can be recorded in .gitmodules as well.

When updating (or initializing) a submodule, we can check .gitmodules, and
iff it is the "wilder" kind, we can set assume-unchanged in the index and
run "cd there && git fetch $remote $branch && git checkout FETCH_HEAD^0"
or whatever you did in your patch.

If the supermodule did not work well with the updated submodule in such a
checkout, at least you have one commit that you can reset your submodule
checkout to, if you do not wipe that information with 0{40} in the trees
and in the index.  The commit recorded in the gitlink can serve as the
"project wide" suggested version to use, even in "wilder" development
style that also suggests to use "tip of that branch".
