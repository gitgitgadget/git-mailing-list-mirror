From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive --format zip utf-8 issues
Date: Fri, 10 Aug 2012 15:47:40 -0700
Message-ID: <7vtxwagy9f.fsf@alter.siamese.dyndns.org>
References: <502583F4.8030308@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 00:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szxzh-0002ZR-PQ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 00:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760240Ab2HJWro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Aug 2012 18:47:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41007 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759320Ab2HJWrm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2012 18:47:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B40C9ED5;
	Fri, 10 Aug 2012 18:47:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QFtcoklK2BsN
	0zAyM49cuWD3JTo=; b=FlMnxzLad3aymcM9aO8pwXSDO42lMlywP+Jk5sHDuvhP
	AYfhKxbX6IAdqb5e86sxN0AORyA5O7jPC0ouUCUMVvQHs7ZkzpkMsy/h5e9MEqe6
	Ie0wXVSAq9/Ebpl437gxInGw/JDWTZxQHnWkLn0sSgNsd3t918eloDPn6HmujkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TTZGzX
	viViVYQpMViWI4+dNwxAfR1cFzKXryW5p8nhEO+tJkQ0D7yvaWsi/fMUakSmbtVp
	deDRk10X5SgeTjGlpqSvnq9rJWKW9KYJrEw9ZUDc/h31c8k9AyaZ6PpBUXj5Xdzl
	tX4hWSJjBecqF7Ag2df8g+HxXSeb2Jub384TU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68AF09ED4;
	Fri, 10 Aug 2012 18:47:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C47DF9ED2; Fri, 10 Aug 2012
 18:47:41 -0400 (EDT)
In-Reply-To: <502583F4.8030308@tu-clausthal.de> (Sven Strickroth's message of
 "Fri, 10 Aug 2012 23:58:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 649998B0-E33D-11E1-ACEE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203275>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> when I create a git repository, add a file containing utf-8 character=
s
> or umlauts (like =C3=B6=C3=A4=C3=BC.txt), commit and then export the =
HEAD revision to a
> zip archive using "git archive --format zip -o 1.zip HEAD", the zip f=
ile
> contains incorrect filenames:

My reading of archive-zip.c seems to suggest that we write out
whatever pathname you have in the tree, so a pathname encoded in
UTF-8 will be literally written out in the resulting zip archive.

Do you know in what encoding the pathnames are _expected_ to be
stored in zip archives?  Random documentation seems to suggest that
there is no standard encoding, e.g. http://docs.python.org/library/zipf=
ile.html
says:

    There is no official file name encoding for ZIP files. If you
    have unicode file names, you must convert them to byte strings
    in your desired encoding before passing them to write(). WinZip
    interprets all file names as encoded in CP437, also known as DOS
    Latin.

which may explain it.

It may not be a bad idea for "git archive --format=3Dzip" to

 (1) check if pathname is a correct UTF-8; and
 (2) check if it can be reencoded to latin-1

and if (and only if) both are true, automatically re-encode the path
to latin-1.

Of course, "git archive --format=3Dzip --path-reencode=3Dutf8-to-latin1=
"
would be the most generic way to do this.
