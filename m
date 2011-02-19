From: Jeff King <peff@peff.net>
Subject: Re: Commit/merge messages for binary files
Date: Sat, 19 Feb 2011 02:06:01 -0500
Message-ID: <20110219070601.GA14059@sigill.intra.peff.net>
References: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com>
 <vpq39nlsb3r.fsf@bauges.imag.fr>
 <4D5ED6F2.8030008@gmail.com>
 <vpqwrkx9h2z.fsf@bauges.imag.fr>
 <4D5EE7D2.5060703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 08:06:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqgtP-0005hr-9b
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 08:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab1BSHGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 02:06:06 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53041 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab1BSHGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 02:06:05 -0500
Received: (qmail 7191 invoked by uid 111); 19 Feb 2011 07:06:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 07:06:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 02:06:01 -0500
Content-Disposition: inline
In-Reply-To: <4D5EE7D2.5060703@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167252>

On Fri, Feb 18, 2011 at 10:42:42PM +0100, Piotr Krukowiecki wrote:

> Maybe I wasn't clear. Both the commit and the merge was for the same binary
> file.
> 
> In case of commit there were non-zero insertions/deletions. 
> See example below - notice both update binary file blob.o:
> 
> $ git commit -m Updated
> [topic 5da30ce] Updated
>  1 files changed, 8 insertions(+), 103 deletions(-)
>  rewrite blob.o (100%)

Yeah, that seems weird. I think it might have to do with break
detection in the diff, which is on during the commit summary diff:

  $ git init
  $ dd if=/dev/urandom of=foo.rand bs=1k count=4
  $ git add foo.rand
  $ git commit -m one
  [master (root-commit) 8c5783a] one
   1 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 foo.rand
  $ git show --oneline --stat --summary
  8c5783a one
   foo.rand |  Bin 0 -> 4096 bytes
   1 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 foo.rand

So far so good. Now let's rewrite it.

  $ dd if=/dev/urandom of=foo.rand bs=1k count=4
  $ git commit -a -m two
  [master 43961bc] two
   1 files changed, 15 insertions(+), 19 deletions(-)
   rewrite foo.rand (100%)

Now that seems wrong. What about doing another diff:

  $ git show --oneline --stat --summary
  43961bc two
   foo.rand |  Bin 4096 -> 4096 bytes
   1 files changed, 0 insertions(+), 0 deletions(-)

That's right. Now let's turn on break detection:

  $ git show --oneline --stat --summary -B
  43961bc two
   foo.rand |   34 +++++++++++++++-------------------
   1 files changed, 15 insertions(+), 19 deletions(-)
   rewrite foo.rand (100%)

Broken again. So I guess we have some problem with making sure we treat
broken filepairs as binary.

-Peff
