From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] magic pathspec updates
Date: Mon,  9 May 2011 22:51:09 -0700
Message-ID: <1305006678-4051-1-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfr0-000190-6Z
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab1EJFvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 01:51:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab1EJFvX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 01:51:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 346A45C82;
	Tue, 10 May 2011 01:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CsSmRaMMXTk9
	Xo2UBn8cZNoqna8=; b=IrRS5jAINudn2JY5tZjdg0SM/A3Nmc2qxA3p7BlA4sZB
	A4vN2BJ8kzSzOJKUgV6M0GUXRSCt+wla1iCWvCs/iOB+9WgdRVRZEP3qFA7jgVwZ
	QZYzA9rqGgA+ARTBsr1jJLdaZjjwDIkAGIvH6CfzkRGSobXggsMUlFIxTbWYYjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v+I1cB
	6zBgx3CqDUiLZ3MAMZhXyuSqJ1GvdedHeh6LgZwk+iQbvCTuGTTu5S46uhG0IKlp
	CCarmeL33re2p0YWsloY7hbeV8TBhk5gH682DqdI2+tRFR/2FI77ps4pLnJmfBpO
	S0OpZSk6Nh29ZE1DM1VZYLyiI7j3fr2G3SQlY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 217935C81;
	Tue, 10 May 2011 01:53:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6131C5C7F; Tue, 10 May 2011
 01:53:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
X-Pobox-Relay-ID: D322F1EC-7AC9-11E0-A065-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173304>

This is a series to update the magic pathspec topic, primarily the area
around the empty ':' pathspec.

The failing tests from Duy's are mostly due to the fact that this round=
 is
not converting the codebase fully and still use char **pathspec in plac=
es.

As get_pathspec() gives only a munged string for pattern matching, whil=
e
losing the original pathspec information such as up to which point in t=
he
resulting string came from the prefix (hence it must match literally ev=
en
under icase) or what the original string looked like, there is no way f=
or
these tests, especially the ones to check failure mode and the informat=
ion
in the error report, to pass.

As NEEDSWORK comment in prefix_pathspec() says, all the callers need to=
 be
converted to use "struct pathspec" interface, so that they can preserve
the original information for error reporting purposes (and also to pass
to external subprocesses --- see how pathspec is used to spawn the "add=
 -i"
helper for example).

Other than that, I think the current code is probably more or less safe=
 to
dogfood with known rough edges.

Junio C Hamano (8):
  grep: use get_pathspec() correctly
  get_pathspec(): an empty ':' pathspec should stand alone
  count_pathspec(): return number of elements in pathspec
  add ":" is a pathspec that is too wide
  git rm ":" is like specifying nothing
  clean ":" is like specifying nothing
  mv ":" ":" is like moving nothing from nowhere to nowhere
  checkout ":" is not giving any pathspec

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  t3703, t4208: add test cases for magic pathspec

 Documentation/glossary-content.txt |    3 +
 builtin/add.c                      |    4 +-
 builtin/checkout.c                 |    9 +---
 builtin/clean.c                    |    1 +
 builtin/grep.c                     |    8 +---
 builtin/mv.c                       |    6 ++-
 builtin/rm.c                       |    4 +-
 cache.h                            |    3 +-
 setup.c                            |   18 ++++++++-
 t/t3703-add-magic-pathspec.sh      |   78 ++++++++++++++++++++++++++++=
++++++++
 t/t4208-log-magic-pathspec.sh      |   45 +++++++++++++++++++++
 11 files changed, 160 insertions(+), 19 deletions(-)
 create mode 100755 t/t3703-add-magic-pathspec.sh
 create mode 100755 t/t4208-log-magic-pathspec.sh

--=20
1.7.5.1.290.g1b565
