From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Sun, 09 May 2010 11:20:21 -0700
Message-ID: <7v1vdl9btm.fsf@alter.siamese.dyndns.org>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 20:20:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBB7W-0004cf-Bn
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 20:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab0EISUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 14:20:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0EISUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 14:20:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30364B262D;
	Sun,  9 May 2010 14:20:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=staDY/B6KyQEF4O0kEF9FLgR7tQ=; b=LwNneo
	eWcp+cF+K/S3p6sHInfErbHJWsKQccxemxtlvjQatDnv/UnAlMdIv2s/NmT93xfz
	227as3pErRPodNLDH86kjgh86ZYkTYMvBJpn+AkSIWoO0xqbjPnFwB2HWRkVqojS
	rSiqhtuw+OC8K3ba8QRdgoY0eJbTCeerWVLqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RoLN1NR+JbanrrQD2x9ajUGrV4wU1xqB
	XG8seYWyguDSEfphlJaDiSckJ9b/jO83VkaHR6YA2tnflsRpv/1M3JyFWj/9vwAf
	jLYJxxRoH7H5DDsnwlatU1K0MPcEWSVjovM8FxuYv38LhXA/oaoDC03DuYzOp+6f
	/CUHbol6eag=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA56B262C;
	Sun,  9 May 2010 14:20:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E787DB262A; Sun,  9 May
 2010 14:20:28 -0400 (EDT)
In-Reply-To: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
 (Bo Yang's message of "Sun\, 9 May 2010 07\:00\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91A5BF08-5B97-11DF-A71E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146736>

Bo Yang <struggleyb.nku@gmail.com> writes:

> git log <revision> -L1,8 -L45,+6 <file1> -L/some/,/end/ -L9,29 <file2> <file3>
> ...
> Since '-L' option is also used by many other command, I don't know the
> exact impact of this, anyway we can use another name anytime...
>
> If there is no opposition for this kind of option syntax, I will try
> to implement it in revision.c. ;-)

I'd rather not to see this in revision.c at all.  The revision.c parser
has always been options and then pathspecs and never takes individual
filnames, except for "--follow" that is an afterthought checkbox hack that
lets the main parser parse and then reject a generic pathspec after the
fact.

I think the right place to do this sort of thing is in the incremental
output of "blame".  The command only takes individual filenames and never
takes general pathspecs, it knows about -L as line-range (and as far as I
see, it is the only command that does so) and I think its output routine
already has the right infrastructure for doing this.  The "--incremental"
output itself is designed for porcelain scripts to interpret and do the UI
around it, but that does not mean it can have another mode that gives
human readable output.  When "blame --incremental" emits the record that
says "these lines are blamed to this path in this commit", it has already
run internally necessary "diff" between blobs to find that
information---you should be able to re-run the diff (or keep the output
from "diff" around, but I would suggest against it) and show something
like "git log -p" output but is limited to the hunks that actually touch
the areas that we are following.
