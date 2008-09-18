From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Thu, 18 Sep 2008 12:31:35 +0100
Message-ID: <b0943d9e0809180431x30c8f751g374732ee861ffe61@mail.gmail.com>
References: <20080912215613.10270.20599.stgit@localhost.localdomain>
	 <20080914085118.GC30664@diana.vm.bytemark.co.uk>
	 <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
	 <20080915075740.GB14452@diana.vm.bytemark.co.uk>
	 <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
	 <20080916074024.GA2454@diana.vm.bytemark.co.uk>
	 <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
	 <20080916193647.GA12513@diana.vm.bytemark.co.uk>
	 <b0943d9e0809170909j4fce34acr8f0b844d0cb5281d@mail.gmail.com>
	 <20080918072450.GB12550@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 13:32:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgHkc-00006x-JQ
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 13:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYIRLbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 07:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYIRLbi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 07:31:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:43049 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYIRLbi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2008 07:31:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3673577rvb.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6qAN8T4xbYIjNLLCAxwL/st8gv6b3al66h8eC7im93U=;
        b=iYnbX8A62tVbElckPevL9EkscHx8EzMJ1yxgD/cKa6kTgQXSXs9CR74+QtzfUNnCCi
         WH7jV/NGWBlnRPvi86YXBNW3tjfjJaZq7HAfyoJ32J9tCC1L9cToAH2bmE8VTTREiXnN
         oDkk/vLKWhhkp41DSuaXbjhlV06ieiYiA4xWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=r/GTLMA+9nAAl981Y0PiSBvfq7ZtVRx2FIB3un0eJKYYTwfvYYI6sYcrSTiESgzRK6
         WXd7d6j22hr4BMZouSWTP1Mpn+1lCVykamA84tz6kZ6qTFT1AylxWhGTdEYEm7mUI+aV
         MdzTXeF2zZKbCZARVP4wpHSJGF5UHfmfuosJ8=
Received: by 10.140.132.3 with SMTP id f3mr7349918rvd.277.1221737495071;
        Thu, 18 Sep 2008 04:31:35 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Thu, 18 Sep 2008 04:31:35 -0700 (PDT)
In-Reply-To: <20080918072450.GB12550@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96193>

2008/9/18 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-17 17:09:46 +0100, Catalin Marinas wrote:
>
>> I'm still confused by this and I don't think your new flag would
>> help. The meaning of stop_before_conflict is that it won't push the
>> conflicting patch but actually leave the stack with several patches
>> pushed or popped.
>>
>> What I want for sink (and float afterwards) is by default to cancel
>> the whole transaction if there is a conflict and revert the stack to
>> it's original state prior to the "stg sink" command.
>
> Ah, OK. Then I think you want something like this:
>
>  try:
>      trans.reorder_patches(applied, unapplied, hidden, iw)
>  except transaction.TransactionHalted:
>      if not options.conflict:
>          trans.abort(iw)
>          raise common.CmdException(
>              'Operation rolled back -- would result in conflicts')
>  return trans.run(iw)

I tried this before but trans.abort(iw) seems to check out the iw
index which is the one immediately after the push conflict, though the
stack is unmodified, i.e. stg status shows some missing files (which
are added by subsequent patches after the conflicting one) and a
conflict.

What I would need is a way to save the original iw and and run
trans.abort(iw_original).

Or simply give up on the --conflict option and always stop after the
conflict (catch the exception and don't re-raise it). This way we
don't have to bother with checking out the initial state. With the
"undo" command in your branch, people could simply revert the stack to
the state prior to the sink command. Maybe that's a good idea so that
we don't complicate commands further with different conflict
behaviours.

--=20
Catalin
