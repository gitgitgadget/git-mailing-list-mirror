From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Wed, 21 Aug 2013 15:50:52 -0700
Message-ID: <xmqqsiy2slo3.fsf@gitster.dls.corp.google.com>
References: <5214F816.3010303@googlemail.com>
	<1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
	<xmqqfvu2u5io.fsf@gitster.dls.corp.google.com>
	<52153C01.6040101@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCHEy-0001ID-BP
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab3HUWu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab3HUWu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:50:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C01E3B8EA;
	Wed, 21 Aug 2013 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQL6bO3gPGok0H7pmHTsShKZL2k=; b=I7pKle
	QwtbF9xJlOywaMAltFNG+NHNdOYO6LDuCYdg7YhPbXUOY7TD7WobK6aQKliXgmZy
	fG8gR6TvBCRqG9GxPy5q4PKLLqAXaWIQuG2A/netKpVSuaBpl2CYzZrOjZcokh86
	N8rkZErTn0UYHePY2Kr2MBIN356diTxJ6F/4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yXqYGTZheyFHntBLjrADV1Z6vnxgQklW
	c1z6iIDQH4bnjoffCrz3uejFdpdWSv7Vocvrqvtf8DoyO8WImmzQX+JxGNtXvrYp
	lrGD8pJ9A/I37adOb1MR56fnBJycdT71ElgpnNN6/vANjGZAKreGnz1lkjYt03kW
	7sY5oEnsshw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 317D83B8E9;
	Wed, 21 Aug 2013 22:50:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84EFB3B8E8;
	Wed, 21 Aug 2013 22:50:54 +0000 (UTC)
In-Reply-To: <52153C01.6040101@googlemail.com> (Stefan Beller's message of
	"Thu, 22 Aug 2013 00:15:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 22DB271E-0AB4-11E3-8309-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232747>

Stefan Beller <stefanbeller@googlemail.com> writes:

>>> +static int delta_base_offset = 1;
>>> +char *packdir;
>> 
>> Does this have to be global?
>
> We could pass it to all the functions, making it not global.

Sorry for being unclear; I meant "not static".  It is perfectly fine
for this to be a file-scope static.

>>> +
>>> +		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
>>> +			string_list_append_nodup(fname_list, fname);
>> 
>> mental note: this is getting names of non-kept packs, not all packs.
>
> I should document that. ;)

Rather, consider giving the function a better name, perhaps?

>>> +	while (strbuf_getline(&line, out, '\n') != EOF) {
>>> +		if (line.len != 40)
>>> +			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
>>> +		strbuf_addstr(&line, "");
>> 
>> What is this addstr() about?
>
> According to the documentation of strbufs, we cannot assume to have sane 
> strings, but anything.

Sorry, I do not get this.  What is a sane string and what is an
insane string?  sb->buf[sb-len] is always terminated with a NUL
when strbuf_getline() returns success, isn't it?
