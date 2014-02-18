From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 07:59:22 -0800
Message-ID: <20140218155842.GA7855@google.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org>
 <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 16:59:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFn54-0000wu-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 16:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbaBRP7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 10:59:30 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:56355 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735AbaBRP73 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 10:59:29 -0500
Received: by mail-pd0-f171.google.com with SMTP id g10so16414046pdj.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/oRlGBpf52wLGRB2ko9HBtvU9Y+QVtJmaNqGKOyTIWQ=;
        b=DEsIsZvnOB6f624LUJqNkKUR3/ZcrYJePz93sqAfaYdMkcb7eMvnUueMt/N3wqPUux
         TQl8LBV46MJ20zdSbe9vofwaWOeb9ZktuSKaB1qsT3GL8jLASBPwmdIQukN3dUgmUaGa
         az2Pez54nI+/zlqLiFYusbM2xfDlDWEH1Z46g0unmYfQ8qkXBqvKVnKxkc58ND3EO3eO
         o7rRqdNvxWuqU+KzKnWsJV3BcbwmamBNJ/oSobGzNiV4E/kOqqzHuE9LcrTmpy/xmCfF
         qUIjTR3pMwRow6D+Jn4wfEBFATK3XSavFvjXH64mT3T82g/AWAcPZjgb0eTn1mCDb9mK
         fnaQ==
X-Received: by 10.68.170.66 with SMTP id ak2mr33812289pbc.5.1392739169325;
        Tue, 18 Feb 2014 07:59:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y9sm145048500pas.10.2014.02.18.07.59.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 07:59:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87ioscsoow.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242329>

David Kastrup wrote:
> Duy Nguyen <pclouds@gmail.com> writes:

>> Likely because --aggressive passes --depth=250 to pack-objects. Long
>> delta chains could reduce pack size and increase I/O as well as zlib
>> processing signficantly.
[...]
> Compression should reduce rather than increase the total amount of
> reads.

--depth=250 means to allow chains of "To get this object, first
inflate this object, then apply this delta" of length 250.

That's absurdly long, and doesn't even help compression much in
practice (many short chains referring to the same objects tends to
work fine).  We probably shouldn't make --aggressive do that.
Something like --depth=10 would make more sense.

Hoping that clarifies,
Jonathan
