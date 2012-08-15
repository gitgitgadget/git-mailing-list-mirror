From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: URL-decode $my_url/$my_uri when stripping
 PATH_INFO
Date: Wed, 15 Aug 2012 11:47:04 -0700
Message-ID: <7vipck56xj.fsf@alter.siamese.dyndns.org>
References: <1344479366-8957-1-git-send-email-jaysoffian@gmail.com>
 <7vr4rgoz1u.fsf@alter.siamese.dyndns.org>
 <201208152015.49132.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:47:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1icc-0000J3-1e
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 20:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab2HOSrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 14:47:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab2HOSrH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 14:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A80DD9CD3;
	Wed, 15 Aug 2012 14:47:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G+StMgFmg1jHHQRYfqbpCixNY2s=; b=kCl40p
	SDXmbGiw1Zi06DgKhHsQn2fd7B40bv66s+/jOUYhBjlebmv5PVjnMAxs6pv/EAHx
	Oucjp9G3Ri7ew/0WKTtfIhu4Cc9JAHPIEzvfv+lJV+72WYfV6gxE529Cx5fpm2EJ
	evMg1kfq53m7Fmr39zxpNF3nUBRVvHr9XYDtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QD0yKpS31vq/IqqxFIAoFBBSLbYTZBq7
	iYBGFsIVUIM5WYQsFnXgY+RFw1q6GKwIYS4VSDdkJCdf/U+9F1ZVz28NPvQQsVmX
	DDYbXW6Z/GuDdJqr6cbBNKDf2EsO1Drn9FWTnP/qEkRra20YfrnOId6m/Q7xszz3
	NV/er1cT0mU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 944929CD2;
	Wed, 15 Aug 2012 14:47:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8FEE9CD1; Wed, 15 Aug 2012
 14:47:05 -0400 (EDT)
In-Reply-To: <201208152015.49132.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 15 Aug 2012 20:15:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C3A844E-E709-11E1-8F53-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203485>

Jakub Narebski <jnareb@gmail.com> writes:

> On Thu, 9 Aug 2012, Junio C Hamano wrote:
>> Jay Soffian <jaysoffian@gmail.com> writes:
>> 
>> > When gitweb is used as a DirectoryIndex, it attempts to strip
>> > PATH_INFO on its own, as $cgi->url() fails to do so.
>> >
>> > However, it fails to account for the fact that PATH_INFO has
>> > already been URL-decoded by the web server, but the value
>> > returned by $cgi->url() has not been. This causes the stripping
>> > to fail whenever the URL contains encoded characters.
>> >
>> > To see this in action, setup gitweb as a DirectoryIndex and
>> > then use it on a repository with a directory containing a
>> > space in the name. Navigate to tree view, examine the gitweb
>> > generated html and you'll see a link such as:
>> >
>> >   <a href="/test.git/tree/HEAD:/directory with spaces">directory with spaces</a>
>> >
>> > When clicked on, the browser will URL-encode this link, giving
>> > a $cgi->url() of the form:
>> >
>> >    /test.git/tree/HEAD:/directory%20with%20spaces
>> >
>> > While PATH_INFO is:
>> >
>> >    /test.git/tree/HEAD:/directory with spaces
>> >
>> > Fix this by calling unescape() on both $my_url and $my_uri before
>> > stripping PATH_INFO from them.
>> >
>> > Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
>> > ---
>> 
>> Thanks.  From a cursory look, with the help from the explanation in
>> the proposed commit log message, the change looks sensible.
>> 
>> I wonder if a breakage like this is something we can catch in one of
>> the t95xx series of tests, though.
>
> No, it is unfortunately not possible with current test infrastructure
> for gitweb.  The gitweb_run from t/gitweb-lib.sh allows to set
> PATH_INFO and QUERY_STRING, but does not allow to set up URL.
>
> That might change in the future...
>
>> Jakub, Ack?
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>
>
> Uf ut us bot too late...

Thanks.
