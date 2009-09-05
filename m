From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 05 Sep 2009 00:58:50 -0700
Message-ID: <7v3a717rgl.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905072017.GA5152@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 09:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqBd-0008W3-6A
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 09:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbZIEH7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 03:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbZIEH7D
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 03:59:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZIEH7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 03:59:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8728044F9C;
	Sat,  5 Sep 2009 03:59:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AqtXbetNEdhZ0WLtAHGyvyCTAw8=; b=oJRjxx
	UyJ6ZFQ0XX8pZNQND+CxkNrT4t09Q48tG576y+pUtf226GjjVpNwYGV+llMCaca2
	Ienp5HaTb5R+Yh++sBH02l8EUj9ri2AVnnNDwK3EzyOUhhErNolahd6UGIb71a0I
	cLSjz2FLD+3Wr6cRj9orJbgsnywDfsctEMZhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZxTOY+9Z/JMySjxIHmMyQ+/1Sr2oN0SI
	J8FtaDKNeJICIy5pbGMM0iNxUrB2rZuNasFT2nbsEdNUxCKnJ3RRkrwgCOdVShgd
	7EmDTOGU0TZW38ue4dS2rwevR7WQtqwAGqQty7M94RaMHSMZ658K8jxoYbVvFjuP
	A6DREXgCwQ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B16F44F99;
	Sat,  5 Sep 2009 03:58:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 840A344F97; Sat,  5 Sep 2009
 03:58:52 -0400 (EDT)
In-Reply-To: <20090905072017.GA5152@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 5 Sep 2009 03\:20\:17 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F748C9C6-99F1-11DE-B77A-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127789>

Jeff King <peff@peff.net> writes:

> I assume you mean "ls-files".  I have every once in a while been annoyed
> by that, but given how infrequently I run ls-files, it is not a big
> deal. :)

I did mean ls-tree, but I misspelled the name of the escape hatch.

Try this:

    $ cd Documentation
    $ git ls-tree HEAD

If I were designing this as a proper plumbing command from scratch, I
wouldn't have given it a cwd behaviour.  ls-files is somewhat more
understandable, as it has other cruft relating the work tree, but ls-tree
is worse:

    $ cd Documentation
    $ git ls-tree origin/html

Whoa???  Yes, it tried to do what "git ls-tree origin/html:Documentation"
would have done if it were unaware of cwd.  It's just crazy.

>> If "git add -u ../.." (I mean "the grand parent directory", not "an
>> unnamed subdirectory") did not work, it would be unexcusable and we would
>> want to devise an migration path, but otherwise I do not think it is such
>> a big deal.  I would say the commands that are used to incrementally build
>
> As I mentioned above, not only is that annoying to use, but the real
> problem is that I _expect_ the other behavior and it silently does the
> opposite of what I want. You can argue that my brain is defective (for
> not remembering, I mean -- we _know_ it's defective in other ways), but
> certainly a config option would be useful to me.

At this moment (as my brain is not quite functioning), I can only say we
agreed to disagree what feels more natural here.
