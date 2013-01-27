From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sat, 26 Jan 2013 21:30:00 -0800
Message-ID: <7vy5ffxkfb.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 27 06:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzKpH-0007e0-79
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 06:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab3A0FaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 00:30:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab3A0FaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 00:30:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 989078C3F;
	Sun, 27 Jan 2013 00:30:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fcXac2WlkVJPa7p8305RiswCAa4=; b=r51WZy
	BdFCBU14R0xNDafxZ2M+MoHN+r7Yx34SSMvIqvHC3+/LCy8/5P0/fy4VR3aUje8c
	EzDMJxX2CMaJXvVw3v5jQW82V1BdmyEFx5ICbpLc+85Rv0Oag/fMIt7J9lZbKI7n
	UIjTxrE8u0043Kjrcwl0GZhc8x8evbpHgPo6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u5kpDPob5kD4axhpCzstZDUO/BV3d9T5
	pd1azZ54Yyc+qlhbNsnllNZaxUzakoqBevsmjNtFqYpOqKIkoz080+PGJifjdRuf
	RbHPcqPLarI3NWO6O6hUKIZqDe6MgYBMVv9KScq0M17umzAlxVqNl7irGYEqYIkI
	O+TaXKKWFiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CA1E8C3C;
	Sun, 27 Jan 2013 00:30:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4882E8C3A; Sun, 27 Jan 2013
 00:30:03 -0500 (EST)
In-Reply-To: <5104B0B5.1030501@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 27 Jan 2013 05:44:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99FA1A04-6842-11E2-8235-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214678>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This will still fail under Python 2.x if repo.path is a byte string that
> contains non-ASCII characters.  And it will fail under Python 3.1 and
> later if repo.path contains characters using the surrogateescape
> encoding option [1],...
> Here you don't really need byte-for-byte correctness; it would be enough
> to get *some* byte string that is unique for a given input ...

Yeek.

As we do not care about the actual value at all, how about doing
something like this instead?

 git-remote-testgit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 5f3ebd2..705750d 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -40,7 +40,7 @@ def get_repo(alias, url):
     repo.get_head()
 
     hasher = _digest()
-    hasher.update(repo.path)
+    hasher.update(".".join([str(ord(c)) for c in repo.path]))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
