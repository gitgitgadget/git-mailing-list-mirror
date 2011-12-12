From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 20/51] repack_without_ref(): reimplement using
 do_for_each_ref_in_array()
Date: Mon, 12 Dec 2011 14:44:08 -0800
Message-ID: <7vk461xq4n.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-21-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Dec 13 01:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGO2-00016R-2Y
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab1LMAiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:38:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410Ab1LMAiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:38:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C96799A;
	Mon, 12 Dec 2011 19:38:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=7+fNhmUDj7X/qQ/tf3WNt35YD8c=; b=RrjLNjlS+doeVjUPFkh4
	XFec+ERVFugOopbwwLjJi+1xJoj3I/6a+ESmWKOPfY7/qqWIX1/QJE/ROfynqFIn
	kEUwwhFJfHaAKIQ+LblQTYVQrvqhgjeez0H4e1GRnGCfwwfyyC2Aj2HY/2HYsAHG
	/u1U5xaagYO0iBY5AY6wlt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=JuQf9EDiCqnPKOMvHhErDvmKEKROLIqn89AiqPL4GXb0ud
	9Tgs4v/DmhygYCgphOhyJ272lbdg/OAzNMaFoMV1scYAI3Wdnm1aj+4ispx0P7et
	paBEF8LX1LQMzngg2dkmsEdPdYjV0RWuansLdiO/Soui3H8A41SJsihwadMrM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 200177999;
	Mon, 12 Dec 2011 19:38:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B4497998; Mon, 12 Dec 2011
 19:38:17 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFDFCD7C-2522-11E1-9467-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186984>

mhagger@alum.mit.edu writes:

> +static int repack_without_ref_fn(const char *refname, const unsigned char *sha1,
> +				 int flags, void *cb_data)
> +{
> +	struct repack_without_ref_sb *data = cb_data;
> +	char line[PATH_MAX + 100];
> +	int len;
> +
> +	if (!strcmp(data->refname, refname))
> +		return 0;
> +	len = snprintf(line, sizeof(line), "%s %s\n",
> +		       sha1_to_hex(sha1), refname);
> +	/* this should not happen but just being defensive */
> +	if (len > sizeof(line))
> +		die("too long a refname '%s'", refname);

Perhaps strbuf would be easier to use for things like this.
