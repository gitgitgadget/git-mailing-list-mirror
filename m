From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Tue, 27 Oct 2015 15:41:33 -0700
Message-ID: <xmqqwpu8lysi.fsf@gitster.mtv.corp.google.com>
References: <1445981088-6285-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 23:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrCw0-0001XR-MF
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 23:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbbJ0Wlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 18:41:36 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752063AbbJ0Wlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 18:41:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 579A825BD2;
	Tue, 27 Oct 2015 18:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yzETOnP7R9xmzb2l/0DYNE55Erk=; b=LUUODJ
	uhSipCDNBSJsrrv7T/LIHNVY0wlaQ+E/5kwiU5rFo23vGTpf95Zsnl+HDfajW33V
	9iI0ABx47muVZK6cU41Ab13P0J96KMqzKP8+ZMJQVXJd7iUzzk0uT86X9IczTcVY
	yC4bir8usNmPiQyCCGcYylcCr2kAPWz/2jAo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w/gC5d9Gcaszs2FPDlGqTa3J/+/vFS7l
	IyL8bOHL05iT8omCZu/wO6bJNalgKxS54iEZHyVpyi86sWbReQ+HGbnu08NAqIFb
	zqGINYeb2hb/Ps7l9Gx0WGUd+rWqTTYLxuwMrdGFjp3dKhLHpQ24LHYOW0oPlOZz
	/bT8H1Ku3bs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FBC825BD0;
	Tue, 27 Oct 2015 18:41:35 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BFD7025BCF;
	Tue, 27 Oct 2015 18:41:34 -0400 (EDT)
In-Reply-To: <1445981088-6285-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Tue, 27 Oct 2015 14:24:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E06EFACE-7CFB-11E5-98E8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280310>

David Aguilar <davvid@gmail.com> writes:

> -	if (! -f "$workdir/$file") {
> -		return (0, $null_sha1);
> +	my $workfile = "$workdir/$file";
> +	if (-f $workfile && ! -l $workfile) {

I still don't know if return (0, $null) is the right thing to do,
but in any case, I find the original flow easier to read, i.e. "we
notice a few cases we cannot do the main 'hash-object' thing this
function is meant to do and return early".  I.e.

	if (-l "$workdir/$file" || ! -f _) {
        	return (0, $null_sha1);
	}
	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
	return ($use, $wt_sha1);
