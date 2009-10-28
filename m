From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix memory leak in transport-helper
Date: Wed, 28 Oct 2009 00:18:51 -0700
Message-ID: <7vocnsrnok.fsf@alter.siamese.dyndns.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
 <20091015185253.6117@nanako3.lavabit.com>
 <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net>
 <20091015154142.GL10505@spearce.org>
 <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
 <20091015204543.GP10505@spearce.org>
 <alpine.LNX.2.00.0910270032170.14365@iabervon.org>
 <alpine.DEB.1.00.0910271510430.4985@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0910271329510.14365@iabervon.org>
 <alpine.DEB.1.00.0910271954020.11562@felix-maschine>
 <alpine.LNX.2.00.0910271456410.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:19:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32oS-0008Ey-Nh
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbZJ1HTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbZJ1HTH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:19:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547AbZJ1HTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:19:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19A2588202;
	Wed, 28 Oct 2009 03:19:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=P2hlmdbcc7h+rFgeHzpfsbcIzxY=; b=NVb1sQe7Wb3JWHqPs/uf1cf
	Pri5brcVl3s8HT/IRKz2w5enTkwhP013DXNqQY+ABWvOAt2Ie48GM2DaTQT4cKUd
	OjO/taWaF8IANpAlff7xpsnQpDlabBDXjhjnonAwQsQUYRDUYUxmTbVRP7IHH/tS
	6EHPw7iwoobGLJo1w68k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hlunng8vMsdpbDcENRu+CtEzMic+d3nZKp13cc8juCBZPa/rN
	PoGUzFxGRZPMn47o+Acaz36Ykht7dHEbOKXsWXaWAepd7N+HidPteIfRUUWRSroz
	BSBjWw/M8Lzn3riCFy91dZt4Z0VcPipACiGi03qAF7AdTg3iqvHUysSNPk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B131D881FF;
	Wed, 28 Oct 2009 03:19:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 29F66881F8; Wed, 28 Oct 2009
 03:18:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BE5EE6A-C392-11DE-8794-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131424>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 27 Oct 2009, Johannes Schindelin wrote:
>
>> So you mean to imply that this method is not about closing, but about 
>> releasing the structure.  Right?
>
> Yes, that's the word I was failing to come up with last night, thanks.
> Junio, "s/close/release/g" on that patch should improve comprehensibility 
> greatly. (And changing the transport method name would probably also 
> improve matters)

Thanks, both.
