From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates corruption issue
Date: Thu, 02 Feb 2012 16:47:31 -0800
Message-ID: <7vzkd0u4ik.fsf@alter.siamese.dyndns.org>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
 <20120202215913.GA26727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart\, Darren" <darren.hart@intel.com>,
	"Ashfield\, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 01:47:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7JU-0005WC-FK
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 01:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab2BCArf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 19:47:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157Ab2BCAre (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 19:47:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD23D659B;
	Thu,  2 Feb 2012 19:47:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lM2cUqjlWuYbGExYPlWZUhOES2I=; b=FIYueF
	jmrG961579vgdHhrF9nqXGpH57x+LHUGtnS0Hi49YEyyOjEJ1UM+X4wsQkHe4wdm
	lYpEj086W06GQRbG0ooTEa5HRflkz8PJtVYSKU4dYC9kR3ZN/g4x/sLGtH1hnrZl
	LkhAlFN2gi6YrIizFL2TwANoe82XdYtow9T3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lj1ddAfmF8AllvJitP8lS2fkd7OpzvUj
	QGhNtKGKLH/ja+Rut652OreTAuwni4ZbMAn590UtTu85bAn+p/jXPyTo2mOYVcLt
	IUndYA8aLn+qfpIU/YVgH3NsWqx2K4H2PplcAK028Ynm90fCMShunZdWPJkqSoA7
	hJ7NkJRvTN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4ACA659A;
	Thu,  2 Feb 2012 19:47:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 532126599; Thu,  2 Feb 2012
 19:47:33 -0500 (EST)
In-Reply-To: <20120202215913.GA26727@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Feb 2012 16:59:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A89B065C-4E00-11E1-B1C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189724>

Jeff King <peff@peff.net> writes:

> @@ -324,8 +324,11 @@ const char *enter_repo(const char *path, int strict)
>  			return NULL;
>  		len = strlen(used_path);
>  		for (i = 0; suffix[i]; i++) {
> +			struct stat st;
>  			strcpy(used_path + len, suffix[i]);
> -			if (!access(used_path, F_OK)) {
> +			if (!stat(used_path, &st) &&
> +			    (S_ISREG(st.st_mode) ||
> +			    (S_ISDIR(st.st_mode) && is_git_directory(used_path)))) {

Hmm, how would this change interact with

>  				strcat(validated_path, suffix[i]);
>  				break;
>  			}

	gitfile = read_gitfile(used_path);

that appear after the context in the patch?
