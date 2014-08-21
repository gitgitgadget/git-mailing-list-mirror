From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Thu, 21 Aug 2014 16:40:11 -0700
Message-ID: <xmqqvbplpg2s.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-19-git-send-email-gitster@pobox.com>
	<CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:40:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKby1-0005sV-DF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 01:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584AbaHUXkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 19:40:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57119 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755454AbaHUXkY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 19:40:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 226223415A;
	Thu, 21 Aug 2014 19:40:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XgYR9Ko9xr1xCU8OwLM8If6A3lo=; b=f2Mceg
	qj1lP1/3bshVRJOC6rji9fWQjMSvO7l+x6X2KJT8edGZM3CyL2vt71aZ8RF0Rb95
	/olBB8CzNjGPre2fS6XG9FA0619pEpYuRghk7xkirlb8gxC8PujbHB/bEmGHJZbN
	xNx7cd/CTGv+9ZJGYbOi6p4u9s0uN9xjOudE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgfhhncOOe7LtKVyiGJno797voIKNy+T
	rMDZ6JIQUkVl+10rdnT+pXYJ1K21UpRzPTN5taN9aquKfaFlEM/4tqsjikfQ8Dbu
	iPvLs+QB28VIMbRY0yCmvfT79ZFK774jD8vG/JptdhHe+ASpP2hJK5WEEFLXMvIr
	DMcVKfJuwZo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E77334159;
	Thu, 21 Aug 2014 19:40:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5CC5234157;
	Thu, 21 Aug 2014 19:40:13 -0400 (EDT)
In-Reply-To: <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
	(Shawn Pearce's message of "Thu, 21 Aug 2014 12:28:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7F2EEF94-298C-11E4-82D7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255647>

Shawn Pearce <spearce@spearce.org> writes:

> On Tue, Aug 19, 2014 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> +  push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
>
> Haha. NUL.  I love our wire protocol.
>
>> +                     PKT-LINE("certificate version 0.1" LF)
>> +                     PKT-LINE("pusher" ident LF)
>> +                     PKT-LINE(LF)
>> +                     *PKT-LINE(command LF)
>> +                     *PKT-LINE(GPG signature lines LF)
>
> Should we include the URL as part of this certificate?
>
> Perhaps the pusher means to sign the master branch of experimental
> tree, but not their trunk tree?

Yes, in $gmane/255582 I cover this and also mention that we would
need some "nonce" from the receiving end to make it harder to
replay.

Currently I am leaning toward to add both "pushed-to <URL>" and also
"nonce <nonce>", the latter of which the receiver can ask with
"push-cert=<nonce>" in its initial capability advertisement.

There are a few gotchas I can certainly use help on, especially from
a smart-http expert ;-).

 * "pushed-to <URL>" will identify the site and the repository, so
   you cannot MITM my push to an experimental server and replay it
   against the authoritative server.

   However, the receiving end may not even know what name its users
   call the repository being pushed into.  Obviously gethostname()
   may not be what the pusher called us, and getcwd() may not match
   the repository name without leading "/var/repos/shard3/" path
   components stripped, for example.

   I am not sure if we even have the necessary information at
   send-pack.c::send_pack() level, where it already has an
   established connection to the server (hence it does not need to
   know to whom it is talking to).


 * The receiving end will issue "push-cert=<nonce>" in its initial
   capability advertisement, and this <nonce> will be given on the
   PUSH_CERT_NONCE environment to the pre/post-receive hooks, to
   allow the "nonce <nonce>" header in the signed certificate to be
   checked against it.  You cannot capture my an earlier push to the
   authoritative server and replay it later.

   That would all work well within a single receive-pack process,
   but with "stateless" RPC, it is unclear to me how we should
   arrange the <nonce> the initial instance of receive-pack placed
   on its capability advertisement to be securely passed to the
   instance of receive-pack that actually receives the push
   certificate.
