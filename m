From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 09/14] git-clean: use a git-add-interactive compatible UI
Date: Thu, 16 May 2013 12:29:24 -0700
Message-ID: <7vy5be4tbf.fsf@alter.siamese.dyndns.org>
References: <cover.1368696028.git.worldhello.net@gmail.com>
	<9d73d532fb2d8372b971d607b9ddaa1af2b84ffd.1368696028.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 21:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud3ro-0005V7-2j
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 21:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab3EPT32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 15:29:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647Ab3EPT31 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 15:29:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 467F81F30A;
	Thu, 16 May 2013 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0lwv9aAOSGKWAOq7zS3i00ZELOU=; b=luVrNd
	CsSiivKbzE0V+spMkopnQxPhnIbAWk4KLkzgX1UotOF05bndsHah/Ek+6HJSlFAf
	KPjIDnzFtO21lc7+efNX0FFsAKgGhfb3Q1gft4jQ3ZiH0eZ7qQr5NhFTXW54xoPb
	VgrJ+ceKIglzUyp5tpcXOEBcQUp/xFFUJZ2JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kum0/VBe6JZyq2d2yOET730ad4p+uPrz
	LkbT8V5YRQn5WwNtPgTde8xx1mNRZstGnI94vfs8nO8XYgcv9fBwb11hGyc5MxJ7
	CkkfIiBadQy7CxE7QB2fgoPXrVoQzkgnYp7u21ZLeUy2lKaCHcarpdmbbLwBT1jF
	hqiASgVch0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39FDC1F309;
	Thu, 16 May 2013 19:29:27 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B8DC1F308;
	Thu, 16 May 2013 19:29:26 +0000 (UTC)
In-Reply-To: <9d73d532fb2d8372b971d607b9ddaa1af2b84ffd.1368696028.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 16 May 2013 17:53:40 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBB435BA-BE5E-11E2-9155-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224612>

Jiang Xin <worldhello.net@gmail.com> writes:

> +static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
> +{
> +	struct string_list menu_list = STRING_LIST_INIT_DUP;
> +	struct strbuf menu = STRBUF_INIT;
> +	int i;
> +
> +	if (MENU_STUFF_TYPE_MENU_ITEM == stuff->type) {
> +	...
> +	} else if (MENU_STUFF_TYPE_STRING_LIST == stuff->type) {
> +	...
> +	}

This is better to write as:

	switch (stuff->type) {
	default:
        	die("programming error");
        case MENU_STUFF_TYPE_MENU_ITEM:
        	...
                break;
	case MENU_STUFF_TYPE_STRING_LIST:
        	...
		break;
	}

Besides, there is no good reason to write an equality comparison
between constant and variable in that order (people call it a "Yoda
condition"); do "var == const" if you must.

Also please fix this one:

> +		for_each_string_list_item(item, (struct string_list *)stuff->stuff) {
> +			if ((*chosen)[i] < 0)
> +				(*chosen)[i] = 0;
> +			strbuf_addf(&menu, "%s%2d: %s", (*chosen)[i] ? "*" : " ", ++i, item->string);

Because the evaluation order of function arguments are not defined
(not left to right; these are comma-expressions),

	(*chosen)[i] ? "*" : " "

may use the original value of "i", or value after increment the
evaluation of

	++i

left in "i".
