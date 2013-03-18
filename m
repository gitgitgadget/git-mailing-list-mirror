From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: sharing .git/config
Date: Mon, 18 Mar 2013 14:30:23 +0530
Message-ID: <CALkWK0nWXCO_EXfx69m8XbrFe=ABBodPdFbSrS9v3VqgfbnQ+w@mail.gmail.com>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
 <CACsJy8Ch70gZMkT7ScY3R-FNQU4QjtUe8UhoGRzE27cH9mu0HA@mail.gmail.com>
 <20130219153600.GA5338@sigill.intra.peff.net> <CALkWK0kZiYmbh-dSr-c2mzK2Mzhf3iZ_T3hFNuR57F0b5tptGw@mail.gmail.com>
 <20130312085342.GA11340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 10:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHVwO-00035V-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 10:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab3CRJAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 05:00:45 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:56742 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab3CRJAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 05:00:45 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so5083361iag.31
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WgZg9xRaVjRRRWKB8tsAXgA7NVpisVHmUkrOx31GP9k=;
        b=GAYblHrsN4ZR9YLmZNo5q1P3FWDiSO1dCMCCZ7Nc7Zvz/xxO+J2ewluvAJeCWk9nKC
         cFct332jPek9EdwAm7yxa9cjB9H5/QG5EIoW21XO/tx2WrZzJVmt+lcIsD8K136PCA80
         E5ly+O2QBAECuKKTIVlIdMJVOg4BuFKc15NgZ1szP2nRciP6N5qDVK1i3TwCERWeuuhi
         6IfcifGihLTGhYORDFXb1ob/YPZePKhXNbuioEpcSB6AVykhmqzlpmHVXQIIcvOAWQ98
         Odc5PEtyF0sO1vSJ4ejHWrt9LwrGB9g7B/EbV5ZEdsnxwXuPg5hTszKBg79fVCJS/KuB
         fJag==
X-Received: by 10.50.17.201 with SMTP id q9mr26587061igd.107.1363597244785;
 Mon, 18 Mar 2013 02:00:44 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 02:00:23 -0700 (PDT)
In-Reply-To: <20130312085342.GA11340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218398>

Jeff King wrote:
> I don't think you can avoid the 3-step problem and retain the safety in
> the general case.  Forgetting implementation details for a minute, you
> have either a 1-step system:
>
>   1. Fetch and start using config from the remote.
>
> which is subject to fetching and executing malicious config, or:
>
>   1. Fetch config from remote.
>   2. Inspect it.
>   3. Integrate it into the current config.

I don't understand your emphasis on step 2.  Isn't the configuration
written by me?  Why would it be malicious?

I've just started thinking about how to design something that will
allow us to share configuration elegantly [1].  Essentially, the
metadata repository will consist of *.layout files, one for each
repository to clone, containing the .git/config to write after cloning
that repository.  So, a git.layout might look like:

[layout]
	directory = git
[remote "origin"]
	url = git://github.com/git/git
[remote "ram"]
	url = git@github.com:artagnon/git
[remote "junio"]
	url = git://github.com/gitster/git

As you can see the [layout] is a special section which will tell our
fetcher where to place the repository.  Everything else is meant to be
inserted into the repository's .git/config.  However, I can foresee a
problem in scaling: when I ask a specific directory like a/b/c to be
populated (equivalent of repo sync `a/b/c`), it'll have to parse the
layout.directory variable of all the .layout files, and this can be
slow.  So, maybe we should have a special _manifest.layout listing all
the paths?

Further, I see this as a way to work with projects that would
otherwise require nested submodules like the Android project.  What do
you think?

[1]: https://github.com/artagnon/src.layout
