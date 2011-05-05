From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git failure on HP-UX
Date: Thu, 05 May 2011 12:06:33 -0700
Message-ID: <7vfwot6k7a.fsf@alter.siamese.dyndns.org>
References: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF12C@GVW1362EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
To: "Kibler\, Bill" <bill.kibler@hp.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3sv-0007YG-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab1EETGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:06:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab1EETGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:06:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FA1245E5;
	Thu,  5 May 2011 15:08:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WSGvYZJ2m21ktyZWSKBYIDNCU74=; b=CzMSGk
	UyM8T2wddXNQvkVtoCguUDiMC3oYBfAEfs/zoJanqJgZFLCM4QOw/1gfESpFyHbw
	gTEIVLYhJckQ+b5/Ne5hfrl/vYk3YSIl9K1DfwlozycLEwT2YfgW9xDNKoYZvpT3
	F94hbyYZtijlaGG4JLP6rIPEriZoFMNNN/Tcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XtWN9RjbdTM2a8GITwa6IEj4IBb2cOGx
	Lrlxj6MQHlA8kDocVuxPAEvZm/YqvoriQQRR4LmqrI3gnDpHHqPfTw7cD73CQM+/
	QYkAQd9Mchh2CXZdJM6K/B2CEbB8fpRev+l5x/hzLgIz0RtRG5W/B8ssgWY33Tnj
	t8bfXygb26Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0C1E45E4;
	Thu,  5 May 2011 15:08:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3186945E3; Thu,  5 May 2011
 15:08:38 -0400 (EDT)
In-Reply-To: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF12C@GVW1362EXC.americas.hpqcorp.net>
 (Bill Kibler's message of "Thu, 5 May 2011 18:04:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1875D93A-774B-11E0-849C-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172882>

"Kibler, Bill" <bill.kibler@hp.com> writes:

> In looking at the code, "sideband.h" defines "LARGE_PACKET_MAX 65520"
> and is related to the passed flag "side-band-64k" as discussed in git
> document pack-protocol.txt. The current default usage seems to be 64K
> transfers, yet if we check the "include/limits.h" of HP-UX we see a
> "PIPE_BUF" set to 8192. Along with the tusc indication of 8K pipe size,
> I suspect that HP-UX is coring due to git trying to use a 64K pipe when
> 8K is max.
>
> I solved the probem for now, by changing the file sideband.h to use
> "LARGE_PACKET_MAX 8208".

This does not make any sense.  We may make write(2) and read(2) system
calls with 64k (or maybe bit more) chunk, but that does not mean the
implementation of these system calls must take that as a whole.  Your
write(2) is allowed to write only whatever fits your pipe buffer, and tell
the caller "I wrote only 8192 bytes", and the code is supposed to loop,
advancing the write pointer by 8k and calling write(2) again, until you
write everything to whoever is reading the other end of the pipe.  The
same thing for the read(2).

If you can find a place where we make write(2)/read(2) and blindly assumes
that a non-negative return means everything was written/read successfully,
then you have found a bug.

If the symptom _were_ a deadlock where the writer of one pipe expected to
be able to send 64k to the other end of the pipe and then hear back from
the other side with a separate read, I would understand that could happen
(actually we know a local pipe transfer without ssh has that kind of
potential deadlock but I think the size we assume that can fit in the pipe
buffer is far smaller than 8k).  But I do not understand where a SIGBUS
can come from.
