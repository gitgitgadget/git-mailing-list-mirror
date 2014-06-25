From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Triangular workflow with Central repo
Date: Wed, 25 Jun 2014 10:32:31 -0700
Message-ID: <xmqqionoao9c.fsf@gitster.dls.corp.google.com>
References: <CANR0-ag4ZKmHBNPxYkohBJEpXierFV+K3Ub4tH8YYD7FK73FdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Ferrell <major@homeonderanged.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzr3s-00048L-TY
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 19:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099AbaFYRcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 13:32:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50770 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757820AbaFYRci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 13:32:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EFFA204F6;
	Wed, 25 Jun 2014 13:32:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=myduHbbeN7G9CCCzaIT7eIuRPl4=; b=g3thUk
	4cswf22HXbf8iOmrEOZqEu5RxYywzO1Xrbu4fr3AcBH9shc0PC101G/iSRty44lW
	cV3cS7iJZF9VUFT/JxLjMfcXWsfcweTC+2nINoWvstuafqbZnM2euk2rHetFkc+/
	+cd/cPyoTm5Av0azeB5+bFglodugNObN2XcsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wPX+Murv8oWtY6IIVxVuMtpT/rPIGuxu
	2lsh8PS7BcTPuFiASB2Dv5/sddiXvsQ1fQpYjYPcnk1UR6ndEWe4GaBlG5xu8HFJ
	pST3XN4VbWarvJx5++fZLJ8SSceeQd31i8fqk6du5Cc2YaU/BDp5nYiQqPqaES/r
	FyZ3hxhYpnw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24DE7204F5;
	Wed, 25 Jun 2014 13:32:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7171B204EC;
	Wed, 25 Jun 2014 13:32:26 -0400 (EDT)
In-Reply-To: <CANR0-ag4ZKmHBNPxYkohBJEpXierFV+K3Ub4tH8YYD7FK73FdA@mail.gmail.com>
	(Mark Ferrell's message of "Mon, 23 Jun 2014 16:37:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ACBB480C-FC8E-11E3-B803-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252451>

Mark Ferrell <major@homeonderanged.org> writes:

> push repository, but our use case relies on the pull branch being
> different than the push branch.  It would seem that git would need a
> branch.<name>.push directive for this to work out.

I thought that you can tell recent versions of Git to pay attention
to the remote.*.push patterns and use them as a refmap even when you
are pushing a single branch?

Here is a demonstration:

 $ (git init src && cd src && git commit --allow-empty -m foo)
 $ git clone src dst
 $ cd dst
 $ edit .git/config ; cat .git/config
 [core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true
 [remote "origin"]
         url = ../src
         fetch = +refs/heads/*:refs/remotes/origin/*
         push = refs/heads/*:refs/heads/dev/me/*
 # note that I edited out [branch "master"] section to show that
 # you do not even need per-branch configuration.
 $ git commit --allow-empty -m bar
 $ git push
 Counting objects: 1, done.
 Writing objects: 100% (1/1), 184 bytes | 0 bytes/s, done.
 Total 1 (delta 0), reused 0 (delta 0)
 To ../src
  * [new branch]      master -> dev/me/master

For simplicity I used two local repositories and used a random
pattern "refs/heads/dev/me/*", trusting that the readers are capable
of updating the example to use remote URLs and different hierarchies
as needed.
