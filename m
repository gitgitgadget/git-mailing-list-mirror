From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A note on modern git plus ancient meld ("wrong number of
 arguments")
Date: Fri, 10 Feb 2012 13:28:55 -0800
Message-ID: <7vwr7unzs8.fsf@alter.siamese.dyndns.org>
References: <20120209191742.GA20703@unpythonic.net>
 <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
 <20120210082106.GA7871@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:29:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvy1f-0004wt-OK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923Ab2BJV27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 16:28:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236Ab2BJV26 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:28:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFA127F09;
	Fri, 10 Feb 2012 16:28:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ALgrAcbNmebiXNpNLSDmijxA16o=; b=IeQiHa
	qarOqGV33+Ms0rr56tp8Y2/f9Y1irs3JJlYDgX/i3PRDVPPUcTiX8fPLvKARIM0n
	TE/x5P4UomrDJLy7wV6cvWda5DC8YaZ8JoZqpFTNRq4TYOrcySI8CkWYtheAwkjy
	sj7sg/XdmVKTigBmx/cN/JCXn0oxgkv8kuRF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=peZBVMIBPl/laAWxwsojrC0llvOEVoKa
	phMat2yFITofP89N6t7R23CXxBYiEO1ipVvXpWvj2R6irVkb4tkeycRp1H4+6dD5
	1u7bFNkf9BikcIgj/dWTpdtZbG7w6DaPC69nAnZJLhmtTV1fl3kNoS9CuTKrD1I2
	1fQAMDI82rQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C67B27F08;
	Fri, 10 Feb 2012 16:28:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D9277F07; Fri, 10 Feb 2012
 16:28:57 -0500 (EST)
In-Reply-To: <20120210082106.GA7871@burratino> (Jonathan Nieder's message of
 "Fri, 10 Feb 2012 02:23:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D684C76-542E-11E1-9087-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190457>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Just parse version numbers instead.  We can detect the version number
> by running "meld --version" and postprocessing it.

Hmm. I am debating myself if it may be more efficient, less error prone
and simpler for the users if we gave them "mergetool.meld.useOutput"
configuration option to tweak.

When an older meld fails when given --output for real (not with the dry
run current code tries with --help), can we sanely detect that particular
failure?  If we can do so, another possibility may be to do something like
this:

merge_cmd () {
	meld_has_output_option=$(git config --bool mergetool.meld.useOutput)
	case "$meld_has_output_option" in
        false)
		... do the non-output thing ...
		;;
	true)
		"$merge_tool_path" --output "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
		;;
	*)
		"$merge_tool_path" --output "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
		if it failed due to missing --output support?
		then
			meld_has_output_option=no
                        git config mergetool.meld.useOutput false
			merge_cmd
		fi
                ;;
	esac
}
