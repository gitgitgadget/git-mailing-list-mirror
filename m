From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH 5/8] Support taking over transports
Date: Wed, 09 Dec 2009 13:08:44 -0800
Message-ID: <7vein3onxf.fsf@alter.siamese.dyndns.org>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-6-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vljhd597h.fsf@alter.siamese.dyndns.org> <20091209151718.GE15673@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 09 22:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NITmO-0001ip-9T
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 22:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002AbZLIVIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 16:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757986AbZLIVIs
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 16:08:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757793AbZLIVIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 16:08:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1CFEDA5F48;
	Wed,  9 Dec 2009 16:08:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=D0OYGfvyZwEmrRpqEUsIaY6mSeU=; b=dhrGcc5bLhmFlIoLaJt6Qde
	LGC/iT7rPD7HCskAqvoLAIL7hTH7f/jhJH6SiFXtHiZX8VwngDyoDn7B6sqzcczl
	FjX2vbhrdeD/pQkqtBF5pEl0nS2GOi2y80Ilo6vb8Suyznpgx4cJuu/4OyPHGZA3
	mApt6RncIPCvr9LggDYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=P4lDrqRL3Lzlc3QXCXSoBsYqsi4GpzxLCVliSu7UEpbX5yXZU
	vTPH/jp3V6/fAjMH27URSKNH1coQHO90RtoIGdMLNGdYDoVuGTpSm+LVM6HwqDpK
	UNczzI1kakr71N9wsIyjZ2ZUmo9+5hJ/ydmIqmNp2tKYrgsBqrxll8ukvM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0CEDA5F46;
	Wed,  9 Dec 2009 16:08:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 604EFA5F44; Wed,  9 Dec 2009
 16:08:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0CC30D24-E507-11DE-A521-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134998>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

>> Who guarantees that reading from the (FILE *)data->out by strbuf_getline()
>> that eventually calls into fgetc() does not cause more data be read in the
>> buffer assiciated with the (FILE *) than we will consume?  The other FILE*
>> you will make out of helper->out won't be able to read what data->out has
>> already slurped in to its stdio buffer.
>
> Causality impiles this can happen only if buffered version gets its buffer
> filled after sending connect command. And looking at stdio operations that
> can occur after sending the command:
>
> - fprintfs on stderr (debug mode only).
> - fgetc()s on unbuffered version.

I was worried about the "capabilities" loop in get_helper() if it reads
too much from data->out (causing helper->out to lose the beginning of what
it should read), but as you said, by "Causality" it cannot happen. The
protocol during that phase works with the other end in lock-step, and the
other end wouldn't have written to the pipe what we shouldn't read in that
loop (e.g. remote-curl.c responds with "capabilities" with lines and ends
with fflush(), and after that it waits for us to talk to it --- it would
never start talking by itself without first being asked to talk).

Is data->out only used inside get_helper() to read the capabilities
response?  I was confused by it being keft open until disconnect time.
