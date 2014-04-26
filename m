From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Fri, 25 Apr 2014 17:53:31 -0700
Message-ID: <CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 02:54:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdqsT-000793-5V
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 02:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbaDZAxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 20:53:54 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:51789 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaDZAxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 20:53:53 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so4207538wgg.21
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=1/IP40NYcu8n20wnPYNyne06YQvrq5eqMA2j1DeIPC8=;
        b=D0xKggxSYqxCXZmcfhVqpGa19gOOIkI4gLmM5tjb5ci4dyg/s2UxbNFLKoFHZM2xfb
         rEkYsoT+H7sKVnkUYTMFLKS0MXLXZrwpQbiJDlqvybcKqFD/fsI2IHsHI+/Qvi989AXs
         aioIsxZQkQGLfLq4r5Hcs6sSGt963u5rrM6vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=1/IP40NYcu8n20wnPYNyne06YQvrq5eqMA2j1DeIPC8=;
        b=gBMe7ElxKCUDMbJ0Xi8y6mK3dhH80lGS24PfkbPIHSp7wwvSuwAimyCzDNpa33cXGk
         QTjjhWb4OFvOGKcr/9LqOKzvCKPMn0kVzVEovOgcU6GhsTfgSPGYQ6dn1D0fG3ZSfrjs
         wClLsqximD0U6z+YhW/97GpwyTt5bYgOqMMwKkRwqvo/OyaD4qIuTdhUQJYJ+7H4L0HV
         zUzJbvZaxmPWBCVOvVwIeqT9Upbgb7jcZwcNRpmR8C9MY+bzfZhPNRbHYoOrkmmXz6zK
         4fKPAUtxHIsOSYnKhmwaMt5I6JLfGKlBwjNNyiAGqZYOD1hIbI1ykYI337wPMkFmpVVn
         +l4A==
X-Gm-Message-State: ALoCoQnVGBI+FLzBW13F4pDxPRxl+f14oXEqYk8T1JXby1tiTBLS8hqHoNALRGaQ1FtV3ySuX01R
X-Received: by 10.194.48.80 with SMTP id j16mr8956516wjn.44.1398473631765;
 Fri, 25 Apr 2014 17:53:51 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Fri, 25 Apr 2014 17:53:31 -0700 (PDT)
In-Reply-To: <1398470210-28746-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247137>

On Fri, Apr 25, 2014 at 4:56 PM, David Kastrup <dak@gnu.org> wrote:
> The previous implementation used a single sorted linear list of blame
> entries for organizing all partial or completed work.  Every subtask had
> to scan the whole list, with most entries not being relevant to the
> task.  The resulting run-time was quadratic to the number of separate
> chunks.
>
> This change gives every subtask its own data to work with.  Subtasks are
> organized into "struct origin" chains hanging off particular commits.
> Commits are organized into a priority queue, processing them in commit
> date order in order to keep most of the work affecting a particular blob
> collated even in the presence of an extensive merge history.

Without reading the code, this sounds like how JGit runs blame.

> For large files with a diversified history, a speedup by a factor of 3
> or more is not unusual.

And JGit was already usually slower than git-core. Now it will be even
slower! :-)
