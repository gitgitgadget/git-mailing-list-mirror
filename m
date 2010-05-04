From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Determining if a file exists in a bare repo
Date: Tue, 04 May 2010 09:39:29 -0700
Message-ID: <7v7hnjoc3i.fsf@alter.siamese.dyndns.org>
References: <w2q799406d61005040911p8fd7c234s5e6382298129985f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 18:39:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9L9y-00062M-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759538Ab0EDQjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 12:39:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab0EDQjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 12:39:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD2D8B0C5E;
	Tue,  4 May 2010 12:39:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kuSd+Ma1jKk3RNIOjs2PcCoWHFk=; b=kOU7+B
	L4omjsmkriVWW9w1lIGAeBLUJZZiWLe5onq/f1LqgUz05jRI0p05syghVAP6seS/
	XEfcXi5aTpYk9iKNAAiVBLgJtlCTJF9CbzwOxx1CgS7RBpU9Zz9/DqxXdzgIS6lO
	FwCYTWhzkCu1m6uVVRoDgbYE112ALUxZSWzPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t7kVoBXbI+KhPCSO7nDLbfJfYuVa0GRg
	AfHTrgkdJbY4I5BVyfdnSIq+huBnP4Naw2PC9kER8r9xat12nhiyy+pD3WzYl1Nb
	G6IcHnupp8EseJgk8FMcgHcW4SgpX4qDBAwozOkA6vn8n2hVv/WJ5Y/4GFBlDZiz
	ZR1tfaM/So8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74015B0C5D;
	Tue,  4 May 2010 12:39:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3966B0C5C; Tue,  4 May
 2010 12:39:30 -0400 (EDT)
In-Reply-To: <w2q799406d61005040911p8fd7c234s5e6382298129985f@mail.gmail.com>
 (Adam Mercer's message of "Tue\, 4 May 2010 11\:11\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E75AB9E-579B-11DF-8148-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146325>

Adam Mercer <ramercer@gmail.com> writes:

> Hi
>
> I'm trying to write a post-receive hook that generates some HTML files
> from reStructured text files stored in a repository. Essentially I'm
> doing this with
>
> git show master:INSTALL | rst2html --no-raw --no-file-insertion >
> /path/to/INSTALL.html
>
> However I would like this script to fail gracefully if the INSTALL
> file is not available in the repository so would like to check if this
> file exists. The problem I'm having is that git-show seems to return a
> zero return code even if the file you request doesn't exist

Even if it returned an error status, you are discarding it by placing the
process on the upstream side of the pipe, so your command line above won't
be able to catch an error anyway.  I would probably do something like this
if I were you:

    git rev-parse --verify master:INSTALL >/dev/null 2>&1 &&
    git cat-file blob master:INSTALL | rst2...
