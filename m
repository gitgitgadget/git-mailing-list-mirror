From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 10:15:35 -0700
Message-ID: <7v8v02swnc.fsf@alter.siamese.dyndns.org>
References: <520BAF9F.70105@googlemail.com>
	<201308141628.42163.mfick@codeaurora.org>
	<7vd2pfsx3j.fsf@alter.siamese.dyndns.org>
	<201308141728.29971.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	iveqy@iveqy.com
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 15 19:15:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA19G-0008Bu-1J
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 19:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522Ab3HORPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 13:15:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756070Ab3HORPl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 13:15:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B126739719;
	Thu, 15 Aug 2013 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nMvP9YeaxYtZ+35J62DJRzJCTsM=; b=nljraK
	Hxkm6sdw5u5eOgcCg3ZlbWZkU8VvotexPDYd1HoSIhLtHwdVMBUaDLHrLmR6Fm69
	BTyMwGExLRw/tVlTRQKfrqOmgCOCiPvotbiIfTHlN/lj+cQf4aPEymGjQ7WUGTEj
	YotKiNtMT/sL2TIjTc8srf5j2Z61KlDTCO21Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZz2ATCnUM1CGkecrRqmyGcuwWoHs6XQ
	EW+G+I64OcKALsea5A8XVNt6XcXD0VmjC45iEB9/zUbeOq7HFqz+tRU+4kQwS18O
	ZNFOS4+Kj0TLVw6+peiFebNDAB4LbhYrX3mRktA1HVBuajERZ+AwRyKwWaf4mb/i
	Lw6xkyFXm48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A431D39718;
	Thu, 15 Aug 2013 17:15:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D12239712;
	Thu, 15 Aug 2013 17:15:37 +0000 (UTC)
In-Reply-To: <201308141728.29971.mfick@codeaurora.org> (Martin Fick's message
	of "Wed, 14 Aug 2013 17:28:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D7E0E4A-05CE-11E3-AAAA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232352>

Martin Fick <mfick@codeaurora.org> writes:

> On Wednesday, August 14, 2013 04:53:36 pm Junio C Hamano 
> wrote:
>> Martin Fick <mfick@codeaurora.org> writes:
>> > One suggestion would be to change the repack code to
>> > create pack filenames based on the sha1 of the
>> > contents of the pack file instead of on the sha1 of
>> > the objects in the packfile. ...
>> > I am not 100% sure if the change in naming convention I
>> > propose wouldn't cause any problems?  But if others
>> > agree it is a good idea, perhaps it is something a
>> > beginner could do?
>> 
>> I would not be surprised if that change breaks some other
>> people's reimplementation.  I know we do not validate
>> the pack name with the hash of the contents in the
>> current code, but at the same time I do remember that
>> was one of the planned things to be done while I and
>> Linus were working on the original pack design, which
>> was the last task we did together before he retired from
>> the maintainership of this project.
>
> Perhaps a config option?  One that becomes standard for git 
> 2.0?

Anything new is too late for Git 2.0, as we do not want to hold the
switching of push.default to "simple" too long.  End of this year
might be a bit too soon, but I want 2.0 to happen by the next
spring.

You can discuss, design the new naming and necessary transition plan
for existing repositories, reach a concensus and declare the name
switch in the future, and then schedule that for the next major
version bump after 2.0 happens.
