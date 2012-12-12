From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 10:29:54 -0800
Message-ID: <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:30:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tir4S-0007hY-JV
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 19:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab2LLS36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 13:29:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab2LLS35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 13:29:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48C22ACDB;
	Wed, 12 Dec 2012 13:29:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CPtgPb7wMMlDzozqw+/GMq+ZdJ4=; b=kcXukk
	bLJG3BocXHasOXEOYmKkvs7Bfd1RFd6sn4xD1MxGyJXDNxBu9I2TILSJtnNIMfp/
	QYodLIgeAIwSPwvzZ3z5iGeZUOG6HtKjy0kB8E1hiJ7akHmYYY5nmG1ruGE5bpW5
	qwFReCBpT/bZUY5HyYxTk9Vg4XSDvpQOUDHO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMANGG6kqvMu/w6wHBdSfi0KKmLfMuCc
	5phRdTXvqDmHegB/vOM5Xy6AJ/4iP4GwAlyCCC+yEtI6BH36r4MHEK16n2yvjGAg
	zJHC0Yk7WMz1bvFKb42IImuji5szAngRPDJmBwLRs4tIXA4q8cpafIB/BVfzDjoj
	zeEEcGzcgo4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35623ACD9;
	Wed, 12 Dec 2012 13:29:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EDE5ACD8; Wed, 12 Dec 2012
 13:29:56 -0500 (EST)
In-Reply-To: <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com> (Kevin's
 message of "Wed, 12 Dec 2012 16:03:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDD555E4-4489-11E2-962E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211380>

Kevin <ikke@ikke.info> writes:

> Regularly I notice that the diffs that are provided (through diff, or
> add -p) tend to disconnect changes that belong to each other and
> report lines being changed that are not changed.
>
> An example for this is:
>
>      /**
> +     * Default parent
> +     *
> +     * @var int
> +     * @access protected
> +     * @index
> +     */
> +    protected $defaultParent;
> +
> +    /**
>
> I understand this is a valid view of what is changed, but not a very
> logical view from the point of the user.
>
> I wondered if there is a way to improve this, or would that have other
> consequences.

I think your example shows a case where the end of the pre-context
matches the end of the added text in the hunk, and it appears it may
produce a better result if you shift the hunk up.  But I think that
works only half the time.  Imagine:

   @@ -K,L +M,N @@
    }
   
   +void new_function(void)
   +{
   +  printf("hello, world.\n");
   +}
   +
    void existing_one(void)
    {
      printf("goodbye, world.\n");

Here the end of the pre-context matches the end of the added lines,
but it will produce worse result if you blindly apply the "shift the
hunk up" trick:

     ... what was before the } we saw in the precontext ...
   +}
   +
   +void new_function(void)
   +{
   +  printf("hello, world.\n");
    }
    
    void existing_one(void)

So I think with s/Regularly/About half the time/, your observation
above is correct.

I think the reason you perceived this as "Regularly" is that you do
not notice nor appreciate it when things go right (half the time),
but you tend to notice and remember only when a wrong side happened
to have been picked (the other half).
