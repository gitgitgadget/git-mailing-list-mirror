From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 19:20:18 +0200
Message-ID: <4A899152.8070607@gnu.org>
References: <20090817072315.4314.qmail@science.horizon.com> <alpine.LFD.2.00.0908171228570.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, bdonlan@gmail.com,
	johnflux@gmail.com, P@draigBrady.com, art.08.09@gmail.com,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:20:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5t9-0001pp-BX
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbZHQRUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbZHQRUV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:20:21 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:46722 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbZHQRUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:20:20 -0400
Received: by ewy10 with SMTP id 10so3114500ewy.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=j1oC3gNfpreMyuNBb7IPN+Nra5lIN30ujFYasBeVzWg=;
        b=XawKDt+fxtkLtxzvPNsHT/0Nin2qjMBx2HAWzR6UfkRSyz2s3PeiOugEcmsajoSCOo
         jpFo3Wd+mKPf9EIQUvhBHEOxXRCFcOZaerGbyqwF2xnTLHKd0eOx4AZKU4NzWqH4L0ak
         2WZbOxa6WTV4qH+eIuqRZKTyXrIg0mB92sqGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xTk1lzSoo/8auvJoktG3D12nzCLL9/BLauc1baJTzjz0GV5uCEAu34Z2LumfFJTayB
         nn5XYANNx5Ql0AJL8GEylJVK7EO3Lvy7o3n4XqFc1wP+ktZj8laNFWXUhldI6WtGzRNo
         W683LHYxMD2o3One1AYEjzkUcW5nH7n1mLv2c=
Received: by 10.210.78.16 with SMTP id a16mr7230967ebb.73.1250529621374;
        Mon, 17 Aug 2009 10:20:21 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 24sm755321eyx.3.2009.08.17.10.20.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 10:20:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <alpine.LFD.2.00.0908171228570.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126240>

> my first version of
> get_be32() was a macro that did this:
>
> #define SHA_SRC(t) \
>    ({ unsigned char *__d = (unsigned char *)&data[t]; \
>       (__d[0]<<  24) | (__d[1]<<  16) | (__d[2]<<  8) | (__d[3]<<  0); })
>
> With such a construct, gcc would always allocate a register to hold __d
> and then dereference that with an offset from 0 to 3.  Whereas:
>
> #define SHA_SRC(t) \
>     ({   unsigned char *__d = (unsigned char *)data; \
>          (__d[(t)*4 + 0]<<  24) | (__d[(t)*4 + 1]<<  16) | \
>          (__d[(t)*4 + 2]<<   8) | (__d[(t)*4 + 3]<<   0); })
>
> does produce optimal assembly as only the register holding the data
> pointer is dereferenced with the absolute byte offset.  I suspect your
> usage of inline functions has the same effect as the first SHA_SRC
> definition above.

Yes, that's what happens.

Paolo
