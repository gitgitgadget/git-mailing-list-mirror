From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pack-objects: no crc check when the cached version is used
Date: Sat, 14 Sep 2013 08:04:56 +0700
Message-ID: <CACsJy8BctT3C+oW9a5azzFUru89j-NZ-kGK_wgxhsjRZEKnq_g@mail.gmail.com>
References: <1379070180-15947-1-git-send-email-pclouds@gmail.com>
 <xmqq7gekk24q.fsf@gitster.dls.corp.google.com> <87k3ikct1e.fsf@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Sep 14 03:05:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKeIs-00033A-DA
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 03:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab3INBF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Sep 2013 21:05:27 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55101 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827Ab3INBF0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 21:05:26 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo20so1760779obc.13
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pUklKyKKlO9YCk6ejQ2RMqykPH/idBo0i0vkkapxt4U=;
        b=NXOFKHIceVok1kscpr27Uh97Awnqxc/jgbJOddMbXqll+H9Zvbl/SlD6vPpQz0+NAn
         RAmq0fAIjlZ2W3pEvLkRLcUGxiWZwmC7+lFPGHyabu4Eaa3izV/iBqCseIRkdTqyWVHs
         +ih3P3iELkmb/5sBfY/ERraU9ONl0CI1SkdIZM0OlhNPYyW0ih7feumT4tFbkQuBXwKW
         49KwSrNofkwRjo0xVtigEHzUFy7rEI094bkseI1jui2dXq83aWrP2D3OWSwalk6Ntp5t
         DbhlwzkVQQr3cXDSQYRf4u/354swovqnOwHHxRu8mXgD3Cc+gdYGZHRPEM3anvZX/9+U
         dOkw==
X-Received: by 10.182.101.165 with SMTP id fh5mr14711obb.58.1379120726374;
 Fri, 13 Sep 2013 18:05:26 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Fri, 13 Sep 2013 18:04:56 -0700 (PDT)
In-Reply-To: <87k3ikct1e.fsf@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234785>

On Sat, Sep 14, 2013 at 4:26 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> Current code makes pack-objects always do check_pack_crc() in
>>> unpack_entry() even if right after that we find out there's a cache=
d
>>> version and pack access is not needed. Swap two code blocks, search
>>> for cached version first, then check crc.
> [...]
>>
>> Interesting.
>>
>> This is only triggered inside pack-objects, which would read a lot
>> of data from existing packs, and the overhead for looking up the
>> entry from the revindex, faulting in the actual packdata, and
>> computing and comparing the crc would not be trivial, especially as
>> the cost is incurred over many objects we need to untangle in the
>> delta chain.  If you have interesting numbers to show how much this
>> improves the performance, I am curious to see it.

No I don't have any timing numbers. I just updated the code to see how
many times crc is checked and how many times we find a cached version
after crc is checked. The numbers with git.git are 353535 and 113257
respectively. IOW we could reduce the number of crc checks by 30%.

>
> I can't see anything wrong with the patch, but then I haven't stared =
too
> hard.  (It seems that my conversion around abe601b (sha1_file: remove
> recursion in unpack_entry, 2013-03-27) was faithful on this point, th=
e
> problem has existed for longer than that.)
>
> I tried the perf script below, but at least for the git repo the only
> thing I can see is noise.

--stdout does not set do_check_packed_object_crc, you need to run
pack-objects without --stdout (i.e. the real use case is repack)

>
> --- 8< --- t/perf/p5300-pack-object.sh --- 8< ---
> #!/bin/sh
>
> test_description=3D"Tests object packing performance"
>
> . ./perf-lib.sh
>
> test_perf_default_repo
>
> test_perf 'pack-objects on commits in HEAD' '
>         git rev-list HEAD |
>         git pack-objects --stdout >/dev/null
> '
>
> test_perf 'pack-objects on all of HEAD' '
>         git rev-list --objects HEAD |
>         git pack-objects --stdout >/dev/null
> '
>
> test_done



--=20
Duy
