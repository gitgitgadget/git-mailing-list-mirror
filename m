From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Fri, 02 Mar 2012 09:31:56 -0800
Message-ID: <7v1upagb8z.fsf@alter.siamese.dyndns.org>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org>
 <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <7vwr73h6td.fsf@alter.siamese.dyndns.org>
 <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 18:32:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3WKr-0007Og-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 18:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439Ab2CBRcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 12:32:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756398Ab2CBRb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 12:31:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D93F97536;
	Fri,  2 Mar 2012 12:31:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qrOtNU7t60Kv83rEPy9ReNtWnFw=; b=wha7Tm
	eJfHb0eypmLiIbqzny5fsKJIznQr710YeR9E1q14xCQL7t9TPyah4ez8jfSaBBG5
	niv3xLFU/o7eHHrG37AcATaC5xcZ1QlQIlelgffHczx68ryO9W2/+68ShU1oZ/zw
	ZV/FTM2ksw2S4Q1moaX+J3hrQ0VkKqJqAo3Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=efFYcbGwTqM7RBkVMuvuI7SwvtxxBbo+
	xvon1etSTeYXi2uIvG8hSJhB8y6msfZ2BeMSK+xGvxDAIVLRwF9U09uElXl2RzuD
	6oIAet3hLN/QPBqfIgy93WVGhrNfvjr9FXpkhRk3OaigtL+h3wJSZgJFewr+YvQX
	FyGzgbicnxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0C297535;
	Fri,  2 Mar 2012 12:31:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30BA77533; Fri,  2 Mar 2012
 12:31:58 -0500 (EST)
In-Reply-To: <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 2 Mar 2012 21:05:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CD38FBC-648D-11E1-A38B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192052>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> OK I think I get what you are trying to say.
> ...

The attack can be even more simplified; the other side needs to know about
only one blob.

Suppose you have a corrupt blob B that is not referenced from anything in
your repository. "git fsck" will find the corruption of that single blob,
but that does not make your repository corrupt, as the corrupt object is
irrelevant to your history. The tip of your current healthy history is at
commit T.

Starting from that state, you fetch from the other side, that has commit X
at the tip. In this simplified scenario, X is a direct child of T.

You expect that the other side sends everything contained in X that you do
not have in T.  Now, the only difference X makes relative to T is that it
adds a new file whose contents is B at the toplevel of the tree.  And the
transfer gives you the commit object X itself, and its toplevel tree
object, but it omits the blob B by malice (or mistake).

Your "rev-list --object T..X" that is run after the transfer completes
will not notice that B is corrupt, because it only checks if it exists.

And now you corrupted your repository, by making B a part of the history
you (incorrectly) declare complete.

The whole point of the check after the transfer is to make sure that the
transfer will not make a repository that was healthy into a corrupt one,
so using --objects and not --verify-objects is a wrong "optimization" in
this case.

> Not everything is valid, then. Objects from new packs are, existing
> ones may be guilty. If there is a way to mark new packs trusted, then
> we only need to validate the other objects, which should be the
> minority or even empty unless an attack is mounted.

Yes, but how?  Running "fsck" on all of pre-existing objects every time
you fetch (or accept push) is not an answer.

If your fetch did not explode the incoming pack into pieces, a possibility
is to still use the --verify-object codepath, but pass the identity of the
pack (e.g. struct packed_git) down the callchain so that you can avoid
rehashing the objects that came from that single pack, but that would not
help the case where you ended up calling unpack-objects.

I also suspect that more than trivial amount of computation is needed to
determine if a given object exists only in a single pack, so the end
result may not be that much cheaper than the current --verify-object code.
