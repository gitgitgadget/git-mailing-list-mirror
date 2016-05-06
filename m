From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 05 May 2016 23:21:44 -0700
Message-ID: <xmqq60ur7ll3.fsf@gitster.mtv.corp.google.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbmW5U+uFCnBhz4r2-ciGsWSwXHU5Va2r-MEca=iacfgQ@mail.gmail.com>
	<xmqqpot06oys.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 08:21:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayZ96-0008He-52
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 08:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164AbcEFGVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 02:21:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751223AbcEFGVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 02:21:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C946810989;
	Fri,  6 May 2016 02:21:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=19MSWQE3PVflrygfIi/9bnIu9Z0=; b=uuvhhC
	8ULiIjUEbClEE68PFtNc4rUPIVmqszo4qtOaOZFO4UhWdwPu0mC/8ggjjH8kJ7qy
	tLCwb7yapJsc72KEEPRkYl/rw9WuvWxjeSr83iM5AJVMY5XOFPrjXQg4fttMhg0F
	pRcPBWV+V1cieR6xOXtsdaXodwedVdxUHp5Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yb8yS+1xbtNDYVRBGJ5KGmSY6aziVde7
	01rM/e3pGeRG8mjWdJTbDaIb5I5sG065IcXQSqaWB9YUcC/+vaSEAXANPj0d2/pd
	dqi+LHwQz51lAQ6iZvR3dk9cUn8EuX0C5OpuBnAOc64n4guE3RVAfm4l8KGNKKMI
	zeWoYgElgUE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0E8510988;
	Fri,  6 May 2016 02:21:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B72610987;
	Fri,  6 May 2016 02:21:46 -0400 (EDT)
In-Reply-To: <xmqqpot06oys.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 May 2016 16:54:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF0B00E6-1352-11E6-AE2D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293745>

Junio C Hamano <gitster@pobox.com> writes:

> When deep/in/ is an unrelated repository, and running either
>
>     git add deep/in/the
>     git add deep/in/the/tree
>
> would add deep/in/the/tree/is-a-leaf.txt to my index, but if I did
>
>     git add deep/in
>
> I'd lose that and suddenly everything there turns into a submodule.

Also, I recall that you floated an idea to declare that

    git add deep/in/the/tree/is-a-leaf.txt

must always behave as if this is done instead:

    git -C deep/in/the/tree/ add is-a-leaf.txt

Even though I am not a huge fan of an operation that crosses module
boundaries, I think that is a sensible semantics of a "cross module
boundary operation" (the actual implementation should not be
iterating over pathspecs and chdir(2)ing around for each and every
one of them, though), if we need "cross module boundary operation"
in order to support end users working on a project with one or more
submodules at the same time.

But treating the bug under discussion as a "feature" will destroy
that future.
