From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 08:52:28 -0700
Message-ID: <7vboa3wmgz.fsf@alter.siamese.dyndns.org>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com> <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org> <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1> <20130327231819.GL28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>, Rob Hoelz <rob@hoelz.ro>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULF8O-0002U0-7W
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab3C1Pwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:52:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab3C1Pwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 11:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E71BA9F6;
	Thu, 28 Mar 2013 11:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/0hoRdnOZlvS1sB2DzaYBP/xjKo=; b=KEN+WX
	Ihcyg8Q1nAqD+6+11xObyvOs+3OhELknKrW2EelRHf2W1+N6mR9AG5uLokPbKfvk
	C44qlVsqfijAGEPK+x5wYPLCA1Et3pESuIOS2ecyzkWwdVi4SipEaq17NG6zv9oB
	WsV7yzeRVPFK+ccRNe3JRQZQ9psWW+2XEpRuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TTjXBAUyGjZhMphMuIHlkAnhFqIUpWU5
	RKd0kDG4nItIxzggsp1qN6K/aUq72xZV4I9A6GT8Ik6GsV+iytuL8ew+Rd5iwTAt
	G3HS7WOhyRhOidVk5YaKxz4W76O+oowMmWrplGl9N0B66CMJ7t8HJq45UQD+lt/v
	rb/+WX8AOlY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63956A9F5;
	Thu, 28 Mar 2013 11:52:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C031FA9F4; Thu, 28 Mar 2013
 11:52:29 -0400 (EDT)
In-Reply-To: <20130327231819.GL28148@google.com> (Jonathan Nieder's message
 of "Wed, 27 Mar 2013 16:18:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EE40B06-97BF-11E2-BD70-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219414>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Josh Triplett wrote:
>
>>                       I have a .gitconfig in my git-managed home
>> directory which sets pushInsteadOf so that I can clone via git:// and
>> immediately have working push.  I work with a number of systems that
>> don't have inbound access to each other but do have outbound access to
>> the network; on some of these "satellite" boxes, I can't push changes
>> directly to the server pushInsteadOf points to, so I can explicitly set
>> pushurl in .git/config for that repository, which overrides the
>> pushInsteadOf.  This change would break that configuration.
>
> Would it?  As long as your pushurl does not start with git://, I think
> your configuration would still work fine.

That is a good point, especially because it is very unlikely that
git:// was used for pushURL, given that it would not have been
rewritten with pushInsteadOf to an authenticated transport.

> After this patch, neither pushInsteadOf nor pushUrl overrides the
> other one.  The rule is:
>
> 	1. First, get the URL from the remote's configuration, based
> 	   on whether you are fetching or pushing.
>
> 	   (At this step, in your setup git chooses the URL specified
> 	   with pushurl in your .git/config.)
> 	
> 	2. Next, apply the most appropriate url.*.insteadOf or
> 	   url.*.pushInsteadOf rule, based on whether you are fetching
> 	   or pushing.
>
> 	   (At this step, no rewrite rules apply, so the URL is used
> 	   as is.)
