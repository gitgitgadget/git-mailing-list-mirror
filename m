From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 14:10:03 +0200
Message-ID: <40aa078e0907280510s1afee3ddw3a9333620a3c7d7a@mail.gmail.com>
References: <200907280446.22890.elendil@planet.nl>
	 <200907281127.44558.trast@student.ethz.ch>
	 <20090728104423.GA12947@vidovic>
	 <200907281313.51304.elendil@planet.nl>
	 <20090728113814.GB12947@vidovic>
	 <40aa078e0907280447p4ed92133jb5e586fb0ca40ef2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frans Pop <elendil@planet.nl>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 14:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVlVp-0000tD-UG
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 14:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZG1MKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 08:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZG1MKF
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 08:10:05 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:60178 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbZG1MKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 08:10:04 -0400
Received: by bwz21 with SMTP id 21so861863bwz.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gZbDvLCW/lovU0LB1zx85ZoawHU+m54d0qYZgKEd0DY=;
        b=ewBSGo2aSRPoEwVDqt7vFwh9NuoR2f3PQu45ludQOin09RWyUn/eTwXRz2BXbekiXg
         5VN/Twfxfz8MJXAttQs+ITfq/gQIu+5E6U+ZRg2CCMSd19m/yM5oL6Qvl4UmShpgnUpT
         lKMaiDPVJQZe8wRV8D/g979deHJ4tCkuOHZWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wg42KdvaImcVRgFhjYFZAiXeR0p5q/syk0TU3m8tkKteMcZXSVySEHdmRSwrcfPSKR
         RYQCJ6a6n7w9pMMGf2OQrD7yvyL9FHeHNzCs4kqJfIwwB0VcYt030sEr0aDG+oRLJSBR
         UokxOY3mrurha8nsZ7K5575SuEUNSWP+nyzoo=
Received: by 10.204.76.199 with SMTP id d7mr4018454bkk.84.1248783003117; Tue, 
	28 Jul 2009 05:10:03 -0700 (PDT)
In-Reply-To: <40aa078e0907280447p4ed92133jb5e586fb0ca40ef2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124242>

On Tue, Jul 28, 2009 at 1:47 PM, Erik Faye-Lund<kusmabite@googlemail.com> wrote:
> On Tue, Jul 28, 2009 at 1:38 PM, Nicolas Sebrecht<nicolas.s.dev@gmx.fr> wrote:
>> Hum, you're right. The '@' symbol is required, whatever "id-right" is.
>> My previous patch should fix it.
>
> With all due respect, I don't see how that patch fixes anything. The
> previous last-resort solution should already be just as valid, it
> assigns 'user@'+hostname to $du_part. Even if hostname is "" it should
> insert an '@', which didn't happen here.

Here's an attempt to fix the case when Sys::Hostname::hostname returns
"" (domains aren't allowed to be empty if I read RFC2822 correctly).
The problem with the previous attempt was that the earlier if assigned
"user@" to $du_part, so the last if was never entered ($du_part was
always defined).

I generally don't write Perl, so people will most likely barf all over
this one, but at least it should show the concept. It might not even
work.

I also suspect that it is not needed.
http://search.cpan.org/~tty/kurila-1.19_0/ext/Sys-Hostname/Hostname.pm
seems to indicate that it either returns something sensible or dies.

---
Untested.

 git-send-email.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 303e03a..baadbdb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -742,7 +742,11 @@ sub make_message_id
        }
        if (not defined $du_part or $du_part eq '') {
                use Sys::Hostname qw();
-               $du_part = 'user@' . Sys::Hostname::hostname();
+               my $domain = Sys::Hostname::hostname();
+               if (not defined $domain or $domain eq '') {
+                       $domain = 'fake.dom';
+               }
+               $du_part = "user@$domain";
        }
        my $message_id_template = "<%s-git-send-email-%s>";
        $message_id = sprintf($message_id_template, $uniq, $du_part);
-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
