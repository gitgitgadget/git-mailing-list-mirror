From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-count-objects: Fix a disk-space under-estimate on
 Cygwin
Date: Tue, 24 Nov 2009 14:08:52 -0800
Message-ID: <7vskc3bmob.fsf@alter.siamese.dyndns.org>
References: <4B059280.40902@ramsay1.demon.co.uk>
 <7vd43d8yva.fsf@alter.siamese.dyndns.org>
 <7vlji17i02.fsf@alter.siamese.dyndns.org>
 <4B072D98.6020101@ramsay1.demon.co.uk>
 <7veinrnym4.fsf@alter.siamese.dyndns.org>
 <4B0C3D0D.60309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND3ZL-0006r7-KG
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 23:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084AbZKXWIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 17:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758045AbZKXWIz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 17:08:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757896AbZKXWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 17:08:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7381BA1E86;
	Tue, 24 Nov 2009 17:09:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W/PSeCuHAyuMEfDE0AK38+oJTMs=; b=PKPwCK
	MQZwkd7EE7QpnUSLdnIalVd62lihJjB1arKmFwQiq5rYKRJx7DkKy1kO3wD6qWuk
	ctmtXtQcHRL12660acfgirbhmnqtXphCZI/qFti+UwcH47tzYZ/dqYDAPqFkRuim
	C+OsfnNr6Y186sY5zTgXyy7psTN4JqYWMmyrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lyy7Cy6S4lCsPOqYU8r3I2+/WOgFjPXp
	1Bk3QX5kGPmUedHePjZ/PCr86BxDXGucTZK9FkphNbO2r5tdHgt3jyA+hdbhNN/n
	OgczXAJClnyX+AC5nk98OJrrk8Sy56bnk0XN7s49A58FNd3fx2dZjyNc503fofuf
	Vzqbw730LQk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51273A1E82;
	Tue, 24 Nov 2009 17:08:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0EB6A1E6D; Tue, 24 Nov 2009
 17:08:53 -0500 (EST)
In-Reply-To: <4B0C3D0D.60309@ramsay1.demon.co.uk> (Ramsay Jones's message of
 "Tue\, 24 Nov 2009 20\:07\:41 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6B7674A-D945-11DE-AFA7-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133595>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Err... no :-D
>
> Note that my suggested addition to your patch is in the core.filemode == false
> code path, and so does not affect the "disk-space under-estimate" problem at all.
>
> [To be clear: the "disk-space under-estimate" problem only happens when
> core.filemode == true and the regular cygwin lstat()/stat() functions are used.
> When core.filemode == false, the code in compat/cygwin.c (namely cygwin_lstat()
> and cygwin_stat()) will (most likely) be called instead. These functions use
> WIN32 api calls to implement equivalent, but presumably faster, versions of the
> stat functions]
>
>> You are forcing st_blksize to 512 but still return the same old st_blocks;
>> I do not understand what that would achieve.
>
> Well, as I said, I haven't tested your patch, or my suggested addition, so I could
> well be wrong... but what I aimed to achieve was to:
>
>     - avoid "undefined behaviour" in on_disk_bytes(), since the value in
>       st_blksize would otherwise be undefined (ie whatever happened to be
>       on the stack-frame of the count_objects() function).
>     - initialize the st_blksize field with a value consistent with the
>       st_blocks field, which is derived from the st_size field, as the
>       number of 512-byte blocks. (see the context line just before the
>       + line in the above diff, along with the size_to_blocks macro)
>     - return the same answer from this code as before.

Ah, sorry, so then I misread your comment.  size_to_blocks() in
compat/cygwin.c counts blocks in 512 (I just checked) and you are applying
the reverse.

But you are right.  If the emulation used on cygwin is _not_ doing the
"blocks * blksize is close to size" thing that is not POSIX but you saw in
your experiment on NTFS, and if we need your follow-up patch to make it do
so, there is no point in using my patch.

> Note that the answer returned from this core.filemode == false code path
> is different to the core.filemode == true code path. Which is why I *slightly*
> prefer my original patch.

Thanks for a clarification.  I've already queued both to 'next', but I
will revert mine and make your patch graduate to 'master'.
