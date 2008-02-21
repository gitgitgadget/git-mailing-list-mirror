From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email getting filtered as spam by vger.kernel.org
Date: Thu, 21 Feb 2008 13:14:19 -0800
Message-ID: <7vejb6t3kk.fsf@gitster.siamese.dyndns.org>
References: <200802210429.58353.lenb@kernel.org>
 <200802210721.29188.lenb@kernel.org>
 <20080221205104.GA14247@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSIlH-0006Zu-Kd
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbYBUVOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008AbYBUVOr
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:14:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbYBUVOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 16:14:45 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 145A828B8;
	Thu, 21 Feb 2008 16:14:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 13CD828AC; Thu, 21 Feb 2008 16:14:36 -0500 (EST)
In-Reply-To: <20080221205104.GA14247@informatik.uni-freiburg.de> (Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Thu, 21 Feb 2008 21:51:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74659>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> Len Brown wrote:
>> It looks like the same patches formatted and set with git 1.5.4.2
>> made it through to the list.
> I suspect 1ca3d6ed01774eab37e96d9c88b840ea618f97af.

When you talk about commits, please also add the summary line,
like this [*1*]:

    1ca3d6e (send-email: squelch warning due to comparing undefined $_ =
to "")

Len said he has the issue with v1.5.4.2-184-gb23b27e but not
with v1.5.4.2.

    $ git lg v1.5.4.2..b23b27e -- git-send-email.perl
    1ca3d6e... send-email: squelch warning due to comparing undefined $=
_ to ""
    6564828... git-send-email: Generalize auto-cc recipient mechanism.
    8a7c56e... git-send-email: Better handling of EOF
    8742997... git-send-email: SIG{TERM,INT} handlers
    2363d74... git-send-email: ssh/login style password requests

and I think you are right.  I see In-reply-to: <> in the reject
message.

Perhaps we should fix it up like this...


diff --git a/git-send-email.perl b/git-send-email.perl
index ccb87a2..c9f8c6b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -475,7 +475,7 @@ if ($thread && !defined $initial_reply_to && $promp=
ting) {
=20
 	$initial_reply_to =3D $_;
 }
-if (defined $initial_reply_to) {
+if (defined $initial_reply_to && $initial_reply_to ne '') {
 	$initial_reply_to =3D~ s/^\s*<?/</;
 	$initial_reply_to =3D~ s/>?\s*$/>/;
 }



[Footnote]

*1* Here is what I have in $HOME/.gitconfig to allow me to say
"git one 1ca3d6ed0177".

[alias]
	lg =3D log --pretty=3Doneline --abbrev-commit
	one =3D show -s --pretty=3D'format:%h (%s)'
