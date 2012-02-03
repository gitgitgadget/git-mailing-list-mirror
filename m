From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Commits with ancient timestamps
Date: Fri, 03 Feb 2012 10:01:24 -0800
Message-ID: <7v1uqbssnf.fsf@alter.siamese.dyndns.org>
References: <1328218903-5681-1-git-send-email-gitster@pobox.com>
 <87mx90yz5y.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 03 19:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtNS3-0005nS-Fa
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 19:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359Ab2BCSBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 13:01:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181Ab2BCSB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 13:01:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1460039CC;
	Fri,  3 Feb 2012 13:01:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uLsTQXb7F2A+sQKB2yMvSaTa2Co=; b=upYecF
	MK71JYeE5VjeJOzdtqIqATplncaJN7F01JcAp8dZcpH4NkMVXbpm7ihk5urCitEL
	E55M/COQlx+T9pvcg3vmlqRbofJUCU75PLztfS42W3Z275Jd5UrE1f07FdZ1fd8g
	Hc3S+jXmuieK8Fce7gasxRqyym5yVZR2BC+XY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ea2i/U5kK9p9ZmBWBR/pQ+Df6fNkyuR2
	K3Kq2DZ8G+F3Iy+I7IS5XXFtCSSTtW80ef4aJqTX9PtitKYUQmWjOgVEGICGhCIl
	9kAB6XAt1scDM+1ruUibUpg2Wv8nXJbdk/DnH8luK0hWk9IkpQP5P6SkQ1B7V2E7
	xoiGjprsdAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C15A39CB;
	Fri,  3 Feb 2012 13:01:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90A3D39CA; Fri,  3 Feb 2012
 13:01:28 -0500 (EST)
In-Reply-To: <87mx90yz5y.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 3 Feb 2012 11:44:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 187F1EE6-4E91-11E1-9601-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189788>

Thomas Rast <trast@inf.ethz.ch> writes:

> Doing this just makes me wonder how important exactly the 1970-1975
> range is.  Is there a notable software history from that era that can be
> recovered?

That is not really a valid question. People who wrote private stuff in
that era deserve to be users of Git, too.

> (Your [1/2] does not seem to parse negative offsets from the unix epoch,
> so anything before 1970 is still out.)

Yes, pre-epoch timestamps are also useful for projects like US
Constitution.

  http://thread.gmane.org/gmane.comp.version-control.git/152433/focus=152725

For that, we would need to use and pass around time_t (or intmax_t if we
follow the reason why originally Linus chose to avoid time_t) throughout
the codebase.  If you actually write commit objects that record pre-epoch
timestamps, however, they will become unreadable by the current versions
of Git (as they would not understand such a negative raw timestamp).

In any case, that is a goal for a much longer term.

But even after such a change happens, you still need a way for Git to
replay a raw timestamp stored in commit objects without regressing the
parse_date() interface too much. These two patches show one way to do so
with minimum disruption.

As an added bonus, with the second patch, the way to spell a raw timestamp
happens to become compatible with how GNU date accepts one, i.e.

        $ date -d @1000000000

even though we do not have to encourage the use of this notation by humans,
tools and script writers may find it useful.
