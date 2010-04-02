From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] diff: cache textconv output
Date: Fri, 02 Apr 2010 00:23:06 -0700
Message-ID: <7vpr2il3mt.fsf@alter.siamese.dyndns.org>
References: <20100402000159.GA15101@coredump.intra.peff.net>
 <20100402001215.GF16462@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 02 09:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxbDv-0006UW-Bm
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 09:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307Ab0DBHXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 03:23:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759301Ab0DBHXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 03:23:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10D14A7BDD;
	Fri,  2 Apr 2010 03:23:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tD4cGFm6iZDN5el18mcet/KRr1E=; b=VxzEUy
	GySqisvD1ZheWCGqCbPpm2RjygwHXHKhgc6ALYvIG/V8QsJCazjgpjd18vs98EDc
	JjoiQuEgKfsUqUyUo7kehQ8+2WdUs8mtwnt25J4LmyfMGtSLtLp+gsrZDaICc1kF
	rWjS2K5HqqDVKywICheAoVev5GyoWV3tm6GOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TrO2HiTeGa4kTjVkfw1hsH31duhcd9YZ
	yRLqCsN3djN3TGLnnnqJEqmr1hOwbXi0ET8/nZVBo1g5PPds8+5zKfsGt3LXb9Jr
	wo4nGAvLaUUnRbt9zCy6zijNbYjnawZVGEqC5lCoM5pnVg5b54CuN+oOXj5f6DpP
	lwhI4qXFDBE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF8F7A7BDC;
	Fri,  2 Apr 2010 03:23:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56AC1A7BDB; Fri,  2 Apr
 2010 03:23:08 -0400 (EDT)
In-Reply-To: <20100402001215.GF16462@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 1 Apr 2010 20\:12\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9806E98A-3E28-11DF-B91A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143784>

Jeff King <peff@peff.net> writes:

> Running a textconv filter can take a long time. It's
> particularly bad for a large file which needs to be spooled
> to disk, but even for small files, the fork+exec overhead
> can add up for something like "git log -p".

Another reason that "log -p" gets benefit from caching is that you would
typically end up running textconv twice on the same blob, once when you
compare $commit:$path with $commit~1:$path, and again when you compare
$commit~$n-1:$path with $commit~$n:$path (assuming that the $path didn't
change between $commit~$n-1 and $commit~1).

It _might_ give you even better performance characteristics if you noice
that you are walking history running many textconv, and cache the textconv
result from the "older" (i.e. "one" side) tree in-core, until it is used
in a "newer" (i.e. "two" side) tree, at which time you would evict it.
