From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 0/8] Encoding support in GUI
Date: Mon, 22 Sep 2008 14:12:33 +0400
Message-ID: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
	 <18646.53492.20994.908025@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 12:13:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhiQO-0000E3-KO
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 12:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbYIVKMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 06:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbYIVKMg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 06:12:36 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:9821 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYIVKMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 06:12:36 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1260143muf.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=B0vgKEjgvgghXKkfExevBgLTHi1DvS5HxAmrebFlrkc=;
        b=kC6S1cMBY3dsY+0UHtzzhZi3WgK9RbuFLC3/6t7cKEjZee/kg8cbHg8lJKg5IXi9vw
         kJsu+jphJyOC0E9/6eYePP4w9KPJGnAhAzMhZiNMqyN97aZSbxLIwZYE6RE/LJlvwk4b
         9qMwTQww2EJvAt6Oia4jm0fkVX9cb7kn3eoUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Wb6wuC6KN+M3oH7vjb6INFTx3wP80YnQRgoVmjca2skZwTT4/+99gKzlNb6oiVW8ER
         w0o0ccSyxl1XuNoX/PqTvJSfoOOfwZc9RMpixPClVx9E6Twl0AdIcuBp0eAHGzvF0k4a
         fNJF/FPsXaiJ8Pf4oLwCMG4F1XqrV2IakZT3k=
Received: by 10.103.131.18 with SMTP id i18mr2442496mun.126.1222078354039;
        Mon, 22 Sep 2008 03:12:34 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Mon, 22 Sep 2008 03:12:33 -0700 (PDT)
In-Reply-To: <18646.53492.20994.908025@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96469>

On Mon, Sep 22, 2008 at 2:55 AM, Paul Mackerras <paulus@samba.org> wrote:
> I'm happy with providing a way to say what the default encoding of
> files in the repository is, but I wonder why it is seen as a property
> of the GUI.  Is it just that there is an existing "gui" section that
> is convenient to use, or does git-gui already use gui.encoding (before
> this patch series), or is there some other reason?

No particular reason, it can be easily renamed to i18n.encoding, or
something else. I only recall seeing the name 'gui.encoding' in a
discussion on this topic several months ago.

> I haven't used .gitattributes before, but I would expect that the
> .gitattributes files would be stored in the repository along with
> everything else.  If that's the case, then for gitk at least there is
> the question of which version of a given .gitattributes file one
> should use when viewing the tree for a commit which isn't the
> currently checked-out commit - do you use the version from that tree,
> or the version in the working directory?  We seem to be using the
> latter at present, and caching the results.  Is there a philosophical
> reason to do that, other than speed?  (Also it seems that we won't
> notice if the user changes .gitattributes after we've looked at it, or
> if they create one after we've looked for one and not found it.)

Core git does not provide any interface for reading attributes from
older commits, so they are loaded from the working copy. And caching
is necessary for performance when lookup involves calling an external
application at least once per 30 files. This may change if
git-check-attr is modified to support --stdin-paths.

>> There are also some bugs in handling of commit encodings in gitk,
>> but they are out of the scope of this series.
>
> I'm interested to hear what they are.

When I tested it, I noticed that:

1. It works correctly only if all commits use the encoding specified
in i18n.commitencoding
2. Even when they do, sometimes commits are loaded through cat-file,
and in this case they are processed using the locale encoding.

Alexander
