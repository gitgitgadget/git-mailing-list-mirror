From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack v4 trees with a canonical base
Date: Tue, 10 Sep 2013 13:45:44 -0700
Message-ID: <xmqq38pcxv5z.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.03.1309091517380.20709@syhkavp.arg>
	<CACsJy8C+SFBRD1czeeK5VBDYT4xA6K+61HgLRnjB+CYJ-2g+uA@mail.gmail.com>
	<xmqqbo40xwnv.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1309101615080.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 22:46:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJUp1-0006As-1E
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 22:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab3IJUpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 16:45:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3IJUpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 16:45:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 272C3402FF;
	Tue, 10 Sep 2013 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ioAdzg2G71Mu1kVpcPU44Wq3LfU=; b=sTYAIO
	6i7mSwl8pZw5KybQcOGTorwSMFhGO2Qn+v7GHRYpJwuHoda3pwRXthlrR6VKe5G8
	KVOAU8hSEfdgsCgL5aZqfQFcqTz/dls9hw3Qoljw1C+7T3tBIbthMxLmHo3avQCF
	+FD+MbLAF+n5rV5dpXxAGk8lxkBMJTVE6QS8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DD/AEoHNXQhgItFgMPEiVuzN0uHyLdPh
	tEzy0l5BcgOdi7WvMZPYQv3xXY9+yITNsXWpKmgb45+aJLSjXtvZPVFLlam5JBC6
	FYFuXNKA/TD7eNh+1Qr+s/gbsxHKBa76dCoJcFZm8ANWDuSvaQZccNfcVTGCFL03
	AJTpnL4wh7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E76C402FE;
	Tue, 10 Sep 2013 20:45:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB8EC402F1;
	Tue, 10 Sep 2013 20:45:47 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309101615080.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Tue, 10 Sep 2013 16:17:27 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F8E3A32C-1A59-11E3-9CE3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234480>

Nicolas Pitre <nico@fluxnic.net> writes:

very much appreciated to> On Tue, 10 Sep 2013, Junio C Hamano wrote:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>> 
>> > On Tue, Sep 10, 2013 at 2:25 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> >> An eventual optimization to index-pack when completing a pack would be
>> >> to attempt the encoding of appended tree objects into the packv4 format
>> >> using the existing dictionary table in the pack, and fall back to the
>> >> canonical format if that table doesn't have all the necessary elements.
>> >
>> > Yeah, it's on the improvement todo list. The way pack-objects creates
>> > dictionaries right now, the tree dict should contain all elements the
>> > base trees need so fall back is only necessary when trees are have
>> > extra zeros in mode field.
>> 
>> Careful.
>> 
>> There may be trees in the wild that record 100775 or 100777 in the
>> mode field for executable blobs, which also need to be special
>> cased.
>
> All the file mode bits are always preserved.  So this is not really a 
> special case as far as the pack v4 encoding is concerned.

Ahh. OK.  It can theoretically be argued that you could further
squeeze 13 bits out per tree entry because you would need only 5
possible values (100644, 100755 120000, 40000, and 160000, all
octal) for the modes, but we will never know what other modes we
would want to use in the future, so not being over-tight and using
16-bit for this purpose is probably a good trade-off (squeezing 8
bits out per tree entry would make the shape of ident table entry
and tree path entry different and may hurt reusing the code to parse
these tables).
