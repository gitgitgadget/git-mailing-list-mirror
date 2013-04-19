From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 10:08:51 -0700
Message-ID: <7vfvym30t8.fsf@alter.siamese.dyndns.org>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTEo1-0001su-0m
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095Ab3DSRI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:08:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab3DSRIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:08:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19E2C17BF1;
	Fri, 19 Apr 2013 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mBfUWgfgFjjo5RsUMFfWq/kySZU=; b=jMF21I
	T3Nuya6A4grXeUB1qxVTxBhskqIiGLcIlagds910O8aBfs2j85WcIhT41GpPg2g6
	elYkxhOuwjGECIILIrFavXFdR9aSoT1WO8bD/mId8hepiDC0Ps6Cd/rBpf1fU8su
	ptp8oySQcN5iPqGW0B3VaixUMDWqC/dvpLCaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T4eViHgn2IpK8NGtRFY5neZXhHzDzBNK
	DPGatMA0LuNtAGrs+BiR1y+ae3dRep41WFaat/11H0CW+35ZwKwpKGnN7qIQNfRb
	pZ5EAOHUVMqA1h6aASZ6kkQO8LV+02YKaagRkNPOrP+CpBkPLQ7s+Oy96RYor8CU
	dvHxFARfRl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EA3F17BF0;
	Fri, 19 Apr 2013 17:08:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F8BC17BEF;
	Fri, 19 Apr 2013 17:08:53 +0000 (UTC)
In-Reply-To: <1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 19 Apr 2013 00:14:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D00EE6C6-A913-11E2-9D4A-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221778>

Felipe Contreras <felipe.contreras@gmail.com> writes:
> The code finds the changes of a commit, runs 'git blame' for each chunk
> to see which other commits are relevant, and then reports the author and
> signers.

In general, I am not all that interested in adding anything new to
contrib/ as git.git has matured enough, but even if this will stay
outside my tree, there are a few interesting things to note to help
its eventual users.

> +    roles = roles.map do |person, role|
> +      address = "%s <%s>" % person
> +      [person, role]
> +    end

Is address being used elsewhere, or is this a remnant from an
earlier debugging or something?

> +    [id, roles]
> +  end
> +
> +end
> ...
> +    File.open(file) do |f|
> +      f.each do |line|
> +        case line
> +        when /^From (\h+) (.+)$/
> +          from = $1
> +        when /^---\s+(\S+)/
> +          source = $1 != '/dev/null' ? $1[2..-1] : nil

This may need to be tightened if you want to use this on a
real-world project (git.git itself does not count ;-); you may see
something like:

    diff --git "a/a\"b" "b/a\"b"

(I did an insane pathname 'a"b' to get the above example, but a more
realistic is a character outside ASCII).

> +        when /^@@\s-(\d+),(\d+)/
> +          get_blame(source, $1, $2, from)

This may want to be a bit more careful for a hunk that adds to an
empty file, which will give you something like

    @@ -0,0 +1 @@
    @@ -0,0 +1,200 @@

Nobody sane would use -U0 when doing a format-patch, but if this
wants to accomodate such a patch as well, it needs to ignore a hunk
that only adds new lines.
