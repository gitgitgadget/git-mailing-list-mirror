From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Convert struct name_entry to use struct object_id.
Date: Tue, 19 Apr 2016 16:02:22 -0700
Message-ID: <xmqqshyhxkw1.fsf@gitster.mtv.corp.google.com>
References: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
	<1460934641-435791-5-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:02:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asefE-0000XL-DE
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbcDSXC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:02:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752287AbcDSXC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:02:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D649015D97;
	Tue, 19 Apr 2016 19:02:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eTF7AKy+LwzWxf1L/uY/HXCP0LM=; b=G5IMrq
	FmZnYv/vS8y+nWYmu7CfqvE8vOYkHvaWdXzTUFK/tKtoxj41Y3dLA5ACm46gFh/o
	xkEQUFYZt04gB+P7e9BAJSAnSUJifJ0XVmdjoM8hAunUYqgurYGk+S4bgA4Z3yGR
	0/uTKqIg+DzGX/HGjzrN1NjzgrdkRO5y6BFNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sy8XXx/ewgCPveTXHvLwKZgxBTNgcQZ9
	hBVgUzUpUMv/BllPlhvUAvqwW2IRgqXyb5fW+pWoyHwnA0Px1OGESE8oYp7dBr2/
	qeLB7c75ac7ZbDhMO009FWL2huiZ5XcwQOIZaGO0Uk9NMMI2IXrrNQkwD7krVuiS
	SXQVYR9s6+A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCB3715D96;
	Tue, 19 Apr 2016 19:02:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A80B15D95;
	Tue, 19 Apr 2016 19:02:24 -0400 (EDT)
In-Reply-To: <1460934641-435791-5-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 17 Apr 2016 23:10:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C769FED2-0682-11E6-A00E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291947>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> @@ -314,7 +314,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
>  	}
>  
>  	if (same_entry(entry+0, entry+1)) {
> -		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
> +		if (entry[2].oid->hash && !S_ISDIR(entry[2].mode)) {

Thanks for a warning in the cover letter.

"if (entry[2].oid && !S_ISDIR(entry[2].mode)" would be a faithful
conversion, wouldn't it?

threeway-callback is called from the unpack-trees codepath and
tree-walk.c::traverse_trees() is what prepared these entries.

An entry[] which is an N-element array represents the traversal
state of walking N trees in parallel, and the callback function like
this one gets an entry that has been tree-walk.c::entry_clear()ed
(i.e. memset to full of '\0's) for a tree that lacks the corresponding
path.

Try to do merge-tree of two trees, where there is a path that we did
not change since common ancestor, while the other side removed it,
and you would hit this if () statement, I would think.
