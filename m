From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 10:59:32 +0200
Message-ID: <CAHGBnuOjb+zmzwJeY-hbU4MYKpOMCQSRtDC4hS4zvCD5DQzv3w@mail.gmail.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
	<1461139809-6573-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 10:59:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asnz5-0001mg-VM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 10:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbcDTI7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 04:59:38 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33254 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933102AbcDTI7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 04:59:33 -0400
Received: by mail-vk0-f50.google.com with SMTP id n62so51185110vkb.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Xtg4j2+/T38bJtPnTQql/bj4+hJczP5K9m29JwM2170=;
        b=YnmOcUjPVgyRCKHEFHMDl6D+Fth7TQFiawjoylfdGpG8Wa6LqVJg44/v9V0hirqZ1Y
         AqD7uyG86JDUFuapgPxcEs0gp3lCrMQLiDIRfqqHzU/+sZum2uHYHZ9U8pBD8MsbXkjP
         OExnE1+pgXgS1s9olRIlNtkYaHLVthpVenTDI8jwXFfpV2IbFgJolrpk+qgk0XTYfeum
         j2RoHlA4CkaBEq8r3jJZZr6zaCP/fJP1QZzXco2gW9W9br3vi69UkREFJD4o3YDKVnk/
         m2ZMQrgE/LOFhHzCKG5l6i5n5QtzZeJIdmbGTvHorSfNpaD1UmuKk5cKEGIVnc6prvk+
         O8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Xtg4j2+/T38bJtPnTQql/bj4+hJczP5K9m29JwM2170=;
        b=dYUbFFxYy/ljI4ln7MGv19fiv8KXi/GNxb8iU7j0G+bcHkWH/rS7Ij9pbvMfPjN0aA
         Z9jTL9kloKEWutvgMzVkMA0ufZi1yuNYxcV4On/cuUGxfDAzmu37GdSSpp8edKpn4gsP
         nel6Vi8UCtEW2raJZ4tDi4ZuA6Tic7YvEt2+zfM9VWfWjj9fNdzd/ZTxtWOu6JHwx8uT
         m9Mbf1GyGWZ16IkuZwc1KwiDWAANEMdCM+GavsWRfMJPZnUd43JzrSE7bjWAgHoG1Th5
         /ioCtHYtWZMk5s/rC3dgS39vXmCdSKFKHW9JUNMZz7RCOa2ojgIajDZB3Gu2IOUWpp1U
         uQ2g==
X-Gm-Message-State: AOPr4FX0AXbRrYxqQjQYY98Qd7+CI5JM/faG1zqdFXFnmuHoP82UxmVXNwK0aFQ3kDCXlKWumX7y7+YkoewXpw==
X-Received: by 10.31.47.200 with SMTP id v191mr4360968vkv.116.1461142772438;
 Wed, 20 Apr 2016 01:59:32 -0700 (PDT)
Received: by 10.176.5.2 with HTTP; Wed, 20 Apr 2016 01:59:32 -0700 (PDT)
In-Reply-To: <1461139809-6573-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291995>

On Wed, Apr 20, 2016 at 10:10 AM,  <larsxschneider@gmail.com> wrote:

> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1064,8 +1064,17 @@ class GitLFS(LargeFileSystem):
>          if pointerProcess.wait():
>              os.remove(contentFile)
>              die('git-lfs pointer command failed. Did you install the extension?')
> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
> -        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
> +
> +        # Git LFS removed the preamble in the output of the 'pointer' command

git-lfs did not remove the output. It simply goes to stderr instead of
stdout now. That said, could a fix simply be to capture both stdout
and sterr? If the output to the streams remain interleaved it should
look exactly like before.

> +        # starting from version 1.2.0. Check for the preamble here to support
> +        # earlier versions.
> +        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
> +        preamble = 'Git LFS pointer for ' + contentFile + '\n\n'
> +        if pointerFile.startswith(preamble):
> +            pointerFile = pointerFile[len(preamble):]
> +
> +        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
> +        oid = oidEntry[0].split(' ')[1].split(':')[1]

Why do we need to remove the preamble at all, if present? If all we
want is the oid, we should simply only look at the line that starts
with that keyword, which would skip any preamble. Which is what you
already do here. However, I'd probably use .splitlines() instead of
.split('\n') and .startswith('oid ') (note the trailing space) instead
of .startswith('oid') to ensure "oid" is a separate word.

But then again, I wonder why there's so much split() logic involved in
extracting the oid. Couldn't we replace all of that with a regexp like

oid = re.search(r"^oid \w+:(\w+)", pointerFile, re.MULTILINE).group(1)

-- 
Sebastian Schuberth
