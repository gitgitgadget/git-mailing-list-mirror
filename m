From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Thu, 28 Mar 2013 16:10:42 -0700
Message-ID: <7vr4izqfwt.fsf@alter.siamese.dyndns.org>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214728.GB10936@sigill.intra.peff.net>
 <20130328224027.GA9911@sigill.intra.peff.net>
 <20130328224928.GA20242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 00:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLyS-0006sZ-4G
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 00:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab3C1XKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 19:10:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744Ab3C1XKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 19:10:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 407B4E30B;
	Thu, 28 Mar 2013 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nIeW1TNa5kaFid7cWm9e/n1RvCA=; b=A/aomt
	jU2XGLXAQ3+RcHPMJy1v0QbmLT/RGJ0BefVJlg8nqo58VfKLkBmZRJPBEiWQDEJV
	04YGnXPkSeyubl6SA0vS0tS8g3bHSZA4suAuL+bv+CVBlWpuVYdrgvh2awQahZIW
	dt0VasmN+jWfpVzCgai1SkqKO3nZduQqox/20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pCtibiRrzNebihggfXnHdpUTunan8d2Z
	F70zZWSw1hVsnfEVrDWXhS0J2am/kDZe6c4if+DzPzyCIQ/m6yB1oYXQmbl9PZqj
	AalEZ491SYBGpy0K9i0BlTdYRFM8TfZ6ho8p0+5I4Hs2SlfR/Ut9reg7vJo5qFP0
	uNnREt6pFBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36F32E30A;
	Thu, 28 Mar 2013 23:10:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B14B1E307; Thu, 28 Mar 2013
 23:10:43 +0000 (UTC)
In-Reply-To: <20130328224928.GA20242@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 28 Mar 2013 18:49:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B74C926E-97FC-11E2-B779-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219477>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 28, 2013 at 06:40:27PM -0400, Jeff King wrote:
>
>> On Thu, Mar 28, 2013 at 05:47:28PM -0400, Jeff King wrote:
>> 
>> > From: Junio C Hamano <gitster@pobox.com>
>> > 
>> > The function takes two counted strings (<basename, basenamelen> and
>> > <pattern, patternlen>) as parameters, together with prefix (the
>> > length of the prefix in pattern that is to be matched literally
>> > without globbing against the basename) and EXC_* flags that tells it
>> > how to match the pattern against the basename.
>> > 
>> > However, it did not pay attention to the length of these counted
>> > strings.  Update them to do the following:
>> > 
>> >  * When the entire pattern is to be matched literally, the pattern
>> >    matches the basename only when the lengths of them are the same,
>> >    and they match up to that length.
>> 
>> Hrm. Though the tip of this series passes all tests, this one actually
>> breaks bisectability. What happens is that the existing code passes:
>
> Ugh. That is a problem, but this series does _not_ pass all tests. I
> think I failed to run the complete test suite on the correct tip.
>
> My match_pathspec fix breaks at least t1011.

Yeah, the tip of 'jch' (slightly ahead of 'next' that I use myself)
has 0003, 1011 and 3001 broken X-<.
