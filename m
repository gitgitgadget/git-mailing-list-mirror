From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/2] submodule: preserve all arguments exactly when
 recursing
Date: Wed, 3 Nov 2010 00:28:37 -0500
Message-ID: <20101103052837.GB10631@burratino>
References: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
 <1288760740-10075-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:29:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDVuH-0004jL-5n
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab0KCF3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:29:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34973 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab0KCF3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 01:29:01 -0400
Received: by ywc21 with SMTP id 21so205779ywc.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EXaJyrDi7E80bqxBYG5pLF5WOCfA2JzkoPu2nQZCW/E=;
        b=IvU4jUqtqsENOv5n3fRiIdcfqw1S5lt1e8UqgRvZrpdM7zJMHAcM5HEIbkpIdaCNnf
         4JBo1dSBGEQIM+uc6Iu3D7mrEHWHW74a+tHV0QSZe9KoFNdevCVR0R2uSQeV0EUasr8t
         +gVGoQhtdozL+4V+PqnvO9IKojho86V3efvDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SVficmrg9Pu+iNkG3fdBuLa5ULI3N0ISdCRUQbnRJZa9iUXfvgatErghM4R3QQ5eKZ
         fvXRC6Pb8w90HYJcnJO18+wbSzuhbjTU2rj5THqXVUslhgTr64tOpfU+5ejS9zIefbtO
         edbO9g7CIM/aQE+NzN8LRFUy/TkuWu3REadr0=
Received: by 10.151.41.21 with SMTP id t21mr534528ybj.158.1288762141228;
        Tue, 02 Nov 2010 22:29:01 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j26sm973340yha.36.2010.11.02.22.28.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:28:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288760740-10075-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160579>

Kevin Ballard wrote:

> When performing a recursive status or update, any argments with whitespace
> would be split along that whitespace when passed to the recursive invocation
> of the update or status command.
> 
> This is caused by the special handling that sh provides to the $@ variable.
> Status and update stored "$@" into a separate variable, and passed that
> variable to the recursive invocation. Unfortunately, the special handling
> afforded to $@ isn't given to this new variable, and word-breaking occurs
> along whitespace boundaries.
> 
> We can use $(git rev-parse --sq-quote "$@") to produce a string containing
> a quoted version of all given args, suitable for passing to eval. We then
> recurse using something like `eval cmd_status "$orig_args"` instead of the
> former `cmd_status $orig_args`. This preserves all arguments exactly as
> given to the initial invocation of the command.

Probably it is because it is late hear, but I find myself intimidated
by the block of explanatory text.  Maybe an example like

	Environment variables only hold strings, not lists of parameters,
	so $orig_args after

		orig_args="$@"

	fails to remember where each parameter starts and ends, if
	some include whitespace.  So

		git submodule update \
			--reference='/var/lib/common objects.git' \
			--recursive

	becomes

		git submodule update --reference=/var/lib/common \
			objects.git --recursive

	in the inner repositories.  Use "git rev-parse --sq-quote" to
	save parameters in quoted form ready for evaluation by the
	shell, avoiding this problem.

would be simpler?

> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -374,7 +374,7 @@ cmd_init()
>  cmd_update()
>  {
>  	# parse $args after "submodule ... update".
> -	orig_args="$@"
> +	orig_args="$(git rev-parse --sq-quote "$@")"

No quotes are needed around the RHS to an assignment like this.

Anyway,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
