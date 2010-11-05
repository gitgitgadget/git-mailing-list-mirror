From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/H] Makefile fix for FC13?
Date: Fri, 05 Nov 2010 15:59:38 -0700
Message-ID: <7vr5ezqsv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 00:00:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEVGS-0007jC-5g
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 00:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab0KEW7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 18:59:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab0KEW7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 18:59:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FAA1374B;
	Fri,  5 Nov 2010 18:59:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=bg4d
	IybIEkbaKIgVb5eePDTz4OM=; b=Jb6MikvuWtO/5EzfohB08Qpzyp2YjJjAsTvH
	83g9TyxxSpdY5GO2SJCxGxP/l2XJqbgHub7IDZ5rbg1/ZZ7qpVfahJVqGuxUMkGS
	myPvoksuRXxEUKsx8va8/DjJkY/qXDKaf6i3J6qCzLyiQvXfd879jAtmpD4hY/8u
	azX9CSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	t/T51Qf+E3Lic13/qbs+Zi0fvm6UUtLrwSudIsX1Vm1neSZTBDzrOksS20ysbU7l
	29Ks4DOAc1h43BTmOioZniaKvLKP6hqMrf+rx2a/qq+93xJvXk373F4eJY2k3n61
	xUgh0c7Fy0YsAZOiz2ujqM8Uk541WRf5LIixMX/nqx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D6B0374A;
	Fri,  5 Nov 2010 18:59:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5634F3749; Fri,  5 Nov 2010
 18:59:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61CA6136-E930-11DF-B11B-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160830>

As k.org is migrating to FC13, I'm also adding an FC13 bochs to my
collection so that I can cut releases for 32-bit i?86 archs.  I noticed
that the compilation fails with this:

      LINK git-imap-send
  /usr/bin/ld: imap-send.o: undefined reference to symbol 'EVP_DecodeBlock'
  /usr/bin/ld: note: 'EVP_DecodeBlock' is defined in DSO
  /lib/libcrypto.so.10 so try adding it to the linker command line

I understand that this is because the linker policy changed in the release
to make things safer.  My understanding of the rationale for the change
goes like this:

  When a binary (e.g. imap-send) wants a symbol X (e.g. EVP_DecodeBlock)
  from a library A (e.g. -lcrypto), and the binary also wants a different
  symbol from another library B (e.g. -lssl), and if the library B happens
  to depend on library A, it used to be sufficient to link the binary with
  library B, without explicitly linking it with library A, as library A
  will be pulled in at the runtime because library B wants it anyway.

  This however would break if library B stops depending on library A
  (i.e. library B gets updated while remaining compatible with its own
  older version, but its implementation no longer requries library A).  It
  is therefore safer to force programs to list their dependencies
  explicitly at link time.

So, I need a patch like the following to make things compile on FC13.

Thoughts?  Ideas for doing this (specifically, "make rpm") in better ways?

On my FC11 bochs and my other Linux boxes, the linker is loose but it does
not seem to hurt (and I do not think it should, as openssl-dev package
seems to have almost always shipped with both -lssl and -lcrypto) to add
this unconditionally.

diff --git a/Makefile b/Makefile
index 1f1ce04..18c7e8e 100644
--- a/Makefile
+++ b/Makefile
@@ -776,6 +776,7 @@ ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
