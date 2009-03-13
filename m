From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 13:23:08 -0700
Message-ID: <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
 <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
 <49BA39A1.9090203@drmicha.warpmail.net>
 <200903131215.49336.trast@student.ethz.ch>
 <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com>
 <49BA6606.1070403@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Mar 13 21:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiDw5-00016p-Oj
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 21:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZCMUXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZCMUXW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 16:23:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZCMUXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 16:23:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B15F1A1B44;
	Fri, 13 Mar 2009 16:23:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 87964A1B39; Fri,
 13 Mar 2009 16:23:10 -0400 (EDT)
In-Reply-To: <49BA6606.1070403@fastmail.fm> (Michael J. Gruber's message of
 "Fri, 13 Mar 2009 14:56:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA476AFA-100C-11DE-9BAA-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113221>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:

> In .gitattributes (or.git/info/a..) use
>
> * filter=gpg diff=gpg
>
> In your config:
>
> [filter "gpg"]
>         smudge = gpg -d -q --batch --no-tty
>         clean = gpg -ea -q --batch --no-tty -r C920A124
> [diff "gpg"]
>         textconv = decrypt
>
> This gives you textual diffs even in log! You want use gpg-agent here.

Don't do this.

Think why the smudge/clean pair exists.

The version controlled data, the contents, may not be suitable for
consumption in the work tree in its verbatim form.  For example, a cross
platform project would want to consistently use LF line termination inside
a repository, but on a platform whose tools expect CRLF line endings, the
contents cannot be used verbatim.  We "smudge" the contents running
unix2dos when checking things out on such platforms, and "clean" the
platform specific CRLF line endings by running dos2unix when checking
things in.  By doing so, you can see what really got changed between
versions without getting distracted, and more importantly, "you" in this
sentence is not limited to the human end users alone.

git internally runs diff and xdelta to see what was changed, so that:

 * it can reduce storage requirement when it runs pack-objects;

 * it can check what path in the preimage was similar to what other path
   in the postimage, to deduce a rename;

 * it can check what blocks of lines in the postimage came from what other
   blocks of lines in the preimage, to pass blames across file boundaries.

If your "clean" encrypts and "smudge" decrypts, it means you are refusing
all the benifit git offers.  You are making a pair of similar "smudged"
contents totally dissimilar in their "clean" counterparts.  That is simply
backwards.

As the sole raison d'etre of diff.textconv is to allow potentially lossy
conversion (e.g. msword-to-text) applied to the preimage and postimage
pair of contents (that are supposed to be "clean") before giving a textual
diff to human consumption, the above config may appear to work, but if you
really want an encrypted repository, you should be using an encrypting
filesystem.  That would give an added benefit that the work tree
associated with your repository would also be encrypted.
