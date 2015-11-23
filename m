From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 18:08:30 -0800
Message-ID: <xmqq610to4bl.fsf@gitster.mtv.corp.google.com>
References: <1448208133-29430-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, max@max630.net
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 03:08:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0gYj-0005Th-MS
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 03:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbbKWCIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 21:08:39 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752916AbbKWCIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 21:08:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 603C92E382;
	Sun, 22 Nov 2015 21:08:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H0CaaqEj+rye5qNASP+vEdvIYaY=; b=ZQoz3k
	eDGuFkATGELF3lIy7iNd/w1O/gOos0doMXeE4fcFUxfF+0144ErecBMGetRxBLZF
	vMwpdXWTKu7wjoK5P7L2YF3xzjGtkqar7cY5zy98sTBKhXdL79wZREkaAM3juWmG
	j+0Ar4rdYx+phuRGAMJQEUye/FAgNvEzOzofs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yto8Gcsy50zAK40tiPIvjgSqu5+IEV/G
	Y3eOdXM8S1uMywsGjdxnDcNZwUYooWi4tw8cSPH9y90JPyAHOfJpGojpS3VSHu4G
	QE6yxAB/6NCy47pSF8F2OoORbPQ4XauTaIThHuO/ZMNjSAZY0Mj6Ep501sRDXtF+
	mTh+UFaAT+g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57B8A2E381;
	Sun, 22 Nov 2015 21:08:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFA112E380;
	Sun, 22 Nov 2015 21:08:31 -0500 (EST)
In-Reply-To: <1448208133-29430-1-git-send-email-eantoranz@gmail.com> (Edmundo
	Carmona Antoranz's message of "Sun, 22 Nov 2015 10:02:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 18477C38-9187-11E5-9105-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281570>

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Will also affect annotate

Is that a good thing?  In any case, make it understandable without
the title line (i.e. make it a full sentence, ending with a full
stop).

> +				if (progress) {
> +					for (next = suspect->suspects; next != NULL;
> +					     next = next->next)
> +						blamed_lines += next->num_lines;
> +					display_progress(progress, blamed_lines);
> +				}

Is this math and the placement of the code correct?  It would
probably be more obvious if this hunk is in found_guilty_entry(),
which is already the dedicated function in which we report about a
group of lines whose ultimate origin has become clear.

> @@ -2830,11 +2851,11 @@ parse_done:
>  
>  	read_mailmap(&mailmap, NULL);
>  
> +	assign_blame(&sb, opt);
> +
>  	if (!incremental)
>  		setup_pager();
>  
> -	assign_blame(&sb, opt);
> -
>  	free(final_commit_name);
>  
>  	if (incremental)

Two comments.

 * How does this interact with incremental or porcelain blame?
   Shouldn't progress be turned off when these modes are in use?

 * Shouldn't progress be turned off if the result comes very
   quickly, using start_progress_delay()?
