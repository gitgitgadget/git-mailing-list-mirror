From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Mon, 19 May 2014 09:54:33 -0700
Message-ID: <xmqqd2f93e0m.fsf@gitster.dls.corp.google.com>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
	<1400203881-2794-2-git-send-email-jmmahler@gmail.com>
	<20140516081445.GA21468@sigill.intra.peff.net>
	<20140517072548.GA18239@hudson.localdomain>
	<20140517074224.GA16697@sigill.intra.peff.net>
	<20140517085911.GA18862@hudson.localdomain>
	<20140517100013.GA18087@sigill.intra.peff.net>
	<20140517153943.GB31912@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 18:54:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQpp-0000Nn-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbaESQyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 12:54:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62930 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932520AbaESQyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:54:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 673B015FB3;
	Mon, 19 May 2014 12:54:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uUI8mTG8wUscketlWQGXhEk0R3Q=; b=s8Rxun
	BDOrkJYtErc3QQnb/ziUJK5LvsqIvbsCY7tCx+trgkYsWmaI6+R+kith3pfOe/r9
	QBIn2hgr9ZRe/GkTCsAbFxe4jOG8roAKj86W8xJgzBu0eOttPAkOAnIawW8q178/
	mY8oxR9azkx9xOimidzIF3KTysXG9/exIs2rI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vj38RITqLUamsmm5mS/ycauWQY0aDTBK
	/OdzJQ4DVdDsdA3VqVvhM6o1oYDFoXCLU5j0jH249yYBNWg8U62K/4Rew8nHIENN
	jPEt/0xop82Ch3/r/o6luiQtnUX75Hrb56h6ewxb0iQpf342tvM1bR+ZuhJDzI4I
	A3b7yOpE0fU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D44C15FB2;
	Mon, 19 May 2014 12:54:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 966F815FAB;
	Mon, 19 May 2014 12:54:34 -0400 (EDT)
In-Reply-To: <20140517153943.GB31912@hudson.localdomain> (Jeremiah Mahler's
	message of "Sat, 17 May 2014 08:39:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4151BC3E-DF76-11E3-9989-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249598>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> On Sat, May 17, 2014 at 06:00:14AM -0400, Jeff King wrote:
>> 
>> If you wanted to know whether it was set, I guess you'd have to compare
>> it to the default, like:
>> 
>>   if (signature_file) {
>> 	if (signature && signature != git_version_string)
>> 		die("you cannot specify both a signature and a signature-file");
>> 	... read signature file ...
>>   }
>> 
>
> That works until someone changes the default value.
> But if they did that then some tests should fail.
>
> I like the address comparision which avoids a string comparision.

Well, "avoids" is not quite a correct phrasing, because !strcmp()
would be wrong there.  You cannot tell "the user did not set
anything and the variable stayed as the default" and "the user
explicitly gave us a string but it happened to be the same as the
default" apart with !strcmp().  Address comparison is not just
"avoids" but is the right thing to do in this case.

>> though it's a bit ugly that this code has to know what the default is.

Avoiding that is easy with an indirection, no?  Something like this
at the top:

  static const char *the_default_signature = git_version_string;
  static const char *signature = the_default_signature;

and comparing to see if signature points at the same address as
the_default_signature would give you what you want, I think.
