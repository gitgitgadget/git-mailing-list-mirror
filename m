From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 10:08:52 -0700
Message-ID: <xmqq7g4k4tzv.fsf@gitster.dls.corp.google.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	<1402615835.5629.34.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:09:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvUyN-0002nG-GD
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbaFMRI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:08:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61399 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbaFMRI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:08:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E6131EECA;
	Fri, 13 Jun 2014 13:08:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=txoFvgHsCDzWKMf1TwdV6JzQlu4=; b=sQ8oZe
	yIzzYEXbUM9MNIgTcr9IsWT/plRYsL5GNOg/comsHryio9l9kfUc1s/HQRiKTjnw
	Fe1LboJgGKFq/NeW0YhMdAi9/eLnhSyHXFPIZfFkAgtqzOEd9ruPFxA28XVPVRHy
	J5rTnGqAQ+RWok9MyyRqV2ieJzANg+BCO0LmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMuUxGxw2T824BDya4cEksiIR6e35Tgq
	kkbUIWZHT6CqAPqOhPd+AgJbDq2fzgOuEkttIDWFu/BuUMiPK7FmqleNxUpxfj5G
	YXmp20ziqQ3dYhvxWDNBpgG6t4zhklfcBY8ZkuDn0VoOWOzTRZYMBqhqLkL42rMP
	WkmPIBVX/Xo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32F351EEC8;
	Fri, 13 Jun 2014 13:08:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CA2A1EEB5;
	Fri, 13 Jun 2014 13:08:53 -0400 (EDT)
In-Reply-To: <1402615835.5629.34.camel@stross> (David Turner's message of
	"Thu, 12 Jun 2014 19:30:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65E99FA2-F31D-11E3-9E93-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251615>

David Turner <dturner@twopensource.com> writes:

> On Thu, 2014-06-12 at 12:47 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> > This issue bit us again recently.
>> >
>> > In talking with some colleagues, I realized that the previous version
>> > of this patch, in addition to being potentially slow, was incomplete.
>> > Specifically, it didn't handle the case of refs/heads/case/one vs
>> > refs/heads/CASE/two; these are case clones even though they strcasecmp
>> > different.
>> 
>> Good catch to realize that two refs that share leading paths that
>> are the same except for cases are also problematic, but that makes
>> this feature even less about "case clones", doesn't it?
>
> I agree: word "clone" is less good now.  Maybe "case conflicts"?

Sounds better but I'd like to hear from the ref people first, as
they have thought about it longer than I have ;-)

>> Also it somehow feels that the patch attempts to solve the issue at
>> a wrong level.  On a platform that cannot represent two refs like
>> these (e.g. trying to create "FOO" when "foo" already exists, or
>> trying to create "a/c" when "A/b" already exists---ending up with
>> "A/c" instead, which is not what the user wanted to create), would
>> it be more sensible to fail the ref creation without touching the
>> users of ref API such as receive-pack?  That way, you would also
>> catch other uses of refs that are not supported on your system,
>> e.g. "git branch a/c" when there already is a branch called "A/b",
>> no?
>
> So we would change is_refname_available?  And to do this, we would
> change the ref_dir functions to take case into account?
> ...
> In other
> words, if the user has A/b and a/c already, and we find A/b first, then
> we reject a/d but allow A/d.   This is arbitrary, but workable.  We
> could warn about this situation when we load up the refs, too.  
>
> Does this match what you are suggesting? 

Yes.  But again, I'd like to hear from the ref people first.  They
may have better ideas.
