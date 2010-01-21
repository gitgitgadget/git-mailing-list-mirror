From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-receive-email: allow customizing of
 subject/intro/footer
Date: Thu, 21 Jan 2010 12:09:51 -0800
Message-ID: <7v636vp6cw.fsf@alter.siamese.dyndns.org>
References: <1263877931-26047-1-git-send-email-vapier@gentoo.org>
 <4B5888C2.60508@xiplink.com> <201001211259.30704.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY3MA-0002IC-AO
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 21:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab0AUUKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 15:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755079Ab0AUUKH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 15:10:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab0AUUKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 15:10:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BBD19287B;
	Thu, 21 Jan 2010 15:10:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=giG4zvg2Bw25fv0+jLR6CjcA/K0=; b=f95JuHgD0n87Wb2YU7nCXYM
	5lDrw1UIZPAZ17T+/PN8ggr2uk1tvzPc9lCTaH/H/P0W45jImohpBi4bK/hKep96
	67OVhmuBs6chzYPHG3+bvpK/BSrcyZrpRqGXcZ5jJSTTqFoFI1UGG4VHiuv89gSl
	3j0Xmqv2LGobVskSncYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ndD8F6T6NdQJt8WLLbw6QaZLOt8suZopDgDXOqlb/z6ZUdUXI
	39n//nxXrc6WGC6QrprDiyviffC7GTrEXYBbahXF/UTWX40qLR1f3XQcutTmDkcr
	+9TX5oFjQESJAjjJ65mLJDXruQRvJsYuRrarp1Kn2BKHtUit8jqpx/0oT0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA90492879;
	Thu, 21 Jan 2010 15:09:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3E3692871; Thu, 21 Jan
 2010 15:09:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2086FC2-06C8-11DF-B779-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137690>

Mike Frysinger <vapier@gentoo.org> writes:

>> So, overall, why not make generate_email_header() be simply:
>> 
>> generate_email_header()
>> {
>> 	# --- Email (all stdout will be the email)
>> 	# Generate header
>> 	subst_vars <<-EOF
>> 	To: $recipients
>> 	Subject: ${emailprefix}${emailsubject}
>> 	X-Git-Refname: @refname@
>> 	X-Git-Reftype: @refname_type@
>> 	X-Git-Oldrev: @oldrev@
>> 	X-Git-Newrev: @newrev@
>> 
>> 	${emailbodyintro}
>> 
>> 	EOF
>> }
>> 
>> This would also let you simply subst_vars() so that it needn't support
>>  piped invocations, no?  (Not a very drastic simplification, but still...)
>
> if emailbodyintro is empty, this adds two useless newlines.  otherwise, this 
> would be fine i think.

I haven't looked at the original that is being improved upon (because I am
not very interested in this sample script myself), but I have two comments
on the above.

 - You can do something like this to fix that "empty line" issue, no?

	LF='
        ' ;# newline
	subst_vars <<-EOF
        ...

        ${emailbodyintro:+"$emailbodyinto$LF"}
	EOF

 - If you are using shell variable interpolation anyway, why do you still
   need @special_name@ interpolated with perl or sed or whatever you are
   using in subst_vars (which I didn't look at)?  If you have $refname,
   $refname_type and friends, can't the above become "cat <<-EOF"?
