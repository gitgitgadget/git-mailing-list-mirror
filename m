From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Fri, 06 Apr 2012 21:56:18 -0700
Message-ID: <7v398gywb1.fsf@alter.siamese.dyndns.org>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 06:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGNhm-0001TO-BB
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 06:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875Ab2DGE4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 00:56:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2DGE4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 00:56:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 983344240;
	Sat,  7 Apr 2012 00:56:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b6Hua/LFhS6q9BAM+dGc6HGcFLI=; b=Bffu4V
	82dx4Go84IUiAW5y3BDhXGdN2tXykOdptB0HaXg0y/N1JWSRkL9TODC/f9W8l070
	/mybHosA5EMAlnHSFH4IMGvfM/KiePCJDDm8lPVh9PtPdZFX5QFAX5zlK0WqJmiQ
	ilJpMWtmBfNUIi8BKFR/UGiQ1I0rkH76D4UoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BRA1yz23nOYTulc6IcMEB7z/cVFg+jCt
	ljoXlusDjS81OJJKXlK8yOyFJES5Trx3mINfEdWNRn3eEnEzpkwoHkoOTTRi3Dzr
	ZQ/tKL8JR02EM590pQFnTJr79fzUD04EeMrrCQ7NJuux5lZkiokMzeNaCTpyGiC6
	t/hjMSiVRNk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA85423F;
	Sat,  7 Apr 2012 00:56:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA7F8423D; Sat,  7 Apr 2012
 00:56:19 -0400 (EDT)
In-Reply-To: <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com> (Shawn
 Pearce's message of "Fri, 6 Apr 2012 21:12:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04007D34-806E-11E1-9A11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194934>

Shawn Pearce <spearce@spearce.org> writes:

> On Fri, Apr 6, 2012 at 20:34, Jeff King <peff@peff.net> wrote:
>>  2. If you use a time-based storage helper like
>>     "git-credential-cache", every time you run a git
>>     command which uses the credential, it will also
>>     re-insert the credential after use, freshening the
>>     cache timestamp. So the cache will eventually expire N
>>     time units after the last _use_, not after the time the
>>     user actually typed the password. This is probably not
>>     what most users expect or want (and if they do, we
>>     should do it explicitly by providing an option to
>>     refresh the timestamp on use).
>
> So if I use the cache helper, and its set to expire at the default of
> 15 minutes, I have to type my password in every 15 minutes, even if I
> am doing a Git operation roughly every 8 minutes during a work day?

I think what Peff meant was to set the expiration time of the cache helper
a lot longer (say 20 hours, as opposed to 15 minutes) but once it learns a
credential material from your helper, leave the timer running without
resetting it every time the user uses the credential (your 8 minutes).

So I do not see a fundamental problem in this part.

>> We can solve this by marking a credential that comes from a
>> helper, so we don't bother feeding it back to the helpers.
>> The credential struct already has an "approved" flag so
>> that we try to store it only once, rather than for each
>> successful http request. We can use the same flag to
>> "pre-approve" a credential which comes from a helper, and
>> enver try to store it at all.
>
> This breaks one of my credential helpers.
>
> I have a helper that generates a password by asking a remote system to
> generate a short lived password based on other authentication systems
> that I can't describe. Once I have that password, its good for $X
> time.

Well, $X is something your helper knows but other helpers don't, so...

> The helper just dumps it out to Git, and Git turns around and stores
> it into the cache for me. This means later requests will keep that
> credential in the cache, and avoid making that remote system call
> every time I do a Git network command. I guess I now need to change my
> helper to cache git credential-cache itself and store the password
> into the cache if it wants to use the cache?

... logically the knowledge of cache expiration time belongs to your
helper, but "after the first use, it is OK to keep using it for N hours"
is so common that the two-helper workaround is very tempting.

I am afraid that "do not trigger the cache helper" might be throwing the
baby with bathwater to solve the real problem the patch tries to address,
which is:

Peff>   2. If you use a time-based storage helper like
Peff>      "git-credential-cache", every time you run a git
Peff>      command which uses the credential, it will also
Peff>      re-insert the credential after use, freshening the
Peff>      cache timestamp. So the cache will eventually expire N
Peff>      time units after the last _use_, not after the time the
Peff>      user actually typed the password. This is probably not

Shouldn't the memory cache based helper already have enough clue to tell
when a new entry is first inserted vs when the existing entry it supplied
came back from the network layer after use?  If there is not enough clue
with the current network-layer-to-helper protocol, then wouldn't it be a
better approach to add that, so that the memory cache helper can make more
intelligent management of its timer?

Once that is fixed, I would imagine that you can tell your users to use
two helpers (yours and generic caching one) and configure them so that (1)
the caching one is asked first and then fall back to ask yours, and (2)
the expiration time of the caching one is set close to $X.
