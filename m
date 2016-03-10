From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: --ext-diff ignored with --cc in git log
Date: Thu, 10 Mar 2016 14:33:55 -0800
Message-ID: <xmqqlh5qc698.fsf@gitster.mtv.corp.google.com>
References: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:34:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae99f-0005Q1-LX
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbcCJWeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 17:34:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752288AbcCJWd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 17:33:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD5114BA2F;
	Thu, 10 Mar 2016 17:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=htsBeQt+a+qcUAIlRZbVp1MPZ1E=; b=N0t0fL
	D2npW8sNC2Dj3ViEhvM/rBfkwlTqm74ctx6OEcEeMcXO8FE1knInEATL5x0PFuKR
	8legSFHm3T4PKqdGhbHTFp6EDr40DZySP9fVRy3U/nwrgLwpYDbztmEFJb2ScreM
	5vg4hfkebATBOTDQATov0WzQRq2Nc2yuPuxs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g7uD9D0nwwyT/P/c2THJ+IditzmPM5Gb
	YfUTKVSLxLpm4rHoRuECtXVujXFU5UKoo6B0+ALeP9wgDTZO+zTZ6dwE4gQMdMxS
	VVC9v9A3hVEAb4Hfmf9M647nccd9Agu2s7oWe3FZ6VQY3ENCsfapd1cVvOkjYaG3
	cFbtSattvlo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C55B84BA2E;
	Thu, 10 Mar 2016 17:33:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 467C24BA2D;
	Thu, 10 Mar 2016 17:33:57 -0500 (EST)
In-Reply-To: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com> (Vadim Zeitlin's
	message of "Wed, 9 Mar 2016 18:43:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D781F52-E710-11E5-A83C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288653>

Vadim Zeitlin <vz-git@zeitlins.org> writes:

> I.e. the
> command "git log --ext-diff -p --cc" still outputs the real diff even for
> the generated files, as if "--ext-diff" were not given. ...
> Is the current behaviour intentional? I see it with all the git versions I
> tried (1.7.10, 2.1.0, 2.7.0 and v2.8.0-rc1), but I don't really see why
> would it need to work like this, so I hope it's an oversight and could be
> corrected.

I think this is "intentional" in the sense that "--cc" feature is
fundamentally and conceptually incompatible with "--ext-diff".

 - The "external diff" feature is to allow third-party tools to
   produce output that is vastly different from the usual "diff"
   output, e.g. unlike the usual "diff", the output may not even be
   line-oriented, and certainly would not have to follow the
   convention of denoting the contents on old and new lines with "-"
   and "+" prefixes.

 - The "--cc" feature is to show multiple "diff" outputs in the
   usual format with post-processing to coalesce them into a more
   concise form, and fundamentally depends on (1) the output being
   line-oriented and (2) the contents of old and new lines denoted
   by "-"/"+" prefixes to be able to do so.

I haven't tried it myself, but if the contents you are using
ext-diff on can be compared in a format that is easy-to-read for
humans by passing them first to "textconv" filter and then running
the normal "diff" on, that may be a viable approach to do what you
are trying to do, as "textconv" feature is meant to still produce
the output that still follows the usual "diff" convention.  Its
output should be usable by any tool (e.g. diffstat) meant to
post-process patch output, and would be a better match for the
"--cc" mechanism.
