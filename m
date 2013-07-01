From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/4] contrib: contacts: add support for multiple patches
Date: Mon, 01 Jul 2013 11:57:46 -0700
Message-ID: <7v38ryglat.fsf@alter.siamese.dyndns.org>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-3-git-send-email-sunshine@sunshineco.com>
	<7v7ghaglmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 20:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtjIP-0005yx-2R
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 20:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab3GAS5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 14:57:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab3GAS5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 14:57:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30D6C2DB42;
	Mon,  1 Jul 2013 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P/j20HuhQd0rlP2gfdTSS+ej1KA=; b=G/gqCT
	5Vd9/Un9KDwjvaOBbyNAHDmITyQLeM0RoNztPwEyaExfJfFi/9iOQehlzap9DqOI
	t6hXotoB51yCRIrEmcElPq0bcdlM3xWPE5tFm4DIBYDqtIZK8srzxlWTWiThVBgN
	qit1q3MLogIIHNLeh7xfX+HqMtTWInkMfs/qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDukUdgZWvl99GT7kWcznjodaJ7N7Kz6
	SrvL0nQe0k0a06N5irwSfZeIR7iSo9mV+8i+1gR4fNFdAQN8AoOXAAfoWgFSxrwn
	t/P8IoPOSQHldOc/XIYNZ4VF3x+vUSxIBpmLhz7W6DbWIOtOgmwFkiyjr+UKkBKt
	vvaqrZTz2Fc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2606B2DB41;
	Mon,  1 Jul 2013 18:57:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 854C22DB3E;
	Mon,  1 Jul 2013 18:57:47 +0000 (UTC)
In-Reply-To: <7v7ghaglmx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 01 Jul 2013 11:50:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1ED5D9D6-E280-11E2-BF5B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229320>

Junio C Hamano <gitster@pobox.com> writes:

> 	while (<$f>) {
> 		if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
> 			# beginning of a patch
> 			$id = $1;
> 		}
>                 next if (!defined $id);
> 		# inline the body of scan_hunks here...

Or alternatively, teach scan_hunks to stop reading when it sees the
beginning of the next patch (and probably you would need to return
the $id you read, as it would be more cumbersome to "rewind" the
input stream).

> 		if (m{^--- (a/.*|/dev/null)$}) {
> 			$source = ...
> 		} elsif (/^@@ -(\d+)...) {
> 			get_blame();
> 		}
> 	}
>
>> @@ -100,10 +104,8 @@ sub commits_from_patch {
>>  	close $f;
>>  }
>>  
>> -exit 1 unless @ARGV == 1;
>> -
>>  my %commits;
>> -commits_from_patch(\%commits, $ARGV[0]);
>> +commits_from_patch(\%commits, $_) for (@ARGV);
>
> This change does not seem to account for an invocation without any
> argument.  Perhaps write it like so to make it more readable?
>
> 	if (!@ARGV) {
> 		die "No input file?\n";
> 	}
>
> 	for (@ARGV) {
> 		commits_from_patch(\%commits, $_);
> 	}	        
>
>>  import_commits(\%commits);
>>  
>>  my %count_per_person;
