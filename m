From: Stefan Zager <szager@chromium.org>
Subject: Make the git codebase thread-safe
Date: Tue, 11 Feb 2014 17:54:51 -0800
Message-ID: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 12 02:54:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDP2P-0002nl-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 02:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbaBLByw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 20:54:52 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57042 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbaBLByv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 20:54:51 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so10309774oag.28
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 17:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tVEaGZTd+79pOHqPbttNM8u+gWG0ztpwTa4jLRvAQWU=;
        b=mVrN6GnlgqK0NJI/9SxuPeNJ7qNKgl1AZkARRVBJ3lPcO8za2FZ2Ga5KgTSbo3wNN9
         NvQxqg3uwM06+zOKOJnnJQbs53ov+vFRO3N+k+BLcr+eQxkE2hs5Z/sC1zNoceB3roB7
         2YRt18X4k4z+shP8DenC1Ck5j726Fg6/7mwnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=tVEaGZTd+79pOHqPbttNM8u+gWG0ztpwTa4jLRvAQWU=;
        b=I7N2oY+TaE84kLDtregM9xaMTwBRcz9Uvtml0yD2pIjg0nPAES6qR6f+huN+TolNME
         jLAao9e7IUT79w4noqYqHGNQY0/45Qa7sQ7sVY18WuATSDCPqxUOySGWpDzEzqHGzUdl
         orshF7hlRGJxNwahgv7gbffpqBoHnDrDzyFNW31mxBOmAI1Mhn4d8i+CqayPaOBJa6UR
         EbFexQjaHbaifXXMLNbzfgDjgE4lXZlOFhtF4ieoKF8ueTdV5NbSPsfKqIxxaI/COuVm
         16srZmu2JYPkXGxbg1eRLq6Fhlt4As/apU3/vSOvSWCJYYYaJw6kFqhUzqtuKdqE2x8Q
         +ylw==
X-Gm-Message-State: ALoCoQmxX5o8BRYR3INKt09GDzVh+2RwGnI903txofUHEyaoD2WQLZyH3qClyai49AwFiQXYIpVg
X-Received: by 10.60.103.134 with SMTP id fw6mr34886807oeb.34.1392170091142;
 Tue, 11 Feb 2014 17:54:51 -0800 (PST)
Received: by 10.76.69.229 with HTTP; Tue, 11 Feb 2014 17:54:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241965>

We in the chromium project have a keen interest in adding threading to
git in the pursuit of performance for lengthy operations (checkout,
status, blame, ...).  Our motivation comes from hitting some
performance walls when working with repositories the size of chromium
and blink:

https://chromium.googlesource.com/chromium/src
https://chromium.googlesource.com/chromium/blink

We are particularly concerned with the performance of msysgit, and we
have already chalked up a significant performance gain by turning on
the threading code in pack-objects (which was already enabled for
posix platforms, but not on msysgit, owing to the lack of a correct
pread implementation).

To this end, I'd like to start submitting patches that make the code
base generally more thread-safe and thread-friendly.  Right after this
email, I'm going to send the first such patch, which makes the global
list of pack files (packed_git) internal to sha1_file.c.

I realize this may be a contentious topic, and I'd like to get
feedback on the general effort to add more threading to git.  I'd
appreciate any feedback you'd like to give up front.

Thanks!

Stefan Zager
