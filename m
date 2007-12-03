From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix UTF Encoding issue
Date: Mon, 03 Dec 2007 02:14:43 -0800
Message-ID: <7v7ijwjd9o.fsf@gitster.siamese.dyndns.org>
References: <4753D419.80503@clearchain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Close <Benjamin.Close@clearchain.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 11:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8KS-0002s1-Te
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXLCKOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbXLCKOt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:14:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55500 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbXLCKOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:14:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 53A532EF;
	Mon,  3 Dec 2007 05:15:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D03099B723;
	Mon,  3 Dec 2007 05:15:06 -0500 (EST)
In-Reply-To: <4753D419.80503@clearchain.com> (Benjamin Close's message of
	"Mon, 03 Dec 2007 20:32:01 +1030")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66899>

Benjamin Close <Benjamin.Close@clearchain.com> writes:

>>From 83042abf3967b455953cddeab43e33c1d59c6f03 Mon Sep 17 00:00:00 2001
> From: Benjamin Close <Benjamin.Close@clearchain.com>
> Date: Sun, 2 Dec 2007 15:09:00 -0800
> Subject: [PATCH] Gitweb: Fix encoding to always translate rather than
> sometimes fail
>
> When performing the utf translation don't test if $res is defined.
> It appears that it is defined even when the conversion fails. This causes
> failures on the writing of the output stream which is expecting UTF.
> @@ -696,12 +696,8 @@ sub validate_refname {
>  sub to_utf8 {
>  	my $str = shift;
>  	my $res;
> -	eval { $res = decode_utf8($str, Encode::FB_CROAK); };
> -	if (defined $res) {
> -		return $res;
> -	} else {
> -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> -	}
> +	eval { return ($res = decode_utf8($str, Encode::FB_CROAK)); };
> +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>  }

This is funny.

I thought the standard catch ... throw idiom in Perl was to do the above
like this:

	my $res;
        eval { $res = decode_utf8($str, Encode::FB_CROAK); };
        if ($@) {
        	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
	}
	return $res;

(alternatively, you can assign return value of eval {} to $res).
