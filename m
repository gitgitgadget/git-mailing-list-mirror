From: Stefan Agner <stefan@agner.ch>
Subject: Re: git send-email Connection Closed
Date: Fri, 24 Jul 2015 16:26:52 +0200
Message-ID: <66194061e3b38a203af399ba4fd8e4be@agner.ch>
References: <CAFow2F9ZFNcBdoc7YTCeGT_PA-UvMyfcKWE4K4ufGMyFXJd5Uw@mail.gmail.com>
 <91a8d8eb8767d29a4ed0a96d7a633c37@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Juston Li <juston.h.li@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 16:30:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIdzC-00035Z-FA
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 16:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbbGXOaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 10:30:00 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52073 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbGXO37 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 10:29:59 -0400
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 0AE175C11FB;
	Fri, 24 Jul 2015 16:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=agner.ch; s=dkim;
	t=1437748197; bh=X/Lcf0lRRoi3KYGqU7bMn2HLYUJejG0dCYOSeBTvNRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sKPOf2H/xrvOW3frzPqPdRScBtjd8io9hUwyG2QdjooViOwkwmCgM84IQ78e3S2Sd
	 NCKPNBtrZsU+Ov1Hbg71Gyw+MyG2v7BiYuT5oojEzyhLL1VH8yVO2Lar96E5fGEybj
	 rR2Rt0GuKMvgg+adNlrMXiOq+QTCAsDQ3XAfZ484=
In-Reply-To: <91a8d8eb8767d29a4ed0a96d7a633c37@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274569>

On 2015-07-24 14:59, Stefan Agner wrote:
> Hi Juston,
> 
> On 2015-07-15 07:11, Juston Li wrote:
>> Recently, I have had trouble using git send-email to send a patchset.
>> After the confirmation to send the email I get the following:
>> Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
>> [Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
>> line 1320.
>> fatal: 'send-email' appears to be a git command, but we were not
>> able to execute it. Maybe git-send-email is broken?
>>
>> This message first appeared when I tried to send a 19 commit patchset
>> via 'git send-email HEAD~19'. It also fails when I try to format-patch
>> and send the patchset separately via 'git send-email 0001...'
>> Oddly enough, it works when I send anything other than 19 commits
>> for example 'git send-email HEAD~1' or 'git send-email HEAD~20'
> 
> Just got a similar message here, without the fatal part, just:
> [Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
> line 1320.
> 
> It seems that only one patch is causing the problem (in my case the
> first after the cover letter). I use TLS too and send it over a postfix
> SMTP server I maintain myself. The postfix log shows this:
> 
> postfix/smtpd[8535]: lost connection after DATA (16357 bytes) from
> unknown[x.y.z.z]
> postfix/smtpd[8535]: disconnect from unknown[x.y.z.z]
> 
> So it seems that the client side disconnects?
> 
> I rerun the command with --smtp-debug=1
> 
> ...
> Net::SMTP::SSL=GLOB(0x1fb3558)>>> +MODULE_LICENSE("GPL");
> Net::SMTP::SSL=GLOB(0x1fb3558)>>> -- 
> Net::SMTP::SSL=GLOB(0x1fb3558)>>> 2.4.5
> Net::SMTP::SSL: Net::Cmd::datasend(): unexpected EOF on command channel:
>  at /usr/lib/git-core/git-send-email line 1320.
> [Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
> line 1320.
> 
> It seems to me that there is a size limit, after cutting down the patch
> to ~16K, sending started to work. I cut it twice, once by removing lines
> from the head and once from the bottom, in both cases at the size of
> around 16K I could send the patch.

I found a work-around by using datasend line by line, which did the job
for me:

Altering /usr/lib/git-core/git-send-email, around line 1320:

                $smtp->datasend("$header\n") or die $smtp->message;
                my @lines = split /^/, $message;
                foreach my $line (@lines) {
                        $smtp->datasend("$line") or die $smtp->message;
                }

--
Stefan
