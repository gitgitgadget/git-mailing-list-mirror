From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: fix #patchNN anchors when path_info is
 enabled
Date: Thu, 17 Mar 2011 11:40:42 -0700
Message-ID: <7v62rh4ml1.fsf@alter.siamese.dyndns.org>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost>
 <m3hbb258pw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0I82-0004cO-O8
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 19:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab1CQSky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 14:40:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922Ab1CQSkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 14:40:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AEDE306F;
	Thu, 17 Mar 2011 14:42:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HL6K1PjwpBuoT87OjTD2s1GmzFQ=; b=igDlM3
	cYX2DEQ1Gz4A8iJVOf8+486yMOJ8fWIFzTzJWBLbwqqVeK8aZkLNIrbu9o1iGAOA
	daDqzvkRYu4cNj0ZCL5SCfHQ+bWwjnpJxo55Vbv53+Y2AFLELs44I9WnJwSdynvj
	Ah7/0PXLg0Usy88t6c1XqTF/N/za43kf2cfxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hyR1PXccRxRz6SGGdaSJdTttjGTsQHOl
	Vlc3qKIDqOJ9RNT3T8C5aK8SxzsMPkfmwSW6ZDOzbBQ30n1keqD/Ya+zkF2DBm2L
	djdCdJmiujydqmLYk1AN1QTjmt55l8FhtQWpRZADEKezr5q+H8QLx2FWsWWnK6Vp
	cIk9RngwlS4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A4FB306E;
	Thu, 17 Mar 2011 14:42:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1285B306A; Thu, 17 Mar 2011
 14:42:16 -0400 (EDT)
In-Reply-To: <m3hbb258pw.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 17 Mar 2011 03:43:12 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4ADD7208-50C6-11E0-B574-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169255>

Jakub Narebski <jnareb@gmail.com> writes:

> It would be better (less error prone) and easier to use '-replay'
> option to href(), i.e. write
>
>> +				print $cgi->a({-href => href(-replay=>1, -anchor=>"patch$patchno")},
>> +				              "patch") .
>
> or even make it so 'href(-anchor=>"ANCHOR")' implies '-replay => 1'.

I don't see why "or even" is an improvement, given the following
implementation.

>   @@ -1310,6 +1310,7 @@ sub href {
>   
>   	$params{'project'} = $project unless exists $params{'project'};
>   
>  -	if ($params{-replay}) {
>  +	if ($params{-replay} ||
>  +	    ($params{-anchor} && keys %params == 1)) {
>   		while (my ($name, $symbol) = each %cgi_param_mapping) {
>   			if (!exists $params{$name}) {
>   				$params{$name} = $input_params{$name};

I don't share your intuition that "anchor" is so special that this part
will not grow into a long chain of "(I want an implicit replay too) ||".

Implicitly enabling it in certain obvious cases is perfectly fine, but the
logic to do so should be in a separate place.  Wouldn't it better to have
a separate code that sets 'replay' under this and that condition so that
other people can later add to it at the very beginning of "sub href"?

Unless we do so, if there are other places that need to change the
behaviour based on 'replay', they need to duplicate the "implicit" logic.
