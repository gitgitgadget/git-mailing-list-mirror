From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 21:05:45 +0300
Message-ID: <37fcd2781002221005l2a8ecb64y3be84eaaacd27cdc@mail.gmail.com>
References: <20100214011812.GA2175@dpotapov.dyndns.org>
	 <20100219082813.GB17952@dpotapov.dyndns.org>
	 <7v635tkta7.fsf@alter.siamese.dyndns.org>
	 <7v8waniue8.fsf@alter.siamese.dyndns.org>
	 <20100221072142.GA5829@dpotapov.dyndns.org>
	 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
	 <20100222033553.GA10191@dpotapov.dyndns.org>
	 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
	 <20100222173122.GG11733@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjcfJ-0006CF-Ix
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab0BVSFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 13:05:48 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:62285 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab0BVSFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 13:05:47 -0500
Received: by fxm19 with SMTP id 19so2787245fxm.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=qCeKWOKaowxFKJV8T3kSWJdhldz7dAF6Sp3+fMN6484=;
        b=jAaxsd8tg4qJ4Bho9amb3GBmSGPTSgs7/m3phRakmq28kwDbQ3nP60LaAm9N6V85yQ
         qNWsO8BLbvZU6vWo2um8i5RDH9jrzoUT+V/yQD0l8VZoGyTgBiSySppZnSD9I/X3ES6/
         /rRb7Djvf4K5/qui+ON0GXKMI/DHltsMH70v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=L5Q7qD5htPTVgeojIv0TfNAInsP995NZvgWoNrVK1QP/dUo2mqW5YbLI8/uSyA/YCC
         ukkb8sJXEUCVkhZraVWN/MZyybXuxYhjhVHXCega1LE5OiXzo81RgMPIOhuhwe9RzciM
         kDIV/n9/5spsBzyoq+mYdjATqlOxSDLDjq48E=
Received: by 10.239.146.210 with SMTP id x18mr1658175hba.77.1266861945580; 
	Mon, 22 Feb 2010 10:05:45 -0800 (PST)
In-Reply-To: <20100222173122.GG11733@gibbs.hungrycats.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140702>

On Mon, Feb 22, 2010 at 8:31 PM, Zygo Blaxell
<zblaxell@gibbs.hungrycats.org> wrote:
>
> If you're read()ing a chunk at a time into a fixed size buffer, and
> doing sha1 and deflate in chunks, the data should be copied once into CPU
> cache, processed with both algorithms, and replaced with new data from
> the next chunk.

Currently, we calculate SHA-1, then lookup whether the object with this
SHA-1 exists, and if it does not, then deflate and write it to the
object storage. So, we avoid deflate and write cost if this object
already exists. Moreover, when we deflate data, we create the temporary
file in the same directory where the target object will be stored, thus
avoiding cross-directory rename (which is important for some reason, but
I don't remember why).  So, creating the temporary file requires the
knowledge first two digits of SHA-1, which you cannot know without
calculation SHA-1.

So, the idea of processing file in chunks is very attractive, but it has
two drawbacks:
1. extra cost (deflating+writing) when the object is already stored
2. some issues with cross-directory renaming


Dmitry
