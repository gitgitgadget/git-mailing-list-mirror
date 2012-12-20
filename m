From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 21:26:36 -0800
Message-ID: <7va9t970qb.fsf@alter.siamese.dyndns.org>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
 <20121220031327.GB9917@sigill.intra.peff.net>
 <7vehil7557.fsf@alter.siamese.dyndns.org>
 <20121220035543.GA14965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 06:27:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlYeo-00048i-Hu
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 06:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab2LTF0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 00:26:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab2LTF0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 00:26:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F5BAAA5A;
	Thu, 20 Dec 2012 00:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GQ1snlYhWqAJ9oiyZeLuqqNnytM=; b=akvDC5
	AEmAtpxckE/urvAFwu0f9q28YIDyk3t0iutcyzxZ75NnzLihUqfWMNtuEYqIt9fR
	hOOb/9XlXcX2T374oPjn3ky3eGOtDTrt3n/5Ya0BNar0yLfHVgDCQdjGJUiJN+34
	K+mT2rA7DPhSrxy2iEHSRpXsNFbxgoJPhw2ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zigv3QsoCVmwy8fJuUvdcozTwNabBgqr
	AySzQ5iofnILl4Z1jOm8GXu3CsWP2qo5Kbbmo4FR4IR+lsAeichifC2i6FGo2Xjy
	dt+AfUumvdpPT2A7cCK33D28bOvrcEN1UViM/C/kJCldIbQhulEXZ3yw9lGDP4ae
	6JcY0VGlM6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CD57AA57;
	Thu, 20 Dec 2012 00:26:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAAB1AA52; Thu, 20 Dec 2012
 00:26:37 -0500 (EST)
In-Reply-To: <20121220035543.GA14965@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Dec 2012 22:55:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3BC8CAE-4A65-11E2-A0C2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211881>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 19, 2012 at 07:51:16PM -0800, Junio C Hamano wrote:
>
>> > ++		if (limit_pathspec_to_literal())
>> > ++			item->nowildcard_len = item->len;
>> > ++		else {
>> > ++			item->nowildcard_len = simple_length(path);
>> > ++			if (item->nowildcard_len < item->len) {
>> > ++				pathspec->has_wildcard = 1;
>> > ++				if (path[item->nowildcard_len] == '*' &&
>> > ++				    no_wildcard(path + item->nowildcard_len + 1))
>> > ++					item->flags |= PATHSPEC_ONESTAR;
>> > ++			}
>> >  +		}
>> 
>> Hmph.  I thought that returning the length without any "stop at glob
>> special" trick from simple_length() would be a simpler resolution.
>> 
>> That is what is queued at the tip of 'pu', anyway.
>
> I don't think we can make a change in simple_length. It gets used not
> only for pathspecs, but also for parsing exclude patterns, which I do
> not think should be affected by this option.

Ouch, yeah, you're right.
