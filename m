From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Don't copy "submodule.<name>.update" to .git/config on
 submodule init
Date: Wed, 23 Feb 2011 12:28:02 -0800
Message-ID: <7v7hcq8pil.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D65660D.3040501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 23 21:28:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsLJo-0003PM-Ln
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 21:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab1BWU2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 15:28:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab1BWU2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 15:28:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13D364E77;
	Wed, 23 Feb 2011 15:29:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Glk85dRmAAwkJDT41E1KyDa7OGE=; b=vqDxea
	lZS1WRHvRBna5KWXdzMsfDq42MnQV1nuzXklINQqQNACBRLvq2t/wCe4TAxMM+0z
	uGj/Y7NQkv+OQJ4mos2JIZ3jMWZuMLMn9MMv5Gpbrp0ea7zDoPS+l3Zfa2l7HsD8
	ITkZyj+yJrVljCiDzeQxGOBxPJ/lcOU47VMX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dBa7fSwabLl8qVhMGvoNwzAxi+dI7UuB
	JI4+H0dCVjqZMB4mTrzgXDh0f1m0l8WwkuLGCJ3Ev5IjJ6L4GZO3L9j2BWsFVYtz
	iOyM1Cpx+zOrGTCxgr35OvFFg8tDmQz4HtsKpA20DkzJ1IoZePjMQgVxFIjM+XQH
	yWQWAil6i/A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5B9A4E6A;
	Wed, 23 Feb 2011 15:29:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC0804E65; Wed, 23 Feb 2011
 15:29:16 -0500 (EST)
In-Reply-To: <4D65660D.3040501@web.de> (Jens Lehmann's message of "Wed\, 23
 Feb 2011 20\:54\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97AF2686-3F8B-11E0-A690-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167720>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Proposal:
>
> Stop copying the "submodule.<name>.update" entries into .git/config
> on "git submodule init". The current behavior makes it impossible
> for upstream to change defaults later, as this value can only be
> altered through user intervention when it resides in .git/config.
> This is a good thing when he chose to copy it there, but it doesn't
> seem to make much sense doing it by default.

Doesn't it just come from the usual "upstream can give a sane default as
recommendation to users who may not bother to set up .git/config, and the
user can tweak that if that doesn't suit his/her needs" convention?

I have a feeling that the correct fix (not limited to "update" but all the
submodule related configuration that share the same "give default, allow
tweak" philosophy) is to:

 (1) record submodule.<name>.update at initialization time, to allow the
     upstream a chance to give a sensible default, as we do now;

 (2) in addition to that, record the fact that the value came as upstream
     default.  You could do so in multiple ways:

     a) record the commit that gave the suggested default to .git/config,
     perhaps submodule.<name>.defaultedFrom (notice that this is
     independent from "update", and covers all such configuration
     variables with a single value); or

     b) record the value the upstream gave to .git/config in a separate
     variable, perhaps submodule.<name>.updateSuggested; or

     c) some other clever way you can think of, as long as it lets us do
     the next step.

 (3) when updating from the upstream results in a change in .gitmodules
     file that changes the previously suggested default the user
     considered, tell that to the user and have him/her choose.  If you
     took (a) in the previous step, you can use "git diff" to determine if
     the suggested default has changed; if you took (b) in the previous
     step, you can compare submodule.<name>.update in .gitmodules with
     submodule.<name>.updateSuggested to do so; if you did (c), you are on
     your own ;-).  After the user updates (or chooses to keep the current
     setting), record the current suggested default just like you did at
     the init time in step (2).

One thing to be careful is in (3) you should not bother users who chose to
ignore the upstream default (i.e. has submodule.<name>.update set
differently from what is suggested by the .gitmodules at the time of
initialization).  The reason (3) updates the "current suggested default"
is exactly for that purpose---the user has seen what the last suggested
default was, and decided to either go with it or have his/her own setting.
