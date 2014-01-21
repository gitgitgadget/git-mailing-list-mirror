From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack --max-pack-size broken in git-next
Date: Tue, 21 Jan 2014 15:01:29 -0800
Message-ID: <xmqqzjmprlbq.fsf@gitster.dls.corp.google.com>
References: <52DEF927.7090005@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Siddharth Agarwal <sid0@fb.com>
To: <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 00:01:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kKC-0004QC-2L
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbaAUXBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:01:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbaAUXBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:01:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41D4D65937;
	Tue, 21 Jan 2014 18:01:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMzJzE5xF7CkszfOR3PYFZCsIkM=; b=KgqGAb
	hleNeODwI7qXp4CZKo/1GQRftijYOY9Yhv8Ju1drAcsD0bb+YRvEvdEEHWNO8W6J
	ZlI5Ag7k73LXZz0zx1xxmuSJNyqyYpORCbBuN94H+RTZXul6eY7nDbTYnK6GexSb
	Ine5iE7egjrZ8dfomqpzrZuvmwThfycCKk96s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YaftXyWMoRZ18MtOFXtNk/bAUTIQy9R2
	zqA2Bw2RR9Xes6+73JrSQa/KsdF3wrqW0RyQKoWJXaN8ykZirGRV/bl9RgTHKsOZ
	4D9XyfLSSdOWU0lEtyA8Mz7yhRcnSV08UnR6W2PvdUPZ3dKPjAVAcduZ3EvbwhFV
	zUAPEBk6WjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3044465936;
	Tue, 21 Jan 2014 18:01:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3657E65931;
	Tue, 21 Jan 2014 18:01:33 -0500 (EST)
In-Reply-To: <52DEF927.7090005@fb.com> (Siddharth Agarwal's message of "Tue,
	21 Jan 2014 14:48:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F8AFBB3A-82EF-11E3-936B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240788>

Siddharth Agarwal <sid0@fb.com> writes:

> With git-next, the --max-pack-size option to git repack doesn't work.
>
> With git at b139ac2, `git repack --max-pack-size=1g` says
>
> error: option `max-pack-size' expects a numerical value

Thanks, Siddharth.

It seems that we have a hand-crafted parser outside parse-options
framework in pack-objects, and the scripted git-repack used to pass
this option without interpreting itself.

We probably should lift the OPT_ULONG() implementation out of
builtin/pack-objects.c and move it to parse-options.[ch] and use it
in the reimplementation of repack.

And probably use it in other places where these "integers in
human-friendly units" may make sense, but that is a separate topic.
