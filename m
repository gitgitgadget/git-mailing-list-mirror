From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6 (v2)] administrative functions for rev-cache, and
 start of integration into git
Date: Sun, 09 Aug 2009 11:36:50 -0700
Message-ID: <7vtz0g7s1p.fsf@alter.siamese.dyndns.org>
References: <op.uyb1vcvytdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Andreas Ericsson" <exon@op5.se>,
	"Christian Couder" <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Nick Edelen" <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:37:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaDGc-0005eZ-J2
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbZHIShF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbZHIShF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:37:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZHIShD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 14:37:03 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1779C41DB;
	Sun,  9 Aug 2009 14:37:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58E9341CD; Sun,  9 Aug
 2009 14:36:52 -0400 (EDT)
In-Reply-To: <op.uyb1vcvytdk399@sirnot.private> (Nick Edelen's message of
 "Sat\, 08 Aug 2009 09\:31\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A23E3F76-8513-11DE-B463-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125363>

"Nick Edelen" <sirnot@gmail.com> writes:

Note that I didn't read the entire patch, so the parts I did not comment
on in this message may or may not have problematic parts.

>  - extra 'size' field added to commit, tag and blob objects, initialized in 
>    parse_* functions and cache traversal

It is unclear which "size" this field refers to without comment.

I do not know if this change is justifiable.  We (mostly Linus) spent
considerble effort to shrink the memory footprint of struct commit (and
struct object in general) exactly because revision traversal needs to
inspect tons of them.

> +static unsigned int parse_size(const char *name)
> +{
> +	unsigned int size;
> +	char *p;
> +	
> +	size = strtol(name, &p, 10);
> +	switch (*p) {
> +	case 'k' : 
> +	case 'K' : 
> +		size *= 0x400;
> +		break;
> +	case 'm' : 
> +	case 'M' : 
> +		size *= 0x100000;
> +		break;
> +	default : 
> +		break;
> +	}
> +	
> +	return size;
> +}

Looks vaguely familiar.

The configuration parser already knows about these size suffixes when told
to read "int".  Can't that code, e.g. git_parse_ulong(), be reused here?

> @@ -219,7 +221,6 @@ unsigned char *get_cache_slice(struct commit *commit)
>  		return 0;
>  	
>  	ie = search_index(commit->object.sha1);
> -	
>  	if (ie && ie->cache_index < idx_head.cache_nr)
>  		return idx_caches + ie->cache_index * 20;

"Oops, fix an earlier mistake"...

> @@ -262,7 +282,6 @@ static int setup_traversal(struct cache_slice_header *head, unsigned char *map,
>  	struct commit_list *prev, *wp, **wpp;
>  	int retval;
>  	
> -	/* printf("adding %s\n", sha1_to_hex(commit->object.sha1)); */

Likewise.
