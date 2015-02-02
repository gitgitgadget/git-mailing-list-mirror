From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] sha1_file: fix iterating loose alternate objects
Date: Mon, 02 Feb 2015 12:00:17 -0800
Message-ID: <xmqqk300t772.fsf@gitster.dls.corp.google.com>
References: <4727F1DC-2FC3-49BE-8C6D-0C4D7D8B107C@jonathonmah.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathon Mah <me@jonathonmah.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:00:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINAj-000377-N6
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbbBBUAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:00:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933316AbbBBUAc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:00:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2390F33EC5;
	Mon,  2 Feb 2015 15:00:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KEE6Vb/Zd610uLlSxvRisiJ9fp0=; b=aT7BH2
	akL0z+/DtNKNs7xQwA2JxkF4scy5qlglW3OXh0Vp4tAdd/01bRNIgsoG36EOdGRL
	ouPJrXTBzE2w74rsBwKKkvcc6YyV0A8ZIvUqqlCN3Q4okbrtpI8PmHHgR3ZKx+w6
	/TTIqMHhxCePQbVEvXMXfrPM+uy0PJlynCjeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mKwIBM1NYJZrmk7EWfc5S4mXCeos2u+u
	c52MRJkZ8f2xUdo2ylROjlGrDwrvgaYNsM01J16Jhj/dnroulqIPqtlx4RF/T+HO
	lTk2u+GkHokiAGnZCgqKqFpObjLo0E6rTRQIF2ALWYwk1vMOWQNrITR9Sogyc8Cn
	DM1Vc8xQlcY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A0C133EC4;
	Mon,  2 Feb 2015 15:00:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84A0533EAA;
	Mon,  2 Feb 2015 15:00:18 -0500 (EST)
In-Reply-To: <4727F1DC-2FC3-49BE-8C6D-0C4D7D8B107C@jonathonmah.com> (Jonathon
	Mah's message of "Mon, 2 Feb 2015 10:48:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C9B4204-AB16-11E4-8F3E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263280>

Jonathon Mah <me@jonathonmah.com> writes:

> +test_expect_success 'prune: handle alternate object database' '
> +	test_create_repo A &&
> +		(cd A &&
> +		echo "Hello World" >file1 &&
> +		git add file1 &&
> +		git commit -m "Initial commit" file1) &&
> +	git clone -s A B &&
> +		(cd B &&
> +		echo "foo bar" >file2 &&
> +		git add file2 &&
> +		git commit -m "next commit" file2 &&
> +		git prune)
> +'

The issue does not have much to do with introducing new path to the
cloned repository, or the original having any specific content for
that matter, so I am tempted to simplify the above to something like
this intead:

	test_create_repo A &&
	git -C A commit --allow-empty -m "initial commit" &&
	git clone --shared A B &&
	git -C B commit --allow-empty -m "next commit" &&
	git -C B prune

Thanks.
