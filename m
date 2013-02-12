From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 14:45:34 -0800
Message-ID: <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Oc0-0002y3-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab3BLWpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:45:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423Ab3BLWpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:45:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BA86C051;
	Tue, 12 Feb 2013 17:45:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vqzqs4iVLVs/gUj2QhJtN+FWiwY=; b=QXUoTb
	VHsDuMFwY6CfCma2gCpAWceOwCmZ23UsVWeLAppukcmFhlESN0dw1hMw3fGM4a47
	OGCcPmwjp2Hu+ylWTW3WQHWnuh80+s7W7oJNKv4IVWPfXHc7hiclVaY5OVAIzq6d
	MmPgsQypn5Fek2a62EauAUeU/CNuOapJ6/nWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TvoQ8Zf+Kh8F/rMPg83UAqFbZYgggSC4
	9/EOQzexEjaBwcTi0Wp/YOTnMAOdzVLJ8WushmfwnTBKA5sjx4XZX5P7BUCpRwyu
	4lyeTThtuGF2R0mAydxVjkT44DPnRTZMxFENqD2YFlpkAcEdzGI1/vF792iixiCV
	oqNIFjJpLhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C12DC050;
	Tue, 12 Feb 2013 17:45:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB6C5C04A; Tue, 12 Feb 2013
 17:45:36 -0500 (EST)
In-Reply-To: <20130212222508.GG12240@google.com> (Jonathan Nieder's message
 of "Tue, 12 Feb 2013 14:25:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB018218-7565-11E2-8E4C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216212>

Jonathan Nieder <jrnieder@gmail.com> writes:

> John Keeping wrote:
>
>>   Documentation/Makefile: fix inherited {html,info,man}dir
>
> This doesn't seem to have hit the list.

More importantly, 

>> When using the top-level install-doc target the html, info and man
>> target directories are inherited from the top-level Makefile by the
>> documentation Makefile as relative paths, which is not expected and
>> results in the files being installed in an unexpected location.

I am not sure what problem it is trying to address.  During every
cycle "make doc && make install-man install-html" is run for all
integration branches and it didn't cause any problems.

A wild guess.  John, are you using config.mak.autogen?

I _think_ exporting mandir/html/infodir from the top-level Makefile
is wrong to begin with.  We should drop the "export mandir" from
there.

Giving them unusual meaning (e.g. "mandir = share/man") is already
bad and that needs to be fixed by limiting this "oh, on some
platforms we compile-in GIT_MAN_PATH as a relative path to an
unspecified place" insanity only to where -DGIT_MAN_PATH=<path> is
defined.  The path used there does not help the building and
installation of the documentation at all, so the variable used for
the purpose of giving that <path> should not be named the same way
as the variable used on Documentation/Makefile to name the real path
in the first place.

Perhaps rename these to runtime_{man,html,info}dir or something and
make sure {man,html,info}dir are defined as the real paths whose
default values begin with $(prefix)?
