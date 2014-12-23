From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git update-ref --stdin : too many open files
Date: Tue, 23 Dec 2014 07:57:35 -0800
Message-ID: <xmqq38865pg0.fsf@gitster.dls.corp.google.com>
References: <54954E44.1080906@dachary.org>
	<xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
	<5498D66B.5090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 16:57:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3RqC-0008K9-W1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 16:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbaLWP5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 10:57:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756341AbaLWP5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 10:57:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D655728DCA;
	Tue, 23 Dec 2014 10:57:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=39UL5su2+yUpKYV0r4EEFscHTFo=; b=Yy2LHq
	0SatywbdsqXS9ztmbCREJeYOqUBCc6DxwLxkbvnbtUxfb87a2DBXD2D6SxqmPucP
	fnPy02GwHPB7PNxv/BxC+KgBRnGK5Bvrm824+6YlLBra3ZkepZhAJk5jt1ySgmYn
	lShvUM1Ni29fSp37+Pl54iBGfGflofZa2yrFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dt8Errwo+iHj0U2dbXz0Tw3GAEH7sBsl
	xg1Yc9YuIne7wDctuRkL9nwyjMz593dJG4SjiRR5uY9nCPognUbpgqHZM5SNCyKz
	zX1EhW4yjY3vTumyyN8zxuWlSXWjR6hug3hrHwvrziFOsGCPtkTTey82vZGswAjS
	r/2raZFmVlw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7D5D28DC6;
	Tue, 23 Dec 2014 10:57:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20D3728DC4;
	Tue, 23 Dec 2014 10:57:37 -0500 (EST)
In-Reply-To: <5498D66B.5090807@gmail.com> (Stefan Beller's message of "Mon, 22
	Dec 2014 18:41:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A66B70E-8ABC-11E4-BC77-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261735>

Stefan Beller <stefanbeller@gmail.com> writes:

> Sounds reasonable. Though by closing the file we're giving up again a
> bit of safety. If we close the file everyone could tamper with the lock
> file. (Sure they are not supposed to touch it, but they could)

There are locking primitives (SysV mandatory locking) that require
you to keep the file you have lock on open for you to retain the
ownership of the lock, and that kind of lock does prevent random
other processes from simultaneously accessing the locked file.

But that is not what our locks are designed around; our locks rely
only on "open(O_EXCL|O_CREAT) fails if it already exists".  And
between keeping a lockfile open and closing but not removing a
lockfile, there is no difference how the lockfile that still exists
prevents open(O_EXCL|O_CREAT) by other processes from succeeding.

So we are not giving up any safety at all, which is a good thing ;-).
