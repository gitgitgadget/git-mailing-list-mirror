From: Shawn Pearce <spearce@spearce.org>
Subject: Re: pack corruption post-mortem
Date: Sat, 19 Oct 2013 12:17:52 -0700
Message-ID: <CAJo=hJugNGkpDxh6o6azVGc7pP3fTGsK113vRgb4A7ipNeV2ZA@mail.gmail.com>
References: <20131016083400.GA31266@sigill.intra.peff.net> <CACsJy8ABdE8mZMVFZkqYMC4ZeN_baWw=XcYOZYBCZytWP97rRw@mail.gmail.com>
 <alpine.LFD.2.03.1310191024000.1951@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Oct 19 21:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXc2V-0004eE-FY
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 21:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab3JSTSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 15:18:15 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44092 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JSTSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 15:18:14 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm4so2385330wib.12
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0Gc/2mL/KVe5TTZAv8IT2FS1g1b1B1bmNG3TcC06eU0=;
        b=elF8j3iCJbpth/lUAc5pwVKFW3sNNV8R6r06uI1SyXtP67JhPnOUXnYf3I2Nvfs8xS
         oX2OHPBbP8L+tGf9N6WkScK0y7BNtNMXfgPEfwZtAJdLws8j3R5a40dlBd3uyqOLKV0w
         IAJa3iNc7Yef1WuLx0bk4lWdwU6uhcL5Y1ONg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0Gc/2mL/KVe5TTZAv8IT2FS1g1b1B1bmNG3TcC06eU0=;
        b=l776+39YhhlfXGMCsd2jzKHfHb8UD87765hQyfEAx2DXigzjTaEuapMefOwyJcABAj
         IRHLtO1UfKptvpkw5Tw5OvIwQ42uYHYHvp3oPgziKHQhUlDKkb/oAcD5c5Bu5uGIGpcJ
         XW0tiIyzLxbXjQ2ZBVpLf7Lm0VhWP29yh0lH9zgVY0TjJUuVx07W7bFcimMiSbRr2b/g
         iKL93zfqWxubostjPqHJ+bEyfkVrUuL9N9X4Gq0tew4gOXsdWFUE06gYYpPzdQORI0R/
         DVB434Z2hpTSJ0xvlbSn96SclcL0HhF2YYIEFn8hYiI1W/D4UYcRzNnzr5VNDs5HRHMa
         eyrQ==
X-Gm-Message-State: ALoCoQnXGTgVqv3ozJyrSNFkyqGNEhaPxhytfceBwVWlaQM+zh9iI0bB/CTxMPHUub7ytfi3CnI0
X-Received: by 10.180.198.115 with SMTP id jb19mr3900444wic.28.1382210293118;
 Sat, 19 Oct 2013 12:18:13 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Sat, 19 Oct 2013 12:17:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1310191024000.1951@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236404>

On Sat, Oct 19, 2013 at 7:41 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 19 Oct 2013, Duy Nguyen wrote:
>
>> On Wed, Oct 16, 2013 at 3:34 PM, Jeff King <peff@peff.net> wrote:
>> > I was recently presented with a repository with a corrupted packfile,
>> > and was asked if the data was recoverable. This post-mortem describes
>> > the steps I took to investigate and fix the problem. I thought others
>> > might find the process interesting, and it might help somebody in the
>> > same situation.
>> >
>> > I started with an fsck, which found a problem with exactly one object
>> > (I've used $pack and $obj below to keep the output readable, and also
>> > because I'll refer to them later):
>> >
>> >     $ git fsck
>> >     error: $pack SHA1 checksum mismatch
>> >     error: index CRC mismatch for object $obj from $pack at offset 51653873
>> >     error: inflate: data stream error (incorrect data check)
>> >     error: cannot unpack $obj from $pack at offset 51653873
>>
>> I wonder if we should protect the sha-1 and pathname tables in packv4
>> with CRC too. A bit flipped in there could cause stream of corrupt
>> objects and make it hard to pinpoint the corrupt location..
>
> It turns out that we already have this covered.
>
> The SHA1 used in the name of the pack file is actually the SHA1 checksum
> of the SHA1 table.

I continue to believe this naming is wrong. The pack file name should
be the SHA1 checksum of the pack data stream, but the SHA1 table. This
would allow cleaner update of a repository that was repacked with
different compression settings, but identical objects.
