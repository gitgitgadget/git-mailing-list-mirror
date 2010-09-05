From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the
 object store
Date: Sun, 5 Sep 2010 11:38:58 +0530
Message-ID: <20100905060854.GA15511@kytes>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:11:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os8Rk-000512-13
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab0IEGLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 02:11:14 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53709 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab0IEGLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:11:13 -0400
Received: by pzk9 with SMTP id 9so1034156pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Nd/RnMHjjZpYt2IcFbNb/paZl2QtdtvPLkPffLSkfu0=;
        b=xlLBUGIbwWd7zIe2LoNg2f0wJqCOr+so0Tlie+2R/VoKDX7B6c+a/RLy09TlQoKsSL
         sc/2XAgseMnbiCVWqN4x8bILuQ/zzfSfF6Ci1JEFRrh0dEseO0nH7yOfms6NsE4Vy6Lu
         poQNS9qO1/XfVhj6Jfgsc6686cQN426USk3lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KG6tqYQcCueXJcy85OcbWz9MAmdmewnWpxGFG1fwy1crnrCc0DMCQcEf8vgtXH9sgl
         32cY5nkaXOo2ruS8tr2nGE9rhyAoPo5RZbIWtG+gjVYCJ41IzBH8qfj0kcdINXNlL+H7
         cP4TFLWqTnpwMSvG84aQuYioSb4Boix1q4/G0=
Received: by 10.114.110.16 with SMTP id i16mr1667556wac.208.1283667072697;
        Sat, 04 Sep 2010 23:11:12 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm7965054wam.19.2010.09.04.23.11.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:11:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905031528.GA2344@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155424>

Hi Jonathan,

Jonathan Nieder writes:
> To recap, because fast-import does not write a pack index until the
> checkpoint, frontends cannot necessarily read back what they have
> written immediately.  The obvious application to allowing that is as a
> sanity check, but more important to us is that it allows the lazy
> frontend to forget previous revisions even if they are required for
> later "file/directory copy" operations in the import.  The frontend
> can be secure in the knowledge that the backend remembers everything
> now.

Excellent timing! I finished writing tests for the svndiff0 applier
and started modifying svn-fe to use it. I've applied your patches and
rebased my work on top of it.

> I suspect that these patches are not in their final form.
> In particular, the interface is kind of klunky: to name a
> blob by path, you have to supply a *tree* which contains that
> blob as well as the pathname.  So retrieving, say,
> v1.7.1:Documentation/git-fast-import.txt, would require
> three round-trips: one to dereference the tag, one to dereference
> the commit, and then one to finally retrieve the blob.

Ideally, we'd like to be able to supply a commit and a pathname. I'll
look into the difficulties in implementing this interface.

> Another possible concern is that this is very much git specific.
> Other fast-import backends are just not going to be able to do
> it with the same format.  Is there a convention for naming
> options like that?

Why is this a concern? We aren't even breaking backward
compatibility. This bidi interface should only be used by SVN-like
frontends.

> Still, I hope it is useful to start with.  Thoughts?  Ideas?
> Improvements?

We'll get ideas to improve this as svn-fe gets built up. On a related
note, we should probably extend the git-remote-testgit helper to use
this feature in future to facilitate writing unittests.

Thanks.

-- Ram
