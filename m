From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Kernel bug caused by 'git apply' misapplying a patch with ambiguous chunk
Date: Thu, 02 Apr 2015 08:59:59 -0700
Message-ID: <xmqqy4majzb4.fsf@gitster.dls.corp.google.com>
References: <551D5F58.4010201@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:00:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdhXO-0000hR-CS
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 18:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbbDBQAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 12:00:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753148AbbDBQAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 12:00:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA0BA42500;
	Thu,  2 Apr 2015 12:00:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N1wqcBiXj4+UZeLa84b2micRNnc=; b=i+Gftd
	0JZkl5mu5IStSxnDqwYs8y63EMEGH6BV485XZA6MCWbUSgsuFzrOTuARTT7nO9ih
	ILLSjZ1McBMcFXbjoF9x+D6X8Hr6UjvouDA/T4FYM28qf4zrg5mH4x9LfaJc7qlM
	Pz39k5beitkvGkpco1U63rwXOgvTcJhIHidSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FeqMIerHf4Z7oBsgaqrN6FRmlf9Y5dmY
	zBO5q+Ia0q7Iq0ahJYVkcowOO4y/3ZmhjwXxQ6DqodWeg6Zdz0QEjpx/zIQeivFv
	UtjnGh/6Sya53L775HPnt7wtgI5crPDcYuFEzKyD39ZukrTzt+00reA75ZDuH+uG
	OEXbFpsJPr8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 72A87424FE;
	Thu,  2 Apr 2015 12:00:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99AE9424F6;
	Thu,  2 Apr 2015 12:00:01 -0400 (EDT)
In-Reply-To: <551D5F58.4010201@kapsi.fi> (Mikko Perttunen's message of "Thu,
	02 Apr 2015 18:25:12 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51D52E3A-D951-11E4-A945-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266644>

Mikko Perttunen <mikko.perttunen@kapsi.fi> writes:

> Of course this is probably rather hard to fix on the applying end; but
> perhaps format-patch could check for ambiguous chunks and either warn
> the user or increase the context size automatically, or apply could
> warn about the chunk being ambiguous?

Interesting thought.  Let me rephrase to make sure I got your
thought process correctly.

Imagine you started from an original that had two cut-and-pasted
codeblocks A and B in the same file and updated one of them, say A,
and then sent out the patch that turns A into A1.

Meanwhile, somebody started from the same original and updated the
same codeblock A in the upstream already to A2. Your patch applies
cleanly to codeblock B and turns it to A1, which is a mispatch.  And
you cannot even detect the problem while applying.

But if you are starting from the original with idential A and B,
format-patch can see that the resulting patch to turn A to A1 can be
misunderstood to be a patch to change B to A1 instead. So in that
case, you _could_ detect.

But imagine if you started from an original that had A and C, that
are clearly different.  Your change turns A into A1.  In the
meantime, the upstream started from the same original, and changed C
into B that looks identical to A.

The same thing would happen to your patch when you try to apply it.
"git apply" could try to diagnose this situation and warn.  But you
cannot check when your format-patch produces a patch that turns <A,C>
into <A1,C>, as there is no ambiguity in the original.

So,

 - format-patch could try to help, but it won't be a complete
   solution.

 - apply could try to help, but it won't be a complete solution.

I am not sure if having "both" would make it complete, but I doubt
it.
