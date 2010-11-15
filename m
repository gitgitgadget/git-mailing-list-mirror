From: Mike Frysinger <vapier@gentoo.org>
Subject: git-send-email and "mailhost" misbehavior
Date: Mon, 15 Nov 2010 15:24:02 -0500
Message-ID: <AANLkTinAjqb7cuCaiu=UvT9m5R=RM5E0hf4zPuKYVmHn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 21:24:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI5bK-0002em-5P
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 21:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676Ab0KOUYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 15:24:25 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40838 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932737Ab0KOUYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 15:24:24 -0500
Received: by wwb24 with SMTP id 24so394208wwb.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=1rXNXztWxje5IGqBtTOcR2/sV8evyoqSO9lh2AAocEU=;
        b=eMJk+8mxotoNiGCbX1tqStQlwJQyyJ5RR9l+6lrDn6Q68oIvLItWBwNVSus50Zl+uV
         lWxSY1EZ7pCWwMl1RLEev/2UKfFII/YmrbG7fvlnLuJW7XD3FJ2h2czNglTRmyRFAFJL
         IklM6yW32BBalkuY0ai7Ka7mz62ZOzcNL/RyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=ilR7TwVgMPV0SE4D4vSKH71NDqw2ejpdaVKZ5C7RO3/pm1euPWS2gxk8n1hB5Hhg2+
         iJKP8An5Xb9tyGd0FBFESHHBv0iGhDpqMd9PiPq/CzHVtV3IZr4OpqKeNSX17GhZWARG
         csTvWel+nzTcGJj3hcDdzqmSbp0niKfw2ROOM=
Received: by 10.216.166.68 with SMTP id f46mr7210824wel.26.1289852663321; Mon,
 15 Nov 2010 12:24:23 -0800 (PST)
Received: by 10.216.19.195 with HTTP; Mon, 15 Nov 2010 12:24:02 -0800 (PST)
X-Google-Sender-Auth: bxgDYpP147tGXRtxrb0D1y2jKhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161510>

i have sendemail in my ~/.gitconfig setup like so:
[sendemail]
    smtpserver = localhost:1111

and i have a ssh tunnel running there to forward my e-mail to another
machine's localhost:25

however, when i attempt to send e-mail from some systems, the `git
send-email` process pauses for like 2 minutes without doing anything.
after hassling my e-mail admin about greylisting (which is disabled
for localhost), i looked at git-send-email a bit closer.

running it through a heavy strace shows the source of the pause:
connect(6, {sa_family=AF_INET, sin_port=htons(25),
sin_addr=inet_addr("208.68.139.38")}, 16)
then there's a timeout after 120 seconds trying to connect to this guy

so wtf is "208.68.139.38" !?  well, my shitty ISP (comcast) is doing
DNS hijacking for unresolved DNS names.  so git-send-email tried to
look up some host and it got back "208.68.139.38".  while comcast is
wrong here, why is git-send-email looking up anything at all
considering my sendemail.smtpserver is configured to localhost ?

it seems that buried in the bowels of git-send-email and totally
undocumented is this nugget:
/usr/libexec/git-core/git-send-email:
...
sub maildomain_mta {
    my $maildomain;

    if (eval { require Net::SMTP; 1 }) {
        for my $host (qw(mailhost localhost)) {
            my $smtp = Net::SMTP->new($host);
...

so git-send-email is so kind as to attempt port 25 connections to
"mailhost:25" and "localhost:25" while attempting to locate its FQDN
!?  this doesnt sound right at all.  DNS lookups do not require actual
TCP/IP connection attempts.

stubbing out "mailhost" to 127.0.0.1 in /etc/hosts fixes my troubles.
-mike
