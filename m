From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t/send-email.sh: add test for suppress self
Date: Wed, 29 May 2013 15:46:36 -0700
Message-ID: <7vmwrdqu9f.fsf@alter.siamese.dyndns.org>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
	<1369579187-27573-2-git-send-email-mst@redhat.com>
	<7vy5axr0mz.fsf@alter.siamese.dyndns.org>
	<20130529214403.GA5956@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 30 00:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhp8m-0001No-4x
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 00:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966834Ab3E2Wqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 18:46:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966329Ab3E2Wqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 18:46:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E6D22325D;
	Wed, 29 May 2013 22:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ra8tx6jIRkWjSduGSmGC/S1xf88=; b=VYsOuJ
	zb2lSkp98PNP5x5L8fAZWVQIQdVQUXHfpSrJ0GR9F5G1uhDRjrBDhSqlZLs2sBEj
	n4O7LieJOdMO5j80ffHXJiMIFr69OMJFuk0YxZmDmWmcjnIUX+B/3dR7DmelcGrL
	XN5ndSv6YD4s1cga08XKD+F8KW1ZmQrS7X9uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XWATkSKPJi9Z+MVBOY2v1551/yWkVqaZ
	rA/3qTfdzv5+HhP8SAirUslTOlsDrWyNlmHIH/Bz5Gfhe1V/+6V9AKqUkF7P1dee
	88t9g6LASWiVg747TNWCM4cWSD3t+RXDwFHV9i8kvFaf4eGoTIV324cldQYEiSpC
	sdyWZHWrzCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 426E22325C;
	Wed, 29 May 2013 22:46:38 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98BBD2325A;
	Wed, 29 May 2013 22:46:37 +0000 (UTC)
In-Reply-To: <20130529214403.GA5956@redhat.com> (Michael S. Tsirkin's message
	of "Thu, 30 May 2013 00:44:03 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EF7D8FA-C8B1-11E2-9CE1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225895>

"Michael S. Tsirkin" <mst@redhat.com> writes:

>> > +test_suppress_self () {
>> > +		test_commit $3 &&
>> > +		test_when_finished "git reset --hard HEAD^" &&
>> > +		{
>> > +			echo "#!$SHELL_PATH"
>> > +			echo sed -n -e s/^cccmd--//p \"\$1\"
>> > +		} > cccmd-sed &&
>> > +		chmod +x cccmd-sed &&
>> 
>> We can use write_script for this kind of thing, I think.
>
> Important?
> It's open-coded elsewhere in this test.

Not that important, other than that it is nice not to spread what
the old tests did before write_script was introduced to new ones, as
that is one more thing to update when somebody feels like it.

> If we don't want to use \, this can also be done like this:
>
> FOO << EOF && 
> BLABLA
> EOF
>  BAR && 
>  VAR
>
> I think this is what you suggest.

Yup, that is exactly what I meant (but no leading indentation before
BAR and VAR).

That way, it is a lot more clear where the input is (the BLABLA is
fed to FOO and BAR and VAR do not have anything to do with it).

>> > +		grep '^Cc:' msghdr1-$3 > actual-no-cc-$3 && \
>> > +		test_cmp expected-no-cc-$3 actual-no-cc-$3

OK, so this is where the message begins, with the commit title "test
supress-cc.self...".

>> > +test suppress-cc.self $3 with name $1 email $2
>> > +
>> > +$3
>> > +
>> > +cccmd--"$1" <$2>
>> > +
>> > +Cc: "$1" <$2>
>> > +Cc: $1 <$2>
>> > +Signed-off-by: "$1" <$2>
>> > +Signed-off-by: $1 <$2>
>> > +EOF
>> > +}
>> > +
>> > +test_expect_success $PREREQ 'self name is suppressed' "
>> > +	test_suppress_self 'A U Thor' 'author@redhat.com' 'self_name_suppressed'
>> > +"
>> > +
>> >  test_expect_success $PREREQ 'Show all headers' '
>> >  	git send-email \
>> >  		--dry-run \
