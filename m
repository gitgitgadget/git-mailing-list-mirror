From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/BUG?] git show with tree/commit
Date: Tue, 12 Apr 2016 09:26:32 -0700
Message-ID: <xmqq4mb6sshz.fsf@gitster.mtv.corp.google.com>
References: <570D154D.6090006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:26:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq19I-0002Ff-TC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbcDLQ0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:26:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755418AbcDLQ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:26:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED04B539C5;
	Tue, 12 Apr 2016 12:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=twuQST6yeeXbXy7gN3wl2DcHo8M=; b=kx5XCm
	q3+3ZoPgsRacvcap62kwow0QMQ6QIVlEwtauFlDpuFUDPX6keXUEL8A2FtrH/tt+
	OKO6l/iLVtwu+CdCmJ2kRB0azKisNIUUDgrbl6TLqBbAWk1RMspM6lPE3Y4BVU+L
	WvbaTbVCLM6qKksCg+7vR5EeTQIS0KkdNqvYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XzMFrSIbKeQc2fM4t+JpmEAwFvPwX/vD
	YEljJRAX2kP0wahRQyrcWrLzZciaX0Bz5LbJQ0CZzgyhyZj3kyNCHJt14DjQB1Ls
	ihypcaIK5l2+VvVzjQxbb2+gZ3DCNTi9n8LE6bkHvixxomGOg0lB/KceaHIf34eE
	1UzmP6SQohI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4992539C4;
	Tue, 12 Apr 2016 12:26:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64414539C2;
	Tue, 12 Apr 2016 12:26:33 -0400 (EDT)
In-Reply-To: <570D154D.6090006@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 12 Apr 2016 17:33:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51EDBC78-00CB-11E6-B104-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291276>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> $ git show cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
> tree cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
>
> .gitattributes
> .gitignore
> .mailmap
> ...
>
> While it's clear to me what's going on, I'm wondering whether it's a
> good idea that "git show" says "tree" in front of the unresolved
> treeish, whether it's a tree, a commit or something else. I think it's
> pretty confusing.

There is no "unresolved treeish" on the line that begins with
"tree", but I suspect it wasn't very clear to you because of the way
you gave the command its input; notice the line in question ends
with a colon, which is unfortunate, but it turns out that it is your
fault ;-).  Read on.

> Alternatives would be:
>
> tree <resolved tree id> # here: 040...
> treeish <treeish>	# here: "treeish cab2c..."
> tree <treeish>^{tree} 	# here: "tree cab2c^{tree}"

So, the three choices are

 (1) resolve the tree object name to 40-hex and show it as
     "tree <object name in hex>"

 (2) given an object that is not a tree, show it as "treeish <object
     name>" 

 (3) do not do anything fancy, just show it as "tree <object name>"
     using what the user gave us.

I think the current output is doing the third one (notice the colon
at the end of the line).

    $ git show master: | head -n 1
    $ git show master^{tree} | head -n 1
    $ git show cab2cdadf: | head -n 1
