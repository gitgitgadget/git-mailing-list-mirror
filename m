From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/32] Split index mode for very large indexes
Date: Fri, 09 May 2014 10:55:22 -0700
Message-ID: <xmqqha4yzvjp.fsf@gitster.dls.corp.google.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
	<CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
	<20140509102744.GA4939@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 19:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wip1F-0003pA-Ad
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986AbaEIRz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:55:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55773 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbaEIRz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:55:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3366815C60;
	Fri,  9 May 2014 13:55:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ac6vvMa5gKdlZ02zzZs9ygLSdz8=; b=Fa+OKQ
	h/beGcfjgisqhLqdBHfqt098nv+Hay4rqqXNOUaEX1cNjl7zzb808HaydNYAzSpn
	gkyf1r3ptDxdziTzt0d01F8+5L7th0/G6q6WIF4SAch9oosAllC+Al6SpsrDPLc6
	G1DsDDpG/lrLGCfZv2GCE+f7+Fxr2ERsB92uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o0ESz8Fl7V+xc8xAW8mlt+5FnoEywavr
	PuY4i4UsiTt4xw9vtrPvhBaX98YAo9ImxrTxNjrMOIQezus/vrGDfL1nOBm5pHuI
	mfpzMKM2IUEtOt9LTkOT6mU8rmsaWuHEZDbDnt05OqbsI/ON57iWcHKa/A71U49T
	i12J6Lc5gZ4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27DE015C5E;
	Fri,  9 May 2014 13:55:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E98315C53;
	Fri,  9 May 2014 13:55:24 -0400 (EDT)
In-Reply-To: <20140509102744.GA4939@lanh> (Duy Nguyen's message of "Fri, 9 May
	2014 17:27:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18BDF880-D7A3-11E3-8BA1-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248600>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Apr 28, 2014 at 02:18:44PM -0700, Shawn Pearce wrote:
>> > The read penalty is not addressed here, so I still pay 14MB hashing
>> > cost. But that's an easy problem. We could cache the validated index
>> > in a daemon. Whenever git needs to load an index, it pokes the daemon.
>> > The daemon verifies that the on-disk index still has the same
>> > signature, then sends the in-mem index to git. When git updates the
>> > index, it pokes the daemon again to update in-mem index. Next time git
>> > reads the index, it does not have to pay I/O cost any more (actually
>> > it does but the cost is hidden away when you do not have to read it
>> > yet).
>> 
>> If we are going this far, maybe it is worthwhile building a mmap()
>> region the daemon exports to the git client that holds the "in memory"
>> format of the index. Clients would mmap this PROT_READ, MAP_PRIVATE
>> and can then quickly access the base file information without doing
>> further validation, or copying the large(ish) data over a pipe.
>
> The below patch implements such a daemon to cache the index. It takes
> 91ms and 377ms to load a 25MB index with and without the daemon. I use
> share memory instead of pipe, but the format is still "on disk" not
> "in memory" for simplicity. I think we're good even without in memory
> format.

Interesting ;-).
