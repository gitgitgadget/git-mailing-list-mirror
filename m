From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t/send-email.sh: add test for suppress self
Date: Wed, 29 May 2013 15:59:51 -0700
Message-ID: <7vip21qtnc.fsf@alter.siamese.dyndns.org>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
	<1369579187-27573-2-git-send-email-mst@redhat.com>
	<7vy5axr0mz.fsf@alter.siamese.dyndns.org>
	<20130529214403.GA5956@redhat.com>
	<7vmwrdqu9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 30 00:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhpLa-0004py-JB
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 00:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967101Ab3E2W7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 18:59:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966799Ab3E2W7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 18:59:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59C6323A14;
	Wed, 29 May 2013 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oTzsWKArXKYwmFZ42uzNMfgb/k8=; b=gbI/b4
	SmgZGHzLkRZ9IykGYFp/gLyunqobRJu4bNDWScwv4SiDGpMvp+Z7JKRdBQMPs7vQ
	OE6aMb4RCZRvRc4AR2KdCAF7Mr0TMlaUTxoQrrj/keEpxIw+ayHqwsHlAdKp6qFn
	Sl4Y4+H2tbLOjq6xJ/cse44gveNulBDezoKFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W4np4FPvV/Vfivf0ONxCh3cn3KcdNdIU
	EZMpU8zU2IEHSL8KsfYlvLQV8bTlmNpP8R4JIs0VYQjCOBX1+qxSNDSDSKV//BIh
	/WjzG3fPokfweqiXTLhCJ4a3j9G2/5ud+Y/o9k3yYNSukvyB8UdpDPssPXqgFxL0
	+4ZVeeBy8P0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ACE823A13;
	Wed, 29 May 2013 22:59:53 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4CEA23A12;
	Wed, 29 May 2013 22:59:52 +0000 (UTC)
In-Reply-To: <7vmwrdqu9f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 29 May 2013 15:46:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78DB1E00-C8B3-11E2-BA0D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225896>

Junio C Hamano <gitster@pobox.com> writes:

>> If we don't want to use \, this can also be done like this:
>>
>> FOO << EOF && 
>> BLABLA
>> EOF
>>  BAR && 
>>  VAR
>>
>> I think this is what you suggest.
>
> Yup, that is exactly what I meant (but no leading indentation before
> BAR and VAR).
>
> That way, it is a lot more clear where the input is (the BLABLA is
> fed to FOO and BAR and VAR do not have anything to do with it).
>
>>> > +		grep '^Cc:' msghdr1-$3 > actual-no-cc-$3 && \
>>> > +		test_cmp expected-no-cc-$3 actual-no-cc-$3
>
> OK, so this is where the message begins, with the commit title "test
> supress-cc.self...".

Another thing I forgot to say, if you are rerolling this patch
anyway to follow that style, is that our newer tests typically
write it like this:

test_supress_self () {
	test_commit $3 &&
        test_when_finished "git reset --hard HEAD^" &&
        write_script <<-EOF &&
        sed -n -e s/^cccmd--//p \"\$1\"
	EOF

	git commit --amend --author="$1 <$2>" -F - <<-EOF &&
	test suppress-cc.self $3 with name $1 email $2

	$3

	cccmd--"$1" <$2>

        Cc: "$1" <$2>
	Cc: $1 <$2>
	Signed-off-by: "$1" <$2>
	Signed-off-by: $1 <$2>
        EOF
        
        clean_fake_sendmail &&
        git format-patch --stdout -1 >"suppress-self-$3.patch" &&
        git send-email --from="$1 <$2>" \
        	--to=nobody@example.com \
                ... other args ...
        ... verification steps for the send-email output ...
}
