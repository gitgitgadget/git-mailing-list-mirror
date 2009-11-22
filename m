From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'error: unable to set permission to './objects/...'
Date: Sun, 22 Nov 2009 15:27:45 -0800
Message-ID: <7vd43acf7y.fsf@alter.siamese.dyndns.org>
References: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafal Rusin <rafal.rusin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 00:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCLqX-0003fX-K4
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 00:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbZKVX1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 18:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbZKVX1q
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 18:27:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZKVX1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 18:27:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D9C825F1;
	Sun, 22 Nov 2009 18:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0dhpqkXg3rac2IZRcMhsLXJ+GyU=; b=aTvEnb
	mDcODBAQ1wcabNR3BwWVsuPBNSplJuP/CUpfrm5W/otgLbbtdCLBdXzfrpNrPc27
	XimLiI9XdVmOcPMgX5maTOigT+TRBpbnsMsDblelL0WC2D70Ye7D5eToSzuZqOL/
	Tjv4jnzmtUbGGl5iT0XNscXISkDxrl/LK7wA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kV8f6wYsEGBW3TOzp6xWUZJEE5O489jE
	UgyBsRMqOeJwbUHp9MnbqrMwTe8PbNuN4znHAbwT1qoUR95ia4DiNoRBgdndvScm
	58w3smvF8+Ofhj8v2bF5r1/G4XCaOImZpaIh9yRpxq6N2YnnqFtgKk3xmIzYWV52
	VVsVxbR100g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CA2825F0;
	Sun, 22 Nov 2009 18:27:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AFFA825EF; Sun, 22 Nov
 2009 18:27:47 -0500 (EST)
In-Reply-To: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
 (Rafal Rusin's message of "Sun\, 22 Nov 2009 21\:02\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A615D82C-D7BE-11DE-9B24-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133463>

Rafal Rusin <rafal.rusin@gmail.com> writes:

> I'm hosting git repository on filesystem with 'chmod <some-file>'
> causing permission denied error (it's smbfs mounted directory),
> When I was doing push to such repo using file:// protocol, I got
> following error:
> error: unable to set permission to './objects/...'
>
> I did a small fix to sha1_file.c (patch in attachment) and git now
> warns when unable to chmod, and continues push. This resolved problem.
> What do you think about applying it?

Suppose the user wanted to use this as a shared public repository and
configured core.sharedrepository.  If we try to set shared-perm and notice
a failure but keep going, what happens to the resulting repository?  

For example, the umask of the user who is pushing objects, causing this
codepath to run, might be too tight to be usable for the purpose of making
the file readable for other members of the group.  And the chmod() fails
in this codepath.  Then what?  Wouldn't it make the resulting repository
unusable?

I think a _fix_ needs to first know why chmod is failing for you and
either

 (1) make it not to fail; or

 (2) Perhaps your filesystem is lying and the result of chmod happens to
     be Ok (iow, the resulting file may be readable/writable by people who
     are supposed to be able to, accoring to the core.sharedrepository
     settings), in which case make the code notice the situation and keep
     going _only when_ it is safe to do so.

I do not think your change to _unconditionally_ keep going is a fix.
