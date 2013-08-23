From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Fri, 23 Aug 2013 10:25:29 +0200
Message-ID: <vpqbo4o3jba.fsf@anie.imag.fr>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 10:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCmge-00045S-6y
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 10:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab3HWIZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 04:25:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60889 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab3HWIZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 04:25:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7N8PSax018293
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 23 Aug 2013 10:25:28 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VCmgT-0005fM-Dt; Fri, 23 Aug 2013 10:25:29 +0200
In-Reply-To: <CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 22 Aug 2013 12:20:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 23 Aug 2013 10:25:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7N8PSax018293
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377851129.1361@+ajATOdDdrOnS48DYQcNhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232802>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Aug 21, 2013 at 4:36 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Tue, Aug 13, 2013 at 8:31 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>>>
>>>> Felipe: Is this the right fix for git-remote-mediawiki? Any better idea?
>>>
>>> Why not keep track of the revisions yourself? You can have file where
>>> you store which was the last revision that was fetched.
>>
>> I don't really understand the point of the "private namespace" anymore I
>> guess. Why do we have both refs/remotes/$remote and
>> refs/$foreign_vcs/$remote, if they are always kept in sync?
>
> They are not always in sync; if a push fails, the private namespace is
> not updated.
[...]
> As I said, they are not exactly the same. It is possible refs/remotes
> point to a mercurial revision on the remote server, and refs/hg points
> to a mercurial revision on the local internal repository, and they are
> not the same.

This is assuming you follow the scheme

  git -> local repo for other vcs -> remote repo for other vcs

which itself more or less assumes that the other VCS is a decentralized
VCS. I understand this is a good idea for hg or bzr remote helpers, but
not applicable for git-remote-mediawiki.

I find this very unclear in the doc. How about adding something like
this in the "'refspec' <refspec>::" part?

--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -176,6 +176,12 @@ applicable refspec takes precedence.  The left-hand of refspecs
 advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
++
+When writing remote-helpers for decentralized version control
+systems, it is advised to keep a local copy of the repository to
+interact with, and to let the private namespace refs point to this
+local repository, while the refs/remotes namespace is used to track
+the remote repository.
 
 'bidi-import'::
        This modifies the 'import' capability.

So, now, I understand the point of the private namespace in the case of
DVCS, but still note really for interactions with centralized VCS.

Back to my original problem: the point of dumb push is to make sure the
next import will re-import the pushed revisions. if I use something
other than the private namespace to keep track of the last imported,
then I'll need to do a non-fast forward update to the private ref. I
could do that by sending "feature force\n" it the beginning of the
fast-import stream when importing, but that loses one safety feature
(e.g. I detected the breakage thanks to the non-fast forward error
message, while the tests incorrectly pass if I enable "force").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
