From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git_open_noatime: return with errno=0 on success
Date: Wed, 8 Jul 2015 14:51:31 -0400
Message-ID: <CAPig+cSacM_JwZzagOVZpMJF=oE7m3rMnq1eKr=aNsGY0vvmfQ@mail.gmail.com>
References: <20150708123820.GA25269@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?Q?Martin_Schr=C3=B6der?= <martin.h.schroeder@intel.com>
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 20:51:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCuRW-0005fq-6L
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 20:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbbGHSve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 14:51:34 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34120 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbbGHSvc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 14:51:32 -0400
Received: by ykcp133 with SMTP id p133so29069027ykc.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=fotez7GoF/PRSmwAXBTOwiA7WXH6Ipiut3CGzTPo3iM=;
        b=WPByYThEb9+gglVGaxj3Ymdk7d7hXw8+PLBafR9u3N8NgAjNJ074+0g1qfKtZSk6WI
         VBct64NBYIBrW5gmsB3yN7SucC06GdusV1FK5uegaQp278ZUXTLRDIISz/mQo7rXowuK
         481yjbs9F3k/7GBb2nEQoVVIHA3jSnB3RfbDWw2fJqkuV+3C3yPKYeiVw/X31qvk5fje
         wpwcRQGvfoXA1VS0KWjDs74cxvIAByxsGGiRN4GmMkIZNi9Mnhde91R8OxeuyM0dshQn
         +VG3HgZQy+6s24EIMk5CtqjhFQ9Uaai8TaTO8MuFVMrvI5pfNbwm2tTKh80mVqgZzaq1
         43mA==
X-Received: by 10.170.196.85 with SMTP id n82mr13086470yke.127.1436381491832;
 Wed, 08 Jul 2015 11:51:31 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 8 Jul 2015 11:51:31 -0700 (PDT)
In-Reply-To: <20150708123820.GA25269@musxeris015.imu.intel.com>
X-Google-Sender-Auth: hbNoDDgf7jfPJa2G69RlaTXkgZU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273701>

On Wed, Jul 8, 2015 at 8:38 AM, Clemens Buchacher
<clemens.buchacher@intel.com> wrote:
> In read_sha1_file_extended we die if read_object fails with a fatal
> error. We detect a fatal error if errno is non-zero and is not
> ENOENT. If the object could not be read because it does not exist,
> this is not considered a fatal error and we want to return NULL.
>
> Somewhere down the line, read_object calls git_open_noatime to open
> a pack index file, for example. We first try open with O_NOATIME.
> If O_NOATIME fails with EPERM, we retry without O_NOATIME. When the
> second open succeeds, errno is however still set to EPERM from the
> first attemt. When we finally determine that the object does not

s/attemt/attempt/

> exist, read_object returns NULL and read_sha1_file_extended dies
> with a fatal error:
>
>     fatal: failed to read object <sha1>: Operation not permitted
>
> Fix this by resetting errno to zero before we call open again.
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
> Helped-by: Martin Schr=C3=B6der <martin.h.schroeder@intel.com>
