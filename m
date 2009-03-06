From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Keep '*' in pattern refspecs
Date: Fri, 06 Mar 2009 00:18:44 -0800
Message-ID: <7vsklrt66z.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903052355480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfVI0-0001xR-Jq
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbZCFISw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 03:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbZCFISw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:18:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbZCFISv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 03:18:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 841543F0C;
	Fri,  6 Mar 2009 03:18:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E239E3F0B; Fri, 
 6 Mar 2009 03:18:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BBE1942-0A27-11DE-89D4-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112403>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In order to do anything more capable with refspecs, the first step is
> to keep the entire input. Additionally, validate patterns by checking
> for the ref matching the rules for a pattern as given by
> check_ref_format(). This requires a slight change to make it require
> the '*' to be at the beginning of a path component.

I had a brief "Huh?" moment wondering about this "slight change", but at
this stage it does not change the rule at all ("/*" still must happen at
the end of the string), so there actually is no change.

> diff --git a/remote.c b/remote.c
> index 93fd03d..d0ce4c6 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -722,10 +716,10 @@ int remote_has_url(struct remote *remote, const char *url)
>  static int name_fits_pattern(const char *key, const char *name,
>  			     const char *value, char **result)
>  {
> -	size_t klen = strlen(key);
> -	int ret = !strncmp(key, name, klen);
> +	size_t klen = strchr(key, '*') - key;
> +	int ret = !strncmp(name, key, klen);

Any particular reason why the first parameters to strncmp() were swapped?

>  	if (ret && value) {
> -		size_t vlen = strlen(value);
> +		size_t vlen = strchr(value, '*') - value;

We would want protection from programming error here, to catch keys and
values without any asterisk.  This comment also applies to [5/5].

>  		*result = xmalloc(vlen +
>  				  strlen(name) -
>  				  klen + 1);
