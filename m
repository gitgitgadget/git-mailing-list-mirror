From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: highlight: strip non-printable characters via
 col(1)
Date: Fri, 26 Aug 2011 14:44:26 -0700
Message-ID: <7v8vqfdf0l.fsf@alter.siamese.dyndns.org>
References: <1314053923-13122-1-git-send-email-cfuhrman@panix.com>
 <201108262154.14493.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christopher M. Fuhrman" <cfuhrman@panix.com>, git@vger.kernel.org,
	cwilson@cdwilson.us, sylvain@abstraction.fr
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 23:44:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx4Ct-0001dF-1a
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 23:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab1HZVoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 17:44:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab1HZVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 17:44:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA1A74CE9;
	Fri, 26 Aug 2011 17:44:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hN5YkR68GcaY11rIoSkDcJIzGn8=; b=eQD0ty
	XaSV400/ZnttKRSEPY98UKXWEWa3Dnps6ZbZQ62HJ3QYDZeSkJl/RevtIa0i4N3W
	V2+XgeMrXeqaurNT8JLMgwEr0Iv1pQBChiWP1j7YZcXgIqtbNWf0Iu/x6SpOp8MZ
	RZaTzMAlJiKH6kUIWFGjSgs7Qnz7YXXyO29Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n5DCB+drYUczj+KYIbYqj9tWeqXtcjBS
	vbgJSZM7N35qD6RUGydV5dmMj9roWXSPM9VgnohQE5TMlxdxdCnsAinEeD6SFLc5
	dcYMpQFFToBlz8UHPak/wK/nJsS7h9DOhNFN0FrOUTS19liPLbNZXIB2cJ2lL66s
	v6AclNUS4eo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A04184CE7;
	Fri, 26 Aug 2011 17:44:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 028124CE4; Fri, 26 Aug 2011
 17:44:27 -0400 (EDT)
In-Reply-To: <201108262154.14493.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 26 Aug 2011 21:54:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92BEC456-D02C-11E0-AE38-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180203>

Jakub Narebski <jnareb@gmail.com> writes:

> Why use external program (which ming be not installed, or might not
> strip control-characters), instead of making gitweb sanitize highlighter
> output itself.  Something like the patch below (which additionally
> shows where there are control characters):

I agree that that would be a more sensible approach. What does your sample
code below do to a HT by the way?

> -- >8 --
> diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
> index 7cf12af..192db2c 100755
> --- i/gitweb/gitweb.perl
> +++ w/gitweb/gitweb.perl
> @@ -1517,6 +1517,17 @@ sub esc_path {
>  	return $str;
>  }
>  
> +# Sanitize for use in XHTML + application/xml+xhtml
> +sub sanitize {
> +	my $str = shift;
> +
> +	return undef unless defined $str;
> +
> +	$str = to_utf8($str);
> +	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
> +	return $str;
> +}
> +
>  # Make control characters "printable", using character escape codes (CEC)
>  sub quot_cec {
>  	my $cntrl = shift;
> @@ -6546,7 +6557,8 @@ sub git_blob {
>  			$nr++;
>  			$line = untabify($line);
>  			printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
> -			       $nr, esc_attr(href(-replay => 1)), $nr, $nr, $syntax ? to_utf8($line) : esc_html($line, -nbsp=>1);
> +			       $nr, esc_attr(href(-replay => 1)), $nr, $nr,
> +			       $syntax ? sanitize($line) : esc_html($line, -nbsp=>1);
>  		}
>  	}
>  	close $fd
>
> -- 8< --
