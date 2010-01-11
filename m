From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove empty directories when checking out a commit with
 fewer submodules
Date: Mon, 11 Jan 2010 01:53:31 -0800
Message-ID: <7vocl1t1b8.fsf@alter.siamese.dyndns.org>
References: <1263178794-3140-1-git-send-email-peter@pcc.me.uk>
 <alpine.DEB.1.00.1001110954410.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Collingbourne <peter@pcc.me.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 10:53:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUGy3-0007Ao-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 10:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab0AKJxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 04:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022Ab0AKJxn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 04:53:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab0AKJxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 04:53:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C99690553;
	Mon, 11 Jan 2010 04:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5H7nE0lO/ZkTEQkAwmOATlqQr+M=; b=Ei9eRv
	rb7gjQQpT7mD4hmjzsqYN96AH0F2io6bss4enWoCUvdx5eQG0j7ChQ+aLCJWqP1X
	32TbgmtE85viUwaI3OrT1BAJV/3e7B67CsPl33Sf9fw7nRZHbzZc408O172ras2H
	U+eapN2+aXjcSy9XN4pJuuBoiG/OLMmnpGM/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PB1PGAw9YUVTDi7aik6Phr73WJWQfeh5
	FmrS/t39fkEzhmU0N2oFcybOeTh9Ym6oJ9jh7EqjVQ1VtsMl4mlkkG9pjtTDwR6h
	IyH+UR3031tdDxGRKe4NzALmrvQWAh2AJp5cSVCiPXmx+IChbtouUwLKI7W0RN1l
	KFOtrETjkZg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC8E090552;
	Mon, 11 Jan 2010 04:53:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FE6C9054E; Mon, 11 Jan
 2010 04:53:33 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001110954410.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 11 Jan 2010 09\:57\:15 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30AFAEE6-FE97-11DE-BEA0-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136627>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> NAK.  We should not even try to _unlink_ submodule subdirectories; it 
> would be _way_ too easy to lose data that way.  Remember, submodules are a 
> totally different beast from regular files.  They can contain valuable, 
> yet uncommitted data, that is not even meant to be committed.
>
> So you say if the submodule directories are empty, it is safe?  Not so.  
> They will never be empty: there is always .git/...

NACK on NAK.

Don't worry, your data will be safe.  The only case rmdir would actually
remove it is (1) you check out superproject that has submodule A, but you
choose not to "submodule init/update" it, because you don't need a
checkout of that part of the tree for your job, and then (2) you switch to
a different version of the superproject that doesn't anymore (or didn't
back then) have that submodule.  In such a use case, you will have only an
empty directory for A in step (1).  The unnecessary empty directory A will
be left behind, even after switching to a version that shouldn't have the
directory there in step (2), if you do not rmdir it.  So the patch is a
strict bugfix (it attempted to unlink, which is a bug; it really meant
"rmdir" and not "rm -rf" which you seem to be worried about).

It is a separate matter to _enhance_ the codepath to actually either (A)
refuse to overwrite (if the version of the superproject you are switching
to in step (2) had a regular file or a directory that is part of the
superproject there, and/or (B) move it away to somewhere safe (recall the
discussion of ".git/modules/$submodule" hierarchy of the superproject?)
automatically when it will disappear.  Such enhancements will help people
who _do_ "submodule init/update" the submodule in step (1) and switch to a
version of the superproject that lacks it in step (2).
