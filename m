From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: do not truncate exported marks file
Date: Tue, 17 May 2016 15:22:30 -0700
Message-ID: <xmqq1t50uxy1.fsf@gitster.mtv.corp.google.com>
References: <1463521223-14565-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git-fc@googlegroups.com, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 00:22:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2nNu-00037l-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 00:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbcEQWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 18:22:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751267AbcEQWWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 18:22:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE0FD1DE63;
	Tue, 17 May 2016 18:22:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4igcYyKKDcz6BH4SMfvkrS38TZc=; b=RLPEE2
	ZXlrlK5NDroIZmhTMotYb0kuE8D7wfQQ8Tq8H4U7iCcmzISP3lFdWaf9O5VlftXx
	4Wi47yBR7OUjErXcDbqiieUP1NcQpj1eOA1LUszUv3ZVFGWiIIem6LFgQRk+lJWq
	KhjlHjoC9CqMcO1No3S1eVARCVuPJ03VSe4ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YH1pmLCumFMJe9aLrMJZaNahhqm3IeDT
	zMtJwYHMwJc6hT3K9OwiCrHvQVOH0pSvRvgbBXHva//ZZeGrfrS4ayv7VStPoFUd
	9slXP/eujjdbUqtQzrw93DrmAdTt//rxXwPi66/gfazwMSAWU+WfkcrrG5yYfQ5O
	fe7Gf5+I/II=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6AD41DE62;
	Tue, 17 May 2016 18:22:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 263FA1DE61;
	Tue, 17 May 2016 18:22:32 -0400 (EDT)
In-Reply-To: <1463521223-14565-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 17 May 2016 16:40:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9307270-1C7D-11E6-BA8C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294918>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Certain lines of the marks file might be corrupted (or the objects
> missing due to a garbage collection), but that's no reason to truncate
> the file and essentially destroy the rest of it.

Hmm, so the issue is:

 - we use die_nicely() that calls dump_marks() after writing a crash
   report as our die_routine().

 - when dump_marks() is called, and export_marks_file names an
   existing file, it tries to write marks in it.  If we let it go
   through, we would end up writing a new marks file based on an
   incomplete set of marks we have only half-read in the earlier
   step, which is bad, as the resulting one is incomplete, and the
   original one that this replaced may have been a good one.

Is that what this change addresses?

I am just wondering if a solution to preserve both files is more
desirable.

This change looks a bit over-eager to discard the dump die_nicely()
is trying to create in one scenario, and a bit less careful at the
same time in another scenario.

 - Even if we are reading from somewhere, export_marks_file can
   point at a completely new file that is different from
   import_marks file, in which case, we are not really losing any
   information by freshly creating a new marks file, no?

 - Even if we did not read from any existing marks file, if we are
   given export_marks_file that names an existing file, wouldn't we
   want to avoid corrupting it with a dump from this aborted run?

In other words, I understand the intent of "import-marks-file-done",
but I am not sure if that is so special a case.

If the patch were to tell dump_marks() if the caller is die_nicely()
or not, and stop it from overwriting an existing file, whether we
read from any import-marks file, I would agree with the change a lot
more strongly.  An obvious extension of that line of thought would
be to export to an alternative marks file, perhaps to
strbuf_addf("%s.crash", exports_marks_file), if exports_marks_file
already exists if we are called while dying.
