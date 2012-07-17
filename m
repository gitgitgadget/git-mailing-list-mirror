From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add explanatory comment for transport-helpers refs
 mapping.
Date: Tue, 17 Jul 2012 11:04:29 -0500
Message-ID: <20120717160429.GG3071@burratino>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <11883284.WI8IR4K6qp@flobuntu>
 <20120717032725.GC3071@burratino>
 <13702454.DmcNg44yyH@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:04:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrAGQ-0001Zf-EG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 18:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab2GQQEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 12:04:37 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50354 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab2GQQEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 12:04:35 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so535490ggl.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hpNW3O0+JUDEC+ZWDIp4MnCNy8AsW9ZFcum1cJqLIJM=;
        b=u/Fjcm7gWoQ3OVG214K2pHOVO/21kw1W5BRrOItARwe9zGBh7A2p8V1n1Kq8khKMXg
         SK3ckiXNFP6ZH2TpZWsdgzGmppuQy3SlP9nDTdlongghtS9bbvi1mAwSNzK3NrNYutH+
         +6cZOjCBrspk7hk6TbcTm4m7SCFdv75lsnpx2Q6zDMLRRXUkr7ehST7edj6RuctgpPCb
         sH6HxwLB2MvK0IDHIUAyHfH+QL9bqIGR/U5nCSW4bQKSHiHkD5e0TUg/lVyhsFGyX0an
         9Vd816BkUVXk1I4q/1/VH04sfulEtJK9PCOe2CjB2k8aYN6CfQR6DeeZCOQQYDYE0Wcm
         Sqzg==
Received: by 10.42.140.4 with SMTP id i4mr1850743icu.18.1342541074363;
        Tue, 17 Jul 2012 09:04:34 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ay5sm11888749igb.15.2012.07.17.09.04.32
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 09:04:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <13702454.DmcNg44yyH@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201607>

Hi,

Florian Achleitner wrote:

> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -484,8 +484,18 @@ static int fetch_with_import(struct transport *transport,
>  		if (posn->status & REF_STATUS_UPTODATE)
>  			continue;
>  		if (data->refspecs)
> +			/*
> +			 * If the remote-helper advertised the refpec capability, we
> +			 * retrieve the local, private ref from it. The imported data is
> +			 * expected there. (see Documentation/git-remote-helpers.*).
> +			 */
>  			private = apply_refspecs(data->refspecs, data->refspec_nr, posn-
>>name);
>  		else
> +			/*
> +			 * else, the default refspec *:* is implied. The remote-helper has
> +			 * to import the remote heads directly to the local heads.
> +			 * remote-helpers using 'import' should have the refspec capability.
> +			 */
>  			private = xstrdup(posn->name);

What is _exactly_ the information the reader would want to know here?
Looking at this code:

		char *private;
		posn = to_fetch[i];
		if (posn->status & REF_STATUS_UPTODATE)
			continue;
		if (!data->refspecs)
			private = xstrdup(...);
		else
			private = apply_refspecs(...);
		if (!private)
			continue;
		read_ref(private, posn->old_sha1);
		free(private);

Despite the misleading "old_sha1" name, this loop runs after
fast-import has finished, and the values being read into
to_fetch[]::old_sha1 are object names representing the result.

Callers such as builtin/fetch.c then use these values to write
feedback to the terminal, to populate FETCH_HEAD, and to
determine what new value peer_ref should get.

Shouldn't the comment say something about these SHA-1s not actually
being old?  Something like:

	/*
	 * If the remote helper advertised the "refspec" capability,
	 * it will have the written result of the import to the refs
	 * named on the right hand side of the first refspec matching
	 * each ref we were fetching.
	 *
	 * (If no "refspec" capability was specified, for historical
	 * reasons we default to *:*.)
	 *
	 * Store the result in to_fetch[i].old_sha1.  Callers such
	 * as "git fetch" can use the value to write feedback to the
	 * terminal, populate FETCH_HEAD, and determine what new value
	 * should be written to peer_ref if the update is a
	 * fast-forward or this is a forced update.
	 */
	for (i = 0; ...

Hmm?
Jonathan
