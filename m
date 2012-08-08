From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug with git-submodule and IFS
Date: Wed, 08 Aug 2012 12:08:17 -0700
Message-ID: <7v628ttd5q.fsf@alter.siamese.dyndns.org>
References: <1496197024.216188.1344449732940.JavaMail.root@sms-zimbra-message-store-03.sms.scalar.ca> <1844267106.216233.1344450083762.JavaMail.root@sms-zimbra-message-store-03.sms.scalar.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Dranse <adranse@oanda.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzBcL-0001oU-3n
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 21:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868Ab2HHTIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 15:08:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758816Ab2HHTIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 15:08:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A83A3923C;
	Wed,  8 Aug 2012 15:08:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zYEA15/xHRHZm0ohrV9gaRJa8Es=; b=hVXzrX
	OmUZHf9j+mtsKiuZRxZJJb+BgCxgcPeLSab3Ab2wD0SNwQNkNwwT9irGsxBVhITO
	yxb3aSGspQB2sjd+8SyxfivQY4Bi2nwoEeeCRaXsHCtG7J2Hjpv8gSRifwG1/gCL
	+8DVVfeDMR9YbRgylTREoGukVEu3lfRbVJc9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FsorueFaSKC7KMYHofPbJnRxlBCkAa9t
	KhlNDQrntxMpS1DMgga+ZPRRkB1zrrnBTZLbFdqKBvOFnP1LCe9Dm2lQnPiMwLqx
	8eyzEtfseIeANn6O/uBB7+I06dl0rxJfmpwHpBvwxRIjQIcMs7tO3LoHmuhUMaLd
	i69YohgWWZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9590C923B;
	Wed,  8 Aug 2012 15:08:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1DF9923A; Wed,  8 Aug 2012
 15:08:18 -0400 (EDT)
In-Reply-To: <1844267106.216233.1344450083762.JavaMail.root@sms-zimbra-message-store-03.sms.scalar.ca> (Andrew Dranse's message of "Wed, 8 Aug 2012 14:21:23 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A161AC8-E18C-11E1-9C55-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203114>

Andrew Dranse <adranse@oanda.com> writes:

> Hi there,
>
> I ran into an interesting bug with git submodules today.  It
> appears that if your IFS is not set to what git-submodule expects
> it to be (i.e. the standard IFS), it will break in a fun way.
>
> Example:
>
> $ git init
> Initialized empty Git repository in /home/adranse/test/.git/
> $ git submodule add github:/repos/perf
> Cloning into 'perf'...
> remote: Counting objects: 5744, done.
> remote: Compressing objects: 100% (4627/4627), done.
> remote: Total 5744 (delta 2400), reused 1579 (delta 343)
> Receiving objects: 100% (5744/5744), 28.78 MiB | 4.56 MiB/s, done.
> Resolving deltas: 100% (2400/2400), done.
> $ export IFS="
>> "
> $ git submodule update --init --recursive
> No submodule mapping found in .gitmodules for path ''

I do not think it is limited to "git submodule", and shell scripts
generally, not limited to shell scripted Porcelain commands from the
Git suite, assume that they can rely safely on words split at SP and
HT.

Perhaps something like this is a good solution for it.

 git-sh-setup.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 770a86e..ee0e0bc 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -9,8 +9,12 @@
 # you would cause "cd" to be taken to unexpected places.  If you
 # like CDPATH, define it for your interactive shell sessions without
 # exporting it.
+# But we protect ourselves from such a user mistake nevertheless.
 unset CDPATH
 
+# Similarly for IFS
+unset IFS
+
 git_broken_path_fix () {
 	case ":$PATH:" in
 	*:$1:*) : ok ;;
