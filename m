From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Sun, 06 Feb 2011 18:09:11 -0800
Message-ID: <7v62swwq7s.fsf@alter.siamese.dyndns.org>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 03:09:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmGXu-00014r-SA
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 03:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab1BGCJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 21:09:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab1BGCJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 21:09:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 21A0C4FF1;
	Sun,  6 Feb 2011 21:10:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xV89e/g07k3vpsiCdqdiO+0520k=; b=rvERWj
	2jUBrkYSOKh2S3bF4gi+MHk0fUDPUE6hdSLsvp7SwsH6JG2Z2aBnS4E7o84/HHfl
	bmZgziAcqFwoDDQpS/VpqT1dhUYqt653PIFk/mwJIiUXxkCEbhXuHgOHTbuCom+W
	Ixp7wGQSlOUJ7inqr4N8XIVn4AS5u9hn2J//g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MR7ARTJTm2SGJuYJ8ZEgEm/SKmfqqKPH
	C6jQqMrw/+ig9l06tmLAfM2gPXVq0GWuyW4o8GfVYnMx/hfeIqKb2XSLbKbB4nC9
	/ovt5eUVE2GtEQ0r4T5Aczdk0z2q2t7USVb38AwIENnotnOZvBi4g4FSK1l/LZBF
	GffkM6Vgv6c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A76B84FEF;
	Sun,  6 Feb 2011 21:10:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31B244FED; Sun,  6 Feb 2011
 21:10:09 -0500 (EST)
In-Reply-To: <1296914835-808-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Sat\,  5 Feb
 2011 21\:07\:15 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A35CBF8-325F-11E0-90CC-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166221>

> diff --git a/cache-tree.c b/cache-tree.c
> index f755590..03732ad 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -621,9 +621,18 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
>  			struct tree *subtree = lookup_tree(entry.sha1);
>  			if (!subtree->object.parsed)
>  				parse_tree(subtree);
> +			if (!hashcmp(entry.sha1, (unsigned char *)EMPTY_TREE_SHA1_BIN)) {
> +				warning("empty tree detected! Will be removed in new commits");
> +				cnt = -1;
> +				break;
> +			}

You shouldn't need the cast (if you did, then hashcmp() macro should be
fixed so that you don't need to).

I don't think warning() is warranted for an operation you introduced to
keep the internal data structure consistent.

Should this comparison done after we parsed the subtree, or should we be
doing that before it?

If you are adding this new check to a point where we have already parsed
the subtree object, don't you have a better and cheaper way to detect if
the subtree is empty than the 20-byte comparision, namely, perhaps by
looking at subtree->size?
