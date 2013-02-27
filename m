From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 6/6] git-send-email: use git credential to obtain
 password
Date: Wed, 27 Feb 2013 08:29:26 -0800
Message-ID: <7va9qpk9eh.fsf@alter.siamese.dyndns.org>
References: <cover.1360677646.git.mina86@mina86.com>
 <cover.1360677646.git.mina86@mina86.com>
 <32bae1f3c7159035ea3fb5f61ab622cbff30293a.1360677646.git.mina86@mina86.com>
 <vpqhakx4z4c.fsf@grenoble-inp.fr> <7vehg1kb09.fsf@alter.siamese.dyndns.org>
 <vpqy5e9zqe9.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Nazarewicz <mpn@google.com>, peff@peff.net,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 27 17:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAjtD-0002jK-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 17:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821Ab3B0Q3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 11:29:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab3B0Q33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 11:29:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0728FBAAF;
	Wed, 27 Feb 2013 11:29:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kf+m6EOH7fleyt/s7Qkznd2jXDI=; b=gbtmd5
	ZvI3+HUYAkM3Jy1iqmndNwvk2XRDjDJbtISFurgK0eyF9XENGa1b48+4KJSyRTK4
	x7AzlZh+kyyoYk990rS2OCPk5WB4sjxcQIjUt29XkQ+JH40ajK/sZ4s5nOOZaWzS
	h0vaH2zyqL/JAJ263cnF2RLGPhsacBrz80qZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NJXxxvPKTLmY+MS58nYU85XUEvmxBgaD
	SZl5IcWCkFk1FYaglq9xwsKTEhmrV04WY26GHJib1inZx1J83AQMhQgyCSTtpzqw
	iKuB1wadhmxoGzeD6iIr3WN1avX8msOincMJ4q4yPlDXofSeSJGlpiLW/xxAo8Nm
	4VFEdX7yFTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F09F0BAAE;
	Wed, 27 Feb 2013 11:29:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58071BAAB; Wed, 27 Feb 2013
 11:29:28 -0500 (EST)
In-Reply-To: <vpqy5e9zqe9.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Wed, 27 Feb 2013 17:13:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB48AB30-80FA-11E2-8C78-2B642E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217219>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 76bbfc3..c3501d9 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1045,6 +1045,14 @@ sub maildomain {
>>  	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
>>  }
>>  
>> +sub smtp_host_string {
>> +	if (defined $smtp_server_port) {
>> +		return "$smtp_server:$smtp_server_port";
>> +	} else {
>> +		return $smtp_server;
>> +	}
>> +}
>> +
>>  # Returns 1 if authentication succeeded or was not necessary
>>  # (smtp_user was not specified), and 0 otherwise.
>>  
>> @@ -1065,7 +1073,7 @@ sub smtp_auth_maybe {
>>  	# reject credentials.
>>  	$auth = Git::credential({
>>  		'protocol' => 'smtp',
>> -		'host' => join(':', $smtp_server, $smtp_server_port),
>> +		'host' => smtp_host_string(),
>>  		'username' => $smtp_authuser,
>>  		# if there's no password, "git credential fill" will
>>  		# give us one, otherwise it'll just pass this one.
>> @@ -1188,9 +1196,7 @@ sub send_message {
>>  		else {
>>  			require Net::SMTP;
>>  			$smtp_domain ||= maildomain();
>> -			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
>> -						 ? "$smtp_server:$smtp_server_port"
>> -						 : $smtp_server,
>> +			$smtp ||= Net::SMTP->new(smtp_host_string(),
>>  						 Hello => $smtp_domain,
>>  						 Debug => $debug_net_smtp);
>>  			if ($smtp_encryption eq 'tls' && $smtp) {
>
> Seems obviously correct. I also did a basic test and it worked smoothly.

OK, I'll squash it in.
Thanks.
