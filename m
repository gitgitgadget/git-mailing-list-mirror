From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 12:41:56 -0700
Message-ID: <xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 20:42:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajXcT-0003XB-FF
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 20:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbcCYTmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 15:42:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753962AbcCYTmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 15:42:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE3AA4F87A;
	Fri, 25 Mar 2016 15:41:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NrM5B11nL12UFiApr/yd/OObLx0=; b=XRf0tP
	eUGrSSjeBGGP/ksQkv9XiwJRd0d+J4t/IYP+f8iyZCveLITyIuQqEGQArLfoTZbk
	rvfBYXvzuBoZ3++D+LyihVN83OCb+GlYDfszfQlBmCViUPPb7FiKMyNpmLsrNj/+
	Bw27LyDJ72QmenlYyTIIMqha2Rj1oJMPnTM28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgeo0s7vhmOpKN5x2Mz4rDxcnXcj14mi
	VO+OyssW9nxDjkeqDfFYkKiIAnZRNuy3n0OpwuInBffK+piTT5dxKmaBwxK6YX9W
	kxsr/TDECir18wjOIEA5xYUPoZQnSIcZzpI1qJnte8pspD9X4+R8+7bPvD7T1xUM
	WAcug0oA7fY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB0964F879;
	Fri, 25 Mar 2016 15:41:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C4DB4F877;
	Fri, 25 Mar 2016 15:41:58 -0400 (EDT)
In-Reply-To: <1458931156-29125-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 25 Mar 2016 11:39:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2FFBC46-F2C1-11E5-B1CF-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289949>

Stefan Beller <sbeller@google.com> writes:

> In the rewrite from shell to C (ee8838d157761, 2015-09-08, submodule:
> rewrite `module_clone` shell function in C), we never made use of the
> prefix. Probably it sneaked in as module_list which was converted in the
> same series had the prefix as well.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Hmph.

This helper is called from the root level of the superproject's
working tree (after cd_to_toplevel is done), and has options like
--url.  If the user named --url with a relative pathname to a local
repository directory (or a bundle file), shouldn't it be adjusted,
and wouldn't prefix the only clue what that given path is relative
to?  Same for --reference repository's path.

I am not sure removing "--prefix=$wt_prefix" without doing "git -C
$wt_prefix" on the calling side is the right thing to do.  Even
though the options list used by this function does not seem to use
OPTION_FILENAME, parse-options API takes prefix exactly because
relative pathnames need to be adjusted, and it smells like that the
breakage brought in by this change is merely hidden by existing bugs
in the code that does not use prefix to adjust relative paths.
