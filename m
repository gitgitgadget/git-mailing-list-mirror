From: "Brandon Casey" <drafnel@gmail.com>
Subject: Re: [PATCH 1/3] repack: modify behavior of -A option to leave unreferenced objects unpacked
Date: Sat, 10 May 2008 23:16:44 -0500
Message-ID: <ee63ef30805102116m68e83fadr8ef9afb080d26cf0@mail.gmail.com>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
	 <3927888.1210392047922.JavaMail.teamon@b303.teamon.com>
	 <20080510060345.GC11556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 06:18:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv30c-0003DO-OZ
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 06:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbYEKEQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 00:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbYEKEQr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 00:16:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:61082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYEKEQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 00:16:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1343599fgg.17
        for <git@vger.kernel.org>; Sat, 10 May 2008 21:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dSbRcUeU+HGvsI+Gvrdf/3o1lADij+STBz9AiRYY3fw=;
        b=ik16yUp/sbiZD7JXSEorI4pFHDFCtth6t8EnyqB4Rr3Us0XMCl1f/gEqYdJILhKXFXReVCnXv+KAxrtoxreeNUOjOWg34O0oUUvHm25rDKLIggvoknfVncEyIHKdgoaUAi56L8/EJV0P14fR0quHmJcZfvA6Se5GMFGazQuZu0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RsOcObJrhKsmPSp9bEQYGvwrygV8W+YKZUO/buDPMot3BTENxHCb9LqNEPciD084aTjv4N23piCb0gY3XbY18fn4elUmX69IxVMXjYjN23vmC/4X66S+2elVj720wcFjuKMrva430UghcZV7fQF0t5nG/hfeOiXESG3+7Evpdro=
Received: by 10.86.90.2 with SMTP id n2mr11658443fgb.51.1210479404162;
        Sat, 10 May 2008 21:16:44 -0700 (PDT)
Received: by 10.86.89.8 with HTTP; Sat, 10 May 2008 21:16:44 -0700 (PDT)
In-Reply-To: <20080510060345.GC11556@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81730>

On Sat, May 10, 2008 at 1:03 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 09, 2008 at 11:01:55PM -0500, drafnel@gmail.com wrote:
>
>> -             keep_unreachable=--keep-unreachable ;;
>> +             keep_unreachable=t ;;
>
> Can we call this something else (like unpack_unreachable) since it now
> has nothing to do with the --keep-unreachable flag?

Actually I initially changed it to unpack_unreachable, and then
changed it back. The reason I did this is because I think
keep_unreachable still describes what is being accomplished, that
unreachables are being kept. When -A is supplied along with -d,
unreachables are kept by being unpacked. When -d is not supplied,
unreachables are kept in their original pack file. If Geert's proposal
or something else is implemented, keep_unreachable may still be
appropriate. hmm?

> Also, should --keep-unreachable be deprecated / removed?
>
>> +                     *)
>> +                             rm -f "$e.idx" "$e.keep"
>> +                             if test -n "$keep_unreachable" &&
>> +                                test -f "$e.pack"
>> +                             then
>> +                                     git unpack-objects < "$e.pack" || {
>> +                                             echo >&2 "Failed unpacking unreachable objects from redundant pack file $e.pack"
>> +                                             exit 1
>> +                                     }
>> +                             fi
>
> I still like Geert's suggestion of unpacking them to a _different_
> place. That helps to avoid spurious "gc --auto" invocations caused by
> too many prunable objects. Though it certainly doesn't solve it, and
> maybe that just needs to be fixed separately.

That was my thinking.

>
> Possibly the "gc --auto" test should be:
>
>  - count objects; if too few, exit
>  - count unreachable loose objects; if too few, exit
>  - run gc
>
> That means having a lot of unreachable objects will still incur some
> extra processing, but not as much as a full repack. And it won't bug the
> user with a "you need to repack" message.

I've got a thought. How about limiting how often auto repack repacks
by looking at the timestamp of the most recent pack? Wouldn't the
packs already be prepared in most cases i.e. prepare_packed_git()

-brandon
