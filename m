From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 16/16] Introduce portable_unset and use it to ensure
 proper && chaining
Date: Sun, 3 Oct 2010 09:51:22 -0500
Message-ID: <20101003145122.GF17084@burratino>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-17-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 16:54:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Pxa-0007eA-IM
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 16:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab0JCOyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 10:54:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53532 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0JCOyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 10:54:36 -0400
Received: by iwn5 with SMTP id 5so5825594iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LQKJGwwtbKPXp1HdGbgEZy87Olk60zpNtQqmAj2lRAE=;
        b=ehCU74iZdZIknpPd/M4IpMMGOI4IxAD3eHVGCuhGNbg6UKifoXJIWP1PKPu8mq1jXD
         FTPeJG+NRC5jC6ozynFDhXN5fY1NSh2smMUf+N4WnOnx9Yq5fjGfup5owl/Ud9xWfS4O
         +Jc8jSLsEMM7Ky8Ya8LoFDG9jlHGpsv5DkSEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ar6bSWu9WOvlB66zhJV9ltbT0Hsmgy//lnOY2tsFn/vkBZbrY34TXuY0tFQw97aOaC
         vt1IhmX621lo5CYdncAzQLDCf8TF0gSre0OvyJGQrs7tPqFzUDMru3zhO/T9mcxLZGiA
         z5MtSaG5SewWcga3wR7ad1zWUuTXlA1k00hC8=
Received: by 10.231.187.194 with SMTP id cx2mr6966192ibb.165.1286117676126;
        Sun, 03 Oct 2010 07:54:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g31sm3784249ibh.22.2010.10.03.07.54.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 07:54:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286082644-31595-17-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157878>

Elijah Newren wrote:

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -268,6 +268,10 @@ remove_cr () {
>  	tr '\015' Q | sed -e 's/Q$//'
>  }
>  
> +portable_unset () {
> +	unset $* || true
> +}

I think this should read

	portable_unset () {
		unset "$@"
		return 0
	}

(or || true).  That is, if I try

	portable_unset "foo bar"

then on platforms where an envvar named "foo bar" is allowed,
this should unset it, no?

Also, maybe a comment could guide people in using this:

	# In some bourne shell implementations, the "unset" builtin
	# returns nonzero status when a variable to be unset was not
	# set in the first place.
	#
	# Use portable_unset when that should not be considered an
	# error.

An update to t/README would be nice, too. :)
