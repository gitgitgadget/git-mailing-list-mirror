From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] auto-repack exits prematurely, locking other processing out
Date: Fri, 23 May 2014 14:40:41 -0700
Message-ID: <xmqqy4xsgome.fsf@gitster.dls.corp.google.com>
References: <20140523195121.GA923@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 23:40:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnxCt-0001qq-Lk
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 23:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaEWVkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 17:40:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50611 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbaEWVkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 17:40:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 749EB1A07B;
	Fri, 23 May 2014 17:40:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SryIPjzHPyxQabPWDciazZR/h8M=; b=dlJ8zX
	2KXr6l2d1ISO7eaenRx8u1JK41p9c2Bbf/yaMaz440LOP0fpI7La1MCGf8vPOEC0
	FOm01+GZHpAEFK1z40FgC/Yo6GCpUQHVPrgPAEjUF3VvmfhTf8QK5Ro67cddugsc
	ewBeHT8JDIBwmnMD3iUgrbTpP8obgDkJfNqXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sJ2kFsBPKlgeCSr62SkC4wBfmnUuH8B6
	+7JKvpN2cXdRbTEqFOa4nK2thjxweu2jV2h6wyZfPD2vH9VpUgEygy4BomxqIV3d
	XuNgpT+uH6NBjKNGxZuySgOpcE7K/AjaMaR4BpwYsPb9sZv5B4qm5k6d89TWjeDy
	8Qm1UjDOmHk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6ACF51A079;
	Fri, 23 May 2014 17:40:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 064081A077;
	Fri, 23 May 2014 17:40:42 -0400 (EDT)
In-Reply-To: <20140523195121.GA923@angband.pl> (Adam Borowski's message of
	"Fri, 23 May 2014 21:51:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E424667E-E2C2-11E3-B4AE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250036>

Adam Borowski <kilobyte@angband.pl> writes:

> Hi guys!
>
> It looks like the periodic auto-repack backgrounds itself when it shouldn't
> do so.  This causes the command it has triggered as a part of to fail:

Yikes.  In the meantime, I think you can turn gc.autodetach off as a
workaround, e.g.

    $ git config --global --add gc.autodetach off

Duy, 9f673f94 (gc: config option for running --auto in background,
2014-02-08) turns to be not such a hot idea.  Sure, if we kick it
off background after doing something heavy, immediately before
giving control back to the end-user, and expect that the user will
stay thinking without making new changes (i.e. read-only stuff like
"git show" would be OK), then daemonize might be a great thing, but
we forgot, while doing that commit, that long-running operations
trigger the auto gc in the middle *and* they want it finish before
they continue, as the purpose of gc is to help the performance
during their further operation.



>
> ==========================================================================
> [~/linux](master)$ git pull --rebase
> remote: Counting objects: 455, done.
> remote: Compressing objects: 100% (64/64), done.
> remote: Total 267 (delta 208), reused 262 (delta 203)
> Receiving objects: 100% (267/267), 44.43 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (208/208), completed with 80 local objects.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>    4b660a7..f02f79d  master     -> linus/master
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> First, rewinding head to replay your work on top of it...
> Applying: perf: tools: fix missing casts for printf arguments.
> Applying: vt: emulate 8- and 24-bit colour codes.
> fatal: Unable to create '/home/kilobyte/linux/.git/refs/heads/master.lock': File exists.
>
> If no other git process is currently running, this probably means a
> git process crashed in this repository earlier. Make sure no other git
> process is running and remove the file manually to continue.
> Could not move back to refs/heads/master
> [~/linux]((no branch, rebasing (null)))$
> ==========================================================================
