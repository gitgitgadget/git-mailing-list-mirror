From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 2/5] refs: split log_ref_write logic into log_ref_setup
Date: Wed, 26 May 2010 15:11:05 -0300
Message-ID: <AANLkTikPypcmGB6NuTl-SQZR3lnIvdmVG5E8wjVAlIej@mail.gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 
	<1274488119-6989-3-git-send-email-erick.mattos@gmail.com> 
	<7v632bs13c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 26 20:11:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHL4o-0002X7-JB
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 20:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252Ab0EZSL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 14:11:29 -0400
Received: from mail-gx0-f215.google.com ([209.85.217.215]:33368 "EHLO
	mail-gx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab0EZSL2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 14:11:28 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 14:11:28 EDT
Received: by gxk7 with SMTP id 7so2667276gxk.17
        for <git@vger.kernel.org>; Wed, 26 May 2010 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/w3G8RfQVGolNnbAHrNfwgaparyXQVxouSnB/c+SJcw=;
        b=vksJ/OYYOYghK7x0Jj5NOyzZzu76UdiSQuwwvyISQ7cV+otnSHclqpFOsEdOIj8D5n
         DUz4mkb2Zy4zAHrZbHQ/qNno4fWj7ueh7vXnauCB5Hu03h8enhPnMY3HjTlX/lOkPZdw
         LV8qOL49MOcDGkzV6ibcfmy1vxB55356dAFwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ijqoUc9HFt/2B5gUbKU3qgzJlfqWlbhQau0i361kmp5mKIHmwITvsh0UM1FHDaYRSi
         JdPWFuSnubygPWRhRhVbH+6qweavvlO16lPWBCTM4E1qCBcGkMcv2mCCqE/p/YeT98wm
         taEMA/vT5kHXrDwCaexu8TXJMC0tVytw9GuLY=
Received: by 10.151.88.8 with SMTP id q8mr9168030ybl.67.1274897487180; Wed, 26 
	May 2010 11:11:27 -0700 (PDT)
Received: by 10.151.39.17 with HTTP; Wed, 26 May 2010 11:11:05 -0700 (PDT)
In-Reply-To: <7v632bs13c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147815>

Hi there,

2010/5/26 Junio C Hamano <gitster@pobox.com>:
> I have a slight suspicion that it would have made the patch smaller a=
nd
> easier to read if you kept the name of the on-stack log_file[] as-is,=
 and
> named the retval parameter logfile_p or soemthing.

The size of the patch is indeed by the split/insertion which
complicates the diff's life.
If you compare both blobs you see it is not a hard change.  But we can
not hope for computer's intelligence during this lifetime.  ;-D

>  Also you would need to
> make this buffer "static char log_file[]", no?  Otherwise you would b=
e
> returning a pointer to a dead buffer to the caller.

Not really.  git_snpath() is taking care of setting up the buffer
dynamically in the heap.  The calling function presents its buffer by
reference thus only the pointer's address which its content is later
changed to point to the dynamic one.

>> +static int log_ref_write(const char *ref_name, const unsigned char =
*old_sha1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const unsigned char *new_sha1, const char *msg)
>> +{
>> + ...
>> + =C2=A0 =C2=A0 result =3D log_ref_setup(ref_name, &log_file);
>> + =C2=A0 =C2=A0 if (result)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;
>> +
>> + =C2=A0 =C2=A0 logfd =3D open(log_file, oflags);
>
> Yuck, the caller needs to call "setup" which discards the file descri=
ptor
> opened for writing and then open it again itself?

The separation of logic of setup from writing of the reflog and the
consequently created log_ref_setup was meant to just prepare the
reflog file.  This way it can be used consistently on different
functions.

At the moment It is being used on log_ref_write() and in
update_refs_for_switch().  In the first case it is interesting that
the reflog keeps opened to be used.  On the later case it is not.  So,
one of the calling functions would have to do something.

We have two approaches to that:
1. keeping the reflog opened and making sure the calling function close=
 it.
2. closing it and making the calling function open it or not as needed.

I have chosen 2 because of:
* I think it is safer to have any function closing open files,
cleaning variables or
  resources used by it whenever possible.
* It is more elegant that the function does what it is meant to do, in =
this case
  setting up the file only.
* It possibly keeps the code cleaner because only one 'close' for this =
function
  needs to be done and in the same place it happened the correspondent =
'open'.
* No approach was going to cost any resources more.

Now just a question, Junio:

I forgot to sign-off those patches, should I have to send them again?

Regards
