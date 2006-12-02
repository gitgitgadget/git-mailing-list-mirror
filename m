X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 09:22:40 +0000
Message-ID: <200612020922.43832.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 09:25:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AHyYRdnERxTLk49p6OEUxazd985umFF5zCTltMTaaMT/jRHNEAfwefWFFH95PhJJdUG2dVLGiO22YSV45q2EnbYqK1kxcVYJqo8oj17GoSfoS2vWbo7UuAKQTzBNy+JFbMarsfFU0rjHa4HcVJBQbz/U6ThKTJg+lMe1YuAyLjU=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33012>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqR7m-0000LD-Dr for gcvg-git@gmane.org; Sat, 02 Dec
 2006 10:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162859AbWLBJZb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 04:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162860AbWLBJZb
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 04:25:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:46512 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1162859AbWLBJZa
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 04:25:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3791379nfa for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 01:25:29 -0800 (PST)
Received: by 10.78.201.2 with SMTP id y2mr5678801huf.1165051528827; Sat, 02
 Dec 2006 01:25:28 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 37sm29532581hub.2006.12.02.01.25.26; Sat, 02 Dec
 2006 01:25:27 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 2006, December 02 00:12, Linus Torvalds wrote:

> 	100644 blob 08602f522183dc43787616f37cba9b8af4e3dade	xdiff-interface.c
> 	100644 blob 1346908bea31319aabeabdfd955e2ea9aab37456	xdiff-interface.h
> 	040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2	xdiff
> 	050000 link 0215ffb08ce99e2bb59eca114a99499a4d06e704	xyzzy
>
> where that 050000 is the new magic type (I picked one out of my *ss: it's
> not a valid type for a file mode, so it's a godo choice, but it could be
> anythign that cannot conflict with a real file), which just specifies the
> "link" part. The SHA1 is the SHA1 of the commit, and the "xyzzy" is
> obviously just the name within the directory of the submodule.

Can I argue that the hash in that object should actually be to a real object 
in the supermodule repository rather than a link?  Then THAT object would 
contain the hash?  So in your above example:

  100644 blob 08602f522183dc43787616f37cba9b8af4e3dade	xdiff-interface.c
  100644 blob 1346908bea31319aabeabdfd955e2ea9aab37456	xdiff-interface.h
  040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2	xdiff
  050000 link a7f26495b7b7e32bf949efbd91ee32267b792cba	xyzzy

And then the local object a7f26495b7b7e32bf949efbd91ee32267b792cba would 
contain your original hash 0215ffb08ce99e2bb59eca114a99499a4d06e704.

The reason I suggest this as without out it the "link" object is the only hash 
in the tree that doesn't point to a valid object.  The contents of objects is 
entirely arbitrary so it's perfectly okay for that to contain a hash that 
won't dereference to a real object in the supermodule.

The main advantage of this is (I think) that git-prune, git-fsck, and whatever 
else relies on tree objects all being real, don't need to be modified at all.

It also gives you scope to later add fields to the "link" object if you 
wanted.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
