From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 12:58:07 -0700
Message-ID: <xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
References: <20130917190659.GA15588@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Sep 17 21:58:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1Pe-00008r-D8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab3IQT6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 15:58:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab3IQT6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Sep 2013 15:58:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67EF84241D;
	Tue, 17 Sep 2013 19:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=x5YpNovhyuhY
	zLaAwVnAjS3fiBs=; b=VSrxyyTs+JphUVj5gA5GxXhyjxBwxFbXo+xL7f16659a
	mGNfjcp+SOkOEDds8J81eTQ0RbcW6I0m8IisGOf321nlQ+sqA/Sd598Wwpy4Gqob
	HXYiabYLjrNSDJ7QXC3QsWL49Yi85NbIe35ig5lO/37XyxV+AGw9uuiotwtsJOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uueW82
	YerJK0HTSuS6P1koCrI2mFE6HEy/D4mBrqTlQ0zVVAVkk3KlKByetzHD1SCVqT1W
	T9TMm4KRGV7dUo0gZTeqsLTHncdd5QXADP4swL//YFdd3/CZxWsnKma5wkq49W1H
	7Dem1Y0OEVQCwdVTIIn8pqRkJZKDnNaveo4us=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DA864241C;
	Tue, 17 Sep 2013 19:58:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B42894241B;
	Tue, 17 Sep 2013 19:58:09 +0000 (UTC)
In-Reply-To: <20130917190659.GA15588@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
 =?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Tue, 17 Sep 2013 21:06:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A0CCD74-1FD3-11E3-866D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234910>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> after these commands:
>
> 	$ git init
> 	$ mkdir subdir
> 	$ echo a > subdir/a
> 	$ git add subdir/a
> 	$ git commit -m a
> 	$ echo more a >> subdir/a
> 	$ echo b > subdir/b
> 	$ git add subdir/*
> 	$ git commit -m b
> 	$ git checkout HEAD^ -- subdir
>
> I'd expect that subdir/b is removed from the index as this file didn'=
t
> exist in HEAD^ but git-status only reports:
>
> 	# On branch master
> 	# Changes to be committed:
> 	#   (use "git reset HEAD <file>..." to unstage)
> 	#
> 	#	modified:   subdir/a
> 	#
>
> Is this intended?
>
> (I'm using git 1.8.4.rc3 as shipped by Debian (package version
> 1:1.8.4~rc3-1).)

The intended behaviour of "git checkout tree-ish -- pathspec" has
always been "grab paths that match pathspec from tree-ish, add them
to the index and check them out to the working tree".  If you have
subdir/b in the index and the working tree, it will be kept when the
paths that match "subdir" pathspec is grabbed out of the tree-ish
HEAD^ (namely, subdir/a) is added to the index and to the working
tree.

I could argue that the above intended behaviour is suboptimal and it
should have been "the resulting paths in the index and the work tree
that match the given pathspec must be identical to that of the
tree-ish".  In the resulting index or working tree, paths that match
"subdir" pathspec in the above result is subdir/a and subdir/b, and
that is different from what exists in the given tree-ish (which has
only subdir/a and not subdir/b), and under that modified definition,
what the current one does is not correct.

I vaguely recall arguing for the updated behaviour described in the
above paragraph, and I even might have started working on it, but I
do not think we changed this behaviour recently, unfortunately.
