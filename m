From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Thu, 21 Aug 2014 20:06:23 -0700
Message-ID: <1C5353D0-E5E1-466B-855E-2E5D8A54AE93@gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com> <1408485987-3590-19-git-send-email-gitster@pobox.com> <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com> <xmqqvbplpg2s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 05:06:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKfBT-0004wV-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 05:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbaHVDG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 23:06:28 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61725 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbaHVDG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 23:06:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so15115652pdj.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 20:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=Iyb4uuxxODvmFLcCYzEeu+KfCBDtsGBS/TTQqQx8t/s=;
        b=k9NJr43obkPhcSEGWiHB4yGIq/Tm7JrzpLeemrCtZiBZzCJeXkMpe34hn+nVUdZGOQ
         3Mbnp7i+dm26yYHCc+HYN9UvztSD6w/bUdHsRVDihwArBCDlgdcOVtX2DD8VqoRvDowr
         pH87b3ufz9kruM1xy7nYBR5gDzqfK993KrEYS/w5qBYZlwAb3xXjU+IeHOBR0tew7Gvd
         PTKIIFzvv9wQqzpOYVKaQiVoKZ5kKCWTPDwWBHJ90BnSEPpBIcE9CVgf6GFIXF0QXKX5
         CEwzFGcnybDMobiobcAJccVsqRvaZtfd79p94LrmnFuexPEH1F5n+0Q18XJRh876at/w
         GMsw==
X-Received: by 10.70.129.162 with SMTP id nx2mr2783873pdb.73.1408676787469;
        Thu, 21 Aug 2014 20:06:27 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id f9sm41178429pdp.43.2014.08.21.20.06.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Aug 2014 20:06:26 -0700 (PDT)
In-Reply-To: <xmqqvbplpg2s.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255651>

On Aug 21, 2014, at 16:40, Junio C Hamano wrote:

> * The receiving end will issue "push-cert=<nonce>" in its initial
>   capability advertisement, and this <nonce> will be given on the
>   PUSH_CERT_NONCE environment to the pre/post-receive hooks, to
>   allow the "nonce <nonce>" header in the signed certificate to be
>   checked against it.  You cannot capture my an earlier push to the
>   authoritative server and replay it later.
>
>   That would all work well within a single receive-pack process,
>   but with "stateless" RPC, it is unclear to me how we should
>   arrange the <nonce> the initial instance of receive-pack placed
>   on its capability advertisement to be securely passed to the
>   instance of receive-pack that actually receives the push
>   certificate.

Have you considered having the advertised nonce only be updated after  
receipt of a successful signed push?

It would eliminate the stateless issue.  And since the next nonce to  
be advertised would be updated at the successful completion of a  
receive of a signed push no replay would be possible.  (I'm assuming  
that receive hook activity is already pipelined in the case of  
simultaneous pushes via some lock file or something or this scheme  
falls apart.)

The obvious downside is that only one of two or more simultaneous  
signed pushers could succeed.  But the sender could be modified to  
automatically retry (a limited number of times) on a nonce mismatch  
error.

A receive hook could also be responsible for generating the next nonce  
value using this technique.
