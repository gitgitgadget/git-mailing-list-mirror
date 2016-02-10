From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 12:57:13 -0800
Message-ID: <xmqqh9hgz3km.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
	<CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:57:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTbpE-0003Mx-3g
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 21:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbcBJU5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 15:57:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123AbcBJU5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 15:57:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3524344650;
	Wed, 10 Feb 2016 15:57:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d7uUAlMru57eARVEW0BBVcd4bpQ=; b=R/Escy
	0MFAFT81/AR5kyoSwLxaCQBMnyLeRAyFN/ytI5Yeu64Lci29HvIkcNkNHxhQolDN
	/FblxtXvt1dLQNVs8LgaMt69D3g9TnlyZx/OCWr09n3W5zZTnyXRa8vpj7g9kS1f
	MxfxJ7Hiy7t8bhE3k04U54AgLaxJIigyP/qbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pJKSuylH97lpjai7h9cWFvvCBrnysTzs
	ff/X/biAM2OqkWAV4WPwx3DUH7/Gx9Yh33jUM3gS2rKHVa3lzc83tJVf7sL7tV7j
	oqOG5L1NIvKsy/BGxPMLxU4b4CqxBiuRrvsiLVaeikPnaXtJNR7eDjNQ0/hh9gBj
	OELzWX9ni2Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C9C24464F;
	Wed, 10 Feb 2016 15:57:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A66744464A;
	Wed, 10 Feb 2016 15:57:14 -0500 (EST)
In-Reply-To: <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 10 Feb 2016 12:23:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DCDDBEF0-D038-11E5-AB3A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285925>

Stefan Beller <sbeller@google.com> writes:

>> 6. Once stored and indexed with .idx, clients run `git fsck
>> --lost-found` to discover the roots of the pack it downloaded. These
>> are saved as temporary references.
>
> jrn:
>> I suspect we can do even faster by making index-pack do the work

I somehow doubt it.  Both index-pack and lost-found need to trace
"object A depends on object B", but the similarity ends there.
index-pack traces the delta dependency, which does not have any
relation with the reachability, which is what lost-found needs to
compute.

>> 7. Client runs incremental fetch, and then deletes the temporary
>> references from 6.
>>
>>
>> An advantage to this process is its much more flexible for the server.
>> There is no additional pack-*.info file required. GC can organize
>> packs anyway it wants, etc.

I am not quite sure if that is an advantage, though.  The second
message proposes that the lost-found computation to be done by the
client using *.pack, but any client, given the same *.pack, will
compute the same result, so if the result is computed on the server
side just once when the *.pack is prepared and downloaded to the
client, it would give us a better overall resource utilization.  And
in essence, that was what the *.info file in the first message was.

The original proposal explicitly specified that the initial bulk
transfer pack must cover all heads and no tags.  For the purpose of
offloading the clone traffic and making it resumable, there is no
need for such a restriction, and I do like the fact that the second
one loosened the requirement.
