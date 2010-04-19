From: Albert Dvornik <dvornik+git@gmail.com>
Subject: Re: [PATCH] Fix checkout of large files to network shares under 
	Windows XP
Date: Mon, 19 Apr 2010 18:46:52 -0400
Message-ID: <z2l9f74dc2c1004191546n5562759an54342e3efdaa9539@mail.gmail.com>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 20 00:47:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3zk4-0004VH-47
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 00:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770Ab0DSWqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 18:46:55 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:44860 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab0DSWqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 18:46:54 -0400
Received: by qyk9 with SMTP id 9so6289312qyk.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=WYfO6AQl4TY9kqK7PqBPUdcXi11ntMR1fGKjS35ulwc=;
        b=QZ+F3XpCCByFzvp/2XVRYAwwujtxa2qKhap6KargqEWDFl6ndt29LeCRymcAoE16LP
         jh8CPKDWefrmclztsWfR9vlDCackibk2EZxrSLW0RRJLHYE1bLPjCExhfwMjHRamKHbp
         myCUjtKmk46Ivb2bKmZ49RiJI5tqp/f+JQlJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=QEcLoMlnGfMy6zRbXEl+wMvIM9Dyxse/V5Rx0b251YULtsG2juYJ2WBZVHJ9yXgGMT
         uyJ7RzyFU8yw2c4F3g4tfvQOTwR5tQ4usocTsw8WMJllUSPZd1+WbhyqHrY1gD6pPORn
         lDRVQ6qUu//6QQgzhC19+YE62gzr92hwFT4nY=
Received: by 10.229.74.193 with HTTP; Mon, 19 Apr 2010 15:46:52 -0700 (PDT)
In-Reply-To: <4BCCC05E.4030206@lsrfire.ath.cx>
X-Google-Sender-Auth: 3e37d6ffbffad2b7
Received: by 10.229.212.213 with SMTP id gt21mr2019913qcb.2.1271717213065; 
	Mon, 19 Apr 2010 15:46:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145339>

On Mon, Apr 19, 2010 at 4:43 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
  [...]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (total + size > count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D c=
ount - total;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> Shouldn't the loop be left in the successful case, too? =A0write(2) i=
s
> allowed to write less than requested, so the caller already needs to
> deal with that case anyway.

That's what I thought initially, since the code would be cleaner, but
I don't like the fact that you could actually end up making a lot more
failed write() calls that way, since you restart the size search on
each call to mingw_write().

=46or example, suppose you were calling mingw_write() with a count that
was exactly 11.5 times bigger than whatever maximum size write() was
willing to accept.  If you only did one write() per mingw_write(),
letting the caller restart, this will result in 47 failed writes and
16 successes.  Letting mingw_write() do the restart (as in the
existing code) will end up with 4 failed writes and 16 successes.
Now, I assume (wait, this is Windows-- I'd *like to hope*) that a
failed write() is a lot cheaper than a successful one, but this still
rubs me the wrong way.

Of course, if we know (or can guess) the maximum size write() will
take, that would be best.

--bert
