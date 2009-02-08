From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] use lock token in non-URI form in start_put
Date: Sun, 8 Feb 2009 09:45:52 +0800
Message-ID: <be6fef0d0902071745r355309c2o76622b3af8df53bc@mail.gmail.com>
References: <498DE0B9.6080603@gmail.com>
	 <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
	 <7v1vuavv4l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 02:47:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVylX-0007Ro-0H
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 02:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbZBHBp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 20:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZBHBp4
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 20:45:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:5398 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbZBHBpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 20:45:55 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1325269rvb.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 17:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZLuDDviaYVKqJjJw4394XGM71EePkTZy1BFORznj4yA=;
        b=PG+jTMeTqsL9KvmB+tdR+vwsYk9MRsc0XciIy6Co2u40z/Jixz/u4ig7mMOYhtYaxo
         95oDoI/Mc2fP7sCoG3LN36wiDzZjdHcBj5GJZDoBRKkYVpfSk0rjNhY87wUuqHR3VzU4
         7glyEoyO2cPJmUzUyJ9j/KVjCg3KVc2WKzen8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZSwizVo9jjA6BDdrmKmMekwECuqhDwXv7qCTt1pa/DPt8xHEW3Tl7E6sj+l0L31V5z
         RNhx206kL2RFRwpJimdCa92sWsthZVkvY412SI2qqXmqpyfl25gMd7GWqfHuoIWR9gIu
         SXCOik7yuqzVrdnoyQ+kLHjIxtayo0/Zd6NIc=
Received: by 10.114.192.3 with SMTP id p3mr2426008waf.166.1234057552475; Sat, 
	07 Feb 2009 17:45:52 -0800 (PST)
In-Reply-To: <7v1vuavv4l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108910>

Hi,

On Sun, Feb 8, 2009 at 4:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Let me show more of my ignorance around this codepath.
>
> What is the real purpose of this appending?  My understanding is that it
> is to ensure that a tentative PUT goes to a new file, so that a DAV server
> whose PUT is not atomic (i.e. can leave a half-written bogosity when the
> operation fails for whatever reason) won't leave a broken object in its
> object store.  We MOVE it to its final destination and expect that to be
> atomic.

This happens to be my understanding as well.

> Does the server side guarantee that the lock token string is unique in the
> sense that it does not reuse a token that was used for a recent
> transaction that was aborted?  If there is no such guarantee, then using
> (a part of) the lock token as the string we append is no better than using
> a random string we choose ourselves.

In section 6.5 which you cite below, the token is unique, and we hold
the server's word for it.

> We may need to send the exact lock token back for unlocking the
> transaction we started, but I do not think it necessarily is a good idea
> to tie that to the random string we would use for PUT-then-MOVE operation.
>
> RFC 4918 (section 6.5) explicitly states that the servers are free to use
> any URI so long as it meets the uniqueness requirements, so relying on it
> being any form of uuid does not sound like a good idea.  It can contain
> not just a colon but other potentially problematic characters, such as a
> slash, no?
>
> That is why I asked in my previous question what in the codepath protects
> ourselves from using problematic characters.
>

You're right, section 6.5 doesn't enforce that lock tokens are UUIDs.

Any solutions to this? Perhaps one could have a function, say,
get_unique_remote_postfix, and the function would check for URI
schemes which we know are safe for use in file names, namely,
"urn:uuid:" and "opaqulocktoken:". However, if its a URI we are unsure
of, then it would generate a random string.

-- 
Cheers,
Ray Chuan
