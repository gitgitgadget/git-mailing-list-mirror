From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Mon, 9 Aug 2010 16:35:11 +0400
Message-ID: <AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
	<wesy6cgm6wd.fsf_-_@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Kanis <expire-by-2010-08-11@kanis.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, Avery Pennarun <apenwarr@gmail.com>,
	jnareb@gmail.com, git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 14:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiRZa-0003bY-12
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 14:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab0HIMfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 08:35:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64770 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382Ab0HIMfN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 08:35:13 -0400
Received: by qwh6 with SMTP id 6so7179380qwh.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I4mD5YlYteYbZ86BzHRdSYc/cPsCOkku5gX5Nok6i8M=;
        b=X69J0A8cf95kGAIr6lpGHJJ90P5Ic0/naMkWWj2Y/LmfwcWxA1hQwNVR4aPxotVq+5
         nykjcWeuDGLTL9SozyugTx45v2Oy/HXqgreK6ZTNLttE0cenBbt0X9N5p7YsZ2O4w5NK
         9qoO4/g0++sM5NDj4xvBXKyuiw8RQRFdYVcp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=knb7TF1ZFjBWON4zsr3F6l/MKe9Q6F/h8F5bEBtwsU/tThTpetak3oe3bwzfyoU6ml
         CAlUZL6C4TAHuPn+72vGakjGgg3x/0vUGsDfAVywe0OvICg+SRdn8PL4m9mNyBnUPWFK
         94X8Q3BlGpZeUpd+aDDf/wD1pE8r5HP0NKudg=
Received: by 10.224.56.75 with SMTP id x11mr8535233qag.278.1281357311710; Mon, 
	09 Aug 2010 05:35:11 -0700 (PDT)
Received: by 10.229.251.3 with HTTP; Mon, 9 Aug 2010 05:35:11 -0700 (PDT)
In-Reply-To: <wesy6cgm6wd.fsf_-_@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152963>

On Mon, Aug 09, 2010 at 12:12:34PM +0200, Ivan Kanis wrote:
>
> I have clone identical repositories and the system starts to swap. I
> think it shows that cloning two repository doesn't share mmap.

Though Git uses MAP_PRIVATE with mmap, this only marks mapped pages as
copy-on-write. Because cloning does not change the pack file, all those
pages should be shared. So, the only reasons for swapping could be:
- each cloning operation access to different pages at the same time, so
  it means more pages have to be loaded in memory to allow two programs
  to run simultaneously.
- each operation allocates 387Mb (accordingly to your earlier data), so
  it may add more memory pressure.

>
> I saw this constant defined in git-compat-util.h
>
> /* This value must be multiple of (pagesize * 2) */
> #define DEFAULT_PACKED_GIT_WINDOW_SIZE \
> =A0 =A0 =A0 =A0(sizeof(void*) >=3D 8 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? =A01 * 1024 * 1024 * 1024 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: 32 * 1024 * 1024)
>
> If I read this correctly git is allocating 1G of mmap on 64 bit
> architecture. Isn't that a bit much?

On 64-bit architecture, you have plenty virtual space, and mapping
a file to memory should not take much physical memory (only space
needed for system tables). You can reduce core.packedGitWindowSize
in the Git configuration to see if it helps, but I doubt that it
will have any noticeable effect.


Dmitry
