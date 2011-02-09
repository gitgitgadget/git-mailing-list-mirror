From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] correct type of EMPTY_TREE_SHA1_BIN
Date: Wed, 09 Feb 2011 15:33:49 -0800
Message-ID: <7vwrl8n5pe.fsf@alter.siamese.dyndns.org>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <7v62swwq7s.fsf@alter.siamese.dyndns.org> <20110207081727.GB2736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 00:34:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnJY5-0000iC-Bo
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 00:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab1BIXeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 18:34:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab1BIXeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 18:34:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 563E74F75;
	Wed,  9 Feb 2011 18:35:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfNFGCxCQ+W3mWtbaLkB2LybrG4=; b=W5ZZnJ
	inWx6PZl74354boc5ZEPwDBxTzrXdg/nceZH7fHBY1CIhBNILAZfYQhCCiP0mb4n
	meobRvqOxms+3KelwpmWIL4TWF+3mincoIlgvieDRUbNWYB+2bJBLLAAjgERiOPj
	FUNdSDfPSrWxtHRkREqypQIyuJAz/+hOJLE5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HftrwvZFqPvQdANPfFIN+vS1WXSIqEJU
	lf7suqMyytiOA/RP2jv55oER1c9y8KYXdpO+8LzGJZ9GHNU+Qu2k+fk/iD+3AO/G
	44qWY2dEeek7nb0D0+W2b1DNbWYSlu/Yr5CiDni2E2V3RHryDRkJVQdbdw/8dorH
	n/e85nfFWC0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2C654F6F;
	Wed,  9 Feb 2011 18:34:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E21194F6E; Wed,  9 Feb 2011
 18:34:50 -0500 (EST)
In-Reply-To: <20110207081727.GB2736@elie> (Jonathan Nieder's message of
 "Mon\, 7 Feb 2011 02\:17\:27 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35D0EAF8-34A5-11E0-9C38-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166456>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>> --- a/cache-tree.c
>>> +++ b/cache-tree.c
>>> @@ -621,9 +621,18 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
>>>  			struct tree *subtree = lookup_tree(entry.sha1);
>>>  			if (!subtree->object.parsed)
>>>  				parse_tree(subtree);
>>> +			if (!hashcmp(entry.sha1, (unsigned char *)EMPTY_TREE_SHA1_BIN)) {
>>> +				warning("empty tree detected! Will be removed in new commits");
>>> +				cnt = -1;
>>> +				break;
>>> +			}
>>
>> You shouldn't need the cast (if you did, then hashcmp() macro should be
>> fixed so that you don't need to).
>
> Isn't this a bug in the definition of EMPTY_TREE_SHA1_BIN rather than
> the signature of hashcmp?

Yeah, you are right.
