From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 09:27:31 -0800
Message-ID: <7vvczy7q4c.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <1299255471.22002.15.camel@drew-northup.unet.maine.edu>
 <4D711639.4070706@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Colin Guthrie <gmane@colin.guthr.ie>
X-From: git-owner@vger.kernel.org Fri Mar 04 18:27:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvYn5-00077t-9C
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 18:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759938Ab1CDR1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 12:27:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759665Ab1CDR1l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 12:27:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 240EA4159;
	Fri,  4 Mar 2011 12:29:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=epldR8qAWIrni/Ww/2rXoGkPkes=; b=SlB+qn
	pGAYd3c7X7pQpHHStJSOtUHONumMAY4pljVApmvl/HCZBvzF0bvr9OnIBZMfAFjd
	OZ/6o0hzQ37W+iSpM2xOVaxC3JVLACEBb+11IzZjzCcyMt2dPqwcNgRMowswh/Xf
	Cl8dS8W4iBySvDkDo1vYt2NjNMbh3nkyjiI3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=flWOKUWJiOsW1xzMjh0xMMS5+6SnnRdB
	iynMQSvRugYJFQzGYqmhKLVDxnJDb+r5ucrITjFfRJM4mHzpxkvo862Rv50yP4yp
	ZWm+ZvEuUQ2wUymWXftdjWHDhpebsePOpHPPdYiF9+Barw7atvAjeureZJKnqFH5
	KntKFUArkJA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D66E64158;
	Fri,  4 Mar 2011 12:29:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B8354156; Fri,  4 Mar 2011
 12:28:56 -0500 (EST)
In-Reply-To: <4D711639.4070706@colin.guthr.ie> (Colin Guthrie's message of
 "Fri\, 04 Mar 2011 16\:41\:29 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4BBD230-4684-11E0-A3B1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168450>

Colin Guthrie <gmane@colin.guthr.ie> writes:

>> If you just send the output of "git format-patch" untouched as an
>> attachment you can expect problems.
>
> Wow! I've never heard of this before... So you're saying it's actually
> invalid to do a git format-patch and then a git am on the files it
> generates?

I don't think you understand what Drew is saying.

The output from format-patch mimics mbox format already; it specifically
was designed so that "format-patch --stdout | am" pipeline would work
without your doing anything funky.

If you include the output from format-patch in your MUA, however, the
message your MUA will send out would look like:

 * From: ... you ...
 * Subject: Hi, I am sending a patch (the message typed to your MUA)
 * Date: ... date ...

 % From <object name> <date looking format-patch signature string>
 % From: ... author name output by format patch
 % Subject: [PATCH] ... first paragraph from commit log message ...

 . The second paragraph and what follows...
 . ---
 . patch

In the above illustration, the lines marked with "*" are what your MUA
would add as the header, and the ones marked with '%' are the headers
format-patch placed to make its output look like mbox.  You are supposed
to move the "Subject: " line marked with '%' to the Subject input field of
your MUA and drop all other lines marked with '%'.

Drew is talking about the problem it causes to the recipient if you did
not do so, and left '%' lines in your MUA.
