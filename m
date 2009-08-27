From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Thu, 27 Aug 2009 14:50:11 -0700
Message-ID: <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <1251337437-16947-9-git-send-email-johan@herland.net>
 <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
 <200908271135.31794.johan@herland.net>
 <7vtyztq8nv.fsf@alter.siamese.dyndns.org> <20090827212710.GV1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgmrg-0006cK-L4
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbZH0Vua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbZH0Vua
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:50:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbZH0Vu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:50:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D37E61BC60;
	Thu, 27 Aug 2009 17:50:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wyDQK8seGeC/n2zAAp6nqOl4pfE=; b=r1q6Ok
	L7ocVBWmqcdQ0jcpDhj5rw49CLhKISXPu/6grNOfAUj/pATgQBY6hqSJ6wP4iMVQ
	/GnopDZxJZhDFQEFC1fSeftHPjy1EKVgc3arsJIcgE8Qo0psN4AJOPhK5B+quIMg
	Yd8DUZZNAlM05NJ/sRuSiYICA9il2aDA+H+Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XpdV+FILOb3Mlywbtbn9WSbR+NjW0WmM
	V/iwYaphmw35UXeu23KTeGnFcFgMjeiYDCF+IpRFoq/alW9vTySjEHx+LxQO8utU
	YFWHmdi8xQ86PsEtPa3ndyp9/sSS+v73JkFaRiGIos53KI3JYO47cvTL5llFbX3v
	0YRpwQR5mJU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 575AC1BC5C;
	Thu, 27 Aug 2009 17:50:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCC671BC55; Thu, 27 Aug
 2009 17:50:12 -0400 (EDT)
In-Reply-To: <20090827212710.GV1033@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 27 Aug 2009 14\:27\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F5D6414-9353-11DE-BA5A-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127221>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Yea, it was me.  I still think it might be a useful idea, since
> it allows you better density of loading notes when parsing the
> recent commits.  In theory the last 256 commits can easly be in
> each of the 2/ fanout buckets, making 2/38 pointless for reducing
> the search space.  Commit date on the other hand can probably force
> all of them into the same bucket, making it easy to have the last
> 256 commits in cache, from a single bucket.
>
> But I thought you shot it down, by saying that we also wanted to
> support notes on blobs.  I happen to see no value in a note on
> a blob, a blob alone doesn't make much sense without at least an
> annotated tag or commit to provide it some named context, and the
> latter two have dates.

Yeah, and in this thread everybody seems to be talking about commits so I
think it is fine to limit notes only to commits.
