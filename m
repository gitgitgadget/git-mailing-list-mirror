From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ident: check /etc/mailname if email is unknown
Date: Mon, 03 Oct 2011 12:15:37 -0700
Message-ID: <7vpqidga3q.fsf@alter.siamese.dyndns.org>
References: <20111003045745.GA17604@elie>
 <7v8vp2iqvc.fsf@alter.siamese.dyndns.org> <20111003061633.GB17289@elie>
 <4E895FBD.8020904@viscovery.net>
 <20105.40257.351258.425389@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:15:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnzM-0003Hp-I9
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab1JCTPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:15:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509Ab1JCTPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:15:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D5AB53B4;
	Mon,  3 Oct 2011 15:15:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mrn+HE5dH9pjmbjnKoU6+XyGwx0=; b=nW0KEF
	qhvwIaqP00+Nd/4KzDeFRZ/ze82vIqK3bWMZvR8TYkpTna3IVmnNFgcDTDILhzUc
	Gzp9zlYcZZ2+EzOY5TBz2i8/woUiYDs+GP1/CgGvfftRmzFiv82qllTPxkTeZ75U
	4SSdfG/g268vBVt/B5YFUdOI8NIMlXZSuz+gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HNp47+djjWS6ekNnbZKsjGyUW1DR8KEz
	mcJcT2YnYfnknlICzNH6yGGn/PSP0G/S14TJlEvvpto8d2YJcvFZwxFz9p6tG/T8
	V6eXMreOiT8DdxD9hd+A0b7NQUPKvXph3D0+lX0/E4QZQmJr6SCNUStTLgdpTIlZ
	VPmyLrHOVgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E2953B3;
	Mon,  3 Oct 2011 15:15:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8159B53B1; Mon,  3 Oct 2011
 15:15:38 -0400 (EDT)
In-Reply-To: <20105.40257.351258.425389@chiark.greenend.org.uk> (Ian
 Jackson's message of "Mon, 3 Oct 2011 12:32:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1412B460-EDF4-11E0-994F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182698>

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

>> > +	if (!mailname) {
>> > +		if (errno != ENOENT)
>> > +			warning("cannot open /etc/mailname: %s",
>> > +				strerror(errno));
>> 
>> This warns on EACCES. Is that OK? (Just asking, I have no opinion.)
>
> I think that's correct.  Personally I'm a bit of an error handling
> fascist and I would have it crash on EACCES but that's probably a bit
> harsh.

It is not just harsh but is outright wrong if the platform is not Debian
and the platform happens to use the file for other purposes that does not
require normal users to be able to read the file.

It _might_ make sense to do

        #ifndef DEBIAN
        #define add_mailname_host(x,y) (-1)
        #else
        static int add_mailname_host(char *buf, size_t len)
        {
                ...
        }
        #endif
