From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Fri, 6 Feb 2009 12:14:20 +0100
Message-ID: <cb7bb73a0902060314u4741528bs196a43d45ff7f283@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050038.57999.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:15:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOgY-0004kc-P6
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbZBFLOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbZBFLOX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:14:23 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:50187 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbZBFLOW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:14:22 -0500
Received: by ewy14 with SMTP id 14so1228442ewy.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ilLRC4PKyeEyax6kfw7LZ/TOhxUPBDoZq7e+l3oIrFg=;
        b=P9Rr5eXuHkWqpxgxtwjj4MAX3RwvYa0TM3PgK+PqxzXcJva/wxwOC1JchEVun9frjt
         oPA0/sMMvctDBisaCRZ2SE7gFVMC4oCAz3mikLrytbRn4mYf/QP9vNP4C9yN9DXhJGEG
         fPtV8iN7F+zFPr7bU6sblzWdcZblYXS89krzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DUkKf0AyYqhMa+FS5jwnDMmSLokn1RpT4ZwXJcU1FN25S3WgGf3PV3l63cgqevmQHA
         UBs2MM7LaOEfhixcUVPthpmf1ixjgNvgIzPT58yPOEKeTxwtYkZXZB7ZAUrnLcetQtYd
         oTMJc32Pi+Z6J9jofr1Pue66pY/uvMx9VcU7Q=
Received: by 10.210.88.3 with SMTP id l3mr288220ebb.189.1233918860834; Fri, 06 
	Feb 2009 03:14:20 -0800 (PST)
In-Reply-To: <200902050038.57999.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108684>

On Thu, Feb 5, 2009 at 12:38 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> The last-modified time header added by RSS to increase cache hits from
>> readers should be set to the date the repository was last modified. The
>> author time in this respect is not a good guess because the last commit
>> might come from a oldish patch.
>>
>> Use the committer time for the last-modified header to ensure a more
>> correct guess of the last time the repository was modified.
>
> First, changing %latest_date from author time to committer time affects
> not only Last-Modified HTTP header, but (after this series) also
> various "publication dates" in the feed contents.  But I think that for
> all those committer time is better approximation of publication date
> and last change date than author time.
>
> Second, author time reflects when change (commit) was made, according
> to authors (perhaps skewed) clock.  Committer time reflects when given
> commit (version of a commit) was entered into repository, or to be more
> exact into some clone of given project.  But there is also an issue of
> when changes got into given instance of repository (given clone): that
> I guess might be found by stat-ing HEAD (if it arrived by commit),
> FETCH_HEAD (if it arrived by fetch or pull) and ??? (if it arrived by
> push)... err... it looks like it wouldn't work in most common case,
> sorry, unless we want to stat all refs and packed-refs file. But while
> this date might be better for Last-Modified, I'm not sure if it is good
> at all for publication date.
>
> So committer time is better than author time, and looks like good
> middle ground.

Oops should have finished reading your comments before my previous
reply. The solution would be to introduce a way to determine robustly
when a branch was last _physically_ updated. Checking the
corresponding entry in refs/ would work for non-packed refs, and maybe
one would hope that if the ref got packed, it means it hasn't updated
in a long time ... but I'm not enough of an expert on git's internal
to really know about this. Suggestions?


-- 
Giuseppe "Oblomov" Bilotta
