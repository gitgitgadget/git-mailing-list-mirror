From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] branch: not report invalid tracking branch
Date: Wed, 14 Aug 2013 08:38:01 -0700
Message-ID: <7vbo50uvty.fsf@alter.siamese.dyndns.org>
References: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
	<96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 17:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9d9T-0006N8-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 17:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759102Ab3HNPiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 11:38:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758380Ab3HNPiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 11:38:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55AE636EC3;
	Wed, 14 Aug 2013 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GOTnKP2m0W6eXAZNW5oydr7eBKI=; b=MUpGjn
	mi66IG9H5EtAgFmalXf640SH1QMKPG4SCf9ZSzSZiSAdJgQNbwbT7VEu/ZmB/BeS
	hQAhdBHDY7jGYyszafTPOqwKown8ky/qat9X7at96R583fULM2I5ps74feTfm9rZ
	Xu1HrFwV7tZg7xVUa11VECT581t3C7EfxBe+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g6dn90hajPS2PL9XroYQUykVDCtf62Sa
	TqablELyW+W0T2qluh4hYqdBbCTNRUq/Iat0bVmmhILcUwgPhYlpN/EqbFttVMCG
	lFrcDcQzS9uaLTAcA3woCXG9Vfo1VqD1F8nNfNb+stUAHFFA/ju2vYH36VD4LSsm
	OD/CwUykdKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 117F336EC2;
	Wed, 14 Aug 2013 15:38:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F54B36EB8;
	Wed, 14 Aug 2013 15:38:12 +0000 (UTC)
In-Reply-To: <96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Tue, 13 Aug 2013 12:53:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87DB4A76-04F7-11E3-8805-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232288>

Jiang Xin <worldhello.net@gmail.com> writes:

> Command "git branch -vv" will report tracking branches, but invalid
> tracking branches are also reported. This is because the function
> stat_tracking_info() can not distinguish whether the upstream branch
> does not exist, or nothing is changed between one branch and its
> upstream.

I am guessing that by "invalid", you used to have another branch
(possibly a remote one) you built a branch on (hence the upstream of
the latter is set to the former) and the former branch no longer
exists.

Shouldn't that case reported a bit more specially?  After doing this:

	git init
        git commit --allow-empty -m initial ;# on master
        git branch topicbase
        git checkout -t -b topic topicbase
        git commit --allow-empty -m topic ;# on topic
        git branch -d topicbase

the branch "topic" _thinks_ it is still based on "topicbase", but of
course "git log @{u}.." will fail.

A few thought-alouds:

 - Perhaps "git branch -d topicbase" should have warned that there
   are some branches that are based on it?  Should it have failed?
   Or should it automatically removed branch.*.merge entries that
   point at it (while warning)?

 - The operation that removes the @{u} of some branch does not have
   to be "git branch -d".  It could be "remote --prune", and it does
   not make much sense to fail that operation, as what is gone from
   the other side is gone, and the point of having remote tracking
   branches is to keep a faithful copy of the observed status of the
   remote.  It implies that failing "git branch -d topicbase" is not
   a good idea.  Also removing the branch.*.merge automatically is
   probably not what the user wants (at least, the name would hint
   something, even after the topicbase branch is gone).

So "git branch -v -v [topic]" would want to still say that topic is
based on topicbranch, even though the latter is gone and there is no
longer a real "building on" relationship.

E.g. before "git branch -d topicbase" we would see something like:

    $ git branch -v -v
      master    e67ac84 initial
    * topic     3fc0f2a [topicbase: ahead 1] topic
      topicbase e67ac84 [master] initial

and after it, we currently see:

    $ git branch -v -v
      master    e67ac84 initial
    * topic     3fc0f2a [topicbase] topic
      topicbase e67ac84 [master] initial

but we may want to say:

    $ git branch -v -v
      master    e67ac84 initial
    * topic     3fc0f2a [topicbase (gone)] topic
      topicbase e67ac84 [master] initial

or something.

In order to distinguish these three cases (i.e. no tracking, with
configured but no longer valid tracking, and with tracking), you
would need more than true/false.

> This patch changes the return value of function stat_tracking_info().
> Only returns false when there is no tracking branch or the tracking
> branch is invalid, otherwise true.

Instead, you would need -1 (with "gone" base), 0 (no base), 1 (with
base).

This is a tangent, but we might want to rename stat_tracking_info().
A branch A building on top of another branch B does not mean A
"tracks" B.  The wording is a source of confusion.
