From: Sam Vilain <sam@vilain.net>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Tue, 11 Jan 2011 10:38:48 +1300
Message-ID: <4D2B7C68.1010200@vilain.net>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>	<alpine.LFD.2.00.1101061956470.22191@xanadu.home>	<AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>	<AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com> <AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 22:39:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcPSJ-00008s-14
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 22:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab1AJVjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 16:39:06 -0500
Received: from mx6.orcon.net.nz ([219.88.242.56]:35309 "EHLO mx6.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353Ab1AJVjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 16:39:05 -0500
Received: from Debian-exim by mx6.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PcPSB-0006pw-13
	for git@vger.kernel.org; Tue, 11 Jan 2011 10:39:03 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx6.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PcPSA-0006pk-OC
	for git@vger.kernel.org; Tue, 11 Jan 2011 10:39:02 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 77D6C2E09B; Tue, 11 Jan 2011 10:39:02 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.83] (arcturus.lan [192.168.1.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9FD8B2E094;
	Tue, 11 Jan 2011 10:38:49 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx6.orcon.net.nz on Tue, 11 Jan 2011 10:39:02 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Tue Jan 11 10:39:03 2011
X-DSPAM-Confidence: 0.5736
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164898>

On 09/01/11 06:21, Luke Kenneth Casson Leighton wrote:
> On Sat, Jan 8, 2011 at 2:17 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> there are a few characteristics of bittorrent pieces that i see:
>> verifiable, resumable, uniquely identifiable across peers and
>> reasonbly small in count.
>>
>> The fixed size helps peers uniquely identify any pieces by splitting
>> the whole transfer equally and indexing them in 1-dimension.
>  ok - you haven't answered the question: are the chains perfectly
> fixed identical sizes?
>
>  if so they can be slotted into the bittorrent protocol by simply
> pre-selecting the size to match.  with the downside that if there are
> a million such "chains" you now pretty much overwhelm the peers with
> the amount of processing, network traffic and memory requirements to
> maintain the "pieces" map.

I'll respond also to this sub-point.  This can be done; but instead of
doing it at the pack level, you take the list of objects between A and B
(for a fetch from A to B), order them by some deterministic order
(called the "commit reel" in the Gittorrent RFC) and then carve that
list up into chunks based on the uncompressed object sizes.

The ordering defined in the RFC is such that it is possible to create
"thin" packs for discrete ranges of commits using existing plumbing, so
that the total transfer size is relatively similar to a complete clone. 
In experiments the network overhead was found to be around 10-20% in
this way.

However I must discourage looking for "inspiration" from the Bittorrent
protocol; it reinvents many wheels unnecessarily, and contains much
shonky advice in it.  See the revision history for the gittorrent RFC
(github.com/samv/gittorrent) for the gory details.

Sam
