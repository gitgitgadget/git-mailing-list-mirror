From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: Kernel bug caused by 'git apply' misapplying a patch with ambiguous
 chunk
Date: Thu, 02 Apr 2015 19:13:08 +0300
Message-ID: <551D6A94.3050707@kapsi.fi>
References: <551D5F58.4010201@kapsi.fi> <xmqqy4majzb4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:13:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydhk6-0001bk-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbbDBQNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 12:13:14 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:44921 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbbDBQNN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 12:13:13 -0400
Received: from [2001:708:30:12d0:beee:7bff:fe5b:f272]
	by mail.kapsi.fi with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <mikko.perttunen@kapsi.fi>)
	id 1Ydhjw-0007ZR-Pk; Thu, 02 Apr 2015 19:13:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqy4majzb4.fsf@gitster.dls.corp.google.com>
X-SA-Exim-Connect-IP: 2001:708:30:12d0:beee:7bff:fe5b:f272
X-SA-Exim-Mail-From: mikko.perttunen@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266645>

On 04/02/2015 06:59 PM, Junio C Hamano wrote:
> Mikko Perttunen <mikko.perttunen@kapsi.fi> writes:
>
>> Of course this is probably rather hard to fix on the applying end; but
>> perhaps format-patch could check for ambiguous chunks and either warn
>> the user or increase the context size automatically, or apply could
>> warn about the chunk being ambiguous?
>
> Interesting thought.  Let me rephrase to make sure I got your
> thought process correctly.
>
> Imagine you started from an original that had two cut-and-pasted
> codeblocks A and B in the same file and updated one of them, say A,
> and then sent out the patch that turns A into A1.
>
> Meanwhile, somebody started from the same original and updated the
> same codeblock A in the upstream already to A2. Your patch applies
> cleanly to codeblock B and turns it to A1, which is a mispatch.  And
> you cannot even detect the problem while applying.
>
> But if you are starting from the original with idential A and B,
> format-patch can see that the resulting patch to turn A to A1 can be
> misunderstood to be a patch to change B to A1 instead. So in that
> case, you _could_ detect.
>
> But imagine if you started from an original that had A and C, that
> are clearly different.  Your change turns A into A1.  In the
> meantime, the upstream started from the same original, and changed C
> into B that looks identical to A.
>
> The same thing would happen to your patch when you try to apply it.
> "git apply" could try to diagnose this situation and warn.  But you
> cannot check when your format-patch produces a patch that turns <A,C>
> into <A1,C>, as there is no ambiguity in the original.
>
> So,
>
>   - format-patch could try to help, but it won't be a complete
>     solution.
>
>   - apply could try to help, but it won't be a complete solution.
>
> I am not sure if having "both" would make it complete, but I doubt
> it.
>
>

I agree. I think you can also create a situation where neither would 
detect the problem, if the upstream changes C such that A->A1 can be 
applied on it and at the same time changes A such that A->A1 no longer 
applies. However, such a situation should be rare, so I think these 
checks would be useful.

In this case, the ambiguity existed the whole time both on the 
submitter's end and in upstream. Upstream just added more stuff into the 
file causing the line numbers to shift. So in this case a check in 
either subcommand would have caught it.

Mikko
