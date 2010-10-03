From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 16/16] Introduce portable_unset and use it to ensure
 proper && chaining
Date: Sun, 03 Oct 2010 16:34:26 -0700
Message-ID: <7vzkuudf5p.fsf@alter.siamese.dyndns.org>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-17-git-send-email-newren@gmail.com>
 <20101003145122.GF17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Y4t-00064p-OP
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab0JCXei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:34:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0JCXeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:34:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5959DB260;
	Sun,  3 Oct 2010 19:34:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rCikGQ8SwodaScMlTcF/NcUqR+M=; b=vvDjm6r1DoruICC0tiBkF/1
	ZR+iiGr/xJX955fiFW1QoEAYxtYDDXEKCPihEnSJ5y5bmBexu5K9+l9UZbdXbsU3
	KGtIjWnRYtpI36CoZLdQkMl5xAGxlqajwAiBWTzWWhdGh/LTdLXuqmHHt9fP3yc5
	WHt8D4wCoHNrOMKZxitY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LOWSGlAiys0FU5SxQ1R/Mw1gbhe0f7E9T0IZtbbWlO+LNX0d+
	Wt91XEDeHuX3zKf9JKKSLGRzYhbT/zJHrioV8sBd9ow2tfbFdeFmFnk9uUiyLy5g
	sJUn+Gfy5rMf6xVlpThz+OqJVT4f+5/t+P7Rx62b4FuKXRpG2cP6AcD2oA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 875DADB25B;
	Sun,  3 Oct 2010 19:34:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0664DB24F; Sun,  3 Oct
 2010 19:34:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6413EA4-CF46-11DF-8192-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157951>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Elijah Newren wrote:
>
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -268,6 +268,10 @@ remove_cr () {
>>  	tr '\015' Q | sed -e 's/Q$//'
>>  }
>>  
>> +portable_unset () {
>> +	unset $* || true
>> +}
>
> I think this should read
>
> 	portable_unset () {
> 		unset "$@"
> 		return 0
> 	}
>
> (or || true).  That is, if I try
>
> 	portable_unset "foo bar"
>
> then on platforms where an envvar named "foo bar" is allowed,
> this should unset it, no?

Yes, or closer to Elijah's original:

	unset "$@" || true

I do not think calling this "portable_" makes much sense, though.  Maybe
depending on the exit status of "unset" may be unportable, but the wrapper
does not make unset portable.  It just picks one behaviour we happen to
like among the possible two (one being "unset always succeeds" vs the
other being "unset errors out if you feed an unset variable").

I have no objection against calling it "sane_unset", though.  It makes it
crystal clear that the semantics wrapper implements is what we picked
because we like (i.e. deem the sanest among alternatives).
