From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git add' regression in git-1.7?
Date: Tue, 09 Mar 2010 23:06:15 -0800
Message-ID: <7veijsmza0.fsf@alter.siamese.dyndns.org>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
 <20100309223729.GA25265@sigill.intra.peff.net>
 <20100309230931.GC25265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 10 08:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpG02-0005jh-4w
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 08:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab0CJHGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 02:06:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0CJHG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 02:06:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86610A03B3;
	Wed, 10 Mar 2010 02:06:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MEYMvq1AzAr8VvkBUGC+OxuxVzI=; b=HerGXw
	nwvgvSUz9mxvdbQbDOY/MScuHhApHFhHwW5JGfZduC4wkwvK7AMEAKwQ9TtFMqZ1
	kM6rJpnLh5WlCPqT0bFvx1yUXiP4EFZ6DJ+iHJVnLKr6RMWKbLjSdWDsYHuj48W6
	HR8dYAHTA+8igiCU6JMdIkDGr9uhtzRVwog9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dpbXT7hZiwHjNpR6pBEyy6ZRHOZbM83E
	Ru1OnVnzk2MDbAaj7UuR9QpgBpLp0OQu69ayYNkGSDuemX4jt97yvibIQEhVxKeS
	HsOh1LnCesMg6x+9ipBZEV0UA+slHfneSMym6eAnNkKEjjz5E3Hrut7pIp84FwXi
	r0j2mxeMEMI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EF13A03B2;
	Wed, 10 Mar 2010 02:06:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E376A03AE; Wed, 10 Mar
 2010 02:06:17 -0500 (EST)
In-Reply-To: <20100309230931.GC25265@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 9 Mar 2010 18\:09\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F92B01E-2C13-11DF-8CD9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, if we accept that the message simply mentions the excluded
> path, i.e.:
>
>   $ git add subdir/file
>   The following paths are ignored by one of your .gitignore files:
>   subdir
>   Use -f if you really want to add them.
>
> then we don't really need to recurse. We just need to fix in_pathspec to
> flag files that are _relevant_ to a pathspec.

Clever and to the point.

> And something like this seems to fix the OP's problem:
> ...
> Which is similar to your fix, but hoisted into the ignore-collection
> phase. Like the original code and your patch, it suffers from using a
> straight memcmp. I think it should actually be checking the pathspec
> expansion to catch things like 'sub*/file' being relevant to 'subdir'.

Yeah.  Care to roll a patch to replace 13bb0ce (builtin-add: fix exclude
handling, 2010-02-28)?  We probably should build the glob matching on top
of your version instead.
