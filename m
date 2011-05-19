From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] streaming: a new API to read from the object store
Date: Wed, 18 May 2011 18:52:36 -0700
Message-ID: <7vtycra23f.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305505831-31587-7-git-send-email-gitster@pobox.com>
 <20110518080947.GE27482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 03:52:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMsPx-0000Sr-Nm
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 03:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab1ESBwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 21:52:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431Ab1ESBwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 21:52:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F9E157BF;
	Wed, 18 May 2011 21:54:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=orUyxx0ga4j6TAMcvcc541yRAsg=; b=sY3jtQ
	ge/ARH+f21XtDgqXxrDJRnK3yF4CG2cMmeYj7lb/mvn6zCJcjUGbgQgYJpiRz/Dn
	0nUMHg90Ubjh7MPVvVLYTvYSMAEo1TF3BpHx8SAVHo9rd5Ke0hlXUxJbvR/IC/NQ
	kpsB4UXrc/KQ3SWuEr49gsGBpGrpzYh5cNQpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a5AmXYXZdd0m0y2kPHelawzQv4/DH+5D
	Oh0A3U6gwUp6omRF7Nc0T39G+h2GJxXuqrwaC/P/XCUQ1XKWPVpXT3hk/L8GAiiK
	clouV/8bjJPuNHMLmM4q5NyIxF3Vasj7ZyCLcrn58vqGq1Z9l6WJD0NEOGlEAdP+
	N6KNfVFvPWo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1CAE357BE;
	Wed, 18 May 2011 21:54:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B5B157BD; Wed, 18 May 2011
 21:54:45 -0400 (EDT)
In-Reply-To: <20110518080947.GE27482@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 18 May 2011 04:09:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAA7DF50-81BA-11E0-B8E8-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173924>

Jeff King <peff@peff.net> writes:

> I assume the "sz" parameter is meant to be an output parameter with the
> total size of the object. The open_istream_incore function fills it in
> properly. But later,...
> may or may not have "size" meaningful at this point, which seems like a
> bug.

Thanks for spotting.

I would want to revamp the API implementation a bit further.

The "u.*.sz" fields should probably become the first level field in
"struct git_istream" [*1*].

The open_istream_$backend() methods should lose "sz" parameter, as it
should be the same as what would be stored in st->size after the above
change. The public API open_istream() would fill the caller supplied *sz
word with what is stored in st->sz by the backend method.

I do not think the "read" method implementations (other than "incore")
currently make sure that what comes out of the z_stream really has the
size. A check probably needs to be added somewhere in the codepath.

I haven't looked at the revindex issue yet.


[Footnote]

*1* Actually I am a bit torn on this. As I am envisioning that we would
later (much later) reuse this API to implement "streaming filters" by
adding a new struct "filter" as a member of the st->u union, and such a
filter would not have "size" known in advance, I am a bit reluctant to
change it to have sz in the common part of istream. It can be argued that
it may not be a big deal to move "size" to the generic part and have only
certain backends look at it while allowing other backends to ignore it,
just like "z" and "z_state" are unnecessary for "incore" but they are
shared among three backends already.
