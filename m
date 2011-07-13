From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not log unless all connect() attempts fail
Date: Wed, 13 Jul 2011 13:39:18 -0700
Message-ID: <7v1uxt7w5l.fsf@alter.siamese.dyndns.org>
References: <1EC2718A-A993-443C-8D7C-DEBD7C424EB9@apple.com>
 <CABPQNSaPXmHE1qECUbG9oWU43HbAXxAY42T1P=MNHgkkWM936w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Zarzycki <zarzycki@apple.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 13 22:39:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6DP-0000QV-Sj
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 22:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab1GMUjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 16:39:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab1GMUjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 16:39:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2650A651E;
	Wed, 13 Jul 2011 16:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rMfwyF0ZOwFuGyTej2WMcvpsuV0=; b=OuBhLS
	H9kiRdzaqnHXwdAVdzmBSVzslbs1mEbTTsY4SQqUxkg+HFT3Vhw+i1UZqpnHDtvv
	jrq3HGYlo6an9QeFue+Q9zS7nyXbREJggAx6KWoFUAHC4c0DeG2g01dngDYtHoTo
	z29BNH/UUinzRqORmeN+Ih/Erwm3ukRzuooqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VkqyAcubCTN9x2xgUszVyApW5udVennS
	cWW9Vi8eryG/SvkQVEHXDnEESsPtzHwcroB0QYJ9tZoZtXQ/7uOa070+8zmpegm+
	J3fYCT4gdrXBpFtUU+8cY/fyO7H6DmFupSKgOMoggvMcOl3hhGIg3gr6iSNVp8WE
	E0wmRhlg2yQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FE66651C;
	Wed, 13 Jul 2011 16:39:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 597E3651B; Wed, 13 Jul 2011
 16:39:20 -0400 (EDT)
In-Reply-To: <CABPQNSaPXmHE1qECUbG9oWU43HbAXxAY42T1P=MNHgkkWM936w@mail.gmail.com> (Erik
 Faye-Lund's message of "Wed, 13 Jul 2011 11:23:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F6DEB5C-AD90-11E0-865D-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177079>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> diff --git a/connect.c b/connect.c
>> index 2119c3f..8eb9f44 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -225,11 +226,8 @@ static int git_tcp_connect_sock(char *host, int flags)
>>                }
>>                if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
>>                        saved_errno = errno;
>> +                       strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
>> +                               host, cnt, ai_name(ai), strerror(saved_errno));
>>                        close(sockfd);
>>                        sockfd = -1;
>>                        continue;
>> @@ -242,11 +240,13 @@ static int git_tcp_connect_sock(char *host, int flags)
>>        freeaddrinfo(ai0);
>>
>>        if (sockfd < 0)
>> -               die("unable to connect a socket (%s)", strerror(saved_errno));
>> +               die("unable to connect to %s:\n%s", host, error_message.buf);
>>
>
> This kills the output from the case where "sockfd < 0" evaluates to
> true for the last entry in ai, no (just above your second hunk), no?
> In that case errno gets copied to saved_errno, and the old output
> would do strerror(old_errno), but now you just print the log you've
> gathered, and don't even look at saved_errno.
>
> If this is intentional then you should probably kill the saved_errno
> variable also, it's rendered pointless by this patch.

As error_message.buf contains strerror([saved_]errno), I think it is
intentional to remove strerror() from the final die().  Without looking at
the code outside the context of the patch I cannot tell if saved_errno has
become unneeded, but I tend to trust your analysis so...
