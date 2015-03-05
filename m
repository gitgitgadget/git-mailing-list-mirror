From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Thu, 05 Mar 2015 14:08:24 -0800
Message-ID: <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
References: <54F88684.3020905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTdwW-0005Lt-6y
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 23:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbbCEWI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 17:08:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750921AbbCEWI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 17:08:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62A733E647;
	Thu,  5 Mar 2015 17:08:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8gLpFt5uYAdz1MR6nQy2kuhegw=; b=k0mG5c
	VqSTFkuln4P9bmu8fGDXccS/72u7beQRaiZlOiNkKmuagaaMEDuK6N/5S5r74Yd/
	jOmxvdtnL44X1P4gv4gEC9TnMx7BI45LBIDuviPfQUnQfVNvoq+Kt3ZCr+U9x4MR
	42ZpQe34KUNFEasrrIXVPR2v/Bn2GX2TH/fTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nN/bXrVZEZe2ghPDM29jgbST7YkrqO1r
	9fFWIVyNdAK0RDXbN4MAri8kOCWhQkAJWva4zNO8DLb6PJa7nw50ymJAV7dL/DDY
	M5nlOlcEQ5NsoQx1J+UPxKFEeo0xP1dp7SsZK6S87fMmqD2QTjrzrcy63tudqjD1
	fido6IhPrGU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 598BA3E646;
	Thu,  5 Mar 2015 17:08:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC13A3E645;
	Thu,  5 Mar 2015 17:08:25 -0500 (EST)
In-Reply-To: <54F88684.3020905@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 05 Mar 2015 17:38:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 255C4006-C384-11E4-A9B6-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264872>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I would expect that the following .gitattributes file
>
>     *       eol=crlf
>     *.png   -text
>
> would leave EOL translation turned off for PNG files. In other words, I
> would expect that explicitly setting "-text" would take precedence over
> the fact that setting "eol" implies that a file should be considered to
> be "text".
>
> I would even more strongly expect
>
>     *       eol=crlf
>     *.png   binary
>
> to turn off EOL translation for PNG files.
>
> But in fact, in both of the above cases, EOL translation is turned *on*
> for PNG files.
>
> I propose that "-text" should override any setting for "eol" (which
> would of course fix both problems, since "binary" is equivalent to
> "-diff -merge -text"). What do people think?

Hmm, is there really something that needs a new proposal and
opinions?

The way I read the flow in convert.c is:

    convert_to_git() uses input_crlf_action() to figure out what
    crlf_to_git() conversion is necessary.

    input_crlf_action() looks at text_attr and says CRLF_BINARY when
    it is CRLF_BINARY without looking at eol_attr at all.

    text_attr above is ca.crlf_action in convert_to_git().

    The whole ca.* comes from convert_attrs() inspecting attributes
    on the incoming path.

    convert_attrs() inspects "eol" and "text" attributes, among
    others, and sets crlf_action by calling git_path_check_crlf().

    git_path_check_crlf() looks at the 'text' attribute; if it is
    set to false, it returns CRLF_BINARY.

    crlf_to_git() when given crlf_action==CRLF_BINARY is a no-op.

So, with the above attributes where anything is eol=crlf by default
and in addition *.png is binary (which contains -text), we shouldn't
get any crlf munging.  Am I reading/following the code incorrectly?

Puzzled....
