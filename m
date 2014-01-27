From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git blame vs git log --follow performance
Date: Mon, 27 Jan 2014 09:34:23 +0700
Message-ID: <CACsJy8A2zpOejtaCd8y8vAJW1LV6to0WRD+es7g-7o2hEUiBxA@mail.gmail.com>
References: <1390770652.20150.25.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Ian Campbell <Ian.Campbell@citrix.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 03:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7c2s-0007LR-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 03:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbaA0Cez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 21:34:55 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:57955 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbaA0Cey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 21:34:54 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so7164965qcx.23
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 18:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N2OwyPneFVUifDr4SlMaH+KuU/LMNq24QvvkNgmIuVo=;
        b=sUa9CGTz4TwFBQJFRKcRwOqFw5dDoGc/jdYwZzhfHEZgerikAp39gISadlWSULKy//
         vVPILq0iQ9xsBpLitUZyPZgUkMdr3Em8wMl9AfqbeL4PNT/nRR/T1467pxrBLsf2M4dP
         QJV/UOYspR0B3vJfxHsE4HdDFSNBcd1i2/E4ixqpSD78hozbiN/QY49TgwW+fjjtQPF6
         UjMjgktjGBmC1OMrpQv1p7dKSQ4YsSdy/1xZ/wQvk9jlXtIOsN0Ih0e6xhJXHkHw7hGk
         /efGak0kkpzXYdLpN9dFw26Kly8WgJ1MHCRDQahlB2M29Oe9MZrcNnkRfehEwHmTPSrZ
         Uo1g==
X-Received: by 10.229.10.197 with SMTP id q5mr39004689qcq.15.1390790093667;
 Sun, 26 Jan 2014 18:34:53 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 26 Jan 2014 18:34:23 -0800 (PST)
In-Reply-To: <1390770652.20150.25.camel@joe-AO722>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241130>

On Mon, Jan 27, 2014 at 4:10 AM, Joe Perches <joe@perches.com> wrote:
> Is there something that can be done about improving
> git log --follow -- <file> performance to be nearly
> equivalent speed to git blame -- <file> ?

Not strictly about --follow, but there is room for improvement for
diff'ing in log in general. Right now we do "diff HEAD HEAD~1", "diff
HEAD~1 HEAD~2" and so on (--follow needs diff to detect rename). At
each step we load new tree objects and reparse. Notice after "diff
HEAD HEAD~1" we may have "HEAD~1" and its subtrees read and parsed
(not entirely). We could reuse that "diff HEAD~1 HEAD~2".

On git.git, "git log --raw" takes 10s and it seems tree object reading
is about 2s.In ideal case we might be able to cut that to 1s. The tree
parsing code (update_tree_entry) takes about 5s. We might be able to
cut that in half, I'm not entirely sure. But there could be a lot of
work in caching "HEAD~1" and the overhead may turn out too high for
any gain.
-- 
Duy
