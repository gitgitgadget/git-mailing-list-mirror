From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "Detailed diagnosis" perhaps broken
Date: Sun, 17 Jun 2012 20:34:39 +0200
Message-ID: <vpq395tvlc0.fsf@bauges.imag.fr>
References: <7vpq91cjby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 20:35:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgKJY-00049E-D0
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 20:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261Ab2FQSfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 14:35:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46380 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758201Ab2FQSes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 14:34:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5HIYTIX010299
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jun 2012 20:34:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SgKJ6-0000HN-0O; Sun, 17 Jun 2012 20:34:40 +0200
In-Reply-To: <7vpq91cjby.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 14 Jun 2012 21:03:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 17 Jun 2012 20:34:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5HIYTIX010299
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340562873.16218@3WCC05Ra57xuB/SrKhke2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200124>

Junio C Hamano <gitster@pobox.com> writes:

> 	$ git log COPYING HEAD^:COPYING
> 	fatal: Path 'COPYING' exists on disk, but not in 'HEAD^'.

Oops!

> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1127,7 +1127,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
>  			if (new_filename)
>  				filename = new_filename;
>  			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
> -			if (only_to_die) {
> +			if (only_to_die && ret) {
>  				diagnose_invalid_sha1_path(prefix, filename,
>  							   tree_sha1, object_name);
>  				free(object_name);

This is one obvious thing to do. We should never call
diagnose_invalid_sha1_path if the search done by get_tree_entry
succeeded. A patch follows with a proper test-case.

But that isn't sufficient unfortunately. The other question here is: why
did we even try calling get_tree_entry, if we're not looking for an
object at all? Indeed, if get_tree_entry fails, we get:

  $ git log COPYING HEAD:foo
  fatal: Path 'foo' does not exist in 'HEAD'

At least, the message is correct in that foo does not exist in HEAD, but
not accurate in the sense that it is not the reason for the error.

So, the other fix should be to distinguish from the caller of
verify_filename whether we should try the detailed diagnosis including
sha1_name_*, or just die and complain about path not being in the
working tree. Another patch follows doing that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
