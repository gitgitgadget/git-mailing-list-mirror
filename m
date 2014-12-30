From: Junio C Hamano <gitster@pobox.com>
Subject: Re: saving "git push --signed" certificate blobs
Date: Tue, 30 Dec 2014 09:48:45 -0800
Message-ID: <xmqqiogtrptu.fsf@gitster.dls.corp.google.com>
References: <54A10ED1.9020704@gmail.com> <54A22586.70001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 18:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y60ug-0003MD-OR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 18:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbaL3Rss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 12:48:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751203AbaL3Rsr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 12:48:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 006E829F32;
	Tue, 30 Dec 2014 12:48:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IpXpYGi0CYK/74kHS9z/KMJf+XE=; b=N6eJRr
	ahw4xbwbKkdj+FmayvJJlsc+vekPq+WyeMPQx/vfR8+DoAnU1tI3jvZAjqDomPcQ
	w4ddvNLsg7lZBxyYAKWLG74f4sKtmjctx8zD5U5N2pjfqqFc+Er9+TRuyLPYr/Rl
	eB5fviajdkAVMOe278ZEaK892XbxAOpirrCoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qz3gOmzdNDmR4xBqgVkIbleTIScH5yxH
	iIdx2PrEsgprHWaN2PrA2Z+YPWPCxmA/kLH3rx8UZx2jYVaYIACcI4jqp616d6bq
	x0Y5DAoBNZaAXZbUbXJ+qDfiKDJyNYjb788GsUpJd9MV5kaGJ2223yFfQte7b3vp
	joVCLSV8XvU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EAD0329F31;
	Tue, 30 Dec 2014 12:48:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CAD029F30;
	Tue, 30 Dec 2014 12:48:46 -0500 (EST)
In-Reply-To: <54A22586.70001@gmail.com> (Sitaram Chamarty's message of "Tue,
	30 Dec 2014 09:39:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A823AAC-904C-11E4-B3B8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261928>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Just wanted to say there's a little script at [1] that saves the certificate
> blobs generated on the server side by "git push --signed".
>
> Quoting from the source:
>
> # Collects the cert blob on push and saves it, then, if a certain number of
> # signed pushes have been seen, processes all the "saved" blobs in one go,
> # adding them to the special ref 'refs/push-certs'.  This is done in a way
> # that allows searching for all the certs pertaining to one specific branch
> # (thanks to Junio Hamano for this idea plus general brainstorming).
>
> Note that although I posted it in the gitolite ML, this has very little to do
> with gitolite.  Any git server can use it, with only one very minor change [2]
> needed.
>
> sitaram
>
> [1]: https://groups.google.com/forum/#!topic/gitolite/7cSrU6JorEY
>
> [2]: Either set the GL_OPTIONS_GPC_PENDING environment variable by reading its
> value from 'git config', or replace the only line that uses that variable, with
> some other "test".

Nicely done.

We'd need to give you a tool to make it easy to create a "validated
chain of certificates" out of

    $ git log refs/push-certs -- refs/heads/master

to make the history this script creates truly useful, but I think it
is a very good start.

I can see that you tried to make the log output "human readable" by
reformatting $cf, I am not sure if it gives us much value.  I would
have expected that you would just use the blob contents for the log
message as-is, so that

    $ git log --pretty=raw refs/push-certs -- refs/heads/master |
      validate-cert-chain

can just work on blobs (shown in the "log" output) without having to
extract the blobs by doing something like

    $ git rev-list refs/push-certs -- refs/heads/master |
      while read commit
      do
		git cat-file blob $commit:refs/heads/master |
                validate-cert
      done

By the way, you seem to like "cat" too much, though.  You don't have
to cat a single file into a pipeline.

Thanks.
