From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 04/16] Modify write functions to prepare for other
 index formats
Date: Sun, 05 Aug 2012 18:34:15 -0700
Message-ID: <7v1ujk3iso.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:34:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCDA-0005E7-EH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab2HFBeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:34:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab2HFBeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:34:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D7608B82;
	Sun,  5 Aug 2012 21:34:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EWUyCZyJgmZVdguG5nPrFSLs/74=; b=ZgoXoS
	g4HfpAGPY/ijTPIc/bw4Fba67TlQdJmnZrHa4Rv+mYAoS1CFv29C7tbJd7bM/h4A
	3LHsr4fRkVcnF8eltKGXKNamUjlHM+1IrYDxfA31Hy9X7qWsh5PzEWtFly10jc89
	GtN+2QnuZ3G28lJpqovpVDN0ytFcv08J3yv50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/LUDwlgLDKHrAvE5YYcEFzSk2An6EiC
	0NanYs/N1XNqsvAlEbvc05Tb7HqdAZAxsJnGXc6ahxizs6wBv2Rk/GFSeIVmArJZ
	NLYvDugE6/IrhRX8IGNXU0+zSgx/Ic7QhyHqcSCwC4HLdSn03hJcoESj62jx/wtQ
	+BLrqTA4gC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 377608B81;
	Sun,  5 Aug 2012 21:34:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A252F8B80; Sun,  5 Aug 2012
 21:34:17 -0400 (EDT)
In-Reply-To: <1344203353-2819-5-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:49:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6883E66-DF66-11E1-8BCE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202944>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> -static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
> +static int ce_write_v2(git_SHA_CTX *context, int fd, void *data, unsigned int len)
>  {

Mild NAK to name this function with any hint that it is for v2 only.
The type of "data" is not "struct ondisk_index_entry_v2" and this is
just a way to stream data to "fd" while hashing, which is similar in
spirit to what csum-file.c "sha1file'"API does.  Perhaps we may want
to update ce_write() interface to build on top of sha1file API?

At this step in the series, is it too early to split read-cache.c
into two files, move all the v2 specific part to read-cache-v2.c,
and keep static function names like write_index_ext_header() as they
are?  After all, the main dispatch would become

> +int write_index(struct index_state *istate, int newfd)
> +{
> +	if (!istate->version)
> +		istate->version = INDEX_FORMAT_DEFAULT;
> +
> +	return write_index_v2(istate, newfd);
> +}

so read-cache-v2.c would need to export write_index_v2() but the
functions to implement it like ce_write_entry() do not have to be
exposed outside the file, no?
