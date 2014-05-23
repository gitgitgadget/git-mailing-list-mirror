From: Junio C Hamano <gitster@pobox.com>
Subject: Re: more concerns about '--git-dir'
Date: Fri, 23 May 2014 12:23:15 -0700
Message-ID: <xmqq1tvkjo4c.fsf@gitster.dls.corp.google.com>
References: <CAKpPgvf_UfgtOkotPz+aF4=UqQTOmk0O8tXg4Cm3zjzFimUoHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 21:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnv3u-00022R-56
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 21:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbaEWTXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 15:23:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54682 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbaEWTXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 15:23:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C25EF19BC3;
	Fri, 23 May 2014 15:23:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6K10t+97BvbhXMp1Le4iv1afdJY=; b=rI3n52
	UhevDFXHLWGto+++QoUMWfqz+61R/kZ8MiU5Amra5BCCqzc80XL08jDuxoeNI1hD
	R790MUwKvDO2/iBKYqJY8akHhCcRNZWhf+dWkwVvwMe5lCn97sIASyEsrOfE5Mnq
	eDA3PkdNWDhc78rOEktKeZLFRhLbb7aWHGVBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nDNQZoXuGPJeRlSm0qhlIFSfU1L8x7bu
	9CtwKc+IYZMX9ELmlbMNGGF7E9B1pKA+hpaAGWejke8on5mdC9A+gduKxNr5ZV0A
	ciQXStiwR0dXvyHM2uAyHNIyd0VdHKK7AsQrmYDmu5zhu6yOUwF9vFARb9MoQakX
	9nV9PUfsnQU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B94BF19BC1;
	Fri, 23 May 2014 15:23:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5D2BF19BB6;
	Fri, 23 May 2014 15:23:17 -0400 (EDT)
In-Reply-To: <CAKpPgvf_UfgtOkotPz+aF4=UqQTOmk0O8tXg4Cm3zjzFimUoHw@mail.gmail.com>
	(Pasha Bolokhov's message of "Fri, 23 May 2014 11:41:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B15AD100-E2AF-11E3-8473-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250016>

Pasha Bolokhov <pasha.bolokhov@gmail.com> writes:

> 1) an apparent missing "normalize_path(git_dir)", when GIT_DIR is an
> absolute path:
>
> don't even need to name the repository anything different, but run this command:
>
> $ cd ~/tmp/
> $ git init
> $ git --git-dir=$HOME/tmp/../tmp/./././.git --work-tree=$HOME/tmp/../tmp/ status
>
> You won't notice anything different in the output of course, but the
> environment will be odd:
>     GIT_DIR=../tmp/./././.git
>     GIT_WORK_TREE=$HOME/tmp
> Notice how the work-tree has been normalized and git-dir hasn't. It's
> kinda hard to imagine when this can lead to an error, but never know.

I think this one is in the "if it hurts, don't do it then"
territory.

> Would there be objections to fixing this?

As long as it can be cleanly done without penalizing sane usage, I
do not think there will be.

> 2) "git --git-dir=meta status" complains:
>
> $ git --git-dir=meta init
> $ git --git-dir=meta status
>
> yells that work-tree isn't setup and denies to run.

Is that because meta/config does not say where the worktree is?

Again, this smells like "if it hurts, don't do it then", even more
so than the previous one.  Does it help if you add --git-work-tree
to the command line, too?
