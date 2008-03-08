From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ISSUE] git send-email sends wrong patches and non-provided CC
 (probably bug)
Date: Fri, 07 Mar 2008 21:14:51 -0800
Message-ID: <7vod9pyeyc.fsf@gitster.siamese.dyndns.org>
References: <7bfdc29a0803060111vc98ef42q96c3ce343fef0859@mail.gmail.com>
 <7vskz4cfyq.fsf@gitster.siamese.dyndns.org>
 <7bfdc29a0803060319v1f3ee295k44c1eecb6fbf1ca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	David Brown <git@davidb.org>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 06:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXrPr-0001ly-HR
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 06:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbYCHFPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 00:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbYCHFPF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 00:15:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbYCHFPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 00:15:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF2DA103B;
	Sat,  8 Mar 2008 00:15:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8D97C1039; Sat,  8 Mar 2008 00:14:56 -0500 (EST)
In-Reply-To: <7bfdc29a0803060319v1f3ee295k44c1eecb6fbf1ca3@mail.gmail.com>
 (Imran M. Yousuf's message of "Thu, 6 Mar 2008 17:19:14 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76547>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> On Thu, Mar 6, 2008 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Imran M Yousuf" <imyousuf@gmail.com> writes:
>>
>>  > 1. git send-email sends CC to gitster though his email is not mentioned.
>>
>>  Check your config first.
>
> Can someone help me where I can find it in the config? because I
> surely did not make any change to config of GIT project. I would be
> grateful for the help.

In $HOME/.gitconfig and $GIT_DIR/config, sendemail.{to,cccmd,bcc} .

Running "git send-email --dry-run $your_command_line_args $files"
may tell you where the recipients list are picked up from.  IIRC, the
command picks up addresses on Signed-off-by: lines too, which needs to be
explicitly squelched with --suppress-cc=all and/or friends.

One irritating pitfall is that --suppress-cc=<cccmd,cc,self,author,sob>
takes lower precedence than others; especially, even the command line
--suppress-cc=all is countermanded by configured sendemail.suppressfrom
and sendemail.signedoffcc.

Even if we ignore this "the command line should trump configured values"
irritation, I think there is a bug here.

    # If explicit old-style ones are specified, they trump --suppress-cc.
    $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
    $suppress_cc{'sob'} = $signed_off_cc if defined $signed_off_cc;

$signed_off_cc asks for cc, so I think the second line should invert its
logic.

-- >8 --
send-email: --no-signed-off-cc should suppress 'sob' cc

The logic to countermand suppression of Cc to the signers with a more
explicit --signed-off-by option done in 6564828 (git-send-email:
Generalize auto-cc recipient mechanism) suffers from a double-negation
error.

A --signed-off-cc option, when false, should actively suppress CC: to be
generated out of S-o-b lines, and it should refrain from suppressing when
it is true.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 29b1105..b3bd922 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -317,7 +317,7 @@ if ($suppress_cc{'all'}) {
 
 # If explicit old-style ones are specified, they trump --suppress-cc.
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
-$suppress_cc{'sob'} = $signed_off_cc if defined $signed_off_cc;
+$suppress_cc{'sob'} = !$signed_off_cc if defined $signed_off_cc;
 
 # Debugging, print out the suppressions.
 if (0) {
