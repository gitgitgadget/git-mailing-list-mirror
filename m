From: "James Pickens" <jepicken@gmail.com>
Subject: Re: [RFC PATCH 0/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 18:04:29 -0700
Message-ID: <885649360812181704l3a905ebfrb90f391e86004efc@mail.gmail.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
	 <494ABDC9.9060001@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Fri Dec 19 02:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDToM-0003uH-63
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 02:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbYLSBEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 20:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbYLSBEb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 20:04:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:11058 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbYLSBEa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 20:04:30 -0500
Received: by rv-out-0506.google.com with SMTP id k40so664853rvb.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fJS/Jr1eLrUuW2PMTpP6eLi3GS/AmB4r7Ulh1l6TMSc=;
        b=NS/qvH/1wHicHvpG314pjqmm4LEdREA1Tgf4FdUxQYW3wUgOyVJBZBdz+4GYtuqNnO
         qTs7M5OXqJF9/QYLW0L+WcapXfsqo/GLcxBwnEqyWBiuS99bIXpld5i5MyNZhutSL8Qr
         yYUbYLBom7B0ozvrNPqcaUDWxsOM1Y+cTVq90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B25f30w2XRcqFmFO7X202Ko2kSNftF75CVrZDtQr0Bp8Z16AwJTuGZCecWx5Qqsa52
         c0hs/7zy+Mf9+YIyxw8zdhb117bE1dFNp4lmtNfjdCPgGJiL5a0E/QUZGXBqdniLkWvK
         4M2yNYvTZOYQAifKj8KjXrS88exCRn93eS3XM=
Received: by 10.114.161.11 with SMTP id j11mr1524963wae.164.1229648669218;
        Thu, 18 Dec 2008 17:04:29 -0800 (PST)
Received: by 10.114.80.15 with HTTP; Thu, 18 Dec 2008 17:04:29 -0800 (PST)
In-Reply-To: <494ABDC9.9060001@morey-chaisemartin.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103524>

On Thu, Dec 18, 2008, Nicolas Morey-Chaisemartin
<devel@morey-chaisemartin.com> wrote:
> I guess you could do something like :
>
> #define checkout_lock()         core_threaded_checkout ?pthread_mutex_lock(&checkout_mutex) : (void) 0
> #define checkout_unlock()               core_threaded_checkout ?pthread_mutex_unlock(&checkout_mutex) : (void) 0

I tried that, and to make it easier to see the impact, I changed the
'wrote = write_in_full(...)' calls in entry.c to 'wrote = size'.  That
makes git just create a bunch of empty files instead of writing the real
contents to disk.  Here's the result, with core.threadedcheckout set to
false, best of 2 runs:

original patch:     3.19
original + above:   3.18

So the cost of locking/unlocking the mutex looks vanishingly small in the
single thread case.

This also puts an upper bound on the time required for a single thread to
unpack the data.

James
