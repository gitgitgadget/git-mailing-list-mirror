From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Sun, 11 Nov 2012 19:06:28 +0100
Message-ID: <CAMP44s1iNFcN6LFhpFTR0cuTcytOXDSof8H+bPN1_0ebGandBw@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0kvScgtqwCLA2BPZxs5qc-ZVyZPiCu6BHrqjne-Yfr8-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:06:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbvu-0008FQ-Ba
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab2KKSGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:06:30 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41687 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab2KKSG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:06:29 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5578357oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bvk38YXJ0MZ2vEkT0ve5Y88ZkCraDb0olRZPP2+93CY=;
        b=Pyz/AnsQB1EF/vD6cNWCMla7Kt2Rtcg482eYoXl30sA9KgAwMkyL3plRQ0iD8WRnTa
         CkgyYgy+18pKv97pLm6+NGtuLl3rkJMDIRPvd5HMTcg09DEElnacB3ARJvY/SHje+Mh4
         b748VTUJCAkvPfr6QVd2+6Zp0gAHqDYHO86HoXWMB52pA8hzwmSlyu+PZXMJ9Ca5rKjp
         pvbamHxisCPFymeX08CI5Zd6r2SLP6ftEI48PUvFwFR/vTEnVml9+9WOzF/p9YoXFLpz
         b4JDFF0YGFc4pe5ybNGM1cXDjW+JpnE0Uk4+clFTsv9KT4PxJcMiR7bcYxK5/8JWIHUM
         rPng==
Received: by 10.182.235.46 with SMTP id uj14mr13285672obc.40.1352657188832;
 Sun, 11 Nov 2012 10:06:28 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 10:06:28 -0800 (PST)
In-Reply-To: <CALkWK0kvScgtqwCLA2BPZxs5qc-ZVyZPiCu6BHrqjne-Yfr8-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209430>

On Sun, Nov 11, 2012 at 6:12 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> I got really tired of 'git send-email' always asking me from which address to send mails... that's already configured.
>
> Use sendemail.from.  The email sender doesn't necessarily have to be the author.

And when it's not the author, then sendemail.from would be used.

% git config user.email felipe.contreras@nokia.com
% git send-email master
From: Felipe Contreras <felipe.contreras@nokia.com>

% git config user.email felipe.contreras@gmail.com
% git send-email.perl master
From: Felipe Contreras <felipe.contreras@gmail.com>

% git send-email --from=foo@bar.com master
From: foo@bar.com

% git config sendemail.from test@example.com
% git send-email master
From: test@example.com

What do you loose with this code? Nothing. What do you gain by asking
the user every time: "Who should the emails appear to be from?", when
the default GIT_AUTHOR_IDENT is already fine? Nothing.

The problem with sendemail.from, is that each time the user needs to
change email address, it has to be done in multiple places:
user.email, and sendemail.from. There's no need for that.

But I screwed the patch, it should be:

+if (!defined $sender) {
+       my $name = Git::config('user.name');
+       my $email = Git::config('user.email');
+
+       if (defined $email) {
+               if (defined $name) {
+                       $sender = sprintf("%s <%s>", $name, $email);
+               } else {
+                       $sender = $email;
+               }
+       }
+}

Cheers.

-- 
Felipe Contreras
