From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can a git push over ssh trigger a gc/repack? Diagnosing pack explosion
Date: Thu, 21 Nov 2013 11:52:15 -0800
Message-ID: <xmqq61rl4jo0.fsf@gitster.dls.corp.google.com>
References: <CACPiFC+TqD_DhMaG+posoK4fTOLCoi=3jhJUPjt_72HTm9xjeQ@mail.gmail.com>
	<CACPiFC+xbnYjZUG49Em=aDUXnS_3_Cp=ZZBCrQCHM-sL78HCdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Coffland <sam.coffland@remote-learner.net>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 20:52:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjaIZ-0001Nu-H7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 20:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab3KUTwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 14:52:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab3KUTwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 14:52:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF97754709;
	Thu, 21 Nov 2013 14:52:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i3p4OjBAVHVU7Sx/lk6aBnuuVMw=; b=lwQrQM
	BmjDGrDXhrSh1dsEx4ieAl8beXU9u/EFsMhAkVQW70nfZhyVIUSbYtioheP4h38r
	g8DkR4iLt/x7YDrP0NsjTXZ6WSY140CwynhIrRJu/48VYKJWK1eG0CoKUx96wSiJ
	T8NlufiNgnBSKF/2d2x0S+CGrQoqpGBKVt6Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MKrHSG8KWvXsQz46Md9yZhzM1hqBP+fn
	UnPgN+BaonPQABPZ+9+CVqcpIfzlF6rSeyQ3P/SCbVK+fIWZjFsd9sy6IrYnFCZP
	S7yBeZ9G2jajtxwfe1Z5fWpB0pyfZI7dtTTPCIjHcAmhAHDWAekqp35WKCr9zezR
	nIoZs3R+0nM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E02FA54708;
	Thu, 21 Nov 2013 14:52:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39B3554706;
	Thu, 21 Nov 2013 14:52:18 -0500 (EST)
In-Reply-To: <CACPiFC+xbnYjZUG49Em=aDUXnS_3_Cp=ZZBCrQCHM-sL78HCdA@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 21 Nov 2013 10:35:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6D63D95A-52E6-11E3-8723-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238138>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Thu, Nov 21, 2013 at 10:21 AM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>> Do client pushes over git+ssh ever trigger a repack on the server?
>
> man git-config
> [snip]
>
>        receive.autogc
>            By default, git-receive-pack will run "git-gc --auto" after
>            receiving data from git-push and updating refs. You can stop it by
>            setting this variable to false.
>
> Oooooops!
>
> Ok, couple problems here:
>
>  - if it's receiving from many pushers, it races with itself; needs
> some lock or back-off mechanism

Surely.

I think these should help:

    64a99eb4 (gc: reject if another gc is running, unless --force is given, 2013-08-08)
    4c5baf02 (gc: remove gc.pid file at end of execution, 2013-10-16)

They should be in the upcoming v1.8.5.
