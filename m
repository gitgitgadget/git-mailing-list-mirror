From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 3/3] connect: move ssh command line preparation to a separate (public) function
Date: Fri, 29 Apr 2016 09:58:37 -0700
Message-ID: <xmqqa8kc1hdu.fsf@gitster.mtv.corp.google.com>
References: <20160428232936.GA8663@glandium.org>
	<1461890625-23222-1-git-send-email-mh@glandium.org>
	<1461890625-23222-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:58:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awBkg-0006Nv-EN
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 18:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbcD2Q6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 12:58:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751339AbcD2Q6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 12:58:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30D6516FCA;
	Fri, 29 Apr 2016 12:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OppczQPDgbNl6cp+tJKfpuiySlg=; b=mMo7GC
	ZMC3apaluqhZcOjA2NlhbTwIqivXBNqMDVNFBaI/TbxKj2V+KHbspWkaKx1Fyn26
	TMixHRKCnoXDFbzx5ni7VSvOW95Kf9TehnN+oiuuzaeHdISWP4shjc6qPUqFjqou
	NSthwr3EZPmdHTHcoNlsVXBFSG3cQwDQaWNwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DlaL8foq3k9IgxYTuNgXR5tusTzK8iHZ
	pNs0ZiBQ2yuqcQuWkXH424rsLknhchOkXGgzs58TTX0mQTzSO9IeI1v5R6wcJE+r
	g1XrPiQoB2ZzjMDzrJeq3u8xvQEc6mRCoz6bDxms0+wVTbe/HhRzvgBxqKlrcEpo
	tclg1kQHWHM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 285E816FC9;
	Fri, 29 Apr 2016 12:58:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C35416FC7;
	Fri, 29 Apr 2016 12:58:39 -0400 (EDT)
In-Reply-To: <1461890625-23222-3-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Fri, 29 Apr 2016 09:43:45 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F07F43E-0E2B-11E6-AE54-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293024>

Mike Hommey <mh@glandium.org> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

I think moving it out into a separate helper function is a very good
change to make the end result easier to follow.

Turning the helper to extern and adding it to connect.h does not
benefit us (and [PATCH 1/3] doesn't, either).

And in the longer term, I doubt think it (and [PATCH 1/3]) would
benefit you, either.  We do not mean to make what goes into libgit.a
(which connect.o is a part of) be a stable "library interface", so
all sorts of future changes we make would affect your external code,
e.g.

 - some people periodically check for extern symbols that do not
   have to be extern, and this will be marked static again any time
   (or you somehow need to arrange it so that this function is
   marked as special to reduce false positives);

 - we may need to update the external interface to this function,
   changing parameters, or updating its return value.

even if we promise not to make such a change only for the purpose of
deliberately breaking you.  So you have to be prepared and willing
to follow the evolution of in-core code anyway.

So I would suggest restructuring this series to do

 * 2/3 (DIAG consolidation)
 * refactoring in 3/3 but not s/static/extern/

and in optional follow(s)-up, do

 * s/static/extern/ and update to *.h in 3/3

 * 1/3, but I do not think it is necessary for users of
   prepare_ssh_command()

The last patch could be kept in your fork of git.git if you want to
keep linking with libgit.a, but my feeling is that we'd prefer to do
without it at least for now, until we gain in-tree users that live
outside connect.c that want to call the helper.


Thanks.
