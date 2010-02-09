From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9302: Protect against OS X normalization
Date: Mon, 08 Feb 2010 22:53:49 -0800
Message-ID: <7vocjyq4qq.fsf@alter.siamese.dyndns.org>
References: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
 <1265688445-46137-1-git-send-email-brian@gernhardtsoftware.com>
 <20100209060845.GD14736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 07:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nejz8-00008Z-8n
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 07:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab0BIGyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 01:54:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab0BIGyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 01:54:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 422AE97844;
	Tue,  9 Feb 2010 01:53:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9JN7yK2qQVH/wudGtzvnk/bEADI=; b=Bu02Ap
	4uRXYTMNoqXDoNwBIrHcYyFwBJ34CKrYUnuF2QNO2pW9/NUqrMMDnrm5DXnKI1UU
	niEeE58KjG8g+oHuXVyiGLxXIeN2cG5Kv3zzIWISQJyFnJ1tSzy7/TRfpI0nmlbP
	gkpwsKVrIpwwmG6jpOoUQ2/QaBiBqww6d2nHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udxvJABShi7Kfz7xwUcKzev5wKQCjSv+
	qdew1o7Gh6JPu+UgOnr3EcKx0DI1RmA7CsgDmyNDhH2URp64Lj1olB82PjkyHgly
	heAaRsV2QJZtBlsbeuzGQmJTjvMU7gt8Avd+oMqAV7D6//veRziW4jNw9NgQDquF
	BxyFfi/DZ0Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED7A9783F;
	Tue,  9 Feb 2010 01:53:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E1649782E; Tue,  9 Feb
 2010 01:53:51 -0500 (EST)
In-Reply-To: <20100209060845.GD14736@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 9 Feb 2010 01\:08\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E43A850A-1547-11DF-B12B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139374>

Jeff King <peff@peff.net> writes:

> I am not 100% sure this will still trigger the failure that 8424981 was
> meant to fix. From my recollection of the bug, it not only needed an
> unterminated string (which we get by having a directory) but the string
> length and presence of multiple spread-out characters may have been
> relevant.

I think the test was triggering by chance.  We give the directory name as
pfx to write_name_quoted() which in turn tells quote_c_style_counted() to
consume only pfxlen, but the random junk after pfxlen was being looked at
because we didn't decrement maxlen.

The call chain that led to this part looks like this:

 tree.c:read_tree_recursive() ll.127-131
 - allocate newbase[], fill the leading directory path
 - call read_tree_recursive with newbase as base
   tree.c:read_tree_recursive() l.114
   - call callback function
     builtin-ls-tree.c:show_tree() l.114
     - call write_name_quotedpfx() with the given base
       unfixed code simply oversteps the end of newbase[] given from the
       toplevel read_tree_recursive!

I think there is no reliable reproduction recipe for this, as we don't
control what garbage is in the tail of malloc'ed memory; valgrind would
have found it, though.

Let's revert the test part of the patch.
