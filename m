From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/5] fetch-pack: prepare updated shallow file before
 fetching the pack
Date: Thu, 2 May 2013 17:04:38 +0700
Message-ID: <CACsJy8D8DT4P2gGp-Z3v_mi_9k-uKiYEnwJ3rGPHkCMGZu3_FA@mail.gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com> <1367405974-22190-3-git-send-email-pclouds@gmail.com>
 <7v61z25tuf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 12:05:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXqO8-00045b-NV
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 12:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab3EBKFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 06:05:12 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:58996 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab3EBKFL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 06:05:11 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so343520oag.31
        for <git@vger.kernel.org>; Thu, 02 May 2013 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=a+Wzfzs5yECENIcBcPcbzzmblaVNJA9HOT1r8fBxOz4=;
        b=Y62FMijXwkCw1oCfGF1fWhKm1m67h8yn1qbyzMT32ovmZrM4dxTnorqo+p7XSUW+/s
         qTlXvg2BsoIkPLJrBC8NiIYjAoY1uou7lKuBY2jNFAfi6ZvbKhx6+CgnyrxXU6p6svXe
         pjK76WDG41Jub2YYoAFE40LYAMZgAkaSKjrjIRzuwCIfHZz7s3JEE9PDSBbo/qvWLlnX
         i7aOTVc5VS6pPFhEROzeCCqQxY0r+Yhhmbx06CUZF0cFoaqd+ez5AV/LlebTdESiWnGk
         nwDUW7SGujy0THsbJdk1kjA+qd8kBvrQ4m24mMwl+eC+SXwOSPStbBe9BE3ZBHdDO5V7
         rQqw==
X-Received: by 10.60.57.3 with SMTP id e3mr1510920oeq.101.1367489108144; Thu,
 02 May 2013 03:05:08 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 2 May 2013 03:04:38 -0700 (PDT)
In-Reply-To: <7v61z25tuf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223187>

On Thu, May 2, 2013 at 3:27 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> index-pack --strict looks up and follows parent commits. If shallow
>> information is not ready by the time index-pack is run, index-pack m=
ay
>> be lead to non-existent objects. Make fetch-pack save shallow file t=
o
>> disk before invoking index-pack.
>>
>> A new environment variable GIT_SHALLOW_FILE is used to inform
>> index-pack to use an alternate shallow file. This variable is for
>> internal use and thus not advertised in git.txt.
>
> The idea to tell the index-pack to use a different shallow file is
> sound, but is the environment variable the best way to go?  I am
> mostly worried about it being an implicit "apply everywhere"
> mechanism and while I do not particularly like the idea of doing
> everything in the same process as the top-level while dealing with
> submodules, I am reasonably sure people would want to "clone"
> recursively inside the same top-level process in the future, and
> this new environment variable adds one more thing to be cleansed
> when crossing a repository boundary.

=46irst of all, fetch does check that GIT_SHALLOW_FILE must not be set
before it updates shallow file, so if fetch is run recursively, the
inner one will get caught. And GIT_SHALLOW_FILE is only set for a
period of time when pack is received. Unless somebody launches fetch
inside index-pack, we should be safe.

That said, passing this info via a --shallow-file is not hard to do
(so I will likely do it). But I wonder how submodule code handles the
case where the user set GIT_OBJECT_DIRECTORY or similar variables.
GIT_WORK_TREE for example could be set internally by git and
propagated down to submodule subprocesses..
--
Duy
