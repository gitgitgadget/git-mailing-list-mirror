From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] trace: refactor to support multiple env variables
Date: Thu, 24 Feb 2011 10:25:04 -0800
Message-ID: <7vsjvd1e9r.fsf@alter.siamese.dyndns.org>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142841.GD15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 19:25:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsfsU-000855-Ht
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 19:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab1BXSZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 13:25:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab1BXSZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 13:25:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A786A42C3;
	Thu, 24 Feb 2011 13:26:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZT1bkQTtGTs2K5+IjOx6HzJu25w=; b=Z8/Qbs/qzhSgp0K995ifUPG
	/t1ldmC7Yd9y7R8HlKk6+H0zHqZsoUzEAZ6wEB9Ru5TosBvPqm5kmna0/Qp/T/g0
	1l/VyYfZlLJxjPtD3fAH1hys0dwIixqTbvGhzQmq+06RogfcoBNmHb/eUz1jPec4
	NQsVYzQbDppQJd85CY58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=b7tmqq7lx3Id6yw/I9vtFAGmlgjP7SqaxZEjcpoPn3DVI2DEE
	++e0lQ0Fxw74rTncESiCwYbt8NxqhyDxUMr/tw2vhdqoa4EWDtzOwA2yLs/2gvTs
	WhxSxtZsKoBLlpqTZt2RwJryPoqCOO2pjmGoPcC+FS8jThIDATS1U2nDKo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6753B42C2;
	Thu, 24 Feb 2011 13:26:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D864E42BE; Thu, 24 Feb 2011
 13:26:20 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9724166E-4043-11E0-8FBD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167845>

Jeff King <peff@peff.net> writes:

> Right now you turn all tracing off and on with GIT_TRACE. To
> support new types of tracing without forcing the user to see
> all of them, we will soon support turning each tracing area
> on with GIT_TRACE_*.
>
> This patch lays the groundwork by providing an interface
> which does not assume GIT_TRACE. However, we still maintain
> the trace_printf interface so that existing callers do not
> need to be refactored.

One thing I found missing in the patch description is a statement of the
overall design and expected usage.  It appears to me that the design is
built around the idea to give each named/namable area to be traceable its
own trace output file descriptor, so that different kinds of trace events
are sent to different files.

I however expect that majority of "trace only areas A and B" users would
want to see logs of events from these two areas in the same stream to see
them in the order they happened.  Perhaps you are envisioning that these
users would use redirection from the command line to send GIT_TRACE_A and
GIT_TRACE_B to the same place; that probably needs to be spelled out more
explicitly somewhere in the documentation, as that would be a more common
thing to do.

I think your [7/8] is kind of strange when viewed in that light.  Imagine
what would happen if you gave separate GIT_TRACE_* to each packet class,
instead of giving them a single umbrella variable GIT_TRACE_PACKET.  If
the user wants to see them all in a single stream, the same redirection
you would use to unify GIT_TRACE_A and GIT_TRACE_B can be used.

Instead, you have packet class prefix in the output so that later the
different kinds of packet events can be sifted out from the unified
output, even though they are forced to go to the same output stream.  In a
sense, you have two-tier classification system for traceable events (the
top layer that can be separated or merged at the file descriptor level,
and the bottom layer that can only be separated by looking at the prefix).

Is this necessarily a good thing (not a rhetorical question)?

To put it another and opposite way, I wonder if it would be better to
instead use a single output stream named by GIT_TRACE and add trace event
class prefix to the output for classes like SETUP and PACKET (again, not a
rhetorical question).

Also instead of wasting environment variable names, it might be a more
compact design from the user's point of view if we took a list of trace
event classes in a single environment variable, e.g.

	GIT_TRACE_CLASS=setup,packet \
        GIT_TRACE=/tmp/tr \
        git push

I dunno.
