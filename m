From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git blame vs git log --follow performance
Date: Mon, 27 Jan 2014 08:33:11 +0700
Message-ID: <CACsJy8B4dkjae3tL+_JvD63HCoi_-nNWYGvT3xRTqi8UpYX95g@mail.gmail.com>
References: <1390770652.20150.25.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Ian Campbell <Ian.Campbell@citrix.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 02:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7b58-0004LI-G6
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 02:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbaA0Bdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 20:33:43 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:64725 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaA0Bdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 20:33:42 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so7248988qcr.14
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 17:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7fG/NhTbEXnJpKNlxa8kIUiXz3PVTLNF0XhUNLSIpQQ=;
        b=xUCFgeJnj5bDzyImWgiPZ9W94D0gpGpf0H5z3j9xdZdaUS8E+mL2PgYbFodyLOKNmx
         6/pTU4wNQgK9TPpbf9SC1qNdaiG50ipatAAZ/1UxVXHvWuILRRVQH9mmbNpTMXypMCUK
         JFN8lJact9+St7mPmuoBXCEqzXrPKk6xLd5vCWgizEoVtf3EYpzsKfW4ZyiO2UiBtSUp
         hdHKs6yIoDt6XXOOo8HKw4fVi8rw8qJDOO3SZ/VuewPDuLeMT5yi5QQz10VAMJjvA2ka
         DvFOTUhie0qmtG6eIxwcu4dA1CyX5NkWQlDlbThWUjEhVe+pGD46aIiNdk94JGjBPSUA
         vOzw==
X-Received: by 10.224.103.131 with SMTP id k3mr147540qao.102.1390786421877;
 Sun, 26 Jan 2014 17:33:41 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 26 Jan 2014 17:33:11 -0800 (PST)
In-Reply-To: <1390770652.20150.25.camel@joe-AO722>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241126>

On Mon, Jan 27, 2014 at 4:10 AM, Joe Perches <joe@perches.com> wrote:
> For instance (using the Linus' linux kernel git):
>
> $ time git log --follow -- drivers/firmware/google/Kconfig > /dev/null
>
> real    0m42.329s
> user    0m40.984s
> sys     0m0.792s
>
> $ time git blame -- drivers/firmware/google/Kconfig > /dev/null
>
> real    0m0.963s
> user    0m0.860s
> sys     0m0.096s
>

It's not fair to compare blame and log. If you compare, compare it to
non follow version

$ time git log --follow -- drivers/firmware/google/Kconfig > /dev/null

real    0m35.552s
user    0m35.120s
sys     0m0.383s

$ time git log -- drivers/firmware/google/Kconfig > /dev/null

real    0m4.366s
user    0m4.215s
sys     0m0.144s

Although because we need to detect rename, we can't really filter to
one path. So the base line is more like

$ time git log > /dev/null

real    0m29.338s
user    0m28.485s
sys     0m0.813s

with rename detection taking some more time.

> Perhaps adding a whole-file rename option to the
> "git log" history simplification mechanism could
> help?
>
> Thoughts?

I tested a version with rename detection logic removed. It did not
change the timing significantly. To improve --follow I think we need
to do something about path filtering.
-- 
Duy
