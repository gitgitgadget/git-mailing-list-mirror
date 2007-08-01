From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 1 Aug 2007 15:20:11 +0200
Message-ID: <81b0412b0708010620h6bf44aarb35da301db967855@mail.gmail.com>
References: <200708010216.59750.jnareb@gmail.com>
	 <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	 <7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	 <20070801092428.GB28106@thunk.org>
	 <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 15:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGE7r-0008Bs-2B
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 15:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761734AbXHANUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 09:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761653AbXHANUP
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 09:20:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:56960 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134AbXHANUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 09:20:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so204176ugf
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 06:20:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M1LxhNNqTmSIipYX7YSUu1eA75uYOik4H9icWj4CMv9MODpXGa98cuj9onCtKYfXLX1Rk9/Jh/T36RywTpkrxD7zLLQbVY1Kb6mFxlyIKbgKeXa6it/k3gbRVRXpqRXh1tpYDuyP638wdD43L6JJN6x1yv+mzJiEGXAbKoHX3uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QzWDLN7EOChumz35nc39toYXCfgdlwGaVck2B85AxF+OSjBf9m/h/J+IJ+81d6LLxy5VJjCmBAsFeto3384CZmAvS2+wKLup3gPADa4u7/zEtD/R3bRKHdM+XsMMaTeZsy8nsbQunu+DJaJE8i9gd5LeasfqhC6mAIJeo76QO5U=
Received: by 10.78.180.18 with SMTP id c18mr187062huf.1185974411551;
        Wed, 01 Aug 2007 06:20:11 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 1 Aug 2007 06:20:11 -0700 (PDT)
In-Reply-To: <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54433>

On 8/1/07, Junio C Hamano <gitster@pobox.com> wrote:
> Theodore Tso <tytso@mit.edu> writes:
> > So would you accept a patch which adds a git-config variable which
> > specifies whether or not local clones should use hard links by default
> > (defaulting to yes), and which adds a --no-hard-links option to
> > git-clone to override the config option?
>
> Are you suggesting to make -l the default for local, in other
> words?  I personally do not make local clone often enough that I
> am not disturbed having to type extra " -l" on the command line.

...as long as the underlying filesystem _supports_ hardlinks.

BTW, we need a warning when falling back to normal copy,
if git-clone -l is used. The user _asked_ for a hard-linked
clone, but silently got something else. Something like this:

diff --git a/git-clone.sh b/git-clone.sh
index 0922554..a744f5b 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -266,6 +266,7 @@ yes,yes)
 	    l=
 	    if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
 	    then
+		    echo >&2 "Hardlinks not supported. Falling back to copy"
 		    l=l
 	    fi &&
 	    rm -f "$GIT_DIR/objects/sample" &&
